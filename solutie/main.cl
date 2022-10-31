class Main inherits IO{
    lists : List <- new List;
    looping : Bool <- true;
    somestr : String;
    stringTokenizer : StringTokenizer <- new StringTokenizer;
    converter : A2I <- new A2I;

    -- help function
    help() : IO {
        {
            out_string("All available commands are the following:\n");
            out_string("\t* help - prints this message\n");
            out_string("\t* load - waits for some input\n");
            out_string("\t* print (index) - prints all lists from the memory or a list at a given index\n");
            out_string("\t* merge index1 index2 - merges the two lists at the given indexes\n");
            out_string("\t* filterBy index {ProductFilter,RankFilter,SamePriceFilter} - filters the list at the given index\n");
            out_string("\t* sortBy index {PriceComparator,RankComparator,AlphabeticComparator} {ascendent,descendent} - sorts the list at the given index\n\n");
            out_string("If the given command is not one of those, the program will automatically exit.\n");
        }
    };

    -- load function
    load() : Object {
        let flagLooping : Bool <- true,
            auxList : List <- new List,
            token : String <- "",
            line : String,
            objType : Object in
        {
            while flagLooping loop
            {
                line <- in_string();
            
                stringTokenizer <- stringTokenizer.init(" ", line);
                token <- stringTokenizer.getCurrentToken();

                if token = "Soda" then
                {
                    objType <- new Soda.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), converter.a2i(stringTokenizer.getCurrentToken()));
                    auxList <- auxList.add(objType);
                }
                else if token = "Coffee" then
                {
                    objType <- new Coffee.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), converter.a2i(stringTokenizer.getCurrentToken()));
                    auxList <- auxList.add(objType);
                }
                else if token = "Laptop" then
                {
                    objType <- new Laptop.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), converter.a2i(stringTokenizer.getCurrentToken()));
                    auxList <- auxList.add(objType);
                }
                else if token = "Router" then
                {
                    objType <- new Router.init(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), converter.a2i(stringTokenizer.getCurrentToken()));
                    auxList <- auxList.add(objType);
                }
                else if token = "Private" then
                {
                    objType <- new Private.init(stringTokenizer.getCurrentToken());
                    auxList <- auxList.add(objType);
                }
                else if token = "Corporal" then
                {
                    objType <- new Corporal.init(stringTokenizer.getCurrentToken());
                    auxList <- auxList.add(objType);
                }
                else if token = "Sergent" then
                {
                    objType <- new Sergent.init(stringTokenizer.getCurrentToken());
                    auxList <- auxList.add(objType);
                }
                else if token = "Officer" then
                {
                    objType <- new Officer.init(stringTokenizer.getCurrentToken());
                    auxList <- auxList.add(objType);
                }
                else if token = "IO" then
                {
                    objType <- new IO;
                    auxList <- auxList.add(objType);
                }
                else if token = "Int" then
                {
                    objType <- converter.a2i(stringTokenizer.getCurrentToken());
                    auxList <- auxList.add(objType);
                }
                else if token = "String" then
                {
                    objType <- stringTokenizer.getCurrentToken();
                    auxList <- auxList.add(objType);
                }
                else if token = "Bool" then
                {
                    objType <- converter.a2b(stringTokenizer.getCurrentToken());
                    auxList <- auxList.add(objType);
                } 
                else {flagLooping <- false;}
                fi fi fi fi fi fi fi fi fi fi fi fi;
            }
            pool;

            lists <- lists.add(new List.cons(auxList.reverse()));
        }
    };

    -- print function
    print(idx : String) : Object {
        let i : Int <- 1,
            newL : List,
            auxList : List <- lists.reverse(),
            listCopy : List <- lists.reverse() in
        {
            if not auxList.tail().isNil() then
            {
                if not idx = "" then 
                {
                    newL <- new List.cons(listCopy.getListAtIndex(converter.a2i(idx)- 1));
                    out_string("[ ").out_string(newL.toString()).out_string(" ]\n");
                }
                else
                while not listCopy.isNil() loop
                {
                    out_int(i).out_string(": [ ").out_string(new List.cons(listCopy.head()).toString()).out_string(" ]\n");
                    listCopy <- listCopy.tail();
                    i <- i + 1;
                } pool
                fi;
            }
            else out_string("[ ").out_string(new List.cons(listCopy.head()).toString()).out_string(" ]\n")
            fi;
        }
    };

    --merge function
    merge(idx1 : String, idx2 : String ) : List {
        let newL1 : List,
            newL2 : List,
            auxList : List,
            listCopy : List <- lists.reverse() in
        {
            -- preiau listele de la indecsii primiti ca param
            newL1 <- new List.cons(listCopy.getListAtIndex(converter.a2i(idx1)- 1));
            newL2 <- new List.cons(listCopy.getListAtIndex(converter.a2i(idx2)- 1));
            -- unesc cele doua liste obtinue
            auxList <- new List.cons(newL1).append(newL2).reverse();
            -- elimin listele de la indescii utilizati
            listCopy <- listCopy.removeListAtIndex((converter.a2i(idx2) -1));
            listCopy <- listCopy.removeListAtIndex((converter.a2i(idx1) -1));
            -- updatez lista de liste cu noua lista formata
            lists <- listCopy.reverse();
            lists <- lists.add(new List.cons(auxList.reverse()));
        }
    };

    -- filterBy function
    filterBy(idx: String, filter: String): List {
        let newL : Object,
            auxList : List,
            listCopy : List <- lists.reverse() in
        {
            -- preiau lista de la indexul primit ca parametru
            newL <- listCopy.getListAtIndex(converter.a2i(idx)- 1);
            case newL of
                type : List =>
                {
                    case type.head() of
                        type2 : List =>
                        {
                            -- aplic filtrul pe lista preluata
                            if filter = "ProductFilter" then auxList <- type2.filterBy(new ProductFilter)
                            else if filter = "RankFilter" then auxList <- type2.filterBy(new RankFilter)
                            else if filter = "SamePriceFilter" then auxList <- type2.filterBy(new SamePriceFilter)
                            else auxList <- new List
                            fi fi fi;
                        };
                    esac;
                };
            esac;

            -- elimin lista de la indexul primit ca parametru
            listCopy <- listCopy.removeListAtIndex((converter.a2i(idx) -1));
            -- updatez lista de liste cu noua lista formata
            listCopy <- listCopy.add(new List.cons(auxList));
            lists <- listCopy.reverse();
        }
    };

    -- sortBy function
    sortBy(idx: String, comparator: String, order: String): List {
        let newL : Object,
            auxList : List,
            listCopy : List <- lists.reverse() in
        {
            -- preiau lista de la indexul primit ca parametru
            newL <- listCopy.getListAtIndex(converter.a2i(idx)- 1);
            case newL of
                type : List =>
                {
                    case type.head() of
                        type2 : List =>
                        {
                            -- fac sortarea pe lista preluata
                            if comparator = "PriceComparator" then auxList <- type2.sortBy(new PriceComparator)
                            else if comparator = "RankComparator" then auxList <- type2.sortBy(new RankComparator)
                            else if comparator = "AlphabeticComparator" then auxList <- type2.sortBy(new AlphabeticComparator)
                            else auxList <- new List
                            fi fi fi;
                        };
                    esac;
                };
            esac;
        
            -- elimin lista de la indexul primit ca parametru si o adaug pe cea sortata in functie de ordine
            listCopy <- listCopy.removeListAtIndex((converter.a2i(idx) -1));

            if order = "ascendent" then listCopy <- listCopy.add(new List.cons(auxList))
            else listCopy <- listCopy.add(new List.cons(auxList.reverse()))
            fi;

            -- updatez lista de liste cu noua lista formata
            lists <- listCopy.reverse();
        }       
    };

    -- main function
    main():Object {
        let token : String <- "" in
        {
            load();
            while looping loop
            {
                somestr <- in_string();
                stringTokenizer <- stringTokenizer.init(" ", somestr);
                token <- stringTokenizer.getCurrentToken();

                if token = "help" then help()
                else if token = "load" then load()
                else if token = "print" then print(stringTokenizer.getCurrentToken()) 
                else if token = "merge" then merge(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken())
                else if token = "filterBy" then filterBy(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken())
                else if token = "sortBy" then sortBy(stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken(), stringTokenizer.getCurrentToken())
                else looping <- false
                fi fi fi fi fi fi;
            } pool;
        }
    };
};