package;

import tink.unit.*;
import tink.testrunner.*;
import mime.Mime;

@:asserts
class RunTests {

  static function main() {
    Runner.run(TestBatch.make([
      new RunTests(),
    ])).handle(Runner.exit);
  }

  public function new() {}

  public function testLookup() {
    asserts.assert(Mime.lookup('test.json') == 'application/json');
    asserts.assert(Mime.lookup('test.txt') == 'text/plain');
    return asserts.done();
  }

  public function testExtension() {
    asserts.assert(Mime.extension('application/json') == 'json');
    asserts.assert(Mime.extension('text/plain') == 'txt');
    return asserts.done();
  }

}