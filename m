Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VrP42-0005dl-Dx
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 09:29:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VrP40-0002mQ-Ky
	for ltp-list@lists.sourceforge.net; Fri, 13 Dec 2013 09:29:42 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rBD9TXt0021679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Dec 2013 04:29:34 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id rBD9TWax025209
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Dec 2013 04:29:33 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 13 Dec 2013 10:29:27 +0100
Message-Id: <69b0ae6d4039f97ac8bc68975640f8a79ac69aa2.1386926927.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] get_robust_list01: use pid_max instead of UINT16_MAX
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

UINT16_MAX can be a valid pid number on some systems.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/get_robust_list/get_robust_list01.c   |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index dd5e726..17da538 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -68,6 +68,7 @@ struct robust_list_head {
 };
 
 int exp_enos[] = { ESRCH, EPERM, EFAULT, 0 };
+static unsigned int pid_max;
 
 void setup(void);
 void cleanup(void);
@@ -134,7 +135,7 @@ int main(int argc, char **argv)
 		 * find the task specified by the pid argument.
 		 */
 
-		TEST(ltp_syscall(__NR_get_robust_list, UINT16_MAX,
+		TEST(ltp_syscall(__NR_get_robust_list, pid_max,
 				      (struct robust_list_head *)&head,
 				      &len_ptr));
 
@@ -190,6 +191,7 @@ void setup(void)
 	tst_require_root(NULL);
 
 	TEST_EXP_ENOS(exp_enos);
+	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/pid_max", "%u", &pid_max);
 
 	TEST_PAUSE;
 }
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
