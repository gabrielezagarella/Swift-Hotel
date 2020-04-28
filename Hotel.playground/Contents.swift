import UIKit
/*
Comment Kdoc
@author Gabriele Zagarella
@project Hotel
 
Un Albergo richiede la creazione di un’applicazione per la
gestione e prenotazione delle sue camere.
L’albergo gestisce delle Stanze.
Ogni camera ha una property che la identifica
univocamente.
Esistono due tipologie di Stanza: Singola e Doppia.
La Singola può ospitare al massimo una persona ed in
più qualche singola (non tutte) può avere la possibilità di avere
un cucinino.
la Doppia può ospitare due persone, non può avere cucinino
ma qualche doppia (non tutte) potrebbe avere la possibilità di
aggiungere un terzo lettino (cosa che non può avere la stanza
singola)
Ogni camera può essere prenotata.
Una funzione dell’albergo mostra tutte le camere libere sia
singole che doppie ognuna con le sue caratteristiche
(Cucinino / Terzo lettino)
Una funzione dell’Albergo permette di prenotare una camera
che sia identificata come “libera” in base alla scelta svolta
dall’utente. (Singola, Singola con Cucinino, Doppia, Doppia
con Lettino)
Se un utente chiede di prenotare una stanza “Singola” o
“Doppia” (e con le opportuni varianti) la nostra funzione deve
essere in grado di effettuare una ricerca tra tutte le stanze in
modo da poter ritornare una stanza che non sia occupata per
poterla in seguito prenotare.
Se non ci sono stanze libere, deve mandare in Output un
messaggio all’utente :
“Ci dispiace ma non ci sono al momento stanze con le
caratteristiche da Lei richieste.”
Se esiste la Stanza e questa è libera, un’altra funzione deve
permettere all’utente di prenotarla, settando la stessa come
occupata.
Trovare il modo migliore per simulare la prenotazione di una
stanza.
Utilizzate L’ereditarietà typeCasting e DownCasting e
Extension dove serve.
*/

class Room {
    private var number: Int;
    private var booked: Bool = false;

    enum Host: Int {
        case Single = 1;
        case Double = 2;
    }
    
    var newNumber: Int {
        get {
            return self.number;

        }
        set (number) {
            self.number = number;
        }
    }
    var newBooked: Bool {
        get {
            return self.booked
        }
        set (booked) {
            self.booked = booked;
        }
    }
    
    init(number: Int) {
        self.number = number;
    }
}
class SingleRoom: Room {
    private var kitchenette: String?;
    
    var newKitchenette: String {
        if let kitchenette = self.kitchenette {
            return kitchenette;
        }else {
            return "No";
        }
    }
    
    override init(number: Int) {
        super.init(number: number);
    }
    
    init(kitchenette: String, number: Int) {
        self.kitchenette = kitchenette;
        super.init(number: number);
    }
    
    func toString() -> String {
        return "Single Romm, number: \(newNumber), hosts: \(Room.Host.Single.rawValue) person, kitchenette: \(self.newKitchenette)";
    }
}

class DoubleRoom: Room {
    private var bed: String?;
    
    var newBed: String {
        if self.bed != nil {
            return "Yes";
        }else {
            return "No";
        }
    }
    
    override init(number: Int) {
        super.init(number: number);
    }
    
    init(number: Int, bed: String) {
        self.bed = bed;
        super.init(number: number);
    }
    
    func addBed(bed: String) -> DoubleRoom {
        let insert = DoubleRoom.init(number: self.newNumber, bed: bed)
        return insert;
    }
    
    func toString() -> String {
        return "Double Romm, number: \(newNumber), hosts: \(Room.Host.Double.rawValue) person, third bed: \(self.newBed)";
    }
}

class Hotel {
    var name: String;
    var freeRoom: [Room] = [];
    var bookedRoom: [Room] = [];
    
    init(name: String, freeRoom: [Room]) {
        self.name = name;
        self.freeRoom = freeRoom;
    }
    
    func getFreeRoom() -> String {
        var result: String = "";
        if freeRoom.count == 0 {
            return "No free room";
        }
        for item in freeRoom {
            if item.newBooked == false {
                if let singleRoom = item as? SingleRoom {
                    result += "\(singleRoom.toString())\n";
                }else if let doubleRoom = item as? DoubleRoom {
                    result += "\(doubleRoom.toString())\n";
                }
            }else {
                return "No free room";
                
            }
        }
        return result;
    }
    
    func bookRoom(number: Int) -> String {
        if freeRoom.count == 0 {
            return "No free room";
        }
        for (index, room) in freeRoom.enumerated() {
            if room.newBooked == true && room.newNumber == number {
                return "room already booked";
            }else if room.newNumber != number {
                return "Number not present for booked room";
            }else if room.newNumber == number {
                if let itemRoom = room as? SingleRoom {
                itemRoom.newBooked = true;
                freeRoom.remove(at: index);
                self.bookedRoom.append(room);
                return "room single booked succesfully";
                }else {
                    if let itemRoom = room as? DoubleRoom {
                    itemRoom.newBooked = true;
                    freeRoom.remove(at: index);
                    self.bookedRoom.append(room);
                    return "room double booked succesfully";
                    }
                }
            }
        }
        return "";
    }
    
    func book(typeRoom: String) {
        switch typeRoom {
        case "Single":
            for (index, room) in freeRoom.enumerated() {
                if let itemRoom = room as? SingleRoom {
                    if itemRoom.newBooked == false {
                        if itemRoom.newKitchenette == "No" {
                            itemRoom.newBooked = true
                            print("Brooked room: \(itemRoom.newNumber)")
                            freeRoom.remove(at: index);
                            self.bookedRoom.append(itemRoom);
                            return
                            }
                        }
                    }
                }
                print("No free room")
                break
            
            case "Single with kitchenette":
                for (index, room) in freeRoom.enumerated() {
                if let itemRoom = room as? SingleRoom {
                    if itemRoom.newBooked == false {
                        if itemRoom.newKitchenette == itemRoom.newKitchenette {
                            itemRoom.newBooked == true
                            print("Brooked room: \(itemRoom.newNumber)")
                            freeRoom.remove(at: index);
                            self.bookedRoom.append(itemRoom);
                            return
                            }
                        }
                    }
                }
                print("No free room")
                break
            
            case "Double":
                for (index, room) in freeRoom.enumerated() {
                if let itemRoom = room as? DoubleRoom {
                    if itemRoom.newBooked == false {
                        if itemRoom.newBed == "No"{
                            itemRoom.newBooked = true
                            print("Brooked room: \(itemRoom.newNumber)")
                            freeRoom.remove(at: index);
                            self.bookedRoom.append(itemRoom);
                            return
                            }
                        }
                    }
                }
                print("No free room")
                break
            
            case "Double with bed":
                for (index, room) in freeRoom.enumerated() {
                if let itemRoom = room as? DoubleRoom {
                    if itemRoom.newBooked == false {
                        if itemRoom.newBed == "Yes"{
                            itemRoom.newBooked = true
                            print("Brooked room: \(itemRoom.newNumber)")
                            freeRoom.remove(at: index);
                            self.bookedRoom.append(itemRoom);
                            return
                            }
                        }
                    }
                }
                print("No free room")
                break
        default:
            print("Error")

        }
    }
    
    func getBookedRoom() -> String {
        var result: String = "";
        if bookedRoom.count == 0 {
            return "No free room";
        }
        for item in bookedRoom {
            if item.newBooked == true {
                if let singleRoom = item as? SingleRoom {
                    result += "\(singleRoom.toString())\n";
                }else if let doubleRoom = item as? DoubleRoom {
                    result += "\(doubleRoom.toString())\n";
                }
            }
           
        }
        return result;
    }
}

"*...Created room object...*"
var room = SingleRoom.init(number: 1)
var room2 = SingleRoom.init(kitchenette: "yes", number: 2);
var room3 = DoubleRoom.init(number: 3);
var room3bed = room3.addBed(bed: "si")
var room4 = DoubleRoom.init(number: 4)
print()
"*...Created hotel object...*"
var hotel = Hotel.init(name: "Casale", freeRoom: [room, room2, room3bed, room4]);
"*...Show free rooms...*"
print(hotel.getFreeRoom());
print()
"*...Booked room...*"
hotel.book(typeRoom: "Double with bed")
print()
"*...Show booked rooms...*"
print(hotel.getBookedRoom())
print()
"*...Booked room...*"
print(hotel.bookRoom(number: 1));
print(hotel.bookRoom(number: 2));
print()
"*...Show booked rooms...*"
print(hotel.getBookedRoom())
"*...Show free rooms...*"
print(hotel.getFreeRoom());



