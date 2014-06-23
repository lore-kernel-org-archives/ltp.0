Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wz08h-0002se-My
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 09:02:11 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wz08f-0008QI-Rw
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 09:02:11 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5N921mD030113
	for <ltp-list@lists.sourceforge.net>; Mon, 23 Jun 2014 17:02:01 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 23 Jun 2014 16:59:08 +0800
Message-ID: <1403513949-24653-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] pan/ltp-pan.c: fix compilation warnings
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

Delete the useless 'char *av[2];' definition.

Fix the 'ignoring return value of read(2)' compilation warnings.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 pan/ltp-pan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 6a1a797..c36a9ee 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -453,12 +453,10 @@ int main(int argc, char **argv)
 	 * this is an "active file cleanliness" thing
 	 */
 	{
-		char *av[2], bigarg[82];
+		char bigarg[82];
 
 		memset(bigarg, '.', 81);
 		bigarg[81] = '\0';
-		av[0] = bigarg;
-		av[1] = NULL;
 
 		for (c = 0; c < keep_active; c++) {
 			if (zoo_mark_cmdline(zoofile, c, panname, "")) {
@@ -864,6 +862,7 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 	static long cmdno = 0;
 	int errpipe[2];		/* way to communicate to parent that the tag  */
 	char errbuf[1024];	/* didn't actually start */
+	int ret;
 
 	/* Try to open the file that will be stdout for the test */
 	if (test_out_dir) {
@@ -1026,7 +1025,8 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 		char *termtype;
 		struct tms notime = { 0, 0, 0, 0 };
 
-		read(errpipe[0], errbuf, errlen);
+		ret = read(errpipe[0], errbuf, errlen);
+		(void)ret;
 		close(errpipe[0]);
 		errbuf[errlen] = '\0';
 		/* fprintf(stderr, "%s", errbuf); */
-- 
1.8.2.1


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
