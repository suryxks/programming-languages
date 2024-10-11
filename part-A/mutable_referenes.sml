val x = ref 42

val y = ref 42

val z = x

val _ = x:=43

val w = (!y) + (!z)

val cbs:(int->unit) list ref=ref []

fun onKeyEvent f = cbs:=f::(!cbs)
