class Filter {
    filter(o : Object):Bool {true};
};

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

class Comparator {
    compareTo(o1 : Object, o2 : Object):Int {0};
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
