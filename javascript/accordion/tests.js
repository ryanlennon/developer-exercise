$(document).ready(function() {
  module("Accordion tests");

  test("example test", function() {
    ok(true);
  });

  test("This is a test", function() {
    ok(testThis, "This is a test");
  });

  test("The actSection isn't nil", function() {
    ok(actSection.length !== 0, "Accordion header isn't nil");
  });

  test("actSection is an object", function() {
    equal("object", typeof(actSection), "actSection is an object");
  });

});
