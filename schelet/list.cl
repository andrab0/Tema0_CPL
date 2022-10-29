class List {

    -- Check if the list is empty
    isNil() : Bool { {abort(); true;} };

    -- Get the head of the list
    head() : Object { {abort(); new Object;} };

    -- Get the tail of the list
    tail() : List { {abort(); new List;} };

    -- Get the element at an index in the list
    getListAtIndex(i : Int) : Object {{abort(); self;}};

    -- Remove list at index:
    removeListAtIndex(i : Int) : List {{abort(); self;}};

    -- Get the length of the list
    length() : Int { {abort(); 0;} };

    -- Initialize a new cons
    cons(obj : Object) : List { 
        (new Cons).init(obj, self)
     };

    -- Append a new list at the end of the list
    append(l : List) : List {
        l
    };

    -- Reverse the current list
    reverse() : List {
        self
    };

    (* TODO: store data *)

    add(o : Object): List {
        cons(o)
    };

    toString():String {
        "[ ]\n" 
    };

    merge(other : List): List {
        append(other)
    };

    filterBy(f : Filter): List {
        self
    };

    sortBy(c : Comparator, order : String): List {
        self
    };

    sortHelper(o : Object, c : Comparator) : List {
        self
    };
};

class Cons inherits List {
    car : Object; -- head of the list
    cdr : List; -- tail of the list
    converter : A2I <- new A2I; 

    -- Check if the list is empty
    isNil() : Bool { false };

    -- Get the head of the list
    head() : Object { car };

    -- Get the tail of the list
    tail() : List { cdr };

    -- Get the length of the list
    length() : Int { 1 + tail().length() };

    -- Get the element at an index in the list
    getListAtIndex(i : Int) : Object {
        if i = 0 then
            car
        else
        {
            cdr <- tail();
            cdr.getListAtIndex(i - 1);
        }
        fi
    };

    -- Remove list at index:
    removeListAtIndex(i : Int) : List {
        if i = 0 then
            cdr
        else
            new Cons.init(car, cdr.removeListAtIndex(i - 1))
        fi
    };

    -- Initialize the list with the given head and tail
    init(head : Object, tail : List) : Cons {
        {
            car <- head;
            cdr <- tail;
            self;
        }
    };

    -- Append a new list at the end of the list
    append(l : List) : List {
        if l.isNil() then self
        else 
        let list : List <- new List in
            list <- tail().append(l).cons(head())
        fi
    };

    -- Reverse the current list
    reverse() : List {
        if isNil() then self
        else
        let list : List <- new List in
            list <- tail().reverse().append(list.cons(head()))
        fi
    };

    -- Filter the list by a given filter
    filterBy(f : Filter): List {
        if isNil() then self
        else
            let list: List <- new List in
                if f.filter(head()) then
                    list <- tail().filterBy(f).cons(head())
                else
                    list <- tail().filterBy(f)
                fi
            fi
    };

    -- Sort the list by a given comparator and order
    sortBy(c : Comparator, order : String) : List {
        -- cdr.sortBy(c, order).sortHelper(car, c)
            if order = "ascending" then
                (new List).append(tail().sortBy(c, order).sortHelper(head(), c))
            else
                (new List).append(tail().sortBy(c, order).sortHelper(car, c).reverse())
            fi
    };

    sortHelper(o : Object, c : Comparator) : List {
        if c.compareTo(o, head()) < 0 then
            (new Cons).init(o, self)
        else
            (new Cons).init(head(), tail().sortHelper(o, c))
        fi
    };

    toString() : String
    {
        let result : String <- "[",
            listCopy : List <- copy() in
        {
            while not listCopy.isNil() loop {
                case listCopy.head() of
                    type : IO => result <- result.concat("IO()");
                    type : Int => result <- result.concat("Int(").concat(converter.i2a(type)).concat(")");
                    type : String => result <- result.concat("String(").concat(type).concat(")");
                    type : Bool => result <- result.concat("Bool(").concat(converter.b2a(type)).concat(")");
                    type : Product => result <- result.concat("Product(").concat(type.toString()).concat(")");
                    type : Rank => result <- result.concat("Product(").concat(type.toString()).concat(")");
                    type : List => result <- result.concat(type.toString());
                esac;
                listCopy <- listCopy.tail();

                if not listCopy.isNil() then
                    result <- result.concat(", ")
                else
                    result <- result.concat("]")
                fi;
            } pool;

            result;
        }

    };
};
