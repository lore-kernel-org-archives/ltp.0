From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 25 May 2017 13:57:44 +0200
Subject: [LTP] [PATCH 2/2] docs: Add description of runtest file format
In-Reply-To: <20170525115744.21720-1-rpalethorpe@suse.com>
References: <20170525115744.21720-1-rpalethorpe@suse.com>
Message-ID: <20170525115744.21720-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

An informal description of the runtest file contents.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/ltp-run-files.txt | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/doc/ltp-run-files.txt b/doc/ltp-run-files.txt
index 36180b97b..f8cc36b9e 100644
--- a/doc/ltp-run-files.txt
+++ b/doc/ltp-run-files.txt
@@ -1,4 +1,43 @@
-List of scripts or executables that need to be run for complete LTP execution.
+The runtest files contain a list of test cases to be executed.
+
+File Format
+-----------
+
+Lines starting with a '#' are comments and blank lines are ignored.
+
+Otherwise, lines start with a test name followed by white space, then some
+shell script to be executed. For example
+
+Test Name
+|       Delimiter               Test case argument
+|       |                       |
+v       v                       v
+splice02 seq 1 20000 | splice02 splice02-temp
+         ^             ^                    ^
+         |             |                    |
+         |             Test case executable |
+         -----------Shell script-------------
+
+So the splice02 runtest entry pipes the output of seq into the splice02 test
+executable. Most runtest entries are simpler than this, for example
+
+splice03 splice03
+
+Here the test name and executable have the same name and no arguments have
+been supplied.
+
+Run test files should start with a comment describing the tests they contain,
+e.g.
+
+#DESCRIPTION:Kernel system calls
+
+Note that the LTP has absorbed a number of other projects. Some of these have
+been fully converted to the LTP format, others have runtest files generated
+for them during installation, while some use a shell script to integrate them
+with the other tests.
+
+Test suites
+-----------
 
  - syscalls  (except epoll, see below)
  - fs
-- 
2.12.2

