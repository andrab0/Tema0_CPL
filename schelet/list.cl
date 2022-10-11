class List {
    (* Define operations on empty lists *)
    --TODO -- MODIFICA STRING CU OBJECT DUPA CE VERIFICI TOT
    
    (* Checks if the list is empty *)
    isNil() : Bool {
        {
            abort();
            true;
        }
    };

    (* Returns the first element of the list *)
    getHead() : String  {
        {
            abort();
            new String;
        }
    };

    (* Returns the tail of the list *)
    getTail() : List {
        {
            abort();
            self;
        }
    };

    (* Returns the length of the list *)
    getLength() : Int {
        0
    };

    cons(o : String) : List {
        let newElement : Cons <- new Cons in
            newElement.init(o, self)
    };

    reverseList() : List {
        {
            abort();
            self;   
        }
    };

    -- (* TODO: store data *)

    add(o : String) : List {
        let newElement : Cons <- new Cons in
            newElement.init(o, self)
    };

    -- toString():String {
    --     "[TODO: implement me]"
    -- };

    -- merge(other : List):SELF_TYPE {
    --     self 
    -- };

    -- filterBy():SELF_TYPE {
    --     self 
    -- };

    -- sortBy():SELF_TYPE {
    --     self 
    -- };
};

class Cons inherits List {
    (* Define operations on generic lists *)

    car : String; -- first element in list
    cdr : List; -- rest of list

    (* Checks if the list is empty *)
    isNil(): Bool {
        false
    };

    (* Returns the first element of the list *)
    getHead(): String {
        car
    };

    (* Returns the tail of the list *)
    getTail(): List {
        cdr
    };

    (* Initialize new list *)
    init(head : String, tail : List): List {
        { 
            car <- head;
            cdr <- tail;
            self;
        }
    };

    (* Add a new object at the end of the list 
        -- reversedList - reverse the list before adding the new element
                          to be able to add the new element at the beggining
        -- newList - new list with the new element added and reversed to 
                     represent the new list in the correct order
    *)
    add(o : String) : List {
        let reversedList : List <- self.reverseList(),
            newList : List <- reversedList.cons(o) in
            newList <- newList.reverseList()
    };

    

    --  (* Reverse a list *)
    --   reverseList() : List {
    --       (let reversedList : List <- (new List).cons(getHead()),
    --           auxList : List <- getTail(),
    --           newl : Cons in
    --           {
    --             -- rever
    --             -- newl <- newl.init(reversedList.getHead(), reverseListHelper(auxList));
    --           reversedList <- newl.init("z", reverseListHelper(auxList));
    --         }
    --       )
    --   };

    --   (* Helper function for reverseList *)
    --   reverseListHelper(newList : List) : List {
    --       if not newList.isNil() then
    --           (let auxList : Cons <- new Cons in
    --               auxList.init(newList.getHead(), newList)
    --           ).reverseListHelper(newList.getTail())
    --       else
    --           newList
    --       fi
    --   };

};

class Main inherits IO {

    myList : List <- new List;
    obj : Object <- new Object;

    print_list(l : List) : Object {
      if l.isNil() then out_string("\n")
                   else {
			   out_string(l.getHead());
			   out_string(" ");
			   print_list(l.getTail());
		        }
      fi
   };

    main() : Object {
      {
	--  mylist <- new List.cons(obj);
	--  while (not mylist.isNil()) loop
	--     {
	--     --    print_list(mylist);
	--        mylist <- mylist.getTail();
	--     }
	--  pool;

        myList <- myList.cons("a").cons("b").cons("c").cons("d").cons("e");
    --  myList <- myList.add("a");
    --  myList <- myList.add("b");
    --     myList <- myList.add("c");
    --     myList <- myList.add("d");

        while (not myList.isNil()) loop
            {   
                print_list(myList);
                myList <- myList.getTail();
            } pool;
      }
   };
};