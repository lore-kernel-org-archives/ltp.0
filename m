Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z4UMq-0005v4-7t
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:24:00 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z4UMo-0003Q3-5H
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 13:24:00 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPZ00523MJFD6D0@mailout1.samsung.com> for
	ltp-list@lists.sourceforge.net; Mon, 15 Jun 2015 22:23:39 +0900 (KST)
Date: Mon, 15 Jun 2015 13:23:51 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <889206737.1047671434374631301.JavaMail.weblogic@epmlwas03c>
Subject: [LTP] [PATCH 3/7] pan/ltp-pan.c: remove unnecessary malloc type cast
Reply-To: maninder1.s@samsung.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 pan/ltp-pan.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 905ff89..cee71aa 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -368,8 +368,8 @@ int main(int argc, char **argv)
 
 	/* a place to store the pgrps we're watching */
 	running =
-	    (struct tag_pgrp *)malloc((keep_active + 1) *
-				      sizeof(struct tag_pgrp));
+		malloc((keep_active + 1) *
+			sizeof(struct tag_pgrp));
 	if (running == NULL) {
 		fprintf(stderr, "pan(%s): Failed to allocate memory: %s\n",
 			panname, strerror(errno));
@@ -379,7 +379,7 @@ int main(int argc, char **argv)
 	running[keep_active].pgrp = -1;	/* end sentinel */
 
 	/* a head to the orphaned pgrp list */
-	orphans = (struct orphan_pgrp *)malloc(sizeof(struct orphan_pgrp));
+	orphans = malloc(sizeof(struct orphan_pgrp));
 	memset(orphans, 0, sizeof(struct orphan_pgrp));
 
 	srand48(time(NULL) ^ (getpid() + (getpid() << 15)));
@@ -1174,7 +1174,7 @@ static struct collection *get_collection(char *file, int optind, int argc,
 	if (!buf)
 		return NULL;
 
-	coll = (struct collection *)malloc(sizeof(struct collection));
+	coll = malloc(sizeof(struct collection));
 	coll->cnt = 0;
 
 	head = p = n = NULL;
@@ -1187,8 +1187,7 @@ static struct collection *get_collection(char *file, int optind, int argc,
 
 		/* If this is line isn't a comment */
 		if ((*a != '#') && (*a != '\0') && (*a != ' ')) {
-			n = (struct coll_entry *)
-			    malloc(sizeof(struct coll_entry));
+			n = malloc(sizeof(struct coll_entry));
 			if ((n->pcnt_f = strstr(a, "%f"))) {
 				n->pcnt_f[1] = 's';
 			}
@@ -1222,7 +1221,7 @@ static struct collection *get_collection(char *file, int optind, int argc,
 			workstr_left--;
 		}
 
-		n = (struct coll_entry *)malloc(sizeof(struct coll_entry));
+		n = malloc(sizeof(struct coll_entry));
 		if ((n->pcnt_f = strstr(workstr, "%f"))) {
 			n->pcnt_f[1] = 's';
 		}
@@ -1239,8 +1238,7 @@ static struct collection *get_collection(char *file, int optind, int argc,
 	}
 
 	/* get an array */
-	coll->ary = (struct coll_entry **)malloc(coll->cnt *
-						 sizeof(struct coll_entry *));
+	coll->ary = malloc(coll->cnt * sizeof(struct coll_entry *));
 
 	/* fill the array */
 	i = 0;
@@ -1275,7 +1273,7 @@ static char *slurp(char *file)
 		return NULL;
 	}
 
-	buf = (char *)malloc(sbuf.st_size + 1);
+	buf = malloc(sbuf.st_size + 1);
 	if (read(fd, buf, sbuf.st_size) != sbuf.st_size) {
 		fprintf(stderr, "pan(%s): slurp failed.  errno:%d  %s\n",
 			panname, errno, strerror(errno));
@@ -1328,7 +1326,7 @@ static void mark_orphan(struct orphan_pgrp *orphans, pid_t cpid)
 	}
 	if (orph == NULL) {
 		/* make a new struct */
-		orph = (struct orphan_pgrp *)malloc(sizeof(struct orphan_pgrp));
+		orph = malloc(sizeof(struct orphan_pgrp));
 
 		/* plug in the new struct just after the head */
 		orph->next = orphans->next;
-- 
1.7.9.5
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
