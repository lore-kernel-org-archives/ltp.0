From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Sep 2020 13:40:25 +0200
Subject: [LTP] [PATCH 1/2] runtest/smoketest: Add smoketest
Message-ID: <20200921114026.11184-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This runtest file is meant to be used for infrastructure checks i.e. to
test LTP integration with various frameworks. The testcases were choosen
so that the testrun is fast and also represents reasonable subset of
different LTP testcases, e.g. binary, shell, etc.

The primary reason we are adding this is that we want to get rid of
quickhit, which has been misused for this purpose.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: "Bird, Tim" <Tim.Bird@sony.com>
CC: Petr Vorel <pvorel@suse.cz>
---
 runtest/smoketest | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 runtest/smoketest

diff --git a/runtest/smoketest b/runtest/smoketest
new file mode 100644
index 000000000..218827a12
--- /dev/null
+++ b/runtest/smoketest
@@ -0,0 +1,15 @@
+# The purpose of this file is to have a quick integration test for various
+# test frameworks that integrate LTP testsuite.
+
+access01 access01
+chdir01 chdir01
+fork01 fork01
+time01 time01
+wait02 wait02
+write01 write01
+symlink01 symlink01
+stat04 symlink01 -T stat04
+utime01A symlink01 -T utime01
+rename01A symlink01 -T rename01
+splice02 seq 1 20 | splice02
+route4-change-dst route-change-dist.sh
-- 
2.26.2

