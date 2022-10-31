class StringTokenizer inherits IO
{
    separator : String;
    string : String;
    stringLen : Int;
    currentPos : Int;

    init(separatorIn : String, stringIn : String) : StringTokenizer {
        {
            separator <- separatorIn;
            string <- stringIn;
            stringLen <- string.length();
            currentPos <- 0;
            self;
        }
    };

    -- Construiesc un string in care adaug caracter cu caracter pana la separator
    getCurrentToken() : String {
        let currToken : String <- "",
            currPos : Int <- currentPos in
        {
            while currPos < stringLen loop
            {
                if  not string.substr(currentPos, 1) = separator then
                    {
                        currToken <- currToken.concat(string.substr(currentPos, 1));
                        currentPos <- currentPos + 1;
                        currPos <- currentPos;
                    }
                else
                    {
                        currentPos <- currentPos + 1;
                        currPos <- stringLen;
                    }
                fi;
            }pool;

            currToken;
        }
    };
};
