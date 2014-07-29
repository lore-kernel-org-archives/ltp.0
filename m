Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XC6aB-0003Xk-QL
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 12:32:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XC6aA-0001d0-1j
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 12:32:43 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TCWZqv004747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 08:32:35 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s6TCWXxc024802
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 08:32:34 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Jul 2014 14:32:26 +0200
Message-Id: <26e1b478753cc8bfbca01350ba27f7ceb0a22b03.1406637055.git.jstancek@redhat.com>
In-Reply-To: <3f8381b9a1e1fc43c1bc47d416045e1e6fe3ae69.1406637055.git.jstancek@redhat.com>
References: <3f8381b9a1e1fc43c1bc47d416045e1e6fe3ae69.1406637055.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2 2/2] mem/lib: optimize how alloc_mem dirties pages
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

There's no need to write pattern across whole range,
just make sure we touch every page.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 61b1ee6..b0c97ae 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -28,7 +28,8 @@
 
 static int alloc_mem(long int length, int testcase)
 {
-	void *s;
+	char *s;
+	long i, pagesz = getpagesize();
 
 	tst_resm(TINFO, "allocating %ld bytes.", length);
 
@@ -43,7 +44,8 @@ static int alloc_mem(long int length, int testcase)
 	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
 		return errno;
 #endif
-	memset(s, '\a', length);
+	for (i = 0; i < length; i += pagesz)
+		s[i] = '\a';
 
 	return 0;
 }
-- 
1.7.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
