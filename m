Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QnhHW-00051R-14
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 01:26:58 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QnhHV-0007bL-4m
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 01:26:57 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p711QpRE031413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 31 Jul 2011 21:26:51 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon,  1 Aug 2011 09:26:08 +0800
Message-Id: <9456f48c7d2f166712811753aaaa117410a85b51.1312148778.git.czhang@redhat.com>
In-Reply-To: <1312161969-9519-1-git-send-email-czhang@redhat.com>
References: <4387b2003cde3c5841dd4bcd9d58560aa891501d.1312147752.git.czhang@redhat.com>
	<1312161969-9519-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH] mm/mbind01: fix broken testcase
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


the original mm/mbind01 test doesn't work, the patch corrected the
errors and both postive and negative tests passed.

positive: # ./mbind01
mbind01     0  TINFO  :  pid = 6637 addr = 0x7f4c5111f000
mbind01     0  TINFO  :  start = 0x7f4c5111f000, end = 0x7f4c51122000
mbind01     1  TPASS  :  only 1 VMA.

negative: # ./mbind01
mbind01     0  TINFO  :  pid = 21868 addr = 0x7fe6eb374000
mbind01     0  TINFO  :  start = 0x7fe6eb374000, end = 0x7fe6eb375000
mbind01     0  TINFO  :  start = 0x7fe6eb375000, end = 0x7fe6eb376000
mbind01     0  TINFO  :  start = 0x7fe6eb376000, end = 0x7fe6eb377000
mbind01     1  TFAIL  :  >1 unmerged VMAs.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/mbind/mbind01.c |   54 ++++++++++++++++++++++-----------
 1 files changed, 36 insertions(+), 18 deletions(-)


--------------1.7.6
Content-Type: text/x-patch; name="0001-mm-mbind01-fix-broken-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-mbind01-fix-broken-testcase.patch"

diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
index fc97174..35f26ca 100644
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -60,11 +60,11 @@ static void usage(void);
 int main(int argc, char** argv)
 {
 	FILE *fp;
-	void* addr;
+	void *addr, *start, *end, *lastend;
 	int node, err, lc;
+	char buf[BUFSIZ];
 	struct bitmask *nmask = numa_allocate_nodemask();
-	char buf[BUFSIZ], start[BUFSIZ], end[BUFSIZ], string[BUFSIZ];
-	char *p, *msg;
+	char *msg;
 
 	pagesize = getpagesize();
 	msg = parse_opts(argc, argv, options, usage);
@@ -81,7 +81,7 @@ int main(int argc, char** argv)
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
-		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
+		addr = mmap(NULL, pagesize*3, PROT_WRITE,
 			MAP_ANON|MAP_PRIVATE, 0, 0);
 		if (addr == MAP_FAILED)
 			tst_brkm(TBROK|TERRNO, NULL, "mmap");
@@ -108,26 +108,44 @@ int main(int argc, char** argv)
 
 		/* /proc/self/maps in the form of
 		   "00400000-00406000 r-xp 00000000". */
-		sprintf(string, "%p", addr);
 		fp = fopen("/proc/self/maps", "r");
 		if (fp == NULL)
 			tst_brkm(TBROK|TERRNO, NULL, "fopen");
 
 		while (fgets(buf, BUFSIZ, fp) != NULL) {
-			/* Find out the 1st VMAs. */
-			if (sscanf(buf, "%s-%s ", start, end) != 2)
+			if (sscanf(buf, "%p-%p ", &start, &end) != 2)
 				continue;
-			/* Remove leading 0x. */
-			if (strcmp(string + 2, start) != 0)
-				continue;
-			/* Find out the second VMA. */
-			if (fgets(buf, BUFSIZ, fp) == NULL)
-				tst_brkm(TBROK|TERRNO, NULL, "fgets");
-			p = strtok(buf, "-");
-			if (p == NULL || strcmp(p, end) != 0)
-				tst_resm(TPASS, "only 1 VMA.");
-			else
-				tst_resm(TFAIL, "more than 1 VMA.");
+
+			if (start == addr) {
+				tst_resm(TINFO, "start = %p, end = %p",
+					start, end);
+				if (end == addr + pagesize*3) {
+					tst_resm(TPASS, "only 1 VMA.");
+					break;
+				}
+
+				lastend = end;
+				while (fgets(buf, BUFSIZ, fp) != NULL) {
+					/* No more VMAs, break */
+					if (sscanf(buf, "%p-%p ", &start,
+						&end) != 2)
+						break;
+					tst_resm(TINFO, "start = %p, end = %p",
+						start, end);
+
+					/* more VMAs found */
+					if (start == lastend)
+						lastend = end;
+					if (end == addr + pagesize*3) {
+						tst_resm(TFAIL,
+							">1 unmerged VMAs.");
+						break;
+					}
+				}
+				if (end != addr + pagesize*3)
+					tst_resm(TFAIL, "no matched VMAs.");
+				break;
+			}
 		}
 		fclose(fp);
 		if (munmap(addr, pagesize*3) == -1)

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



