BEGIN {
  FS = "|"
  }
{ printf("%d:%d:%s\n", NF, NR, $0) }