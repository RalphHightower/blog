# Takes input from the bulleted list of topics, builds and outputs to replace in Jekyll blog headers:
# 1) "tags: […]"
# 2) extracts keywords from tags, outputs 'categories : […]"
BEGIN {
    FS = "《"
    tags = "tags: ["
    KEYWORDS = ",keywords,"
    len_KEYWORDS = length(KEYWORDS)
    # Stop categories flags. First one signals the end of the keyword section
    STOP = ",organizations,|,events,|,political parties,"
    cntStop = split(STOP, STOP_FLAGS, "|")
    }

{
    gsub(":", "– ")
    gsub(",", "")
    gsub("?", "")
    gsub("#", "")
    #gsub(" #", " ")
    if (substr($0, 1, 2) == "- ")
        $0 = substr($0, 2)
    if (length($0) > 0)
        tags = tags sprintf("%s%s", (NR > 1 ? "," : ""), $0)
    }

END {
    tags = tags "]"
    beg_KW = index(tags, KEYWORDS)
    # printf("#DEBUG900: length(tags)=%d\nbeg_KW=%d\n", length(tags), beg_KW)
    if (beg_KW > 0) {
        categories = "categories: []"
        end_KW = 32767
        for (ndx = 1; ndx <= cntStop; ndx ++) {
            s_stop = index(tags, STOP_FLAGS[ndx])
            # printf("#DEBUG910: flag[%d]=|%s|, s_stop: %d\n", ndx, STOP_FLAGS[ndx], s_stop)
            if (s_stop > 0) {
                end_KW = (min(s_stop, end_KW) ? s_stop : end_KW)
                }
            # printf("#DEBUG920: END_KW: |%s|, s_stop: %d, end_KW: %d\n", STOP_FLAGS[ndx], s_stop, end_KW)
            }
        if ((end_KW > 0) && (end_KW < length(tags))) {
            # printf("#DEBUG825: drop=|%s|\n", substr(tags, end_KW))
            }
        # printf("#DEBUG930: length(%s) = %d\n", tags, length(tags))
        if ((beg_KW * end_KW) > 0) {
            s_begin = beg_KW + len_KEYWORDS
            s_len = end_KW - s_begin 
            categories = "categories: [" substr(tags, s_begin, s_len) "]"
            # printf("#DEBUG950: s_begin: %d, s_len: %d\n", beg_KW, s_len)
            }
        printf("%s\n%s\n", tags, categories)
        
        }
    }
    
function min(x, y) {
    return (x < y)
    }