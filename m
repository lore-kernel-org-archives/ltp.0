Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Xb9h9-0006kN-Ck
	for ltp-list@lists.sourceforge.net; Mon, 06 Oct 2014 14:55:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xb9h8-0000ZQ-6s
	for ltp-list@lists.sourceforge.net; Mon, 06 Oct 2014 14:55:27 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s96EtKNU010589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Oct 2014 10:55:20 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s96EtHaJ008066
	for <ltp-list@lists.sourceforge.net>; Mon, 6 Oct 2014 10:55:19 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  6 Oct 2014 16:55:10 +0200
Message-Id: <6cf14ee28f2a6fc0a131eeecd0f500214ed1f512.1412604688.git.jstancek@redhat.com>
In-Reply-To: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
References: <a710c99deb86fdad787e0530013b20913de57dbe.1412604688.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2 v2] checkpoints: fix usage in children started via
	exec
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

creat07 and setpgid03 are currently failing in following way:
  CHILD: Failed to open fifo '': No such file or directory at creat07_child.c:31
  creat07     1  TBROK  :  tst_checkpoint.c:126: Checkpoint timeouted after 5000 msecs at creat07.c:78
  creat07     2  TBROK  :  tst_checkpoint.c:126: Remaining cases broken

These testcases start children via exec, so only initialize
checkpoint struct, FIFO has been already created by parent.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/creat/creat07_child.c    |    8 ++++++--
 .../kernel/syscalls/setpgid/setpgid03_child.c      |    8 +++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07_child.c b/testcases/kernel/syscalls/creat/creat07_child.c
index f3e6aa0..1641601 100644
--- a/testcases/kernel/syscalls/creat/creat07_child.c
+++ b/testcases/kernel/syscalls/creat/creat07_child.c
@@ -24,10 +24,14 @@
 
 char *TCID = "creat07_child";
 
-static struct tst_checkpoint checkpoint = {.timeout = 5, .retval = 1};
-
 int main(void)
 {
+	struct tst_checkpoint checkpoint;
+
+	/* we are already in tmpdir, so only initialize checkpoint,
+	 * fifo has been created by parent already. */
+	TST_CHECKPOINT_INIT(&checkpoint);
+
 	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
 
 	for (;;) {
diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
index c4cf892..c9ea87f 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
@@ -20,10 +20,16 @@
 
 char *TCID = "setpgid03_child";
 
-static struct tst_checkpoint checkpoint = { .timeout = 10000, .retval = 1};
 
 int main(void)
 {
+	struct tst_checkpoint checkpoint;
+
+	/* we are already in tmpdir, so only initialize checkpoint,
+	 * fifo has been created by parent already. */
+	TST_CHECKPOINT_INIT(&checkpoint);
+	checkpoint.timeout = 10000;
+
 	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint);
 	TST_CHECKPOINT_CHILD_WAIT(&checkpoint);
 
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
