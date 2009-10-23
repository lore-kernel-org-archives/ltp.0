Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1N1IJF-0008TR-QG
	for ltp-list@lists.sourceforge.net; Fri, 23 Oct 2009 11:27:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N1IJB-0001Zn-L2
	for ltp-list@lists.sourceforge.net; Fri, 23 Oct 2009 11:27:53 +0000
Date: Fri, 23 Oct 2009 20:38:32 +0900 (JST)
Message-Id: <20091023.203832.41091033407475231.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Fri_Oct_23_20_38_32_2009_205)--"
Content-Transfer-Encoding: 7bit
Subject: [LTP] [patch] Complete the test cases for geteuid16
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

----Next_Part(Fri_Oct_23_20_38_32_2009_205)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Another small patch to complete the test cases for *16.

Put compat_16.h to testcases/kernel/syscalls/geteuid.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>

----Next_Part(Fri_Oct_23_20_38_32_2009_205)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="geteuid16.patch"

Index: testcases/kernel/syscalls/geteuid/Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/geteuid/Makefile,v
retrieving revision 1.8
diff -u -r1.8 Makefile
--- testcases/kernel/syscalls/geteuid/Makefile	9 Oct 2009 17:55:55 -0000	1.8
+++ testcases/kernel/syscalls/geteuid/Makefile	23 Oct 2009 11:02:08 -0000
@@ -20,4 +20,7 @@
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../utils/compat_16.mk
+
+CPPFLAGS		+= -I$(abs_srcdir)/../utils
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
Index: testcases/kernel/syscalls/geteuid/geteuid01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/geteuid/geteuid01.c,v
retrieving revision 1.5
diff -u -r1.5 geteuid01.c
--- testcases/kernel/syscalls/geteuid/geteuid01.c	23 Mar 2009 13:35:42 -0000	1.5
+++ testcases/kernel/syscalls/geteuid/geteuid01.c	23 Oct 2009 11:02:08 -0000
@@ -116,10 +116,12 @@
 #include "test.h"
 #include "usctest.h"
 
+#include "compat_16.h"
+
 void setup();
 void cleanup();
 
-char *TCID = "geteuid01";	/* Test program identifier.    */
+TCID_DEFINE(geteuid01);	        /* Test program identifier.    */
 int TST_TOTAL = 1;		/* Total number of test cases. */
 extern int Tst_count;		/* Test Case counter for tst_* routines */
 
@@ -161,7 +163,7 @@
 		;
 
 		/* Call geteuid(2) */
-		TEST(geteuid());
+		TEST(GETEUID());
 
 		/* check return code */
 		if (TEST_RETURN < 0) {

----Next_Part(Fri_Oct_23_20_38_32_2009_205)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="compat_16.h"

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

#ifndef __GETUID_COMPAT_16_H__
#define __GETUID_COMPAT_16_H__


#include "linux_syscall_numbers.h"
#include "compat_uid.h"


#ifdef TST_USE_COMPAT16_SYSCALL

UID_T
GETEUID(void)
{
	return syscall(__NR_geteuid);
}

#else

UID_T
GETEUID(void)
{
	return geteuid();
}

#endif

#endif /* __GETUID_COMPAT_16_H__ */

----Next_Part(Fri_Oct_23_20_38_32_2009_205)--
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
----Next_Part(Fri_Oct_23_20_38_32_2009_205)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----Next_Part(Fri_Oct_23_20_38_32_2009_205)----

