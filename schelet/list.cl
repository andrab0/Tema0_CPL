class List {

    -- Defining the following operations for empty generic lists:
    (*
        -- isNil() - checks if the list is empty
        -- head() - getter for the head of the list
        -- tail() - getter for the tail of the list
        -- length() - returns the length of the list
        -- cons(obj) - initializes a new cons
        -- append() - appends an element to the end of the list
        -- concat() - concatenates two lists
        -- reverse() - reverses the list
    *)

    -- Check if the list is empty
    isNil() : Bool { {abort(); true;} };

    -- Get the head of the list
    head() : Object { {abort(); new Object;} };

    -- Get the tail of the list
    tail() : List { {abort(); new List;} };

    -- Get the length of the list
    length() : Int { {abort(); 0;} };

    -- Initialize a new cons
    cons(obj : Object) : List { 
        let newCons : Cons <- new Cons in
            newCons.init(obj, self)
     };

    (* TODO: store data *)

    add(o : Object):SELF_TYPE {
        self (* TODO *)
    };

    toString():String {
        "[TODO: implement me]"
    };

    merge(other : List):SELF_TYPE {
        self (* TODO *)
    };

    filterBy():SELF_TYPE {
        self (* TODO *)
    };

    sortBy():SELF_TYPE {
        self (* TODO *)
    };
};

class Cons inherits List {
    -- Defining the following operations for not empty generic lists:
    (*
        -- isNil() - checks if the list is empty
        -- head() - getter for the head of the list
        -- tail() - getter for the tail of the list
        -- init(head, tail) - initalizes the list with the given head and tail
    *)

    car : Object; -- head of the list
    cdr : List; -- tail of the list

    -- Check if the list is empty
    isNil() : Bool { false };

    -- Get the head of the list
    head() : Object { car };

    -- Get the tail of the list
    tail() : List { cdr };

    -- Initialize the list with the given head and tail
    init(head : Object, tail : List) : Cons {
        {
            car <- head;
            cdr <- tail;
            self;
        }
    };
};

class Main inherits IO
{
    myList : List <- new List;

    main() : Object {
        myList <- myList.cons(self)
    };

};