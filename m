Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YJeY6-00023r-L9
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 08:46:02 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YJeY4-0007eM-9f
	for ltp-list@lists.sourceforge.net; Fri, 06 Feb 2015 08:46:02 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t168imxb028862
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Feb 2015 16:44:48 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 6 Feb 2015 16:41:26 +0800
Message-ID: <1423212090-24164-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/6] power_management: compile and install
	testcases/kernel/power_management by default
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

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 configure.ac                   | 14 --------------
 include/mk/features.mk.default |  7 -------
 include/mk/features.mk.in      |  7 -------
 runtest/Makefile               |  4 ----
 scenario_groups/default        |  1 -
 testcases/kernel/Makefile      |  6 +-----
 6 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/configure.ac b/configure.ac
index 794059c..0ca21a6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -102,20 +102,6 @@ fi
 
 # Testsuites knobs
 
-# testcases/kernel/power_management requires python.
-if test "x$with_python" = xyes; then
-    AC_ARG_WITH([power-management-testsuite],
-      [AC_HELP_STRING([--with-power-management-testsuite],
-        [compile and install the x86 power management testsuite (default=no)])],
-      [with_power_management_testsuite=yes],
-    )
-fi
-if test "x$with_power_management_testsuite" = xyes; then
-    AC_SUBST([WITH_POWER_MANAGEMENT_TESTSUITE],["yes"])
-else
-    AC_SUBST([WITH_POWER_MANAGEMENT_TESTSUITE],["no"])
-fi
-
 AC_ARG_WITH([open-posix-testsuite],
   [AC_HELP_STRING([--with-open-posix-testsuite],
     [compile and install the open posix testsuite (default=no)])],
diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
index c9edc1c..69425ca 100644
--- a/include/mk/features.mk.default
+++ b/include/mk/features.mk.default
@@ -34,13 +34,6 @@ HAVE_SECUREBITS			:= no
 
 # Test suite knobs
 
-# Enable testcases/kernel/power_management's compile and install?
-ifeq ($(UCLINUX),1)
-WITH_POWER_MANAGEMENT_TESTSUITE	:= no
-else
-WITH_POWER_MANAGEMENT_TESTSUITE	:=
-endif
-
 # Enable testcases/open_posix_testsuite's compile and install?
 WITH_OPEN_POSIX_TESTSUITE	:= no
 
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 1fd28f8..49471fd 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -34,13 +34,6 @@ HAVE_SECUREBITS			:= @HAVE_SECUREBITS@
 
 # Test suite knobs
 
-# Enable testcases/kernel/power_management's compile and install?
-ifeq ($(UCLINUX),1)
-WITH_POWER_MANAGEMENT_TESTSUITE	:= no
-else
-WITH_POWER_MANAGEMENT_TESTSUITE	:= @WITH_POWER_MANAGEMENT_TESTSUITE@
-endif
-
 # Enable testcases/open_posix_testsuite's compile and install?
 WITH_OPEN_POSIX_TESTSUITE	:= @WITH_OPEN_POSIX_TESTSUITE@
 
diff --git a/runtest/Makefile b/runtest/Makefile
index 8702559..0907ef6 100644
--- a/runtest/Makefile
+++ b/runtest/Makefile
@@ -32,10 +32,6 @@ UNWANTED_FILES		:= Makefile CVS STAX
 
 INSTALL_MODE		:= 00644
 
-ifneq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
-UNWANTED_FILES		+= power_management_tests
-endif
-
 INSTALL_TARGETS		:= $(filter-out $(UNWANTED_FILES),$(notdir $(patsubst $(abs_srcdir)/%,%,$(wildcard $(abs_srcdir)/*))))
 
 MAKE_TARGETS		:=
diff --git a/scenario_groups/default b/scenario_groups/default
index 3a55702..0b82e5b 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -19,7 +19,6 @@ fcntl-locktests
 connectors
 admin_tools
 timers
-power_management_tests
 numa
 hugetlb
 commands
diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
index 50a12fa..689350b 100644
--- a/testcases/kernel/Makefile
+++ b/testcases/kernel/Makefile
@@ -53,11 +53,7 @@ SUBDIRS			+= connectors \
 			   timers \
 			   tracing \
 			   module \
-
-ifeq ($(WITH_POWER_MANAGEMENT_TESTSUITE),yes)
-SUBDIRS			+= power_management
-endif
-
+			   power_management
 endif
 
 MAKE_DEPS		:= include/linux_syscall_numbers.h
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
