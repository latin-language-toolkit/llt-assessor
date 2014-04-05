As weekend cannot be avoided, some thoughts

Mirror llt-review a bit

- Create a base Assessor class
- A Treebank and an Alignment class should inherit from it
- Could use the HashContainable architecture again, but it's not
  absolutely needed.
- API should take an array of assessments/gradings one would like to
  have returned. Think about default values
- Every Assessor should come with a description of itself. This might be
 useful for HTML views who could provide some info about what is
displayed here.
- Not sure where to do this. A conll-metric class could include the
  description in it's top-level probably and then include the different
scores in it's container.
- Other approach would be to pass it down to the indiviual contained
  elements, in the case of conll this would be something like 'LAS'.
- Probably do both, a general description on how the indiviual scores
  connect with each other, if they do, and a more specific descripion of
each individual element.

