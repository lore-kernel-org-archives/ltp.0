Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304A8C27C52
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 06:55:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7993A3D0A58
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 08:55:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29DAC3CE32A
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 08:55:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=13.245.218.24; helo=smtpbg153.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F0241028F6A
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 08:55:21 +0200 (CEST)
X-QQ-mid: bizesmtp88t1717656912taocyygx
X-QQ-Originating-IP: Fdy/2h+Y+4TEOxCzal/a1q6Y+oIdtmnHvUaoYzWlHOw=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 06 Jun 2024 14:55:10 +0800 (CST)
X-QQ-SSF: 01400000000000C0C000000A0000000
X-QQ-FEAT: TXoNPSSaW4mmE43q7OwFnwU66TgRL+8QJU6Zr1FOm4eejsFGThXUj4xqNawH9
 LmG7LgHaL3ZiV2WD333aUwzebr6Ml1VJ5zMQdTl8P4OYcgQzHCCtiqQhulXN0eypJJmKHt4
 AgoIDa49wFTOPj7Ny6yZ8ev6W/KRXGqBp7XEM58r3iqeLuI4hT4E+I7eHprLh2LUoGKwiMq
 n25/5hQFymQfLtojbZ0lZREpFrWUuJACjTPUahxWNoNQfeBZ/jtBx7QbHUQ4M/5ZczOxvf5
 kKotCnDOiDpCC2D2yulM+yHZYaPZ0DGEzBC7I5Dg59eLkuVrPYl03XkbXYw1hwKDtZVwRdD
 d5A7ji90Oos3VALpIBm3Kxj+STxSJ4iivJnvM3Gq6NdzmxSb65HQKPUBwRw9Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3184383029548576545
From: lufei <lufei@uniontech.com>
To: ltp@lists.linux.it
Date: Thu,  6 Jun 2024 14:55:06 +0800
Message-Id: <20240606065506.1686-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] acct01: add EFAULT errno check
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
Cc: lufei <lufei@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1. add EFAULT errno check.
2. fix make check errors and warnings.

Signed-off-by: lufei <lufei@uniontech.com>
---
 testcases/kernel/syscalls/acct/acct01.c | 31 +++++++++++++++++--------
 testcases/kernel/syscalls/acct/acct02.c |  2 +-
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index a05ed2ea9..ed1817bc5 100644
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
@@ -34,6 +33,7 @@
 #define FILE_TMPFILE		"./tmpfile"
 #define FILE_ELOOP		"test_file_eloop1"
 #define FILE_EROFS		"ro_mntpoint/file"
+#define FILE_EFAULT		"/tmp/invalid/file/name"
 
 static struct passwd *ltpuser;
 
@@ -46,6 +46,7 @@ static char *file_eloop;
 static char *file_enametoolong;
 static char *file_erofs;
 static char *file_null;
+static char *file_efault;
 
 static void setup_euid(void)
 {
@@ -57,12 +58,22 @@ static void cleanup_euid(void)
 	SAFE_SETEUID(0);
 }
 
+static void setup_emem(void)
+{
+	file_efault = SAFE_MMAP(NULL, 1, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+}
+static void cleanup_emem(void)
+{
+	SAFE_MUNMAP(file_efault, 1);
+}
+
 static struct test_case {
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
@@ -73,16 +84,13 @@ static struct test_case {
 	{&file_eloop,   FILE_ELOOP,   ELOOP,        NULL, NULL},
 	{&file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
 	{&file_erofs,   FILE_EROFS,   EROFS,        NULL, NULL},
+	{&file_efault,	FILE_EFAULT,  EFAULT,  setup_emem, cleanup_emem},
 };
 
 static void setup(void)
 {
 	int fd;
 
-	TEST(acct(NULL));
-	if (TST_RET == -1 && TST_ERR == ENOSYS)
-		tst_brk(TCONF, "acct() system call isn't configured in kernel");
-
 	ltpuser = SAFE_GETPWNAM("nobody");
 
 	fd = SAFE_CREAT(FILE_TMPFILE, 0777);
@@ -113,7 +121,7 @@ static void verify_acct(unsigned int nr)
 		tcase->setupfunc();
 
 	TST_EXP_FAIL(acct(*tcase->filename), tcase->exp_errno,
-	             "acct(%s)", tcase->desc);
+			"acct(%s)", tcase->desc);
 
 	if (tcase->cleanfunc)
 		tcase->cleanfunc();
@@ -136,5 +144,8 @@ static struct tst_test test = {
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
