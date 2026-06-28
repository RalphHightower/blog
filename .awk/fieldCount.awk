BEGIN {
  FS = "|"
  }
{ 
    #if (NF !=4)
        printf("%d:%d:%s\n", NF, NR, $0)
    }