Return-Path: <SRS0=+Yfp=PC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C992DC433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 15:36:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68D660ED4
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 15:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C68D660ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1303C13CF
	for <ltp@archiver.kernel.org>; Thu, 14 Oct 2021 17:36:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4484F3C0E6B
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 17:36:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8FD711A017CD
 for <ltp@lists.linux.it>; Thu, 14 Oct 2021 17:36:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 676EE2199D;
 Thu, 14 Oct 2021 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634225762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s0MPNcVCwGMuaLCEaAohxxnGuZ6zyQIdow+iAMfntYE=;
 b=fL6PQazYlLW+NuJpSQXibJNOJB//n0UI1g53KpzXjspegbDGLFUMYQHO/sU7UFcwmk9Q3b
 oJ8UBID9khJylqfDKpqH06hz9slZRF+2IzvQhExrMd4OWJe1VE5I10DikPvVC7uqmhkYU5
 nTIqcKoiKBBJBUwOg8zy4r2iu955e7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634225762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s0MPNcVCwGMuaLCEaAohxxnGuZ6zyQIdow+iAMfntYE=;
 b=J0EfPuvwUecHMDVmqXtLamlJZDGrHkKy9rno5f4loDj9PzRa25mI6gfMZ4K2JoCBoGzyFx
 47iAzEHwfKH2wMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E7BB13D9F;
 Thu, 14 Oct 2021 15:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XwSaB2JOaGEaHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Oct 2021 15:36:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Oct 2021 17:35:54 +0200
Message-Id: <20211014153554.8932-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] creat09: Run on all_filesystems
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

To make sure bug on XFS is detected on systems which use it.

Due setgid is test problematic on Microsoft filesystems:

creat09.c:81: TBROK: ntfs: Setgid bit not set
creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)

thus they're disabled.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/creat/creat09.c | 57 +++++++++++++++++------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
index 681b80c7d..04f92ba21 100644
--- a/testcases/kernel/syscalls/creat/creat09.c
+++ b/testcases/kernel/syscalls/creat/creat09.c
@@ -33,15 +33,20 @@
 #include <stdlib.h>
 #include <sys/types.h>
 #include <pwd.h>
+#include <stdio.h>
 #include "tst_test.h"
 #include "tst_uid.h"
 
 #define MODE_RWX        0777
 #define MODE_SGID       (S_ISGID|0777)
 
-#define WORKDIR		"testdir"
-#define CREAT_FILE	WORKDIR "/creat.tmp"
-#define OPEN_FILE	WORKDIR "/open.tmp"
+#define MNTPOINT	"mntpoint"
+#define CREAT_FILE	"creat.tmp"
+#define OPEN_FILE	"open.tmp"
+
+static char *workdir;
+static char *creat_file;
+static char *open_file;
 
 static gid_t free_gid;
 static int fd = -1;
@@ -51,21 +56,32 @@ static void setup(void)
 	struct stat buf;
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
+	SAFE_CHDIR(MNTPOINT);
+
 	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
 		(int)ltpuser->pw_gid);
 	free_gid = tst_get_free_gid(ltpuser->pw_gid);
 
 	/* Create directories and set permissions */
-	SAFE_MKDIR(WORKDIR, MODE_RWX);
-	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
-	SAFE_CHMOD(WORKDIR, MODE_SGID);
-	SAFE_STAT(WORKDIR, &buf);
+	workdir = SAFE_MALLOC(strlen(tst_device->fs_type) + 1);
+	sprintf(workdir, "%s", tst_device->fs_type);
+
+	creat_file = SAFE_MALLOC(strlen(workdir) + strlen(CREAT_FILE) + 2);
+	sprintf(creat_file, "%s/%s", workdir, CREAT_FILE);
+
+	open_file = SAFE_MALLOC(strlen(tst_device->fs_type) + strlen(OPEN_FILE) + 2);
+	sprintf(open_file, "%s/%s", workdir, OPEN_FILE);
+
+	SAFE_MKDIR(workdir, MODE_RWX);
+	SAFE_CHOWN(workdir, ltpuser->pw_uid, free_gid);
+	SAFE_CHMOD(workdir, MODE_SGID);
+	SAFE_STAT(workdir, &buf);
 
 	if (!(buf.st_mode & S_ISGID))
-		tst_brk(TBROK, "%s: Setgid bit not set", WORKDIR);
+		tst_brk(TBROK, "%s: Setgid bit not set", workdir);
 
 	if (buf.st_gid != free_gid) {
-		tst_brk(TBROK, "%s: Incorrect group, %u != %u", WORKDIR,
+		tst_brk(TBROK, "%s: Incorrect group, %u != %u", workdir,
 			buf.st_gid, free_gid);
 	}
 
@@ -95,20 +111,24 @@ static void file_test(const char *name)
 
 static void run(void)
 {
-	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
+	fd = SAFE_CREAT(creat_file, MODE_SGID);
 	SAFE_CLOSE(fd);
-	file_test(CREAT_FILE);
+	file_test(creat_file);
 
-	fd = SAFE_OPEN(OPEN_FILE, O_CREAT | O_EXCL | O_RDWR, MODE_SGID);
-	file_test(OPEN_FILE);
+	fd = SAFE_OPEN(open_file, O_CREAT | O_EXCL | O_RDWR, MODE_SGID);
+	file_test(open_file);
 	SAFE_CLOSE(fd);
 
 	/* Cleanup between loops */
-	tst_purge_dir(WORKDIR);
+	tst_purge_dir(workdir);
 }
 
 static void cleanup(void)
 {
+	free(workdir);
+	free(creat_file);
+	free(open_file);
+
 	if (fd >= 0)
 		SAFE_CLOSE(fd);
 }
@@ -119,6 +139,15 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.skip_filesystems = (const char*[]) {
+		"exfat",
+		"ntfs",
+		"vfat",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0fa3ecd87848"},
 		{"CVE", "2018-13405"},
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
