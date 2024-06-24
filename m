Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC2AC27C4F
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 01:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 145A43D0F7D
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 03:55:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E69EA3CFA21
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 03:54:45 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.207.19.206; helo=smtpbgbr1.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B382D600052
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 03:54:42 +0200 (CEST)
X-QQ-mid: bizesmtp83t1719194076t7s6776p
X-QQ-Originating-IP: YfJlR8Yeg2+PNpGIqSVkfp/YCc0knknyalgih3X+Isw=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 24 Jun 2024 09:54:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4826063833496330004
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Mon, 24 Jun 2024 09:54:32 +0800
Message-Id: <20240624015432.54985-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240606065506.1686-1-lufei@uniontech.com>
References: <20240606065506.1686-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] acct: fix make check errors: using .needs_kconfigs
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
Reply-To: pvorel@suse.cz
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fix make check errors and warnings. Using .needs_kconfigs instead of ENOSYS.

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/acct/acct01.c | 18 ++++++++----------
 testcases/kernel/syscalls/acct/acct02.c |  2 +-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index a05ed2ea9..1b53a32f2 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -25,8 +25,7 @@
 
 #include "tst_test.h"
 
-#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-			 S_IXGRP|S_IROTH|S_IXOTH)
+#define DIR_MODE	0755
 #define FILE_EISDIR		"."
 #define FILE_EACCESS		"/dev/null"
 #define FILE_ENOENT		"/tmp/does/not/exist"
@@ -61,8 +60,8 @@ static struct test_case {
 	char **filename;
 	char *desc;
 	int exp_errno;
-	void (*setupfunc) ();
-	void (*cleanfunc) ();
+	void (*setupfunc)();
+	void (*cleanfunc)();
 } tcases[] = {
 	{&file_eisdir,  FILE_EISDIR,  EISDIR,  NULL,   NULL},
 	{&file_eaccess, FILE_EACCESS, EACCES,  NULL,   NULL},
@@ -79,10 +78,6 @@ static void setup(void)
 {
 	int fd;
 
-	TEST(acct(NULL));
-	if (TST_RET == -1 && TST_ERR == ENOSYS)
-		tst_brk(TCONF, "acct() system call isn't configured in kernel");
-
 	ltpuser = SAFE_GETPWNAM("nobody");
 
 	fd = SAFE_CREAT(FILE_TMPFILE, 0777);
@@ -113,7 +108,7 @@ static void verify_acct(unsigned int nr)
 		tcase->setupfunc();
 
 	TST_EXP_FAIL(acct(*tcase->filename), tcase->exp_errno,
-	             "acct(%s)", tcase->desc);
+			"acct(%s)", tcase->desc);
 
 	if (tcase->cleanfunc)
 		tcase->cleanfunc();
@@ -136,5 +131,8 @@ static struct tst_test test = {
 		{&file_enametoolong, .size = PATH_MAX+2},
 		{&file_erofs, .str = FILE_EROFS},
 		{}
-	}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_BSD_PROCESS_ACCT=y",
+	},
 };
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index d3f3d9d04..74019f430 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -186,7 +186,7 @@ static void run(void)
 
 		if (read_bytes != acct_size) {
 			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
-			        read_bytes, acct_size);
+					read_bytes, acct_size);
 			goto exit;
 		}
 
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
