BEGIN {
  FS = "@"
  }
{ printf("%s\n", $2) }