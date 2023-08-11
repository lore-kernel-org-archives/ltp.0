Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2C7C001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:56:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B34D33CD043
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:56:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEDD43C89B6
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61D7E1A006B7
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DC981F459
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N61fDO53vtww7oFpWb5zcjRXI3K5Mf7PJi69nM/vqIU=;
 b=ibiLFM7q06MBii+z9QoJOMtMHg/VDSm7rjFBmXuUgmFXydtyiWcnkeYEk97yg5LGZdLwHl
 ZHWiOh8KXf8VbraojYH3LOlzcQcFm9JWw9MzuHl2llMe/tHtIL3fUTnuuXCnry5kbsIJ1W
 qH+T3vY7lsgkW/29160v50sr+MR6pQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N61fDO53vtww7oFpWb5zcjRXI3K5Mf7PJi69nM/vqIU=;
 b=fhtm3Gz2B9/LQfJ5ZoguDDO5V9ZPefhR01xqyB3TWnol3N/jTdfFS3H8TaxspM8t9D8XdC
 UbSzvGjd7HJl0aDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7ED81138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qP24HcQh1mQHWwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:44 +0200
Message-ID: <20230811115647.32387-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/6] syscalls/acct01: Make use of guarded buffers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/acct/acct01.c | 84 +++++++++++++------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 254d7b503..52c4d41da 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -27,17 +27,25 @@
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define FILE_EISDIR		"."
-#define FILE_EACCES		"/dev/null"
+#define FILE_EACCESS		"/dev/null"
 #define FILE_ENOENT		"/tmp/does/not/exist"
 #define FILE_ENOTDIR		"./tmpfile/"
-#define TEST_TMPFILE		"./tmpfile"
-#define TEST_ELOOP		"test_file_eloop1"
-#define TEST_ENAMETOOLONG	nametoolong
-#define TEST_EROFS		"mntpoint/file"
+#define FILE_TMPFILE		"./tmpfile"
+#define FILE_ELOOP		"test_file_eloop1"
+#define FILE_EROFS		"ro_mntpoint/file"
 
-static char nametoolong[PATH_MAX+2];
 static struct passwd *ltpuser;
 
+static char *file_eisdir;
+static char *file_eaccess;
+static char *file_enoent;
+static char *file_enotdir;
+static char *file_tmpfile;
+static char *file_eloop;
+static char *file_enametoolong;
+static char *file_erofs;
+static char *file_null;
+
 static void setup_euid(void)
 {
 	SAFE_SETEUID(ltpuser->pw_uid);
@@ -49,21 +57,21 @@ static void cleanup_euid(void)
 }
 
 static struct test_case {
-	char *filename;
-	char *exp_errval;
+	char **filename;
+	char *desc;
 	int exp_errno;
 	void (*setupfunc) ();
 	void (*cleanfunc) ();
 } tcases[] = {
-	{FILE_EISDIR, "EISDIR",  EISDIR,  NULL,   NULL},
-	{FILE_EACCES, "EACCES",  EACCES,  NULL,   NULL},
-	{FILE_ENOENT, "ENOENT",  ENOENT,  NULL,   NULL},
-	{FILE_ENOTDIR, "ENOTDIR", ENOTDIR, NULL,   NULL},
-	{TEST_TMPFILE, "EPERM",   EPERM,   setup_euid, cleanup_euid},
-	{NULL,       "EPERM",   EPERM,   setup_euid, cleanup_euid},
-	{TEST_ELOOP, "ELOOP",        ELOOP,        NULL, NULL},
-	{TEST_ENAMETOOLONG, "ENAMETOOLONG", ENAMETOOLONG, NULL, NULL},
-	{TEST_EROFS, "EROFS",        EROFS,        NULL, NULL},
+	{&file_eisdir,  FILE_EISDIR,  EISDIR,  NULL,   NULL},
+	{&file_eaccess, FILE_EACCESS, EACCES,  NULL,   NULL},
+	{&file_enoent,  FILE_ENOENT,  ENOENT,  NULL,   NULL},
+	{&file_enotdir, FILE_ENOTDIR, ENOTDIR, NULL,   NULL},
+	{&file_tmpfile, FILE_TMPFILE, EPERM,   setup_euid, cleanup_euid},
+	{&file_null,    "NULL",       EPERM,   setup_euid, cleanup_euid},
+	{&file_eloop,   FILE_ELOOP,   ELOOP,        NULL, NULL},
+	{&file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
+	{&file_erofs,   FILE_EROFS,   EROFS,        NULL, NULL},
 };
 
 static void setup(void)
@@ -76,10 +84,10 @@ static void setup(void)
 
 	ltpuser = SAFE_GETPWNAM("nobody");
 
-	fd = SAFE_CREAT(TEST_TMPFILE, 0777);
+	fd = SAFE_CREAT(FILE_TMPFILE, 0777);
 	SAFE_CLOSE(fd);
 
-	TEST(acct(TEST_TMPFILE));
+	TEST(acct(FILE_TMPFILE));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "acct failed unexpectedly");
 
@@ -89,11 +97,11 @@ static void setup(void)
 		tst_brk(TBROK | TTERRNO, "acct(NULL) failed");
 
 	/* ELOOP SETTING */
-	SAFE_SYMLINK(TEST_ELOOP, "test_file_eloop2");
-	SAFE_SYMLINK("test_file_eloop2", TEST_ELOOP);
+	SAFE_SYMLINK(FILE_ELOOP, "test_file_eloop2");
+	SAFE_SYMLINK("test_file_eloop2", FILE_ELOOP);
 
-	/* ENAMETOOLONG SETTING */
-	memset(nametoolong, 'a', PATH_MAX+1);
+	memset(file_enametoolong, 'a', PATH_MAX+1);
+	file_enametoolong[PATH_MAX+1] = 0;
 }
 
 static void verify_acct(unsigned int nr)
@@ -103,31 +111,29 @@ static void verify_acct(unsigned int nr)
 	if (tcase->setupfunc)
 		tcase->setupfunc();
 
-	TEST(acct(tcase->filename));
+	TST_EXP_FAIL(acct(*tcase->filename), tcase->exp_errno,
+	             "acct(%s)", tcase->desc);
 
 	if (tcase->cleanfunc)
 		tcase->cleanfunc();
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "acct(%s) succeeded unexpectedly",
-				tcase->filename);
-		return;
-	}
-
-	if (TST_ERR == tcase->exp_errno) {
-		tst_res(TPASS | TTERRNO, "acct() failed as expected");
-	} else {
-		tst_res(TFAIL | TTERRNO,
-				"acct() failed, expected: %s",
-				tst_strerrno(tcase->exp_errno));
-	}
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.mntpoint = "mntpoint",
+	.mntpoint = "ro_mntpoint",
 	.needs_rofs = 1,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.test = verify_acct,
+	.bufs = (struct tst_buffers []) {
+		{&file_eisdir, .str = FILE_EISDIR},
+		{&file_eaccess, .str = FILE_EACCESS},
+		{&file_enoent, .str = FILE_ENOENT},
+		{&file_enotdir, .str = FILE_ENOTDIR},
+		{&file_tmpfile, .str = FILE_TMPFILE},
+		{&file_eloop, .str = FILE_ELOOP},
+		{&file_enametoolong, .size = PATH_MAX+2},
+		{&file_erofs, .str = FILE_EROFS},
+		{}
+	}
 };
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
