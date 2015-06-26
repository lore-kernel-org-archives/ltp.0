Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SPb-0005Fj-63
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:07:15 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SPZ-0006t8-P2
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:07:15 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ01J27WBUTYD0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:07:06 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:42 +0530
Message-id: <1435320294-45783-2-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 01/13] kernel/pidns: use ARRAY_SIZE
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
Cc: pankaj.m@samsung.com

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 testcases/kernel/containers/pidns/pidns17.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
index 354716a..16dbaea 100644
--- a/testcases/kernel/containers/pidns/pidns17.c
+++ b/testcases/kernel/containers/pidns/pidns17.c
@@ -74,7 +74,7 @@ int child_fn(void *arg)
 	exit_val = 0;
 
 	/* Spawn many children */
-	for (i = 0; i < (sizeof(children) / sizeof(children[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
 		switch ((children[i] = fork())) {
 		case -1:
 			perror("fork failed");
@@ -98,7 +98,7 @@ int child_fn(void *arg)
 		exit_val = 1;
 	}
 
-	for (i = 0; i < (sizeof(children) / sizeof(children[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
 		if (waitpid(children[i], &status, 0) == -1) {
 			perror("cinit: waitpid failed");
 			kill(children[i], SIGTERM);
-- 
1.7.9.5


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
