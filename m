Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VbqDO-00044V-IQ
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 11:15:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VbqDK-0004qW-G7
	for ltp-list@lists.sourceforge.net; Thu, 31 Oct 2013 11:15:00 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r9VBBELU032043
	for <ltp-list@lists.sourceforge.net>; Thu, 31 Oct 2013 19:11:17 +0800
Message-ID: <52723AC1.6090807@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 19:10:57 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] realtime: add realtime tests to the default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


modify run.sh to check whether the kernel support RT PREEMPT

modify configure.ac to make the realtime tests default

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 configure.ac                        | 10 ++++++----
 runtest/realtime                    |  1 +
 scenario_groups/default             |  1 +
 testcases/realtime/run.sh           | 20 ++++++++++++++++++++
 testcases/realtime/scripts/Makefile |  2 +-
 5 files changed, 29 insertions(+), 5 deletions(-)
 create mode 100644 runtest/realtime

diff --git a/configure.ac b/configure.ac
index 940f4f7..c4d63b4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -128,14 +128,16 @@ else
 fi
 
 # testcases/realtime requires bash and python.
-if test "x$with_bash" = xyes && test "x$with_python" = xyes; then
+AC_CHECK_PROG(bash_exist, bash, [yes], [no])
+AC_CHECK_PROG(python_exist, python, [yes], [no])
+if test "x$bash_exist" = xyes && test "x$python_exist" = xyes; then
     AC_ARG_WITH([realtime-testsuite],
-      [AC_HELP_STRING([--with-realtime-testsuite],
+      [AC_HELP_STRING([--without-realtime-testsuite],
         [compile and install the realtime testsuite (default=no)])],
-      [with_realtime_testsuite=yes]
+      [without_realtime_testsuite=yes],[without_realtime_testsuite=no]
     )
 fi
-if test "x$with_realtime_testsuite" = xyes; then
+if test "x$without_realtime_testsuite" = xno; then
     AC_SUBST([WITH_REALTIME_TESTSUITE],["yes"])
     # Run configure on testcases/realtime as well.
     AC_CONFIG_SUBDIRS([testcases/realtime])
diff --git a/runtest/realtime b/runtest/realtime
new file mode 100644
index 0000000..ca6023c
--- /dev/null
+++ b/runtest/realtime
@@ -0,0 +1 @@
+realtime cd $LTPROOT/testcases/realtime/ && ./run.sh
diff --git a/scenario_groups/default b/scenario_groups/default
index 9eca8ad..f29e817 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -25,3 +25,4 @@ hugetlb
 commands
 hyperthreading
 kernel_misc
+realtime
diff --git a/testcases/realtime/run.sh b/testcases/realtime/run.sh
index a66e4e5..e4943b6 100755
--- a/testcases/realtime/run.sh
+++ b/testcases/realtime/run.sh
@@ -62,6 +62,17 @@ check_error()
 		exit 1
 	fi
 }
+
+check_kernel_config()
+{
+	local kernel_release=$(uname -r)
+	local config_file="/boot/config-${kernel_release}"
+
+	local is_exist=$(cat $config_file | grep "$1=y" -c)
+
+	return $is_exist
+}
+
 list_tests()
 {
 	echo
@@ -180,6 +191,15 @@ find_test()
 SCRIPTS_DIR="$(readlink -f "$(dirname "$0")")/scripts"
 source $SCRIPTS_DIR/setenv.sh
 
+# check whether the kernel support RT PREEMPT
+check_kernel_config "CONFIG_PREEMPT_RT"
+
+if [ $? -lt 1 ];then
+	echo "realtime      TCONF  Kernel don't support RT PREEMPT."
+	echo "see wiki <http://rt.wiki.kernel.org> for more information"
+	exit 0
+fi
+
 if [ $# -lt 1 ]; then
 	usage
 fi
diff --git a/testcases/realtime/scripts/Makefile b/testcases/realtime/scripts/Makefile
index 28bf88e..5dda3a7 100644
--- a/testcases/realtime/scripts/Makefile
+++ b/testcases/realtime/scripts/Makefile
@@ -22,5 +22,5 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../config.mk
-INSTALL_TARGETS		:= run_c_files.sh setenv.sh __init__.py parser.py
+INSTALL_TARGETS		:= run_all_test.sh run_c_files.sh setenv.sh __init__.py parser.py ../run.sh
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.8.2.1

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
