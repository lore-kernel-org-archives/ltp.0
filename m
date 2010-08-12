Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1OjSxa-0007FY-AQ
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 08:16:22 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OjSxZ-0002Ef-DX
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 08:16:22 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7C8GF8P020029
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Aug 2010 01:16:15 -0700 (PDT)
Message-ID: <4C63ADC4.3030100@windriver.com>
Date: Thu, 12 Aug 2010 16:16:04 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040503000405040904080506"
Subject: [LTP] [patch]rt_sigprocmask01 issue
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040503000405040904080506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In rt_sigprocmask01.c:

TEST(syscall(__NR_rt_sigpending, &oset,
                   SIGSETSIZE));
               if (TEST_RETURN == -1) {
                   tst_brkm(TFAIL|TTERRNO, cleanup,
                       "rt_sigpending call failed");
               }
               TEST(sigismember(&oset, TEST_SIG));
               if (TEST_RETURN == 0) {
                   tst_brkm(TFAIL|TTERRNO,
                       cleanup,
                       "sigismember call failed");
               }
               /* call rt_sigprocmask() to unblock
                * signal#TEST_SIG */
               TEST(syscall(__NR_rt_sigprocmask,
                   SIG_UNBLOCK, &set, &oset, 8));

on most of the arch,the SIGSETSIZE is 8, but it is 16 for mips, so in 
sigprocmask,
the last parameter should be SIGSETSIZE too, not 8.

Regards,

Lina Zhao

--------------040503000405040904080506
Content-Type: text/x-diff;
 name="rt_sigprocmask01-argument-change.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="rt_sigprocmask01-argument-change.patch"

From 69be40baa594c10e5de553a2a60ba4875680c68c Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Thu, 12 Aug 2010 15:45:10 +0800
Subject: [PATCH] On most of the arch,the SIGSETSIZE is 8,
 but it is 16 for mips, so in sigprocmask, the last parameter
 should be SIGSETSIZE too, not 8.

Signed-off-by: Lina Zhao <lina.zhao@windriver.com>
---
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index cc32ea8..e100561 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -210,7 +210,7 @@ int main(int ac, char **av) {
 				/* call rt_sigprocmask() to unblock
 				 * signal#TEST_SIG */
 				TEST(syscall(__NR_rt_sigprocmask,
-					SIG_UNBLOCK, &set, &oset, 8));
+					SIG_UNBLOCK, &set, &oset, SIGSETSIZE));
 				if (TEST_RETURN == -1) {
 					tst_brkm(TFAIL|TTERRNO,
 						cleanup,
-- 
1.6.3.1


--------------040503000405040904080506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------040503000405040904080506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040503000405040904080506--

