Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1Mw99w-0001sJ-BJ
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:41:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mw99p-0005OU-Cj
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:41:00 +0000
Date: Fri, 09 Oct 2009 15:44:45 +0900 (JST)
Message-Id: <20091009.154445.548431512384017812.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Fri_Oct__9_15_44_45_2009_670)--"
Content-Transfer-Encoding: 7bit
Subject: [LTP] Complete the test cases for getuid16
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net

----Next_Part(Fri_Oct__9_15_44_45_2009_670)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some of testcases for *16 and *64 system calls have not been completed yet
though my makefile trick were introduced by Suburata. *16 may not be so important
but I'd like to complete them anyway. The first one is for getuid16.

To apply getuid16.patch use -p0 option.
Put compat_uid.h  at testcases/kernel/syscalls/utils/compat_uid.h.
Put compat_16.h.  at testcases/kernel/syscalls/getuid/compat_16.h.


Signed-off-by: Masatake YAMATO <yamato@redhat.com>


----Next_Part(Fri_Oct__9_15_44_45_2009_670)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="getuid16.patch"

Index: testcases/kernel/syscalls/getuid/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/getuid/Makefile,v
retrieving revision 1.8
diff -u -r1.8 Makefile
--- testcases/kernel/syscalls/getuid/Makefile	7 Nov 2008 08:45:27 -0000	1.8
+++ testcases/kernel/syscalls/getuid/Makefile	8 Oct 2009 14:21:44 -0000
@@ -16,7 +16,7 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
 
-CFLAGS += -I../../../../include -Wall
+CFLAGS += -I../../../../include  -I../utils -Wall
 LDLIBS += -L../../../../lib -lltp
 
 include ../utils/compat_16.mk
Index: testcases/kernel/syscalls/getuid/getuid01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/getuid/getuid01.c,v
retrieving revision 1.7
diff -u -r1.7 getuid01.c
--- testcases/kernel/syscalls/getuid/getuid01.c	23 Mar 2009 13:35:45 -0000	1.7
+++ testcases/kernel/syscalls/getuid/getuid01.c	8 Oct 2009 14:21:45 -0000
@@ -116,11 +116,12 @@
 #include <signal.h>
 #include "test.h"
 #include "usctest.h"
+#include "compat_16.h"
 
 void setup();
 void cleanup();
 
-char *TCID = "getuid01";	/* Test program identifier.    */
+TCID_DEFINE(getuid01);          /* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 extern int Tst_count;		/* Test Case counter for tst_* routines */
 
@@ -156,7 +157,7 @@
 		/*
 		 * Call getuid(2)
 		 */
-		TEST(getuid());
+		TEST(GETUID());
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
Index: testcases/kernel/syscalls/getuid/getuid02.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/getuid/getuid02.c,v
retrieving revision 1.4
diff -u -r1.4 getuid02.c
--- testcases/kernel/syscalls/getuid/getuid02.c	23 Mar 2009 13:35:45 -0000	1.4
+++ testcases/kernel/syscalls/getuid/getuid02.c	8 Oct 2009 14:21:45 -0000
@@ -44,8 +44,9 @@
 #include <errno.h>
 #include <test.h>
 #include <usctest.h>
+#include "compat_16.h"
 
-char *TCID = "getuid02";
+TCID_DEFINE(getuid02);
 int TST_TOTAL = 1;
 extern int Tst_count;
 
@@ -71,7 +72,7 @@
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		TEST(geteuid());
+		TEST(GETEUID());
 
 		if (TEST_RETURN < 0) {
 			tst_brkm(TBROK, cleanup, "This should never happen");
@@ -83,6 +84,11 @@
 			if (pwent == NULL) {
 				tst_resm(TFAIL, "geteuid() returned unexpected "
 					 "value %d", TEST_RETURN);
+			} else if (!UID_SIZE_CHECK(pwent->pw_uid)) {
+				tst_brkm(TBROK,
+					 cleanup,
+					 "uid(%d) is too large for testing geteuid16",
+					 TEST_RETURN);
 			} else {
 				if (pwent->pw_uid != TEST_RETURN) {
 					tst_resm(TFAIL, "getpwuid() value, %d, "
Index: testcases/kernel/syscalls/getuid/getuid03.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/getuid/getuid03.c,v
retrieving revision 1.6
diff -u -r1.6 getuid03.c
--- testcases/kernel/syscalls/getuid/getuid03.c	23 Mar 2009 13:35:45 -0000	1.6
+++ testcases/kernel/syscalls/getuid/getuid03.c	8 Oct 2009 14:21:45 -0000
@@ -44,8 +44,10 @@
 #include <errno.h>
 #include <test.h>
 #include <usctest.h>
+#include "compat_16.h"
 
-char *TCID = "getuid03";
+
+TCID_DEFINE(getuid03);
 int TST_TOTAL = 1;
 extern int Tst_count;
 
@@ -72,7 +74,7 @@
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		TEST(getuid());
+		TEST(GETUID());
 
 		if (TEST_RETURN < 0) {
 			tst_brkm(TBROK, cleanup, "This should never happen");
@@ -84,6 +86,12 @@
 			if (pwent == NULL) {
 				tst_resm(TFAIL, "getuid() returned unexpected "
 					 "value %d", TEST_RETURN);
+			} else if (!UID_SIZE_CHECK(pwent->pw_uid)) {
+				tst_brkm(TBROK,
+					 cleanup,
+					 "uid(%d) is too large for testing getuid16",
+					 TEST_RETURN);
+			  
 			} else {
 				if (pwent->pw_uid != TEST_RETURN) {
 					tst_resm(TFAIL, "getpwuid() value, %d, "

----Next_Part(Fri_Oct__9_15_44_45_2009_670)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="compat_uid.h"

/*
 *
 *   Copyright (c) Red Hat Inc., 2009
 *
 *   This program is free software;  you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 *   the GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program;  if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* Author: Masatake YAMATO <yamato@redhat.com> */

#ifndef __COMPAT_UID_16_H__
#define __COMPAT_UID_16_H__


#include <asm/posix_types.h>


#ifdef TST_USE_COMPAT16_SYSCALL
typedef __kernel_old_uid_t UID_T;
int 
UID_SIZE_CHECK(uid_t uid)
{
	/* See high2lowuid in linux/highuid.h
	   Return 0 if uid is too large to store
	   it to __kernel_old_uid_t. */
	return ((uid) & ~0xFFFF)? 0: 1;
}

#else

typedef uid_t UID_T;
int 
UID_SIZE_CHECK(uid_t uid)
{
	return 1;
}

#endif

#endif /* __SETUID_COMPAT_16_H__ */

----Next_Part(Fri_Oct__9_15_44_45_2009_670)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="compat_16.h"

/*
 *
 *   Copyright (c) Red Hat Inc., 2008
 *
 *   This program is free software;  you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 *   the GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program;  if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* Author: Masatake YAMATO <yamato@redhat.com> */

#ifndef __GETUID_COMPAT_16_H__
#define __GETUID_COMPAT_16_H__


#include "linux_syscall_numbers.h"
#include "compat_uid.h"


#ifdef TST_USE_COMPAT16_SYSCALL

UID_T
GETUID(void)
{
	return syscall(__NR_getuid);
}

UID_T
GETEUID(void)
{
	return syscall(__NR_geteuid);
}

#else

UID_T
GETUID(void)
{
	return getuid();
}

UID_T
GETEUID(void)
{
	return geteuid();
}

#endif

#endif /* __GETUID_COMPAT_16_H__ */

----Next_Part(Fri_Oct__9_15_44_45_2009_670)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
----Next_Part(Fri_Oct__9_15_44_45_2009_670)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----Next_Part(Fri_Oct__9_15_44_45_2009_670)----

