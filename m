From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:34 -0700
Subject: [LTP] [PATCH V3 01/23] Add knob to control whether numa support
	should be checked
Message-ID: <20160722042656.22346-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Roy.Li" <rongqing.li@windriver.com>

otherwise undeterministic dependency will be generated
during build depending upong numa being staged or not

Signed-off-by: Roy.Li <rongqing.li@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 m4/ltp-numa.m4 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
index 60ae07b..2cef0ef 100644
--- a/m4/ltp-numa.m4
+++ b/m4/ltp-numa.m4
@@ -24,7 +24,12 @@ dnl ----------------------------
 dnl
 AC_DEFUN([LTP_CHECK_SYSCALL_NUMA],
 [dnl
-AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
+AC_ARG_WITH(
+	[numa],
+	AC_HELP_STRING([--without-numa],
+	[without numa support]),
+	[],
+	[AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
 	LTP_SYSCALL_NUMA_HEADERS=yes
 	AC_CHECK_LIB(numa,numa_alloc_onnode,[have_numa_alloc_onnode="yes"])
 	if  test "x$have_numa_alloc_onnode" = "xyes"; then
@@ -48,3 +53,4 @@ if test "x$have_mpol_constants" = "xyes"; then
 	AC_DEFINE(HAVE_MPOL_CONSTANTS,1,[define to 1 if you have all constants required to use mbind tests])
 fi
 )])
+])
-- 
2.9.0

