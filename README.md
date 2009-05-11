# DGFrameworkTests

This is a test suite for the [DataGraph framework][framework], a
commercially available 2D plotting framework available from [Visual Data
Tools][vdt] along with the companion [Datagraph][app] application.

[framework]: http://www.visualdatatools.com/DataGraph/Framework/
[app]: http://www.visualdatatools.com/DataGraph/
[vdt]: http://www.visualdatatools.com

DataGraph.app and the companion framework are frequently updated with new
features. However, aside from example applications, there are no publicly
available tests to ensure that methods in the framework continue to work as
expected after updates. In the course of using the framework through various
versions, I have started to build a small test suite to ease the pain of
updates to custom applications.

The test application uses [GHUnit][], which is compatible with SenTestKit,
but is more flexible, and allows easier interactions with the debugger.

[GHUnit]: http://github.com/gabriel/gh-unit/tree/master

## Requirements

The test suite is currently configured to use DataGraph.framework located in
one of the system search paths (/Library/Frameworks or ~/Library/Frameworks).
[Download DataGraph.framework][download-framework] and install it in one of
those locations.

[download-framework]: http://www.visualdatatools.com/DataGraph/DataGraphFramework.dmg

## Instructions

1. Install DataGraph.framework in /Library/Frameworks
2. Clone (or fetch the latest) version of this repo from GitHub.
3. Open the project in Xcode
4. Click Build & Go.

### Do I need a DataGraph license?

Chances are that if you are running this test suite, it is because you've
already realized how useful DataGraph is, and have purchased the App, which
gives you full access to the framework. If not, then you should still be able
to run the test suite.

short answer: NO.  The tests will run without a license.

## Contributing

Please add tests. I will eventually add tests for every feature that I use,
but I don't use every feature. If you use something that isn't tested, please
[fork this repo and submit a patch][forking].

[forking]: http://github.com/guides/fork-a-project-and-submit-your-modifications

## Where should I report DataGraph.framework bugs?

Please post a message on the [DataGraph framework forum][forum]. The author of
DataGraph, David Adalsteinsson, is very responsive and usually fixes things
quickly. You can help expedite the process by:

1. forking this repository
2. adding a failing test case
3. posting a link to your forked version
4. sending a pull request

[forum]: http://www.visualdatatools.com/phpBB2/viewforum.php?f=10

## License

This test suite is released under the MIT License. See the LICENSE file for
details.