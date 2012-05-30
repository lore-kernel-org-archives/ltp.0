Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SZdYD-0003i3-N7
	for ltp-list@lists.sourceforge.net; Wed, 30 May 2012 07:42:37 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZdY8-0003wJ-Ap
	for ltp-list@lists.sourceforge.net; Wed, 30 May 2012 07:42:37 +0000
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q4U7gkJG014802
	for <ltp-list@lists.sourceforge.net>; Wed, 30 May 2012 15:42:47 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
Date: Wed, 30 May 2012 15:43:02 +0800
Message-Id: <1338363782-10590-1-git-send-email-penght@cn.fujitsu.com>
Subject: [LTP] [PATCH] filecapstest.sh: fix a bug of fail in RHEL5
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

setcap is not used in ltp, So AC_CHECK_PROG(SETCAP,setcap,setcap)
should be deleted.

When HAVE_LIBCAP is not defined, the case should not be fail.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 include/mk/features.mk.default                      |    3 ---
 include/mk/features.mk.in                           |    3 ---
 m4/ltp-cap.m4                                       |    1 -
 testcases/kernel/security/Makefile                  |    8 --------
 testcases/kernel/security/cap_bound/cap_bounds_r.c  |    4 ++--
 testcases/kernel/security/cap_bound/cap_bounds_rw.c |   10 +++++++++-
 6 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/mk/features.mk.default b/include/mk/features.mk.default
index 75a4c1d..86e4d4c 100644
--- a/include/mk/features.mk.default
+++ b/include/mk/features.mk.default
@@ -20,9 +20,6 @@
 # Garrett Cooper, October 2010
 #
 
-# Path to setcap program
-SETCAP				:=
-
 # Tools enable knobs
 WITH_EXPECT			:= no
 
diff --git a/include/mk/features.mk.in b/include/mk/features.mk.in
index c9162e5..1fd28f8 100644
--- a/include/mk/features.mk.in
+++ b/include/mk/features.mk.in
@@ -20,9 +20,6 @@
 # Garrett Cooper, October 2010
 #
 
-# Path to setcap program
-SETCAP				:= @SETCAP@
-
 # Tools enable knobs
 WITH_EXPECT			:= @WITH_EXPECT@
 
diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index 953ea50..c646c8c 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -29,7 +29,6 @@ AH_TEMPLATE(HAVE_LIBCAP,
 AC_CHECK_HEADERS([sys/capability.h],[capability_header_prefix="sys"])
 if test "x$capability_header_prefix" != x; then
 	AC_CHECK_LIB(cap,cap_compare,[cap_libs="-lcap"])
-	AC_CHECK_PROG(SETCAP,setcap,setcap)
 fi
 if test "x$cap_libs" != x; then
 	AC_DEFINE(HAVE_LIBCAP)
diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
index 9a7a2b2..0bb816f 100644
--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -24,14 +24,6 @@ top_srcdir		?= ../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-# For broken compilers and toolchains, like Montavista, that improperly detect
-# system headers when running autoconf -_-... bleh.
-ifeq ($(strip $(CAP_LIBS)),)
-FILTER_OUT_DIRS		:= cap_bound filecaps securebits
-endif
-ifeq ($(strip $(SETCAP)),)
-FILTER_OUT_DIRS		+= filecaps
-endif
 ifneq ($(HAVE_SECUREBITS),yes)
 FILTER_OUT_DIRS		+= securebits
 endif
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_r.c b/testcases/kernel/security/cap_bound/cap_bounds_r.c
index 006ab6a..0c09873 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_r.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_r.c
@@ -37,7 +37,7 @@ int TST_TOTAL=1;
 
 int main(int argc, char *argv[])
 {
-#if HAVE_SYS_CAPABILITY_H
+#ifdef HAVE_LIBCAP
 	int ret = 1;
 	int i;
 
@@ -88,4 +88,4 @@ int main(int argc, char *argv[])
 	tst_resm(TCONF, "System doesn't have POSIX capabilities.");
 #endif
 	tst_exit();
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/security/cap_bound/cap_bounds_rw.c b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
index eb69b4e..7ebdd65 100644
--- a/testcases/kernel/security/cap_bound/cap_bounds_rw.c
+++ b/testcases/kernel/security/cap_bound/cap_bounds_rw.c
@@ -55,6 +55,7 @@ int check_remaining_caps(int lastdropped)
 			return i;
 		}
 	}
+#ifdef HAVE_LIBCAP
 	for (; i <= CAP_LAST_CAP; i++) {
 #if HAVE_DECL_PR_CAPBSET_READ
 		ret = prctl(PR_CAPBSET_READ, i);
@@ -71,6 +72,9 @@ int check_remaining_caps(int lastdropped)
 			return -i;
 		}
 	}
+#else
+	printf("System doesn't support full POSIX capabilities.\n");
+#endif
 	return 0;
 }
 
@@ -79,6 +83,7 @@ int main(int argc, char *argv[])
 	int ret = 1;
 	int i;
 
+#ifdef HAVE_LIBCAP
 #if HAVE_DECL_PR_CAPBSET_DROP
 	ret = prctl(PR_CAPBSET_READ, -1);
 #else
@@ -131,5 +136,8 @@ int main(int argc, char *argv[])
 		}
 	}
 	tst_resm(TPASS, "PR_CAPBSET_DROP tests passed\n");
+#else
+	printf("System doesn't support full POSIX capabilities.\n");
+#endif
 	tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.10.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
