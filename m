Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F9EECAAD3
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 05:39:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E9413CA968
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 07:39:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF7A43C88EB
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 07:39:04 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F236D1000A16
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 07:39:00 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 2875cp6c002031;
 Wed, 7 Sep 2022 13:38:51 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Wed, 7 Sep 2022 13:38:49 +0800
From: Randolph Lin <randolph@andestech.com>
To: <ltp@lists.linux.it>, <rpalethorpe@suse.de>
Date: Wed, 7 Sep 2022 13:38:41 +0800
Message-ID: <20220907053841.7923-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82
MIME-Version: 1.0
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 2875cp6c002031
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: Fix tst_res() format string for 64-bit
 offset
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Mina Hui-Min Chou <minachou@andestech.com>, kester.tw@gmail.com,
 alankao@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Mina Hui-Min Chou <minachou@andestech.com>

When compiling as 32-bit with _FILE_OFFSET_BITS=64, the format string
needs to be specified as 64-bit long (%lld).
Fix format string for type block_size.

ref:
https://github.com/linux-test-project/ltp/commit/98e25434db561e69624bc34b0fab456ca2e501ea

Co-developed-by: Randolph <randolph@andestech.com>
Signed-off-by: Mina <minachou@andestech.com>
---
 testcases/kernel/syscalls/lseek/lseek01.c       | 8 ++++----
 testcases/kernel/syscalls/lseek/lseek07.c       | 8 ++++----
 testcases/kernel/syscalls/lseek/lseek11.c       | 6 +++---
 testcases/kernel/syscalls/sendfile/sendfile05.c | 2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index 22d9fbfd7..db973d7c4 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -46,13 +46,13 @@ static void verify_lseek(unsigned int n)
 
 	TEST(lseek(fd, tc->off, tc->whence));
 	if (TST_RET == (off_t) -1) {
-		tst_res(TFAIL | TTERRNO, "lseek(%s, %ld, %s) failed", TFILE,
+		tst_res(TFAIL | TTERRNO, "lseek(%s, %lld, %s) failed", TFILE,
 			tc->off, tc->wname);
 		return;
 	}
 
 	if (TST_RET != tc->exp_off) {
-		tst_res(TFAIL, "lseek(%s, %ld, %s) returned %ld, expected %ld",
+		tst_res(TFAIL, "lseek(%s, %lld, %s) returned %ld, expected %lld",
 			TFILE, tc->off, tc->wname, TST_RET, tc->exp_off);
 		return;
 	}
@@ -60,10 +60,10 @@ static void verify_lseek(unsigned int n)
 	SAFE_READ(1, fd, read_buf, tc->exp_size);
 
 	if (tc->exp_data && strcmp(read_buf, tc->exp_data)) {
-		tst_res(TFAIL, "lseek(%s, %ld, %s) read incorrect data",
+		tst_res(TFAIL, "lseek(%s, %lld, %s) read incorrect data",
 			TFILE, tc->off, tc->wname);
 	} else {
-		tst_res(TPASS, "lseek(%s, %ld, %s) read correct data",
+		tst_res(TPASS, "lseek(%s, %lld, %s) read correct data",
 			TFILE, tc->off, tc->wname);
 	}
 }
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index ae6f48f37..e35d5c772 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -43,13 +43,13 @@ static void verify_lseek(unsigned int n)
 
 	TEST(lseek(*tc->fd, tc->off, SEEK_SET));
 	if (TST_RET == (off_t) -1) {
-		tst_res(TFAIL | TTERRNO, "lseek(%s, %ld, SEEK_SET) failed",
+		tst_res(TFAIL | TTERRNO, "lseek(%s, %lld, SEEK_SET) failed",
 			tc->fname, tc->off);
 		return;
 	}
 
 	if (TST_RET != tc->exp_off) {
-		tst_res(TFAIL, "lseek(%s, %ld, SEEK_SET) returned %ld, expected %ld",
+		tst_res(TFAIL, "lseek(%s, %lld, SEEK_SET) returned %ld, expected %lld",
 			tc->fname, tc->off, TST_RET, tc->exp_off);
 		return;
 	}
@@ -63,10 +63,10 @@ static void verify_lseek(unsigned int n)
 	SAFE_READ(1, *tc->fd, read_buf, tc->exp_size);
 
 	if (strcmp(read_buf, tc->exp_data)) {
-		tst_res(TFAIL, "lseek(%s, %ld, SEEK_SET) wrote incorrect data %s",
+		tst_res(TFAIL, "lseek(%s, %lld, SEEK_SET) wrote incorrect data %s",
 			tc->fname, tc->off, read_buf);
 	} else {
-		tst_res(TPASS, "lseek(%s, %ld, SEEK_SET) wrote correct data %s",
+		tst_res(TPASS, "lseek(%s, %lld, SEEK_SET) wrote correct data %s",
 			tc->fname, tc->off, read_buf);
 	}
 }
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 14435f617..1292ae165 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -159,7 +159,7 @@ static void setup(void)
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0666);
 
 	get_blocksize();
-	tst_res(TINFO, "The block size is %lu", block_size);
+	tst_res(TINFO, "The block size is %d", block_size);
 
 	/*
 	 * truncate to the expected file size directly, to keep away the effect
@@ -202,12 +202,12 @@ static void test_lseek(unsigned int n)
 
 	if (rc != 0) {
 		tst_res(TFAIL,
-		        "The %uth test failed: %s from startblock %ld offset %ld, expect \'%s\' return \'%s\'",
+		        "The %uth test failed: %s from startblock %lld offset %lld, expect \'%s\' return \'%s\'",
 		        n, (tp->whence == SEEK_DATA) ? "SEEK_DATA" : "SEEK_HOLE",
 		        tp->startblock, tp->offset, tp->data ? tp->data : "", buf);
 	} else {
 		tst_res(TPASS,
-		        "The %uth test passed: %s from startblock %ld offset %ld",
+		        "The %uth test passed: %s from startblock %lld offset %lld",
 		        n, (tp->whence == SEEK_DATA) ? "SEEK_DATA" : "SEEK_HOLE",
 		        tp->startblock, tp->offset);
 	}
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index e271a47d4..1b1dd8f00 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -39,7 +39,7 @@ static void run(void)
 	off_t offset = -1;
 
 	TST_EXP_FAIL(sendfile(out_fd, in_fd, &offset, 1), EINVAL,
-		     "sendfile(out, in, &offset, ..) with offset=%ld", offset);
+		     "sendfile(out, in, &offset, ..) with offset=%lld", offset);
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
