# Takes input from the bulleted list of topics into one line for tags to include for Jekyll posts 
BEGIN {
    printf("tags: [")
    }
{
    gsub(":", " – ")
    gsub(",", "")
    gsub("?", "")
    if (substr($0, 1, 2) == "- ")
        $0 = substr($0, 2)
    printf("%s%s", (NR > 1 ? ", " : ""), $0)
    }
END {
    printf("]\n")
    }