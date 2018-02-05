From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Feb 2018 14:24:41 +0100
Subject: [LTP] [RFC,
	COMMITTED 1/1] configure: add knob to control numa support
Message-ID: <20180205132441.19130-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Anders Roxell <anders.roxell@linaro.org>

Allow to disable numa from the top level.

Based on patch:
http://cgit.openembedded.org/openembedded-core/commit/meta/recipes-extended/ltp?id=4c7873552e13dfdba96afca7562c398d2966ca71

Reported-by: Roy Li <rongqing.li@windriver.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure.ac b/configure.ac
index 5c8d4eaf8..b39a31ddb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,6 +83,14 @@ else
     AC_SUBST([WITH_EXPECT],["no"])
 fi
 
+# Numa
+AC_ARG_WITH([numa],
+  AC_HELP_STRING([--without-numa],
+    [without numa support (default=yes)]),
+  [with_numa=no],
+  [with_numa=yes]
+)
+
 # Perl
 AC_ARG_WITH([perl],
   [AC_HELP_STRING([--with-perl],
@@ -157,7 +165,9 @@ LTP_CHECK_SELINUX
 LTP_CHECK_SIGNAL
 LTP_CHECK_SYSCALL_EVENTFD
 LTP_CHECK_SYSCALL_MODIFY_LDT
+if test "x$with_numa" = xyes; then
 LTP_CHECK_SYSCALL_NUMA
+fi
 LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UNSHARE
-- 
2.15.1

