Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YlU1P-0005jO-4J
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:19 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlU1N-0004aw-Np
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 03:11:19 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O3A0Cs031070
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 11:10:00 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 11:06:09 +0800
Message-ID: <1429844769-7113-8-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1429844769-7113-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 8/8] power_management: compile
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
 include/mk/features.mk.default |  2 +-
 include/mk/features.mk.in      |  2 +-
 3 files changed, 2 insertions(+), 16 deletions(-)

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
index c9edc1c..22a0f0e 100644
--- a/include/mk/features.mk.default
+++ b/include/mk/features.mk.default
@@ -38,7 +38,7 @@ HAVE_SECUREBITS			:= no
 ifeq ($(UCLINUX),1)
 WITH_POWER_MANAGEMENT_TESTSUITE	:= no
 else
-WITH_POWER_MANAGEMENT_TESTSUITE	:=
+WITH_POWER_MANAGEMENT_TESTSUITE	:= yes
 endif
 
 # Enable testcases/open_posix_testsuite's compile and install?
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index 1fd28f8..8030be7 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -38,7 +38,7 @@ HAVE_SECUREBITS			:= @HAVE_SECUREBITS@
 ifeq ($(UCLINUX),1)
 WITH_POWER_MANAGEMENT_TESTSUITE	:= no
 else
-WITH_POWER_MANAGEMENT_TESTSUITE	:= @WITH_POWER_MANAGEMENT_TESTSUITE@
+WITH_POWER_MANAGEMENT_TESTSUITE	:= yes
 endif
 
 # Enable testcases/open_posix_testsuite's compile and install?
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
