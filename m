Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8SS6-0008DV-Mc
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:09:50 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8SS5-0006ww-Cx
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:09:50 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ02FYGWG6Z7B0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:09:42 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:48 +0530
Message-id: <1435320294-45783-8-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 07/13] kernel/socketpair: use ARRAY_SIZE
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
 .../kernel/syscalls/socketpair/socketpair02.c      |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index c5f744c..f1ff463 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	if (socketpair(PF_UNIX, SOCK_STREAM, 0, fds) == -1) {
 		tst_brkm(TFAIL, cleanup, "socketpair(0) failed");
 	}
-	for (i = 0; i < (sizeof(fds) / sizeof(fds[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(fds); i++) {
 		fl = fcntl(fds[i], F_GETFL);
 		if (fl == -1) {
 			tst_brkm(TBROK, cleanup, "fcntl failed");
@@ -141,7 +141,7 @@ int main(int argc, char *argv[])
 	if (socketpair(PF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0, fds) == -1) {
 		tst_brkm(TFAIL, cleanup, "socketpair(SOCK_NONBLOCK) failed");
 	}
-	for (i = 0; i < (sizeof(fds) / sizeof(fds[0])); i++) {
+	for (i = 0; i < ARRAY_SIZE(fds); i++) {
 		fl = fcntl(fds[i], F_GETFL);
 		if (fl == -1) {
 			tst_brkm(TBROK, cleanup, "fcntl failed");
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
