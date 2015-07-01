Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZABcb-0006rM-LJ
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 06:35:49 +0000
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZABca-0004ox-Uk
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 06:35:49 +0000
Received: by pdcu2 with SMTP id u2so20422279pdc.3
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2015 23:35:43 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed,  1 Jul 2015 14:35:32 +0800
Message-Id: <1435732532-10995-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCHv3] containers: Use ltp_syscall for setns incase some
	libc library do not support it
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
To: LTP List <ltp-list@lists.sourceforge.net>

Use ltp_syscall for setns incase some libc library do not support it. Also
check whether we support setns in setup(). If it's support the syscall will
silently fails and test continues. If not, then tst_brkm call will end the
test with TCONF.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/userns/userns04.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns04.c b/testcases/kernel/containers/userns/userns04.c
index 7077679..9836fd9 100644
--- a/testcases/kernel/containers/userns/userns04.c
+++ b/testcases/kernel/containers/userns/userns04.c
@@ -35,6 +35,7 @@ int TST_TOTAL = 1;
 static void setup(void)
 {
 	check_newuser();
+	ltp_syscall(__NR_setns, -1, 0);
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(NULL);
 }
@@ -55,7 +56,7 @@ static int child_fn2(void *arg)
 	int exit_val = 0;
 	int ret;
 
-	ret = setns(((long)arg), CLONE_NEWUSER);
+	ret = ltp_syscall(__NR_setns, ((long)arg), CLONE_NEWUSER);
 	if (ret != -1) {
 		printf("child2 setns() unexpected success\n");
 		exit_val = 1;
@@ -112,7 +113,7 @@ static void test_cap_sys_admin(void)
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
-		if (setns(fd, CLONE_NEWUSER) == -1) {
+		if (ltp_syscall(__NR_setns, fd, CLONE_NEWUSER) == -1) {
 			printf("parent pid setns failure: (%d) %s",
 				errno, strerror(errno));
 			exit(1);
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
