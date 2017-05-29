From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 29 May 2017 10:25:19 +0200
Subject: [LTP] [PATCH v2 1/2] docs: Add running the tests section
Message-ID: <20170529082520.1976-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The simplest/shortest possible guide to installing from source and running the tests.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2 Changes:
* Added an example of running a test with environment variables

 README | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/README b/README
index bf0061c41..f962de3ec 100644
--- a/README
+++ b/README
@@ -30,6 +30,77 @@ Don't run them on production systems. Growfiles, doio, and iogen in particular
 stress the I/O capabilities of systems and while they should not cause problems
 on properly functioning systems, they are intended to find (or cause) problems.
 
+Quick guide to running the tests
+--------------------------------
+
+If you have Git, autoconf, automake, m4, the linux headers and the common
+developer packages installed, the chances are the following will
+work.
+
+$ git clone https://github.com/the-linux-test-project/ltp.git
+$ cd ltp
+$ make autotools
+$ ./configure
+$ make
+$ make install
+
+This will install LTP to /opt/ltp.
+- If you have a problem see doc/mini-howto-building-ltp-from-git.txt.
+- If you still have a problem see INSTALL and './configure --help'.
+- Failing that, ask for help on the mailing list or Github.
+
+Some tests will be disabled if the configure script can not find their build
+dependencies.
+- If a test returns TCONF due to a missing component, check the ./configure
+  output.
+- If a tests fails due to a missing user or group, see the Quick Start section
+  of INSTALL.
+
+To run all the test suites
+
+$ cd /opt/ltp
+$ ./runltp
+
+Note that many test cases have to be executed as root.
+
+To run a particular test suite
+
+$ ./runltp -f syscalls
+
+To run all tests with 'madvise' in the name
+
+$ ./runltp -f syscalls -s madvise
+
+Also see
+
+$ ./runltp --help
+
+Test suites (e.g. syscalls) are defined in the runtest directory. Each file
+contains a list of test cases in a simple format, see doc/ltp-run-files.txt.
+
+Each test case has its own executable or script, these can be executed
+directly
+
+$ testcases/bin/abort01
+
+Some have arguments
+
+$ testcases/bin/fork13 -i 37
+
+The vast majority of test cases accept the -h (help) switch
+
+$ testcases/bin/ioctl01 -h
+
+Many require certain environment variables to be set
+
+$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
+
+Most commonly, the path variable needs to be set and also LTPROOT, but there
+are a number of other variables. runltp usually sets these for you.
+
+Note that all shell scripts need the PATH be set. However this is not limited
+to shell scripts, many C based tests need environment variables as well."
+
 Developers corner
 -----------------
 
-- 
2.12.2

