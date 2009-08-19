Return-Path: <ltp-list-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 19 Aug 2009 16:11:52 -0700
Message-ID: <364299f40908191611x4accc24yc36b344956c7a40c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Cross-compile configure bug
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
To: openhpi-devel@lists.sourceforge.net
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi,
    Found this bug while trying to cross-compile with the
openhpi-test-suite in LTP, and made the ERROR into WARN. Please fix
this item as per the attached patch.
Thanks,
-Garrett

PS Please CC my address in all correspondence w.r.t. this email thread.

Summary:

1. int != 4 shouldn't be checked for while cross-compiling.
2. Warn instead of erroring out, because we have a _lot_ of 64-bit
platforms that we test on which will be negatively impacted by this
check.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--- /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//configure.ac.orig	2009-08-19
16:04:08.000000000 -0700
+++ /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//configure.ac	2009-08-19
16:10:47.000000000 -0700
@@ -44,14 +44,13 @@
 AC_PROG_LN_S
 AC_PROG_MAKE_SET

-dnl die on int != 32bits.  This is too instrumental to our code right now.
+dnl Warn when int != 32bits.  This is too instrumental to our code right now.
 dnl AC_MSG_CHECKING(int is 4 bytes)
 OH_SET_SIZES
-if test "x$OH_SIZEOF_INT" != "x4"; then
-    AC_MSG_ERROR([
+if test x$cross_compiling != xyes && test "x$OH_SIZEOF_INT" != "x4"; then
+    AC_MSG_WARN([
 *** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
-*** undefined behavior will result
-*** please contact the openhpi development team to fix this
+*** undefined behavior may result from this.
 ])
 fi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
