class Main inherits IO{
    lists : List <- new List;
    looping : Bool <- true;
    somestr : String;
    stringTokenizer : StringTokenizer <- new StringTokenizer;
    dispatcher : DispatchObjects <- new DispatchObjects;
    atoi : A2I <- new A2I;

    -- help function
    help() : IO {
        {
            out_string("All available commands are the following:\n");
            out_string("\t* help - prints this message\n");
            out_string("\t* load - waits for some input\n");
            out_string("\t* print - prints all lists from the memory\n");
            out_string("\t* merge index1 index2 - merges the two lists at the given indexes\n");
            out_string("\t* filterBy index {ProductFilter,RankFilter,SamePriceFilter} - filters the list at the given index\n");
            out_string("\t* sortBy index {PriceComparator,RankComparator,AlphabeticComparator} {ascendent,descendent} - sorts the list at the given index\n\n");
            out_string("If the given command is not one of those, the program will automatically exit.\n");
        }
    };

    -- load function
    load() : List {
        {
        let flag : Bool <- true,
            line : String,
            objType : Object,
            currList : List,
            tokens : List <- new List in
            {
                while flag loop
                {
                    line <- in_string();

                    if line = "END" then
                        flag <- false
                    else
                    {

                        -- construiesc lista de tokeni:
                        tokens <- stringTokenizer.init(line, " ").createTokenList();

                        -- construiesc obiectul pe care il voi adauga in lista
                        objType <- dispatcher.castObject(tokens.head());

                        --- adaug noul obiect la lista in functie de tipul lui
                        case objType of
                            type : IO => currList.cons(objType);
                            type : Int => currList.cons(objType.init(atoi.a2i(tokens.tail().head())));
                            type : String => currList.cons(objType.init(tokens.tail().head()));
                            type : Bool => currList.cons(objType.init(atoi.a2b(tokens.tail().head())));
                            type : Soda => currList.cons(objType.init(tokens.tail().head(), tokens.tail().tail().head(), atoi.a2i(tokens.tail().tail().tail().head())));
                            type : Coffee => currList.cons(objType.init(tokens.tail().head(), tokens.tail().tail().head(), atoi.a2i(tokens.tail().tail().tail().head())));
                            type : Laptop => currList.cons(objType.init(tokens.tail().head(), tokens.tail().tail().head(), atoi.a2i(tokens.tail().tail().tail().head())));
                            type : Router => currList.cons(objType.init(tokens.tail().head(), tokens.tail().tail().head(), atoi.a2i(tokens.tail().tail().tail().head())));
                            type : Private => currList.cons(objType.init(tokens.tail().head()));
                            type : Corporal => currList.cons(objType.init(tokens.tail().head()));
                            type : Sergent => currList.cons(objType.init(tokens.tail().head()));
                            type : Officer => currList.cons(objType.init(tokens.tail().head()));
                        esac;
                    }
                    fi;
                }
                pool;
            };

            lists.add(currList);
        }
    };

    -- print function
    print() : IO {
        let i : Int <- 1,
            listCopy : List <- lists in
        {
            while not listCopy.isNil() loop
            {
                if listCopy.head().type_name() = "List" then
                {
                    out_int(i).out_string(": ").concat(listCopy.toString()).out_string("\n");
                    listCopy <- listCopy.tail();
                    i <- i + 1;
                }
                else {
                    listCopy <- listCopy.tail();
                    i <- i + 1;
                } fi;
            } pool;
        }
    };

    -- merge function
    merge(idx1 : String, idx2 : String ) : Object {

        let auxList : List in
        {
            case lists.getListAtIndex(atoi.a2i(idx1 - 1)) of 
            type : List => auxList <- type;
            esac;

            case lists.getListAtIndex(atoi.a2i(idx2 - 1)) of
            type : List => auxList <- auxList.merge(type);
            esac;

            lists <- lists.removeListAtIndex(atoi.a2i(idx1 - 1));
            lists <- lists.append(auxList);
            lists <- lists.removeListAtIndex(atoi.a2i(idx2 - 1)); --maybe de schimbat liniile astea 2 intre ele
        }
    };

    -- filterBy function
    filterBy(idx: String, filter: String): Object {
        let auxList : List,
            applyedFilter : Filter in
        {
            case lists.getListAtIndex(atoi.a2i(idx - 1)) of
            type : List => auxList <- type;
            esac;

            applyedFilter <- dispatcher.castFilter(filter);
            case filter of
            type : ProductFilter => auxList <- auxList.filterBy(applyedFilter);
            type : RankFilter => auxList <- auxList.filterBy(applyedFilter);
            type : SamePriceFilter => auxList <- auxList.filterBy(applyedFilter);
            esac;

            lists <- lists.removeListAtIndex(atoi.a2i(idx - 1));
            lists <- lists.append(auxList);
        }
    };

    -- sortBy function
    sortBy(idx: String, comparator: String, order: String): Object {
        let auxList : List,
            applyedComparator : Comparator in
        {
            case lists.getListAtIndex(atoi.a2i(idx - 1)) of
            type : List => auxList <- type;
            esac;

            applyedComparator <- dispatcher.castComparator(comparator);
            case comparator of
            type : PriceComparator => auxList <- auxList.sortBy(applyedComparator, order);
            type : RankComparator => auxList <- auxList.sortBy(applyedComparator, order);
            type : AlphabeticComparator => auxList <- auxList.sortBy(applyedComparator, order);
            esac;

            lists <- lists.removeListAtIndex(atoi.a2i(idx - 1));
            lists <- lists.append(auxList);
        }
    };

    -- main function
    main():Object {
        let tokens : List in
        {
            load();

            while looping loop
            {
                out_string(">> ");
                somestr <- in_string();
                tokens <- stringTokenizer.init(somestr, " ").createTokenList();

                if tokens.head() = "help" then help()
                else if tokens.head() = "load" then load()
                else if tokens.head() = "print" then print()
                else if tokens.head() = "merge" then merge(tokens.tail().head(), tokens.tail().tail().head())
                else if tokens.head() = "filterBy" then filterBy(tokens.tail().head(), tokens.tail().tail().head())
                else if tokens.head() = "sortBy" then sortBy(tokens.tail().head(), tokens.tail().tail().head(), tokens.tail().tail().tail().head())
                else abort()
                fi fi fi fi fi fi;
            } pool;
        }
    };
};