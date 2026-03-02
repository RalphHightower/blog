BEGIN {
  FS = "|"
  }
{ 
    if (NF !=4)
    printf("%s:%d:%d:%s\n", FILENAME, NF, NR, $0) }