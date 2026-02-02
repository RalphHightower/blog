# Part 1 to create a unified Jekyll categories tag for a group of posts
# Outputs just the Jekyll categories tag. Append the output to a file for sorting and post-processing. 
BEGIN {
    FS = ","
    CAT_BGN = "categories: ["
    lenBgn = length(CAT_BGN)
    CAT_END = "]"
    }
/^categories: \[/ {
    categories = $0
    gsub(" [ ]*", " ", categories)
    #gsub("categories: [", " ", categories)
    #gsub("]", " ", categories)
    
    bgn = index(categories, CAT_BGN)
    if (bgn > 0)
        categories = substr(categories, bgn + lenBgn)
        
    end = index(categories, CAT_END)
    if (end > 0)
        categories = substr(categories, 1, end - 1)
    
    cnt = split(categories, aCat, ",")
    for (ndx = 1; ndx <= cnt; ndx ++) {
        if (length(aCat[ndx]) > 0) {
            printf("%d:%s\n", ndx, aCat[ndx])
            }
        }
    }
