Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MDcxx-0007Dp-KJ
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:24:37 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDcvG-0000bm-24
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 11:24:37 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8365EFF0FF0E
	for <ltp-list@lists.sourceforge.net>;
	Mon,  8 Jun 2009 13:21:48 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277) id 1MDcvE-00056h-00
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 13:21:48 +0200
From: Jiri Palecek <jpalecek@web.de>
Date: Mon, 8 Jun 2009 13:25:23 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200906081325.24357.jpalecek@web.de>
Subject: [LTP] [PATCH] Change syscall numbers to symbolic constants in
	rt_sigprocmask01
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

Hello,

this patch changes the syscall numbers in rt_sigprocmask01 test to symbolic constants, to make it functional on other architectures than i386.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>

---
 .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
index c3251ab..6398a28 100644
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
@@ -163,14 +163,14 @@ int main(int ac, char **av) {
 			
 			/* call rt_sigaction() */
 			act.sa_handler = sig_handler;
-                        TEST(syscall(174, 33, &act, &oact, 8));
+                        TEST(syscall(__NR_rt_sigaction, 33, &act, &oact, 8));
 			if(TEST_RETURN != 0){
 				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();
 				tst_exit();
 			}
 			/* call rt_sigprocmask() to block signal#33 */
-                        TEST(syscall(175, SIG_BLOCK, &set, &oset, 8));
+                        TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &set, &oset, 8));
 			if(TEST_RETURN == -1){
 				tst_resm(TFAIL,"Call to rt_sigprocmask()**** Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();
@@ -192,7 +192,7 @@ int main(int ac, char **av) {
 				}
 				else {
 					/* call rt_sigpending() */
-					TEST(syscall(176, &oset, 8));
+					TEST(syscall(__NR_rt_sigpending, &oset, 8));
 					if(TEST_RETURN == -1){
 						tst_resm(TFAIL,"call rt_sigpending() failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         			cleanup();
@@ -205,7 +205,7 @@ int main(int ac, char **av) {
 						tst_exit();
 					}
 					/* call rt_sigprocmask() to unblock signal#33 */
-					TEST(syscall(175, SIG_UNBLOCK, &set, &oset, 8));
+					TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
 					if(TEST_RETURN == -1){
 						tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
                         			cleanup();
-- 
1.6.2.4


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
