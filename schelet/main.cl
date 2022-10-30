class Main inherits IO{
    lists : List <- new List;
    aux : List <- new List;
    looping : Bool <- true;
    somestr : String;
    stringTokenizer : StringTokenizer <- new StringTokenizer;
    -- dispatcher : DispatchObjects <- new DispatchObjects;
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

    -- load function -- moartea pulii mele
    load() : Object {
    {
        let flagLooping : Bool <- true,
            line : String,
            objType : Object,
            currList : List <- new List,
            token : String <- "" in
        {
            -- currList <- new List;

            while flagLooping loop
            {
                line <- in_string();
            
                stringTokenizer <- stringTokenizer.init(" ", line);
                token <- stringTokenizer.getCurrentToken();
                if token = "Soda" then
                    {
                    objType <- new Soda.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), atoi.a2i(stringTokenizer.getCurrentToken()));
                    currList <- currList.add(objType);
                    }
                else if token = "Coffee" then
                {
                    objType <- new Coffee.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), atoi.a2i(stringTokenizer.getCurrentToken()));
                    currList <- currList.add(objType);
                }
                else if token = "Laptop" then
                {
                    objType <- new Laptop.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), atoi.a2i(stringTokenizer.getCurrentToken()));
                    currList <- currList.add(objType);
                }
                else if token = "Router" then
                {
                    objType <- new Router.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), atoi.a2i(stringTokenizer.getCurrentToken()));
                    currList <- currList.add(objType);
                }
                else if token = "Private" then
                {
                    objType <- new Private.init(stringTokenizer.getCurrentToken());
                    currList <- currList.add(objType);
                }
                else if token = "Corporal" then
                {
                    objType <- new Corporal.init(stringTokenizer.getCurrentToken());
                    currList <- currList.add(objType);
                }
                else if token = "Sergent" then
                {
                    objType <- new Sergent.init(stringTokenizer.getCurrentToken());
                    currList <- currList.add(objType);
                }
                else if token = "Officer" then
                {
                    objType <- new Officer.init(stringTokenizer.getCurrentToken());
                    currList <- currList.add(objType);
                }
                else if token = "IO" then
                {
                    objType <- new IO;
                    currList <- currList.add(objType);
                }
                else if token = "Int" then
                {
                    objType <- atoi.a2i(stringTokenizer.getCurrentToken());
                    currList <- currList.add(objType);
                }
                else if token = "String" then
                {
                    objType <- stringTokenizer.getCurrentToken();
                    currList <- currList.add(objType);
                }
                else if token = "Bool" then
                    {
                    objType <- atoi.a2b(stringTokenizer.getCurrentToken());
                    currList <- currList.add(objType);
                    }   
                else {flagLooping <- false;}
                fi fi fi fi fi fi fi fi fi fi fi fi;
            }
            pool;
            lists <- lists.add(new List.cons(currList.reverse()));
        };
    }
    };

    -- print function
    print() : Object {
        let i : Int <- 1,
            listCopy : List <- lists.reverse() in
        {
            while not listCopy.isNil() loop
            {
                out_int(i).out_string(": [ ").out_string(new List.cons(listCopy.head()).toString()).out_string(" ]\n");
                listCopy <- listCopy.tail();
                i <- i + 1;
            } pool;
        }
    };

    print_idx(idx: String) : Object {self};

    -- merge function
    merge(idx1 : String, idx2 : String ) : List {
        let auxList : List,
            listCopy : List <- lists.reverse() in
        {
            -- out_string("aici\n");
            -- case lists.getListAtIndex((atoi.a2i(idx1))).head() of 
            -- type : List => {auxList <- type;};-- out_string(auxList.toString()).out_string("\n"); out_string("1\n");};
            -- esac;
                -- out_string(lists.getListAtIndex(atoi.a2i(idx1) - 1).toString()).out_string("\n");
                -- auxList <- new List.cons(lists.getListAtIndex(atoi.a2i(idx1)));
                -- out_string(auxList.toString()).out_string("\n");
                -- auxList <- auxList.append(lists.getListAtIndex(atoi.a2i(idx2)));
                -- out_string(auxList.toString()).out_string("\n");

                auxList <- new List.cons(listCopy.getListAtIndex((atoi.a2i(idx1) - 1)).append(listCopy.getListAtIndex((atoi.a2i(idx2) - 1))));
                -- out_string(auxList.toString()).out_string("\n");

                    listCopy <- listCopy.removeListAtIndex((atoi.a2i(idx2) -1));
                    listCopy <- listCopy.removeListAtIndex((atoi.a2i(idx1) -1));
                    -- listCopy <- listCopy.add(auxList.reverse());

                    lists <- listCopy.reverse();
                    lists <- lists.add(new List.cons(auxList.reverse()));
                    -- lists <- lists.add(listCopy);
                -- lists <- lists.add(auxList.reverse());
                -- lists <- lists.removeListAtIndex((atoi.a2i(idx1) - 1));--.removeListAtIndex((atoi.a2i(idx2) - 1));

                -- lists <- listCopy.removeListAtIndex((atoi.a2i(idx2) - 1));

                -- lists.removeListAtIndex(atoi.a2i(idx1));
            -- lists <- lists.removeListAtIndex(atoi.a2i(idx2));
-- 
            -- lists <- lists.removeListAtIndex(atoi.a2i(idx2) - 1);
            -- lists <- lists.removeListAtIndex(atoi.a2i(idx2));

            -- lists <- listCopy;

            
            -- lists



                -- out_string(listCopy.getListAtIndex(atoi.a2i(idx2) - 1).toString()).out_string("\n");
            -- out_string("aici2\n");
            -- case listCopy.getListAtIndex((atoi.a2i(idx2))).head() of
            -- type : List => {auxList <- auxList.append(type); out_string("aici4\n");out_string(auxList.toString()).out_string("\n");};
            -- esac;

            -- lists <- lists.removeListAtIndex((atoi.a2i(idx1)));
            -- lists <- lists.add(auxList.reverse());
            -- lists.getListAtIndex(atoi.a2i(idx1) - 1) <- auxList;
            -- out_string("aici3\n");
            -- lists <- lists.append(auxList);
            -- auxList;
            -- lists <- lists.removeListAtIndex((atoi.a2i(idx2)));
             --maybe de schimbat liniile astea 2 intre ele
        }
    };

    -- filterBy function
    filterBy(idx: String, filter: String): Object {
        let auxList : List,
            applyedFilter : Filter in
        {
            case lists.getListAtIndex(atoi.a2i(idx) - 1) of
            type : List => auxList <- type;
            esac;

            if filter = "ProductFilter" then
                applyedFilter <- new ProductFilter
            else if filter = "RankFilter" then
                applyedFilter <- new RankFilter
            else if filter = "SamePriceFilter" then
                applyedFilter <- new SamePriceFilter
            else
                out_string("Invalid filter name!\n")
            fi fi fi;
            -- applyedFilter <- dispatcher.castObject(filter);
            -- case filter of
            -- type : ProductFilter => auxList <- auxList.filterBy(applyedFilter);
            -- type : RankFilter => auxList <- auxList.filterBy(applyedFilter);
            -- type : SamePriceFilter => auxList <- auxList.filterBy(applyedFilter);
            -- esac;
            auxList <- auxList.filterBy(applyedFilter);
            lists <- lists.removeListAtIndex(atoi.a2i(idx) - 1);
            lists <- lists.append(auxList);
        }
    };

    -- sortBy function
    sortBy(idx: String, comparator: String, order: String): Object {
        let auxList : List,
            applyedComparator : Comparator in
        {
            case lists.getListAtIndex(atoi.a2i(idx) - 1) of
            type : List => auxList <- type;
            esac;

            if comparator = "PriceComparator" then
                applyedComparator <- new PriceComparator
            else if comparator = "RankComparator" then
                applyedComparator <- new RankComparator
            else if comparator = "AlphabeticComparator" then
                applyedComparator <- new AlphabeticComparator
            else
                out_string("Invalid comparator name!\n")
            fi fi fi;
            -- applyedComparator <- dispatcher.castObject(comparator);
            -- case comparator of
            -- type : PriceComparator => auxList <- auxList.sortBy(applyedComparator, order);
            -- type : RankComparator => auxList <- auxList.sortBy(applyedComparator, order);
            -- type : AlphabeticComparator => auxList <- auxList.sortBy(applyedComparator, order);
            -- esac;
            auxList <- auxList.sortBy(applyedComparator, order);
            lists <- lists.removeListAtIndex(atoi.a2i(idx) - 1);
            lists <- lists.append(auxList);
        }
    };

    -- main function
    main():Object {
        let token : String <- "",
            param : String <- "" in
        {
            load();
            while looping loop
            {
                -- out_string(">> ");
                somestr <- in_string();
                stringTokenizer <- stringTokenizer.init(" ", somestr);
                token <- stringTokenizer.getCurrentToken();

                if token = "help" then help()
                else if token = "load" then load()
                else if token = "print" then print()
                else if token = "merge" then merge(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken()) 
                else looping <- false
                fi fi fi fi;
            } pool;
        }
    };
};