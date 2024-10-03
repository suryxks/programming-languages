
fun is_older(first:(int*int*int),second:(int*int*int))=
    if (#1 first)<(#1 second)
    then true
    else if (#2 first )<(#2 second) andalso (#1 first)=(#1 second)
    then true
    else if (#3 first)<(#3 second) andalso (#1 first)=(#1 second) andalso (#2 first) =(#2 second)
    then true
    else false

fun number_in_month(dates: (int*int*int) list , month:int)=
    if null dates
    then 0
    else
      let 
          val tl_ans = number_in_month(tl dates , month)
      in 
        if (#2 (hd dates))=month
        then 1 + number_in_month(tl dates , month)
        else number_in_month(tl dates , month)
    end

fun number_in_months(dates: (int*int*int) list , month:int list)=
    if null dates orelse null month
    then 0 
    else number_in_month(dates,hd month) + number_in_months(dates,tl month)

fun dates_in_month (dates: (int*int*int) list , month:int) = 
    if null dates
    then []
    else  
       let 
          val tl_ans=dates_in_month(tl dates,month)
       in
         if (#2 (hd dates))=month
         then (hd dates)::tl_ans
         else tl_ans
       end

fun dates_in_months(dates: (int*int*int) list , month:int list)=
    if null dates orelse null month
    then []
    else dates_in_month(dates,hd month) @ dates_in_months(dates,tl month)

fun get_nth(strlist:string list, n:int)=
    if n=1
    then hd strlist
    else get_nth(tl strlist,n-1)
    

fun date_to_string (date:int*int*int)=
    let 
      val months = ["January", "February", "March", "April",
                  "May", "June", "July", "August", "September",
                  "October", "November", "December"]
    in
       get_nth(months,(#2 date))^ " " ^ Int.toString((#3 date)) ^  ", " ^Int.toString((#1 date))
    end

fun number_before_reaching_sum(sum:int, numlist: int list)=
  if hd numlist >= sum
  then 0
  else
  let 
    fun helper(sum:int, numlist:int list , index:int)=
    if sum - hd numlist <= hd (tl numlist)
    then index
    else  helper(sum - hd(numlist),tl numlist,index+1)
  in
   helper(sum,numlist,1) 
  end
  
fun what_month(num:int)=
    let
      val days=[31,28,31,30,31,30,31,31,30,31,30,31];
    in
     number_before_reaching_sum(num,days) + 1 
    end
    
fun month_range(day1:int,day2:int)=
    if day1>day2
    then []
    else what_month(day1)::month_range(day1+1,day2)

fun oldest(dates:(int*int*int) list)=
    if null dates
    then NONE
    else 
        let
          fun helper(dates : (int*int*int) list)=
                if null(tl dates)
                then hd dates
                else
                  let 
                    val tl_oldest=helper(tl dates)
                    in
                       if is_older(hd dates,tl_oldest)
                       then hd dates
                       else tl_oldest
              end
        in
          SOME(helper dates)
        end
