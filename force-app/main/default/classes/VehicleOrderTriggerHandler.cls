public class VehicleOrderTriggerHandler {

    public static void validateStock(List<Vehicle_Order__c> orders) {

        Set<Id> vehicleIds = new Set<Id>();

        for (Vehicle_Order__c order : orders) {
            if (order.Vehicle__c != null) {
                vehicleIds.add(order.Vehicle__c);
            }
        }

        if (vehicleIds.isEmpty()) {
            return;
        }

        Map<Id, Vehicle__c> vehicleMap = new Map<Id, Vehicle__c>(
            [
                SELECT Id, Name, Stock_Quantity__c, Availability__c
                FROM Vehicle__c
                WHERE Id IN :vehicleIds
            ]
        );

        for (Vehicle_Order__c order : orders) {

            if (order.Vehicle__c == null) {
                continue;
            }

            Vehicle__c vehicle = vehicleMap.get(order.Vehicle__c);

            if (vehicle == null) {
                order.addError('Selected vehicle could not be found.');
                continue;
            }

            if (order.Quantity__c == null || order.Quantity__c <= 0) {
                order.addError('Order quantity must be greater than zero.');
                continue;
            }

            if (vehicle.Stock_Quantity__c == null ||
                vehicle.Stock_Quantity__c < order.Quantity__c) {

                order.addError(
                    'Order cannot be placed. ' +
                    vehicle.Name +
                    ' has only ' +
                    String.valueOf(vehicle.Stock_Quantity__c) +
                    ' vehicle(s) available.'
                );
            }
        }

        assignNearestDealer(orders);
    }


    public static void assignNearestDealer(List<Vehicle_Order__c> orders) {

        Set<Id> customerIds = new Set<Id>();

        for (Vehicle_Order__c order : orders) {
            if (order.Vehicle_Customer__c != null) {
                customerIds.add(order.Vehicle_Customer__c);
            }
        }

        if (customerIds.isEmpty()) {
            return;
        }

        Map<Id, Vehicle_Customer__c> customerMap =
            new Map<Id, Vehicle_Customer__c>(
                [
                    SELECT Id, Name, Latitude__c, Longitude__c
                    FROM Vehicle_Customer__c
                    WHERE Id IN :customerIds
                ]
            );

        List<Dealer__c> dealers = [
            SELECT Id, Name, Latitude__c, Longitude__c
            FROM Dealer__c
            WHERE Latitude__c != null
            AND Longitude__c != null
        ];

        if (dealers.isEmpty()) {
            return;
        }

        for (Vehicle_Order__c order : orders) {

            if (order.Vehicle_Customer__c == null) {
                continue;
            }

            Vehicle_Customer__c customer =
                customerMap.get(order.Vehicle_Customer__c);

            if (customer == null ||
                customer.Latitude__c == null ||
                customer.Longitude__c == null) {

                continue;
            }

            Dealer__c nearestDealer;
            Decimal shortestDistance;

            for (Dealer__c dealer : dealers) {

                Decimal distance = calculateDistance(
                    customer.Latitude__c,
                    customer.Longitude__c,
                    dealer.Latitude__c,
                    dealer.Longitude__c
                );

                if (shortestDistance == null ||
                    distance < shortestDistance) {

                    shortestDistance = distance;
                    nearestDealer = dealer;
                }
            }

            if (nearestDealer != null) {
                order.Dealer__c = nearestDealer.Id;
            }
        }
    }


    private static Decimal calculateDistance(
        Decimal lat1,
        Decimal lon1,
        Decimal lat2,
        Decimal lon2
    ) {

        Decimal earthRadius = 6371;

        Double latitude1 = Double.valueOf(String.valueOf(lat1));
        Double longitude1 = Double.valueOf(String.valueOf(lon1));
        Double latitude2 = Double.valueOf(String.valueOf(lat2));
        Double longitude2 = Double.valueOf(String.valueOf(lon2));

        Double dLat = (latitude2 - latitude1) * Math.PI / 180;
        Double dLon = (longitude2 - longitude1) * Math.PI / 180;

        Double a =
            Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(latitude1 * Math.PI / 180) *
            Math.cos(latitude2 * Math.PI / 180) *
            Math.sin(dLon / 2) * Math.sin(dLon / 2);

        Double c =
            2 * Math.atan2(
                Math.sqrt(a),
                Math.sqrt(1 - a)
            );

        return Decimal.valueOf(String.valueOf(earthRadius * c));
    }
}