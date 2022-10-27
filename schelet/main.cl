class Main inherits IO{
    -- lists : List;
    looping : Bool <- true;
    somestr : String;

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

    -- load() :
    -- print() :
    -- merge() :
    -- filterBy():
    -- sortBy() :

    main():Object {
        while looping loop {
            somestr <- in_string();

            if somestr = "help" then
                help()
            else
            {
                out_string("Invalid command received. Exiting program.\n");
                abort();
            }fi;
        } pool
    };
};