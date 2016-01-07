From: Khem Raj <raj.khem@gmail.com>
Date: Thu,  7 Jan 2016 17:46:43 +0000
Subject: [LTP] [PATCH 2/3] Add knob to control whether numa support should
	be checked
In-Reply-To: <1452188804-8959-1-git-send-email-raj.khem@gmail.com>
References: <1452188804-8959-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452188804-8959-2-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Roy.Li" <rongqing.li@windriver.com>

otherwise undeterministic dependency will be generated
during build depending upong numa being staged or not

signed-off-by: Roy.Li <rongqing.li@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 configure.ac | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure.ac b/configure.ac
index cc50397..d1095b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -129,6 +129,12 @@ else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
 
+AC_ARG_WITH([numa],
+  AC_HELP_STRING([--without-numa],
+    [without the numa support]),
+  [],[with_numa=yes],
+)
+
 AC_CONFIG_SUBDIRS([utils/ffsb-6.0-rc2])
 
 # END testsuites knobs
@@ -145,7 +151,9 @@ LTP_CHECK_SELINUX
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
2.7.0

