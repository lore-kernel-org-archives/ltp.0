Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RzQuW-0005Qo-2W
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 10:56:00 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RzQuQ-0004wE-Gt
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 10:56:00 +0000
Received: by pbcum15 with SMTP id um15so6166223pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Feb 2012 02:55:48 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 20 Feb 2012 18:55:01 +0800
Message-Id: <1329735301-17676-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
References: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 2/2] mm/ksm,oom: fix count_numa()
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
To: Zhouping Liu <zliu@redhat.com>, LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


This patch makes ksm on oom tests use the new count_numa() function.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/ksm/ksm02.c |    7 ++++---
 testcases/kernel/mem/ksm/ksm04.c |    7 ++++---
 testcases/kernel/mem/oom/oom02.c |    3 ++-
 testcases/kernel/mem/oom/oom04.c |    5 +++--
 4 files changed, 13 insertions(+), 9 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0002-mm-ksm-oom-fix-count_numa.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-mm-ksm-oom-fix-count_numa.patch"

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index c7333c0..8f99063 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -85,15 +85,16 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nnodes = 1;
+	unsigned long nnodes;
 	unsigned long nmask = 2;
+	long nodes[MAXNODES];
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	nnodes = count_numa();
-	if (count_numa() <= 1)
+	nnodes = count_numa(nodes);
+	if (nnodes <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 
 	setup();
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index ff55c31..feb9502 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -85,15 +85,16 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nnodes = 1;
+	unsigned long nnodes;
 	unsigned long nmask = 2;
+	long nodes[MAXNODES];
 
 	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	nnodes = count_numa();
-	if (count_numa() <= 1)
+	nnodes = count_numa(nodes);
+	if (nnodes <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 
 	setup();
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 585ffbf..2fa1c9d 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -49,6 +49,7 @@ int main(int argc, char *argv[])
 	char *msg;
 	int lc, fd;
 	unsigned long nnodes = 1;
+	long nodes[MAXNODES];
 
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -57,7 +58,7 @@ int main(int argc, char *argv[])
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
-	nnodes = count_numa();
+	nnodes = count_numa(nodes);
 	if (nnodes <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 724b55b..a3dd99f 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -49,6 +49,7 @@ int main(int argc, char *argv[])
 	char *msg;
 	int lc, fd;
 	unsigned long nnodes = 1;
+	long nodes[MAXNODES];
 	char buf[BUFSIZ], mem[BUFSIZ];
 
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
@@ -58,8 +59,8 @@ int main(int argc, char *argv[])
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
-	nnodes = count_numa();
-	if (count_numa() <= 1)
+	nnodes = count_numa(nodes);
+	if (nnodes <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 
 	setup();

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



