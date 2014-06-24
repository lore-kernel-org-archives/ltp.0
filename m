Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WzKwJ-0003Ba-0K
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 07:14:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WzKwH-0002ck-UY
	for ltp-list@lists.sourceforge.net; Tue, 24 Jun 2014 07:14:46 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s5O7EaX3031932
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Jun 2014 15:14:37 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 24 Jun 2014 15:11:38 +0800
Message-ID: <1403593899-17040-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/2] pan/ltp-pan.c: fix compilation warnings
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

Delete the useless 'char *av[2], bigarg[82];' definition.

Fix the 'ignoring return value of read(2)' compilation warnings.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 pan/ltp-pan.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 6a1a797..9324f47 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -453,13 +453,6 @@ int main(int argc, char **argv)
 	 * this is an "active file cleanliness" thing
 	 */
 	{
-		char *av[2], bigarg[82];
-
-		memset(bigarg, '.', 81);
-		bigarg[81] = '\0';
-		av[0] = bigarg;
-		av[1] = NULL;
-
 		for (c = 0; c < keep_active; c++) {
 			if (zoo_mark_cmdline(zoofile, c, panname, "")) {
 				fprintf(stderr, "pan(%s): %s\n", panname,
@@ -1026,7 +1019,8 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
 		char *termtype;
 		struct tms notime = { 0, 0, 0, 0 };
 
-		read(errpipe[0], errbuf, errlen);
+		if (read(errpipe[0], errbuf, errlen) < 0)
+			fprintf(stderr, "Failed to read from errpipe[0]\n");
 		close(errpipe[0]);
 		errbuf[errlen] = '\0';
 		/* fprintf(stderr, "%s", errbuf); */
-- 
1.8.2.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
