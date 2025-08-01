{ if (NR == 1)
    prior = $0
  else {
    if ($0 == prior)
      printf("%d:%s\n", NR, $0)
    prior = $0
    }
  }