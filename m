Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PfSOD-0007V8-Ha
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:23:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfSOB-0007yt-Gn
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:23:33 +0000
Message-ID: <4D369178.4010107@cn.fujitsu.com>
Date: Wed, 19 Jan 2011 15:23:36 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] exit_group01: fix error of using wrong TEST_RETURN
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

"TEST_RETURN" should be replaced with "cpid".

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 .../kernel/syscalls/exit_group/exit_group01.c      |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/exit_group/exit_group01.c b/testcases/kernel/syscalls/exit_group/exit_group01.c
index 9280f0a..d7454b2 100644
--- a/testcases/kernel/syscalls/exit_group/exit_group01.c
+++ b/testcases/kernel/syscalls/exit_group/exit_group01.c
@@ -113,7 +113,7 @@ int main(int ac, char **av) {
 	cpid = fork();     //call exit_group()
 	if (cpid == -1) {
         	tst_brkm(TFAIL|TERRNO, cleanup, "fork failed");
-	} else if (TEST_RETURN == 0) {
+	} else if (cpid == 0) {
 		sleep(5);
 		TEST(syscall(__NR_exit_group,4));
 	} else {
@@ -129,4 +129,4 @@ int main(int ac, char **av) {
         }
 	cleanup();
         tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
