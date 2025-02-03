enum CombinationOutcome{
  combined(0),
  accentOnly(1),
  separated(2),
  cleared(3);

  const CombinationOutcome(
    this.value,
  );

 final int value;
}