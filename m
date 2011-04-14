Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QAKyj-0003qw-It
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 11:44:53 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QAKyi-0000yO-MK
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 11:44:53 +0000
Date: Thu, 14 Apr 2011 07:44:46 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1443931472.73326.1302781486782.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1640962017.73206.1302781090843.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] memcg_process.c: signals initialization
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
Cc: Jeffrey Burke <jburke@redhat.com>

1. There seems to be copy paste error, instead of clearing 
sigusr_action.sa_mask it clears sigint_action.sa_mask.
Change comes from 6c4d1c6d4b3c116ff88f9209b4860940fb8659a8

2. Other fields of these structures are left to be uninitialized.

Both 1) and 2) make the behaviour unexpected. Occasionally I saw,
this program to end upon receiving SIGUSR1.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../controllers/memcg/functional/memcg_process.c   |    9 ++-

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index bccb2da..da91dc9 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -295,17 +295,18 @@ int main(int argc, char *argv[])
 	if ((fd = open("/dev/zero", O_RDWR)) == -1)
 		err(1, "open /dev/zero failed");
 
+	memset(&sigint_action, 0, sizeof(sigint_action));
+	memset(&sigusr_action, 0, sizeof(sigusr_action));
+
 	/* TODO: writer error handling here. */
 	sigemptyset(&sigint_action.sa_mask);
 	sigint_action.sa_handler = &sigint_handler;
 	sigaction(SIGINT, &sigint_action, NULL);
 
-	sigemptyset(&sigint_action.sa_mask);
+	sigemptyset(&sigusr_action.sa_mask);
 	sigusr_action.sa_handler = &sigusr_handler;
 	sigaction(SIGUSR1, &sigusr_action, NULL);
 
-	sigemptyset(&sigusr_action.sa_mask);
-
 	process_options(argc, argv);
 
 	while (!flag_exit)
-- 
1.7.1

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
