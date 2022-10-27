(* Think of these as abstract classes *)
class Comparator {
    compareTo(o1 : Object, o2 : Object):Int {0};
};

class Filter {
    filter(o : Object):Bool {true};
};

(* TODO: implement specified comparators and filters*)

class ProductFilter inherits Filter
{
    filter(o : Object): Bool {
        case o of
            type : Product => true;
            type : Object => false;
        esac
    };
};

class RankFilter inherits Filter
{
    filter(o : Object): Bool {
        case o of
            type : Rank => true;
            type : Object => false;
        esac
    };
};

class SamePriceFilter inherits Filter
{
    filter(o : Object): Bool {
        case o of
            type : Product => type.getprice() = type@Product.getprice();
            type : Object => false;
        esac
    };
};

class PriceComparator inherits Comparator
{
    compareTo(o1 : Object, o2: Object) : Int {
        let firstPrice : Int,
            secondPrice : Int in
        {
            case o1 of
                type : Product => firstPrice <- type.getprice();
                type : Object => {0-1; abort();};
            esac;

            case o2 of
                type : Product => secondPrice <- type.getprice();
                type : Object => {0-1; abort();};
            esac;

            firstPrice - secondPrice;
        }

    };
};

class RankComparator inherits Comparator
{
    compareTo(o1 : Object, o2 : Object) : Int {
        let firstRank : Int,
            secondRank : Int in
        {
            case o1 of
                type : Private => firstRank <- 1;
                type : Corporal => firstRank <- 2;
                type : Sergent => firstRank <- 3;
                type : Officer => firstRank <- 4;
                type : Object => { firstRank <- 0-1; abort();};
            esac;
            
            case o2 of
                type : Private => secondRank <- 1;
                type : Corporal => secondRank <- 2;
                type : Sergent => secondRank <- 3;
                type : Officer => secondRank <- 4;
                type : Object => { secondRank <- 0-1; abort();};

            esac;

            firstRank - secondRank;
        }
    };
};

class AlphabeticComparator inherits Comparator
{
    compareTo(o1 : Object, o2 : Object) : Int {
        -- let firstStr : Bool,
        --     secondStr : Bool,
        --     result : Int in
        -- {
        --     case o1 of 
        --         type : String => firstStr <- true;
        --         type : Object => firstStr <- false;
        --     esac;

        --     case o2 of
        --         type : String => secondStr <- true;
        --         type : Object => secondStr <- false;
        --     esac;

        --     if not firstStr then
        --         abort()
        --     else
        --         if not secondStr then
        --             abort()
        --         else
        --             result <- compareStrs(o1, o2)
        --         fi
        --     fi;

        --     result;
        -- }
        -- {
            let result : Int <- 0-2 in
            {
                if o1.type_name() = "String" then
                    if o2.type_name() = "String" then
                        result = compareStrs(o1, o2)
                    else
                        abort()
                    fi
                else
                    abort()
                fi;

                result;
            }
    };

    compareStrs(s1 : Object, s2: Object) : Int {
        if s1 < s2 then
            0-1
        else 
            if s2 < s1 then
                1
            else
                0
            fi
        fi
    };
};

-- TODO
-- class SamePriceFilter inherits Filter
-- {
--     filter(o : Object): Bool {
--         case o of
--             o : SamePrice => true;
--             o : Object => false;
--         esac
--     };

-- };


-- Din codul de la curs, sursa moodle
(*
   The class A2I provides integer-to-string and string-to-integer
conversion routines.  To use these routines, either inherit them
in the class where needed, have a dummy variable bound to
something of type A2I, or simpl write (new A2I).method(argument).
*)


(*
   c2i   Converts a 1-character string to an integer.  Aborts
         if the string is not "0" through "9"
*)
class A2I {

    c2i(char : String) : Int {
        if char = "0" then 0 else
        if char = "1" then 1 else
        if char = "2" then 2 else
        if char = "3" then 3 else
        if char = "4" then 4 else
        if char = "5" then 5 else
        if char = "6" then 6 else
        if char = "7" then 7 else
        if char = "8" then 8 else
        if char = "9" then 9 else
        { abort(); 0; }  -- the 0 is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
    };

(*
  i2c is the inverse of c2i.
*)
    i2c(i : Int) : String {
        if i = 0 then "0" else
        if i = 1 then "1" else
        if i = 2 then "2" else
        if i = 3 then "3" else
        if i = 4 then "4" else
        if i = 5 then "5" else
        if i = 6 then "6" else
        if i = 7 then "7" else
        if i = 8 then "8" else
        if i = 9 then "9" else
        { abort(); ""; }  -- the "" is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
    };

(*
  a2i converts an ASCII string into an integer.  The empty string
is converted to 0.  Signed and unsigned strings are handled.  The
method aborts if the string does not represent an integer.  Very
long strings of digits produce strange answers because of arithmetic 
overflow.

*)
    a2i(s : String) : Int {
        if s.length() = 0 then 0 else
            if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
                if s.substr(0,1) = "+" then a2i_aux(s.substr(1,s.length()-1)) else
                    a2i_aux(s)
        fi fi fi
    };

(*
 a2i_aux converts the usigned portion of the string.  As a programming
example, this method is written iteratively.
*)
    a2i_aux(s : String) : Int {
        (let int : Int <- 0 in  
            {    
                (let j : Int <- s.length() in
                    (let i : Int <- 0 in
                        while i < j loop
                        {
                            int <- int * 10 + c2i(s.substr(i,1));
                            i <- i + 1;
                        }
                        pool
                    )
                );
                int;
            }
        )
    };

(*
   i2a converts an integer to a string.  Positive and negative 
numbers are handled correctly.  
*)
   i2a(i : Int) : String {
    if i = 0 then "0" else 
        if 0 < i then i2a_aux(i) else
            "-".concat(i2a_aux(i * ~1)) 
        fi fi
   };
   
(*
   i2a_aux is an example using recursion.
*)      
   i2a_aux(i : Int) : String {
        if i = 0 then "" else 
            (let next : Int <- i / 10 in
                i2a_aux(next).concat(i2c(i - next * 10))
            )
        fi
   };

--    metoda pentru tipul bool
   b2a(b : Bool) : String {
        if b then "true" else "false" fi
   };

};


--  TODO: de sters tot de aici in jos:
(*******************************
 *** Classes Product-related ***
 *******************************)
 class Product {
    name : String;
    model : String;
    price : Int;

    init(n : String, m: String, p : Int):SELF_TYPE {{
        name <- n;
        model <- m;
        price <- p;
        self;
    }};

    getprice():Int{ price * 119 / 100 };

    toString():String {
        "TODO: implement me"
    };
};

class Edible inherits Product {
    -- VAT tax is lower for foods
    getprice():Int { price * 109 / 100 };
};

class Soda inherits Edible {
    -- sugar tax is 20 bani
    getprice():Int {price * 109 / 100 + 20};
};

class Coffee inherits Edible {
    -- this is technically poison for ants
    getprice():Int {price * 119 / 100};
};

class Laptop inherits Product {
    -- operating system cost included
    getprice():Int {price * 119 / 100 + 499};
};

class Router inherits Product {};

(****************************
 *** Classes Rank-related ***
 ****************************)
class Rank {
    name : String;

    init(n : String):String {
        name <- n
    };

    toString():String {
        -- Hint: what are the default methods of Object?
        "TODO: implement me"
    };
};

class Private inherits Rank {};

class Corporal inherits Private {};

class Sergent inherits Corporal {};

class Officer inherits Sergent {};

class Main inherits IO
{
    
    main() : Object {
        abort()
    };

};