Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sj3nv-0005gi-0s
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 07:33:47 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Sj3nq-0004cK-Q9
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 07:33:47 +0000
Received: by dalh21 with SMTP id h21so4499166dal.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Jun 2012 00:33:36 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 25 Jun 2012 15:33:02 +0800
Message-Id: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH 1/2] mm/vma01: consider topdown and bottomup allocation
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
To: hejianet@linux.vnet.ibm.com, Wang Sheng-Hui <shhuiw@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


When calculating VMAs, results differ in topdown and bottomup memory
allocation mechanisms. This patch fix the potential failures and should
work like below:

In topdown allocation, the start addr in second VMA should be smaller
than first one, i.e.:

    u======t------(t+3*ps)
      2nd    1st

Thus, in buggy kernel, if we find a VMA mapping entry in child like:

    start_addr == u && end_addr == t+3*ps;

the test would go fail. Otherwise, in good kernel, we should see

    start_addr1 == u && end_addr1 == t;
    start_addr2 == t && end_addr2 == t+3*ps;

While in bottomup allocation, it's different:

    t------u======(t+6*ps)
      1st    2nd

Here in buggy kernel, we can see VMA mapping entry like this:

    start_addr == t && end_addr == t+6*ps;

And in good kernel:

    start_addr1 == t && end_addr1 == u;
    start_addr2 == u && end_addr2 == t+6*ps;

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/vma/vma01.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0001-mm-vma01-consider-topdown-and-bottomup-allocation.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-vma01-consider-topdown-and-bottomup-allocation.patch"

diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index 398d7a1..16ee078 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -59,7 +59,7 @@ char *TCID = "vma01";
 int TST_TOTAL = 1;
 
 static void check_vma(void);
-static void *get_end_addr(void *addr_s, char *mapfile);
+static void *get_end_addr(void *addr_s);
 static void check_status(int status);
 static void setup(void);
 static void cleanup(void);
@@ -90,9 +90,10 @@ int main(int argc, char **argv)
 static void check_vma(void)
 {
 	int status;
-	void *t, *u, *x, *y;
+	int topdown;
+	void *t, *u, *x;
 
-	t = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+	t = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	if (t == MAP_FAILED)
 		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
 	memset(t, 1, ps);
@@ -103,21 +104,29 @@ static void check_vma(void)
 	case 0:
 		memset(t, 2, ps);
 		u = mmap(t + 3*ps, 3*ps, PROT_WRITE,
-			    MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
+			    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 		if (u == MAP_FAILED) {
-			perror("mmap failed.\n");
+			perror("mmap");
 			exit(255);
 		}
+		topdown = (u > t) ? 0 : 1;
 		printf("parent: t = %p\n", t);
 		printf("child : u = %p\n", u);
 		memset(u, 2, ps);
 
-		x = get_end_addr(u, MAPS_FILE);
-		if (x == u + 6*ps)
-			exit(1);
-		if (x == u + 3*ps) {
-			y = get_end_addr(x, MAPS_FILE);
-			if (y == x + 3*ps)
+		if (topdown) {
+			x = get_end_addr(u);
+			printf("child : x = %p\n", x);
+			if (x == t + 3*ps)
+				exit(1);
+			else if (x == t && get_end_addr(x) == t + 3*ps)
+				exit(0);
+		} else {
+			x = get_end_addr(t);
+			printf("child : x = %p\n", x);
+			if (x == t + 6*ps)
+				exit(1);
+			else if (x == u && get_end_addr(x) == t + 6*ps)
 				exit(0);
 		}
 		exit(255);
@@ -131,13 +140,13 @@ static void check_vma(void)
 	}
 }
 
-static void *get_end_addr(void *addr_s, char *mapfile)
+static void *get_end_addr(void *addr_s)
 {
 	FILE *fp;
 	void *s, *t;
 	char buf[BUFSIZ];
 
-	fp = fopen(mapfile, "r");
+	fp = fopen(MAPS_FILE, "r");
 	if (fp == NULL)
 		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
 	while (fgets(buf, BUFSIZ, fp) != NULL) {

--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



