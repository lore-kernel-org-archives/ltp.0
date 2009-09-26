Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1Mrg27-0005XS-LY
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:27 +0000
Received: from fg-out-1718.google.com ([72.14.220.156])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mrg1z-0000xE-EX
	for ltp-list@lists.sourceforge.net; Sat, 26 Sep 2009 22:46:27 +0000
Received: by fg-out-1718.google.com with SMTP id d23so1154524fga.10
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 Sep 2009 15:46:13 -0700 (PDT)
From: Andrew Vagin <avagin@gmail.com>
Date: Sun, 27 Sep 2009 02:46:01 +0400
Message-Id: <1254005162-27353-4-git-send-email-avagin@gmail.com>
In-Reply-To: <1254005162-27353-3-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
	<1254005162-27353-2-git-send-email-avagin@gmail.com>
	<1254005162-27353-3-git-send-email-avagin@gmail.com>
Subject: [LTP] [PATCH 4/5] fsstress: fix memory leak in fread_d
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

1. check result from operation open before set flags
2. close descriptor and free path if set flags failed

valgrind --leak-check=full --show-reachable=yes ./fsstress -d /home/shpagin/git-archive/ltp/testcases/kernel/fs/fsstress/tmp -l 10 -n 100

==23212== 1,134 bytes in 108 blocks are definitely lost in loss record 4 of 5
==23212==    at 0x4A0776F: realloc (vg_replace_malloc.c:429)
==23212==    by 0x401E6A: append_pathname (fsstress.c:528)
==23212==    by 0x4024E3: fent_to_name (fsstress.c:760)
==23212==    by 0x40284F: get_fname (fsstress.c:846)
==23212==    by 0x4041E0: dread_f (fsstress.c:1757)
==23212==    by 0x402368: doproc (fsstress.c:728)
==23212==    by 0x401CC1: main (fsstress.c:463)

Signed-off-by: Andrew Vagin <avagin@gmail.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 715c08d..cf7ba76 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -1764,10 +1764,6 @@ dread_f(int opno, long r)
 	}
 	fd = open_path(&f, O_RDONLY);
 
-	if (!setdirect(fd)) {
-		return;
-	}
-
 	e = fd < 0 ? errno : 0;
 	check_cwd();
 	if (fd < 0) {
@@ -1777,6 +1773,13 @@ dread_f(int opno, long r)
 		free_pathname(&f);
 		return;
 	}
+
+	if (!setdirect(fd)) {
+		close(fd);
+		free_pathname(&f);
+		return;
+	}
+
 	if (fstat64(fd, &stb) < 0) {
 		if (v)
 			printf("%d/%d: dread - fstat64 %s failed %d\n",
@@ -1864,8 +1867,11 @@ dwrite_f(int opno, long r)
 		return;
 	}
 
-	if (!setdirect(fd))
+	if (!setdirect(fd)) {
+		close(fd);
+		free_pathname(&f);
 		return;
+	}
 	if (fstat64(fd, &stb) < 0) {
 		if (v)
 			printf("%d/%d: dwrite - fstat64 %s failed %d\n",
-- 
1.6.2.5


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
