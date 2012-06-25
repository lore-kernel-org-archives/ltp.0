Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sj3nx-0005gy-Dd
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 07:33:49 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Sj3nt-0005TU-B7
	for ltp-list@lists.sourceforge.net; Mon, 25 Jun 2012 07:33:49 +0000
Received: by pbbrq2 with SMTP id rq2so5709608pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Jun 2012 00:33:39 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 25 Jun 2012 15:33:03 +0800
Message-Id: <1340609583-8300-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
References: <1340609583-8300-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH 2/2] mm/vma01: create a bighole
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


There are two mmaps in vma01, sometimes first mmap succeeds while
second mmap might fail due to a small hole (3*ps <= hole < 6*ps)
produced by /etc/ld.so.cache and /etc/libc.so.6, I created a big hole
and then munmap it to make sure both allocations can succeed.

    |-3*ps-|
	|------|------|------| hole
	t      p
	|======|------|        top-down alloc
	       |------|======| bottom-up alloc

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/vma/vma01.c |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch; name="0002-mm-vma01-create-a-bighole.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-mm-vma01-create-a-bighole.patch"

diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index 16ee078..3d00b97 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -59,12 +59,14 @@ char *TCID = "vma01";
 int TST_TOTAL = 1;
 
 static void check_vma(void);
+static void create_bighole(void);
 static void *get_end_addr(void *addr_s);
 static void check_status(int status);
 static void setup(void);
 static void cleanup(void);
 
 static unsigned long ps;
+static void *p;
 
 int main(int argc, char **argv)
 {
@@ -93,7 +95,8 @@ static void check_vma(void)
 	int topdown;
 	void *t, *u, *x;
 
-	t = mmap(NULL, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	create_bighole();
+	t = mmap(p, 3*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	if (t == MAP_FAILED)
 		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
 	memset(t, 1, ps);
@@ -140,6 +143,26 @@ static void check_vma(void)
 	}
 }
 
+static void create_bighole(void)
+{
+	void *t;
+
+	/*
+	 * |-3*ps-|
+	 * |------|------|------| hole
+	 * t      p
+	 * |======|------|        top-down alloc
+	 *        |------|======| bottom-up alloc
+	 */
+	t = mmap(NULL, 9*ps, PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (t == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	memset(t, 'a', ps);
+	p = t + 3*ps;
+	if (munmap(t, 9*ps) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+}
+
 static void *get_end_addr(void *addr_s)
 {
 	FILE *fp;

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



