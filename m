Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6784FC54EE9
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 11:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B16C3CAD4C
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 13:44:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45A2F3CAAE5
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 13:44:29 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 213C11400DEE
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 13:44:25 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 28KBiErZ042233;
 Tue, 20 Sep 2022 19:44:14 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atcsi01.andestech.com (10.0.15.167) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 20 Sep 2022
 19:44:11 +0800
From: Randolph Lin <randolph@andestech.com>
To: <ltp@lists.linux.it>, <rpalethorpe@suse.de>, <chrubis@suse.cz>
Date: Tue, 20 Sep 2022 19:43:58 +0800
Message-ID: <20220920114358.2259862-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82
MIME-Version: 1.0
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 28KBiErZ042233
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls: Fix tst_res() format string for 64-bit
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
Cc: Mina <minachou@andestech.com>, kester.tw@gmail.com, alankao@andestech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Randolph <randolph@andestech.com>

When compiling format string contains off_t type, to print off_t
correctly is cast it to (long long int) type and change the format
string to %lli.
Fix format string for type block_size.

Co-developed-by: Randolph <randolph@andestech.com>
Signed-off-by: Mina <minachou@andestech.com>
---
 testcases/kernel/syscalls/lseek/lseek01.c       | 17 +++++++++--------
 testcases/kernel/syscalls/lseek/lseek07.c       | 17 +++++++++--------
 testcases/kernel/syscalls/lseek/lseek11.c       | 11 ++++++-----
 testcases/kernel/syscalls/sendfile/sendfile05.c |  3 ++-
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/lseek/lseek01.c b/testcases/kernel/syscalls/lseek/lseek01.c
index 22d9fbfd7..a48b2d4c0 100644
--- a/testcases/kernel/syscalls/lseek/lseek01.c
+++ b/testcases/kernel/syscalls/lseek/lseek01.c
@@ -46,25 +46,26 @@ static void verify_lseek(unsigned int n)
 
 	TEST(lseek(fd, tc->off, tc->whence));
 	if (TST_RET == (off_t) -1) {
-		tst_res(TFAIL | TTERRNO, "lseek(%s, %ld, %s) failed", TFILE,
-			tc->off, tc->wname);
+		tst_res(TFAIL | TTERRNO, "lseek(%s, %lli, %s) failed", TFILE,
+			(long long int)tc->off, tc->wname);
 		return;
 	}
 
 	if (TST_RET != tc->exp_off) {
-		tst_res(TFAIL, "lseek(%s, %ld, %s) returned %ld, expected %ld",
-			TFILE, tc->off, tc->wname, TST_RET, tc->exp_off);
+		tst_res(TFAIL, "lseek(%s, %lli, %s) returned %ld, expected %lli",
+			TFILE, (long long int)tc->off, tc->wname, TST_RET,
+			(long long int)tc->exp_off);
 		return;
 	}
 
 	SAFE_READ(1, fd, read_buf, tc->exp_size);
 
 	if (tc->exp_data && strcmp(read_buf, tc->exp_data)) {
-		tst_res(TFAIL, "lseek(%s, %ld, %s) read incorrect data",
-			TFILE, tc->off, tc->wname);
+		tst_res(TFAIL, "lseek(%s, %lli, %s) read incorrect data",
+			TFILE, (long long int)tc->off, tc->wname);
 	} else {
-		tst_res(TPASS, "lseek(%s, %ld, %s) read correct data",
-			TFILE, tc->off, tc->wname);
+		tst_res(TPASS, "lseek(%s, %lli, %s) read correct data",
+			TFILE, (long long int)tc->off, tc->wname);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/lseek/lseek07.c b/testcases/kernel/syscalls/lseek/lseek07.c
index ae6f48f37..62d399797 100644
--- a/testcases/kernel/syscalls/lseek/lseek07.c
+++ b/testcases/kernel/syscalls/lseek/lseek07.c
@@ -43,14 +43,15 @@ static void verify_lseek(unsigned int n)
 
 	TEST(lseek(*tc->fd, tc->off, SEEK_SET));
 	if (TST_RET == (off_t) -1) {
-		tst_res(TFAIL | TTERRNO, "lseek(%s, %ld, SEEK_SET) failed",
-			tc->fname, tc->off);
+		tst_res(TFAIL | TTERRNO, "lseek(%s, %lli, SEEK_SET) failed",
+			tc->fname, (long long int)tc->off);
 		return;
 	}
 
 	if (TST_RET != tc->exp_off) {
-		tst_res(TFAIL, "lseek(%s, %ld, SEEK_SET) returned %ld, expected %ld",
-			tc->fname, tc->off, TST_RET, tc->exp_off);
+		tst_res(TFAIL, "lseek(%s, %lli, SEEK_SET) returned %ld, expected %lli",
+			tc->fname, (long long int)tc->off, TST_RET,
+			(long long int)tc->exp_off);
 		return;
 	}
 
@@ -63,11 +64,11 @@ static void verify_lseek(unsigned int n)
 	SAFE_READ(1, *tc->fd, read_buf, tc->exp_size);
 
 	if (strcmp(read_buf, tc->exp_data)) {
-		tst_res(TFAIL, "lseek(%s, %ld, SEEK_SET) wrote incorrect data %s",
-			tc->fname, tc->off, read_buf);
+		tst_res(TFAIL, "lseek(%s, %lli, SEEK_SET) wrote incorrect data %s",
+			tc->fname, (long long int)tc->off, read_buf);
 	} else {
-		tst_res(TPASS, "lseek(%s, %ld, SEEK_SET) wrote correct data %s",
-			tc->fname, tc->off, read_buf);
+		tst_res(TPASS, "lseek(%s, %lli, SEEK_SET) wrote correct data %s",
+			tc->fname, (long long int)tc->off, read_buf);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/lseek/lseek11.c b/testcases/kernel/syscalls/lseek/lseek11.c
index 14435f617..2a2383a4a 100644
--- a/testcases/kernel/syscalls/lseek/lseek11.c
+++ b/testcases/kernel/syscalls/lseek/lseek11.c
@@ -159,7 +159,7 @@ static void setup(void)
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0666);
 
 	get_blocksize();
-	tst_res(TINFO, "The block size is %lu", block_size);
+	tst_res(TINFO, "The block size is %d", block_size);
 
 	/*
 	 * truncate to the expected file size directly, to keep away the effect
@@ -202,14 +202,15 @@ static void test_lseek(unsigned int n)
 
 	if (rc != 0) {
 		tst_res(TFAIL,
-		        "The %uth test failed: %s from startblock %ld offset %ld, expect \'%s\' return \'%s\'",
+		        "The %uth test failed: %s from startblock %lli offset %lli, expect \'%s\' return \'%s\'",
 		        n, (tp->whence == SEEK_DATA) ? "SEEK_DATA" : "SEEK_HOLE",
-		        tp->startblock, tp->offset, tp->data ? tp->data : "", buf);
+		        (long long int)tp->startblock, (long long int)tp->offset,
+		        tp->data ? tp->data : "", buf);
 	} else {
 		tst_res(TPASS,
-		        "The %uth test passed: %s from startblock %ld offset %ld",
+		        "The %uth test passed: %s from startblock %lli offset %lli",
 		        n, (tp->whence == SEEK_DATA) ? "SEEK_DATA" : "SEEK_HOLE",
-		        tp->startblock, tp->offset);
+		        (long long int)tp->startblock, (long long int)tp->offset);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/sendfile/sendfile05.c b/testcases/kernel/syscalls/sendfile/sendfile05.c
index e271a47d4..1879b4666 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile05.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile05.c
@@ -39,7 +39,8 @@ static void run(void)
 	off_t offset = -1;
 
 	TST_EXP_FAIL(sendfile(out_fd, in_fd, &offset, 1), EINVAL,
-		     "sendfile(out, in, &offset, ..) with offset=%ld", offset);
+		     "sendfile(out, in, &offset, ..) with offset=%lli",
+		     (long long int)offset);
 }
 
 static struct tst_test test = {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
