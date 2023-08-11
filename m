Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F52C001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:56:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D22803CD067
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:56:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A0F63C89B6
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6EEAB6008C1
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 149CD1F88C
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUrZgmFPDGTXQputdMxfXVGV3vYAi++YOW+ukJlAxIE=;
 b=BZjWCI2Mvnvced4yOOyd7ALKpxO6XVSs1PeznFFmPVB6ze1dlqT3/FgdRX65JKQ/eghYA/
 3ZCu871XY8jUN/OL2hmPYHfNqrpLuLFokHadf8K/pXJ13nn2I0h7sKLHq7L49v97hDjbfw
 ezmhWpGSBHVcJIkzCxP3TtZ1OwMOjsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUrZgmFPDGTXQputdMxfXVGV3vYAi++YOW+ukJlAxIE=;
 b=e6vRRSQ+67Qj13laE0O5FLx5mGyr7RnGgtRDxPq9N62DeyXQ19IMN8K6x47fcWTvV+bPHR
 SoalOOryCxA5FvAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 025D1138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PHEEO8Qh1mQLWwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:48 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:45 +0200
Message-ID: <20230811115647.32387-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] syscalls/chdir01: Make use use of guarded buffers
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
 testcases/kernel/syscalls/chdir/chdir01.c | 55 +++++++++++++++--------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index e4080e3f4..d50a8f50c 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -31,18 +31,27 @@ static char *workdir;
 static int skip_symlinks, skip_blocked;
 static struct passwd *ltpuser;
 
+static char *file_name;
+static char *blocked_name;
+static char *dir_name;
+static char *cwd_name;
+static char *parent_name;
+static char *root_name;
+static char *missing_name;
+static char *link_name;
+
 static struct test_case {
-	const char *name;
+	char **name;
 	int root_ret, root_err, nobody_ret, nobody_err;
 } testcase_list[] = {
-	{FILE_NAME, -1, ENOTDIR, -1, ENOTDIR},
-	{BLOCKED_NAME, 0, 0, -1, EACCES},
-	{DIR_NAME, 0, 0, 0, 0},
-	{".", 0, 0, 0, 0},
-	{"..", 0, 0, 0, 0},
-	{"/", 0, 0, 0, 0},
-	{"missing", -1, ENOENT, -1, ENOENT},
-	{LINK_NAME1, -1, ELOOP, -1, ELOOP},
+	{&file_name, -1, ENOTDIR, -1, ENOTDIR},
+	{&blocked_name, 0, 0, -1, EACCES},
+	{&dir_name, 0, 0, 0, 0},
+	{&cwd_name, 0, 0, 0, 0},
+	{&parent_name, 0, 0, 0, 0},
+	{&root_name, 0, 0, 0, 0},
+	{&missing_name, -1, ENOENT, -1, ENOENT},
+	{&link_name, -1, ELOOP, -1, ELOOP},
 };
 
 static void setup(void)
@@ -53,8 +62,6 @@ static void setup(void)
 
 	umask(0);
 
-	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL);
-
 	cwd = SAFE_GETCWD(NULL, 0);
 	workdir = SAFE_MALLOC(strlen(cwd) + strlen(MNTPOINT) + 2);
 	sprintf(workdir, "%s/%s", cwd, MNTPOINT);
@@ -109,7 +116,7 @@ static void run(unsigned int n)
 {
 	struct test_case *tc = testcase_list + n;
 
-	tst_res(TINFO, "Testing '%s'", tc->name);
+	tst_res(TINFO, "Testing '%s'", *tc->name);
 
 	if (tc->root_err == ELOOP && skip_symlinks) {
 		tst_res(TCONF, "Skipping symlink loop test, not supported");
@@ -119,8 +126,8 @@ static void run(unsigned int n)
 	/* Reset current directory to mountpoint */
 	SAFE_CHDIR(workdir);
 
-	TEST(chdir(tc->name));
-	check_result("root", tc->name, tc->root_ret, tc->root_err);
+	TEST(chdir(*tc->name));
+	check_result("root", *tc->name, tc->root_ret, tc->root_err);
 
 	if (tc->nobody_err == EACCES && skip_blocked) {
 		tst_res(TCONF, "Skipping unprivileged permission test, "
@@ -130,25 +137,35 @@ static void run(unsigned int n)
 
 	SAFE_CHDIR(workdir);
 	SAFE_SETEUID(ltpuser->pw_uid);
-	TEST(chdir(tc->name));
+	TEST(chdir(*tc->name));
 	SAFE_SETEUID(0);
-	check_result(TESTUSER, tc->name, tc->nobody_ret, tc->nobody_err);
+	check_result(TESTUSER, *tc->name, tc->nobody_ret, tc->nobody_err);
 }
 
 static void cleanup(void)
 {
 	SAFE_CHDIR("..");
-	tst_umount(workdir);
 	free(workdir);
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.format_device = 1,
+	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.test = run,
 	.tcnt = ARRAY_SIZE(testcase_list),
 	.setup = setup,
-	.cleanup = cleanup
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&file_name, .str = FILE_NAME},
+		{&blocked_name, .str = BLOCKED_NAME},
+		{&dir_name, .str = DIR_NAME},
+		{&cwd_name, .str = "."},
+		{&parent_name, .str = ".."},
+		{&root_name, .str = "/"},
+		{&missing_name, .str = "does_not_exist"},
+		{&link_name, .str = LINK_NAME1},
+		{}
+	}
 };
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
