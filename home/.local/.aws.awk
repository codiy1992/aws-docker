$0 == "[" PROFILE "]" || $0 == "[profile " PROFILE "]" {
    FLAG = 1; next;
}
/\[/ {
    FLAG = 0; next;
}
FLAG == 1 {
    OFS = " *= *";
    if ($1 == "region" || $1 == "output") print "export AWS_DEFAULT_" toupper($1) "=" $2
}
END {
    print "export AWS_DEFAULT_PROFILE=" PROFILE
}
