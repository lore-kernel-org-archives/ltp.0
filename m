Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MW67K-0006aV-T6
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 10:10:38 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MW67E-0003wx-Rn
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 10:10:38 +0000
Received: by gxk20 with SMTP id 20so2650425gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 03:10:27 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 29 Jul 2009 15:40:27 +0530
Message-ID: <f5a7b3810907290310h159a8fcby374e7d6b789a6d16@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd4830a72d38d046fd56564
Subject: [LTP] [FIX PATCH] open_posix_pthread_equal_2-1.c
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Mike Frysinger <vapier@gentoo.org>, maxin john <maxinbjohn@gmail.com>

--000e0cd4830a72d38d046fd56564
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have notice HUNG status for pthread_equal/2-1.c under posix test suite.
conformance/interfaces/pthread_equal/2-1.test:execution:HUNG

This because of while(do_it)loop is behaving as while(1).
do_it updated value from one thread is not reflecting in the other
thread because the type is not proper.
I have changed the type from char -> volatile int

I have shared results before and after this patch.

Before PATCH:
conformance/interfaces/pthread_equal/2-1.test:execution:HUNG

After PATCH:
conformance/interfaces/pthread_equal/2-1.test:execution:PASS

I have attached patch and below.
Please review the same.

Best regards,
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c	2005-06-03
22:01:47.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_equal/2-1.c	2009-07-29
14:27:05.000000000 +0530
@@ -80,7 +80,7 @@
 /***********************************    Test cases
*****************************************/
 /********************************************************************************************/

-char do_it=1;
+volatile int do_it=1;
 unsigned long count_ope=0;
 #ifdef WITH_SYNCHRO
 sem_t semsig1;

--000e0cd4830a72d38d046fd56564
Content-Type: application/octet-stream; name="ltp-fix-pthread_equal_2-1.patch"
Content-Disposition: attachment; filename="ltp-fix-pthread_equal_2-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxpvxq6x0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9wdGhyZWFkX2VxdWFsLzItMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVz
dHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvcHRocmVhZF9lcXVhbC8yLTEuYwotLS0gYS90
ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9wdGhy
ZWFkX2VxdWFsLzItMS5jCTIwMDUtMDYtMDMgMjI6MDE6NDcuMDAwMDAwMDAwICswNTMwCisrKyBi
L3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3B0
aHJlYWRfZXF1YWwvMi0xLmMJMjAwOS0wNy0yOSAxNDoyNzowNS4wMDAwMDAwMDAgKzA1MzAKQEAg
LTgwLDcgKzgwLDcgQEAKIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiAgICBU
ZXN0IGNhc2VzICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIC8q
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIAotY2hhciBkb19pdD0xOwordm9s
YXRpbGUgaW50IGRvX2l0PTE7CiB1bnNpZ25lZCBsb25nIGNvdW50X29wZT0wOwogI2lmZGVmIFdJ
VEhfU1lOQ0hSTwogc2VtX3Qgc2Vtc2lnMTsK
--000e0cd4830a72d38d046fd56564
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd4830a72d38d046fd56564
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd4830a72d38d046fd56564--

