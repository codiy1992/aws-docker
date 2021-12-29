$0 == "[" PROFILE "]" || $0 == "[profile " PROFILE "]" {
    FLAG = 1; next;
}
/\[/ {
    FLAG = 0; next;
}
FLAG == 1 {
    OFS = " *= *";
    $1 == "region" && $1 = "AWS_DEFAULT_REGION"
    $1 == "output" && $1 = "AWS_DEFAULT_OUTPUT"
    if ($1 != "") print "export " toupper($1) "=" $2
}
END {
    print "export AWS_DEFAULT_PROFILE=" PROFILE
}
