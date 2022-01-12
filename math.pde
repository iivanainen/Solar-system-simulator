//Factorial function

int factorial(int n) {
  for (int i=n-1;i>=1;i--) {
    n=n*i;
  }
  return n;
}
