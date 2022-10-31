class List inherits IO {

    -- Verific daca lista e vida (in cazul asta da)
    isNil() : Bool { true };

    -- Returnez valoarea capatului listei
    head() : Object { {abort(); new Object;} };

    -- Returnez restul listei
    tail() : List { {abort(); new List;} };

    -- Returnez o lista de la un anumit index
    getListAtIndex(i : Int) : Object {{abort(); self;}};

    -- Returnez o lista noua din care elimin o lista la un anumit index
    removeListAtIndex(i : Int) : List {{abort(); self;}};

    -- Initializez un cons nou
    cons(obj : Object) : List { 
        (new Cons).init(obj, self)
     };

    -- Adaug o lista noua la finalul listei curente
    append(l : List) : List {
        l
    };

    -- Reversez lista curenta
    reverse() : List {
        self
    };

    -- Adaug un element nou in lista
    add(o : Object): List {
        cons(o)
    };

    -- Returnez un string nul
    toString():String {
        "" 
    };

    -- Adaug o lista noua la finalul listei curente
    merge(other : List): List {
        append(other)
    };

    -- Filtrez lista curenta folosind un anumit filtru
    filterBy(f : Filter): List {
        self
    };

    -- Sortez lista curenta folosind un anumit comparator
    sortBy(cmp : Comparator): List {
        self
    };

    sortByHelper(e : Object, cmp : Comparator) : Object {
        self
    };
};

class Cons inherits List {
    car : Object; -- capatul listei
    cdr : List; -- restul listei
    converter : A2I <- new A2I; 

    -- Verific daca lista e vida (in cazul asta nu)
    isNil() : Bool { false };

    -- Returnez valoarea capatului listei
    head() : Object { car };

    -- Returnez restul listei
    tail() : List { cdr };

    -- Returnez o lista de la un anumit index
    getListAtIndex(i : Int) : Object {
        if i = 0 then head()
        else tail().getListAtIndex(i - 1)
        fi
    };

    -- Returnez o lista noua din care elimin o lista la un anumit index
    removeListAtIndex(i : Int) : List {
        if i = 0 then cdr
        else new Cons.init(car, cdr.removeListAtIndex(i - 1))
        fi
    };

    -- Construiesc un cons
    init(head : Object, tail : List) : Cons {
        {
            car <- head;
            cdr <- tail;
            self;
        }
    };

    -- Adaug o lista noua la finalul listei curente
    append(l : List) : List {
        if l.isNil() then self
        else 
        let list : List <- new List in
            list <- tail().append(l).cons(head())
        fi
    };

    -- Reversez lista curenta
    reverse() : List {
        if isNil() then self
        else
        let list : List <- new List in
            list <- tail().reverse().append(list.cons(head()))
        fi
    };

    -- Filtrez lista curenta folosind un anumit filtru
    filterBy(f : Filter): List {
        let list: List <- new List in
            if f.filter(head()) then list <- tail().filterBy(f).cons(head())
            else list <- tail().filterBy(f)
            fi
    };

    -- Sortez lista curenta folosind un anumit comparator
    sortBy(c : Comparator) : List {
        let list : List <- new List in
            if cdr.isNil() then self
            else list <- new List.cons(sortByHelper(head(), c)).append(tail().sortBy(c))
            fi
    };

    sortByHelper(o : Object, c : Comparator) : Object {
        if c.compareTo(o, head()) < 0  then o
        else tail().sortByHelper(o, c)
        fi
    };

    -- Transform lista curenta si obiectele din ea intr-un string pentru a le putea afisa
    toString() : String
    {
        let result : String <- "",
            listCopy : List <- self in
        {
            while not listCopy.isNil() loop {
                case listCopy.head() of
                    type : IO => result <- result.concat("IO()");
                    type : Int => result <- result.concat("Int(").concat(converter.i2a(type)).concat(")");
                    type : String => result <- result.concat("String(").concat(type).concat(")");
                    type : Bool => result <- result.concat("Bool(").concat(converter.b2a(type)).concat(")");
                    type : Product => result <- result.concat(type.toString());
                    type : Rank => result <- result.concat(type.toString());
                    type : List => result <- result.concat(type.toString());
                esac;
                listCopy <- listCopy.tail();

                if not listCopy.isNil() then result <- result.concat(", ")
                else result <- result.concat("")
                fi;
            } pool;

            result;
        }
    };
};
