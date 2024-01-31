Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D844DC47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 18:08:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 593C73CF92B
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 19:08:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B213A3CE19E
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B9DDF1A0C252
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 19:07:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 465F021E7D;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABMBeQOTBrXDTWaxCWKXb2I81e10uWxxZ8+tbxdMZFA=;
 b=DeiyDdvCznGpMx6uKVZo80N2Q2R+VLG2g2xks0CZ60sQEuVxaWUMOjunTMUdQ6oSN668Nr
 CUYMlbq/Puv2DSw0ZIdBd6kdjjbI5/pr1Ynov1e3PoTIWQpzMQfIaMMCj+E79y5ZRqcQK6
 l0eJmCIyFSih99+WH2eW5xDRiTdzAyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABMBeQOTBrXDTWaxCWKXb2I81e10uWxxZ8+tbxdMZFA=;
 b=BhxeVLOtsAwDWcGjZ2GxrNyNP08r4rUDwgKK/CFdvEMsocO2CmBDmbsvfoF2jHScxyzx7X
 X3/nxik/Rp2GYUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706724423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABMBeQOTBrXDTWaxCWKXb2I81e10uWxxZ8+tbxdMZFA=;
 b=DeiyDdvCznGpMx6uKVZo80N2Q2R+VLG2g2xks0CZ60sQEuVxaWUMOjunTMUdQ6oSN668Nr
 CUYMlbq/Puv2DSw0ZIdBd6kdjjbI5/pr1Ynov1e3PoTIWQpzMQfIaMMCj+E79y5ZRqcQK6
 l0eJmCIyFSih99+WH2eW5xDRiTdzAyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706724423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABMBeQOTBrXDTWaxCWKXb2I81e10uWxxZ8+tbxdMZFA=;
 b=BhxeVLOtsAwDWcGjZ2GxrNyNP08r4rUDwgKK/CFdvEMsocO2CmBDmbsvfoF2jHScxyzx7X
 X3/nxik/Rp2GYUCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F0A5139D9;
 Wed, 31 Jan 2024 18:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id eK2tBEeMumUoIgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 18:07:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 19:06:57 +0100
Message-ID: <20240131180659.23587-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131180659.23587-1-pvorel@suse.cz>
References: <20240131180659.23587-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DeiyDdvC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BhxeVLOt
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 465F021E7D
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] tree: Reuse MNTPOINT definition
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

Reuse MNTPOINT definition instead of MNT_POINT and other custom
definitions.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/io/direct_io/dma_thread_diotest.c |  9 ++++-----
 testcases/kernel/syscalls/access/access04.c        |  5 ++---
 testcases/kernel/syscalls/chmod/chmod06.c          |  5 ++---
 testcases/kernel/syscalls/chown/chown04.c          |  6 ++----
 testcases/kernel/syscalls/fchmod/fchmod06.c        |  5 ++---
 testcases/kernel/syscalls/fchown/fchown04.c        |  5 ++---
 testcases/kernel/syscalls/fstatfs/fstatfs01.c      |  5 ++---
 testcases/kernel/syscalls/link/link08.c            |  3 +--
 testcases/kernel/syscalls/mkdir/mkdir03.c          |  3 +--
 testcases/kernel/syscalls/mkdirat/mkdirat02.c      |  3 +--
 testcases/kernel/syscalls/mknod/mknod07.c          |  7 +++----
 testcases/kernel/syscalls/mknodat/mknodat02.c      |  9 ++++-----
 testcases/kernel/syscalls/rename/rename01.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename03.c        | 11 +++++------
 testcases/kernel/syscalls/rename/rename04.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename05.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename06.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename07.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename08.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename10.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename12.c        |  5 ++---
 testcases/kernel/syscalls/rename/rename13.c        |  7 +++----
 testcases/kernel/syscalls/rmdir/rmdir02.c          |  5 ++---
 testcases/kernel/syscalls/statfs/statfs01.c        |  5 ++---
 testcases/kernel/syscalls/statvfs/statvfs01.c      |  5 ++---
 testcases/kernel/syscalls/statx/statx01.c          |  3 +--
 testcases/kernel/syscalls/statx/statx04.c          |  5 ++---
 testcases/kernel/syscalls/statx/statx05.c          |  1 -
 testcases/kernel/syscalls/statx/statx06.c          |  5 ++---
 testcases/kernel/syscalls/statx/statx08.c          |  7 +++----
 testcases/kernel/syscalls/statx/statx09.c          |  1 -
 testcases/kernel/syscalls/statx/statx10.c          |  1 -
 testcases/kernel/syscalls/utime/utime01.c          |  5 ++---
 testcases/kernel/syscalls/utime/utime02.c          |  5 ++---
 testcases/kernel/syscalls/utime/utime04.c          |  5 ++---
 testcases/kernel/syscalls/utime/utime05.c          |  7 +++----
 testcases/kernel/syscalls/utime/utime06.c          |  5 ++---
 testcases/kernel/syscalls/utimes/utimes01.c        |  3 +--
 38 files changed, 76 insertions(+), 115 deletions(-)

diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest.c b/testcases/kernel/io/direct_io/dma_thread_diotest.c
index c317eba8e..3c94ec140 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest.c
@@ -108,8 +108,7 @@
 #define FILESIZE	(12*1024*1024)
 #define READSIZE	(1024*1024)
 
-#define MNT_POINT	"mntpoint"
-#define FILE_BASEPATH   MNT_POINT "/_dma_thread_test_%.04d.tmp"
+#define FILE_BASEPATH   MNTPOINT "/_dma_thread_test_%.04d.tmp"
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define FILECOUNT	100
@@ -385,7 +384,7 @@ static void setup(void)
 		SAFE_CLOSE(NULL, fd);
 	}
 
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
 
 	/*
 	 * verify whether the current directory has enough free space,
@@ -401,7 +400,7 @@ static void setup(void)
 			tst_mkfs(NULL, device, "ext3", NULL, NULL);
 		}
 
-		SAFE_MOUNT(NULL, device, MNT_POINT, "ext3", 0, NULL);
+		SAFE_MOUNT(NULL, device, MNTPOINT, "ext3", 0, NULL);
 		mount_flag = 1;
 	}
 
@@ -427,7 +426,7 @@ static void cleanup(void)
 {
 	free(buffer);
 
-	if (mount_flag && tst_umount(MNT_POINT) < 0)
+	if (mount_flag && tst_umount(MNTPOINT) < 0)
 		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
 
 	free(worker);
diff --git a/testcases/kernel/syscalls/access/access04.c b/testcases/kernel/syscalls/access/access04.c
index b5764a5dd..d32cc2894 100644
--- a/testcases/kernel/syscalls/access/access04.c
+++ b/testcases/kernel/syscalls/access/access04.c
@@ -39,7 +39,6 @@
 #define DNAME	"accessfile2"
 #define SNAME1	"symlink1"
 #define SNAME2	"symlink2"
-#define MNT_POINT	"mntpoint"
 #define LONGPATHSIZE (PATH_MAX + 2)
 
 static uid_t uid;
@@ -108,7 +107,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.setup = setup,
 	.test = verify_access,
 	.bufs = (struct tst_buffers []) {
@@ -117,7 +116,7 @@ static struct tst_test test = {
 		{&sname1, .str = SNAME1},
 		{&empty_fname, .str = ""},
 		{&longpathname, .size = LONGPATHSIZE},
-		{&mnt_point, .str = MNT_POINT},
+		{&mnt_point, .str = MNTPOINT},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
index d6b86af75..ae8248de4 100644
--- a/testcases/kernel/syscalls/chmod/chmod06.c
+++ b/testcases/kernel/syscalls/chmod/chmod06.c
@@ -35,7 +35,6 @@
 #define TEST_FILE2	"testdir_1/tfile_2"
 #define TEST_FILE3	"t_file/tfile_3"
 #define TEST_FILE4	"test_file4"
-#define MNT_POINT	"mntpoint"
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
@@ -61,7 +60,7 @@ static struct tcase {
 	{long_path, FILE_MODE, ENAMETOOLONG, NULL, NULL},
 	{"", FILE_MODE, ENOENT, NULL, NULL},
 	{TEST_FILE3, FILE_MODE, ENOTDIR, NULL, NULL},
-	{MNT_POINT, FILE_MODE, EROFS, NULL, NULL},
+	{MNTPOINT, FILE_MODE, EROFS, NULL, NULL},
 	{TEST_FILE4, FILE_MODE, ELOOP, NULL, NULL},
 };
 
@@ -144,5 +143,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tc),
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 };
diff --git a/testcases/kernel/syscalls/chown/chown04.c b/testcases/kernel/syscalls/chown/chown04.c
index 4e9188567..0299f866f 100644
--- a/testcases/kernel/syscalls/chown/chown04.c
+++ b/testcases/kernel/syscalls/chown/chown04.c
@@ -41,13 +41,11 @@
 #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH)
 
-#define MNT_POINT	"mntpoint"
 #define DIR_TEMP	"testdir_1"
 #define TEST_FILE1	"tfile_1"
 #define TEST_FILE2	"testdir_1/tfile_2"
 #define TEST_FILE3	"t_file/tfile_3"
 #define TEST_FILE4	"test_eloop1"
-#define TEST_FILE5	"mntpoint"
 
 static char long_path[PATH_MAX + 2] = {[0 ... PATH_MAX + 1] = 'a'};
 
@@ -63,7 +61,7 @@ static struct test_case_t {
 	{"", ENOENT, "when file does not exist"},
 	{TEST_FILE3, ENOTDIR, "when the path prefix is not a directory"},
 	{TEST_FILE4, ELOOP, "with too many symbolic links"},
-	{TEST_FILE5, EROFS, "when the named file resides on a read-only filesystem"}
+	{MNTPOINT, EROFS, "when the named file resides on a read-only filesystem"}
 };
 
 static void run(unsigned int i)
@@ -100,7 +98,7 @@ static void setup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.tcnt = ARRAY_SIZE(tc),
 	.test = run,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fchmod/fchmod06.c b/testcases/kernel/syscalls/fchmod/fchmod06.c
index 4a8aee6ca..367872edc 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod06.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod06.c
@@ -16,7 +16,6 @@
 #include <pwd.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 
 static int fd1;
 static int fd2;
@@ -58,7 +57,7 @@ static void setup(void)
 {
 	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
-	fd3 = SAFE_OPEN(MNT_POINT"/file", O_RDONLY);
+	fd3 = SAFE_OPEN(MNTPOINT"/file", O_RDONLY);
 	fd1 = SAFE_OPEN("tfile_1", O_RDWR | O_CREAT, 0666);
 	fd2 = SAFE_OPEN("tfile_2", O_RDWR | O_CREAT, 0666);
 	SAFE_CLOSE(fd2);
@@ -82,5 +81,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 };
diff --git a/testcases/kernel/syscalls/fchown/fchown04.c b/testcases/kernel/syscalls/fchown/fchown04.c
index a7af3aae7..36bc4c96c 100644
--- a/testcases/kernel/syscalls/fchown/fchown04.c
+++ b/testcases/kernel/syscalls/fchown/fchown04.c
@@ -25,7 +25,6 @@
 #include "compat_tst_16.h"
 #include "tst_safe_macros.h"
 
-#define MNT_POINT	"mntpoint"
 #define TEST_FILE	"tfile_1"
 #define MODE		0666
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH)
@@ -48,7 +47,7 @@ static void setup(void)
 	struct passwd *ltpuser;
 
 	fd1 = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, MODE);
-	fd3 = SAFE_OPEN(MNT_POINT, O_RDONLY);
+	fd3 = SAFE_OPEN(MNTPOINT, O_RDONLY);
 
 	ltpuser = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(ltpuser->pw_uid);
@@ -78,7 +77,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.tcnt = ARRAY_SIZE(tc),
 	.test = run,
 	.setup = setup,
diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs01.c b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
index 6b14fd0d6..d54be49ca 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs01.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs01.c
@@ -15,8 +15,7 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
-#define TEMP_FILE MNT_POINT"/test_file"
+#define TEMP_FILE MNTPOINT"/test_file"
 
 static int file_fd;
 static int pipe_fd;
@@ -61,7 +60,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.needs_root = 1
 };
diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
index 92d507489..f844493d2 100644
--- a/testcases/kernel/syscalls/link/link08.c
+++ b/testcases/kernel/syscalls/link/link08.c
@@ -26,7 +26,6 @@
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
-#define MNT_POINT	"mntpoint"
 #define TEST_FILE	"testfile"
 #define TEST_FILE1	"testfile1"
 #define TEST_FILE2	"mntpoint/file"
@@ -86,5 +85,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 };
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index d5141bb64..5e5695db2 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -24,7 +24,6 @@
 #define TST_ENOTDIR_DIR	"tst_enotdir/tst"
 #define MODE		0777
 
-#define MNT_POINT	"mntpoint"
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
 #define TST_EROFS      "mntpoint/tst_erofs"
@@ -89,7 +88,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(TC),
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.setup = setup,
 	.test = verify_mkdir,
 };
diff --git a/testcases/kernel/syscalls/mkdirat/mkdirat02.c b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
index 2bd8fe9c0..21cdf0a8c 100644
--- a/testcases/kernel/syscalls/mkdirat/mkdirat02.c
+++ b/testcases/kernel/syscalls/mkdirat/mkdirat02.c
@@ -12,7 +12,6 @@
 #define _GNU_SOURCE
 #include "tst_test.h"
 
-#define MNT_POINT	"mntpoint"
 #define TEST_DIR	"mntpoint/test_dir"
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
@@ -77,5 +76,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 };
diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
index 829199061..3c27c795c 100644
--- a/testcases/kernel/syscalls/mknod/mknod07.c
+++ b/testcases/kernel/syscalls/mknod/mknod07.c
@@ -52,7 +52,6 @@
 #define DIR_TEMP_MODE		(S_IRUSR | S_IXUSR)
 #define DIR_MODE		(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 				 S_IXGRP|S_IROTH|S_IXOTH)
-#define MNT_POINT		"mntpoint"
 
 #define FIFO_MODE	(S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH)
 #define SOCKET_MODE	(S_IFSOCK | S_IRWXU | S_IRWXG | S_IRWXO)
@@ -130,8 +129,8 @@ static void setup(void)
 	TEST_PAUSE;
 
 	/* mount a read-only file system for EROFS test */
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
 
 	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
@@ -174,7 +173,7 @@ static void cleanup(void)
 	if (seteuid(0) == -1)
 		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
 
-	if (mount_flag && tst_umount(MNT_POINT) < 0)
+	if (mount_flag && tst_umount(MNTPOINT) < 0)
 		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
 
 	if (device)
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index fdac5db15..6ca46677a 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -44,7 +44,6 @@ static void cleanup(void);
 
 #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
 			 S_IXGRP|S_IROTH|S_IXOTH)
-#define MNT_POINT	"mntpoint"
 
 #define FIFOMODE	(S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH)
 #define FREGMODE	(S_IFREG | S_IRUSR | S_IRGRP | S_IROTH)
@@ -124,10 +123,10 @@ static void setup(void)
 	/*
 	 * mount a read-only file system for EROFS test
 	 */
-	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
-	SAFE_MOUNT(cleanup, device, MNT_POINT, fs_type, MS_RDONLY, NULL);
+	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
+	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, MS_RDONLY, NULL);
 	mount_flag = 1;
-	dir_fd = SAFE_OPEN(cleanup, MNT_POINT, O_DIRECTORY);
+	dir_fd = SAFE_OPEN(cleanup, MNTPOINT, O_DIRECTORY);
 
 	/*
 	 * NOTE: the ELOOP test is written based on that the consecutive
@@ -168,7 +167,7 @@ static void cleanup(void)
 {
 	if (dir_fd > 0 && close(dir_fd) < 0)
 		tst_resm(TWARN | TERRNO, "close(%d) failed", dir_fd);
-	if (mount_flag && tst_umount(MNT_POINT) < 0)
+	if (mount_flag && tst_umount(MNTPOINT) < 0)
 		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
 
 	if (device)
diff --git a/testcases/kernel/syscalls/rename/rename01.c b/testcases/kernel/syscalls/rename/rename01.c
index 159341d09..e8048682c 100644
--- a/testcases/kernel/syscalls/rename/rename01.c
+++ b/testcases/kernel/syscalls/rename/rename01.c
@@ -14,7 +14,6 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 
 static const char *old_file_name = "oldfile";
 static const char *old_dir_name = "olddir";
@@ -32,7 +31,7 @@ static inline void swap(const char **a, const char **b)
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 
 	SAFE_TOUCH(old_file_name, 0700, NULL);
 	SAFE_MKDIR(old_dir_name, 00770);
@@ -78,6 +77,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index 652fa3bdb..d8ef98b7f 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -16,11 +16,10 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
-#define OLD_FILE_NAME MNT_POINT"/oldfile"
-#define NEW_FILE_NAME MNT_POINT"/newfile"
-#define OLD_DIR_NAME MNT_POINT"/olddir"
-#define NEW_DIR_NAME MNT_POINT"/newdir"
+#define OLD_FILE_NAME MNTPOINT"/oldfile"
+#define NEW_FILE_NAME MNTPOINT"/newfile"
+#define OLD_DIR_NAME MNTPOINT"/olddir"
+#define NEW_DIR_NAME MNTPOINT"/newdir"
 
 static struct stat old_file_st, old_dir_st, new_file_st, new_dir_st;
 
@@ -68,6 +67,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename04.c b/testcases/kernel/syscalls/rename/rename04.c
index 598ecd6fe..54363ac8a 100644
--- a/testcases/kernel/syscalls/rename/rename04.c
+++ b/testcases/kernel/syscalls/rename/rename04.c
@@ -15,14 +15,13 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define DIR1 "dir1"
 #define DIR2 "dir2"
 #define TEMP_FILE DIR2"/tmpfile"
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_MKDIR(DIR1, 00770);
 	SAFE_MKDIR(DIR2, 00770);
 	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
@@ -44,7 +43,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename05.c b/testcases/kernel/syscalls/rename/rename05.c
index 7894a9214..6ed213837 100644
--- a/testcases/kernel/syscalls/rename/rename05.c
+++ b/testcases/kernel/syscalls/rename/rename05.c
@@ -15,13 +15,12 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define TEMP_FILE "tmpfile"
 #define TEMP_DIR "tmpdir"
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
 	SAFE_MKDIR(TEMP_DIR, 00770);
 }
@@ -37,6 +36,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename06.c b/testcases/kernel/syscalls/rename/rename06.c
index 82665d1c2..fdff5a8c4 100644
--- a/testcases/kernel/syscalls/rename/rename06.c
+++ b/testcases/kernel/syscalls/rename/rename06.c
@@ -15,13 +15,12 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define DIR1 "dir1"
 #define DIR2 DIR1"/dir2"
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_MKDIR(DIR1, 00770);
 	SAFE_MKDIR(DIR2, 00770);
 }
@@ -37,6 +36,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename07.c b/testcases/kernel/syscalls/rename/rename07.c
index 51338dbf4..fc851fc6f 100644
--- a/testcases/kernel/syscalls/rename/rename07.c
+++ b/testcases/kernel/syscalls/rename/rename07.c
@@ -16,13 +16,12 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define TEMP_DIR "tmpdir"
 #define TEMP_FILE "tmpfile"
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_MKDIR(TEMP_DIR, 00770);
 	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
 }
@@ -38,6 +37,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename08.c b/testcases/kernel/syscalls/rename/rename08.c
index 8a9a9b344..89dac5423 100644
--- a/testcases/kernel/syscalls/rename/rename08.c
+++ b/testcases/kernel/syscalls/rename/rename08.c
@@ -15,13 +15,12 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define TEMP_FILE "tmpfile"
 #define INVALID_PATH ((void *)-1)
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
 }
 
@@ -38,6 +37,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename10.c b/testcases/kernel/syscalls/rename/rename10.c
index 5b5f79073..954f2846a 100644
--- a/testcases/kernel/syscalls/rename/rename10.c
+++ b/testcases/kernel/syscalls/rename/rename10.c
@@ -15,7 +15,6 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define TEMP_FILE "tmpfile"
 
 /* Path longer than PATH_MAX: fails the syscall right away (getname() fails) */
@@ -28,7 +27,7 @@ static char long_name[PATH_MAX] = {[0 ... PATH_MAX - 2] = 'a', [PATH_MAX - 1] =
 
 static void setup(void)
 {
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_TOUCH(TEMP_FILE, 0700, NULL);
 }
 
@@ -45,6 +44,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/rename/rename12.c b/testcases/kernel/syscalls/rename/rename12.c
index d6e1ccbe9..f6982b6d4 100644
--- a/testcases/kernel/syscalls/rename/rename12.c
+++ b/testcases/kernel/syscalls/rename/rename12.c
@@ -17,7 +17,6 @@
 #include <pwd.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
 #define TEMP_DIR "tempdir"
 #define TEMP_FILE1 TEMP_DIR"/tmpfile1"
 #define TEMP_FILE2 TEMP_DIR"/tmpfile2"
@@ -32,7 +31,7 @@ static void setup(void)
 	pw = SAFE_GETPWNAM("nobody");
 	nobody_uid = pw->pw_uid;
 
-	SAFE_CHDIR(MNT_POINT);
+	SAFE_CHDIR(MNTPOINT);
 	SAFE_MKDIR(TEMP_DIR, 0777);
 	SAFE_STAT(TEMP_DIR, &buf1);
 	SAFE_CHMOD(TEMP_DIR, buf1.st_mode | S_ISVTX);
@@ -56,7 +55,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]){
diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
index 51490db75..2cccd8428 100644
--- a/testcases/kernel/syscalls/rename/rename13.c
+++ b/testcases/kernel/syscalls/rename/rename13.c
@@ -15,9 +15,8 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
-#define TEMP_FILE1 MNT_POINT"/tmpfile1"
-#define TEMP_FILE2 MNT_POINT"/tmpfile2"
+#define TEMP_FILE1 MNTPOINT"/tmpfile1"
+#define TEMP_FILE2 MNTPOINT"/tmpfile2"
 
 static struct stat buf1, buf2;
 
@@ -43,7 +42,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.needs_root = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]){
diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
index cb0aec857..32336a4ae 100644
--- a/testcases/kernel/syscalls/rmdir/rmdir02.c
+++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
@@ -26,7 +26,6 @@
 #define TESTDIR2	"nosuchdir/testdir2"
 #define TESTDIR3	"testfile2/testdir3"
 #define TESTDIR4	"/loopdir"
-#define MNT_POINT	"mntpoint"
 #define TESTDIR5	"mntpoint/dir"
 #define TESTFILE    "testdir/testfile"
 #define TESTFILE2   "testfile2"
@@ -45,7 +44,7 @@ static struct testcase {
 	{NULL, EFAULT},
 	{looppathname, ELOOP},
 	{TESTDIR5, EROFS},
-	{MNT_POINT, EBUSY},
+	{MNTPOINT, EBUSY},
 	{".", EINVAL}
 };
 
@@ -104,5 +103,5 @@ static struct tst_test test = {
 	.test = verify_rmdir,
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 };
diff --git a/testcases/kernel/syscalls/statfs/statfs01.c b/testcases/kernel/syscalls/statfs/statfs01.c
index a2043f03d..224d76acf 100644
--- a/testcases/kernel/syscalls/statfs/statfs01.c
+++ b/testcases/kernel/syscalls/statfs/statfs01.c
@@ -14,8 +14,7 @@
 
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
-#define TEMP_FILE MNT_POINT"/testfile"
+#define TEMP_FILE MNTPOINT"/testfile"
 #define TEXT "dummy text"
 
 static void setup(void)
@@ -38,6 +37,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/statvfs/statvfs01.c b/testcases/kernel/syscalls/statvfs/statvfs01.c
index c10c67b18..f68486354 100644
--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -16,8 +16,7 @@
 #include <sys/statvfs.h>
 #include "tst_test.h"
 
-#define MNT_POINT "mntpoint"
-#define TEST_PATH MNT_POINT"/testfile"
+#define TEST_PATH MNTPOINT"/testfile"
 #define NLS_MAX_CHARSET_SIZE 6
 
 static void run(void)
@@ -58,6 +57,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1
 };
diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index f9c2748d2..188babb7e 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -39,8 +39,7 @@
 #include <inttypes.h>
 
 #define TESTFILE "test_file"
-#define MNTPOINT "mntpoint/"
-#define DEVICEFILE MNTPOINT"blk_dev"
+#define DEVICEFILE MNTPOINT"/blk_dev"
 #define MODE 0644
 
 #define SIZE 256
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 58296bd24..1f5aa62ce 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -58,8 +58,7 @@
 #include "lapi/stat.h"
 #include "lapi/fcntl.h"
 
-#define MOUNT_POINT "mntpoint"
-#define TESTDIR MOUNT_POINT "/testdir"
+#define TESTDIR MNTPOINT "/testdir"
 
 #define ATTR(x) {.attr = x, .name = #x}
 
@@ -129,7 +128,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.all_filesystems = 1,
 	.mount_device = 1,
-	.mntpoint = MOUNT_POINT,
+	.mntpoint = MNTPOINT,
 	.min_kver = "4.11",
 	.skip_filesystems = (const char *const[]) {
 		"fuse",
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 9781b3e70..3240a63c3 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -29,7 +29,6 @@
 #include "lapi/stat.h"
 #include "lapi/fcntl.h"
 
-#define MNTPOINT "mnt_point"
 #define TESTDIR_FLAGGED MNTPOINT"/test_dir1"
 #define TESTDIR_UNFLAGGED MNTPOINT"/test_dir2"
 
diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 1771dff49..d9854af21 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -30,8 +30,7 @@
 #include "lapi/mount.h"
 #include "lapi/fcntl.h"
 
-#define MOUNT_POINT "mount_ext"
-#define TEST_FILE MOUNT_POINT"/test_file.txt"
+#define TEST_FILE MNTPOINT"/test_file.txt"
 #define SIZE 2
 
 static int fd;
@@ -153,7 +152,7 @@ static struct tst_test test = {
 	.test = test_statx,
 	.min_kver = "4.11",
 	.needs_root = 1,
-	.mntpoint = MOUNT_POINT,
+	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.dev_fs_type = "ext4",
 	.dev_fs_opts = (const char *const []){"-I", "256", NULL},
diff --git a/testcases/kernel/syscalls/statx/statx08.c b/testcases/kernel/syscalls/statx/statx08.c
index 64b36986d..6f0e88f67 100644
--- a/testcases/kernel/syscalls/statx/statx08.c
+++ b/testcases/kernel/syscalls/statx/statx08.c
@@ -28,9 +28,8 @@
 #include "lapi/stat.h"
 #include "lapi/fcntl.h"
 
-#define MOUNT_POINT "mntpoint"
-#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
-#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
+#define TESTDIR_FLAGGED MNTPOINT"/test_dir1"
+#define TESTDIR_UNFLAGGED MNTPOINT"/test_dir2"
 
 static int fd, clear_flags;
 static int supp_compr = 1, supp_append = 1, supp_immutable = 1, supp_nodump = 1;
@@ -176,6 +175,6 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.all_filesystems = 1,
 	.mount_device = 1,
-	.mntpoint = MOUNT_POINT,
+	.mntpoint = MNTPOINT,
 	.min_kver = "4.11",
 };
diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
index 6e75ff3ec..9c52b4653 100644
--- a/testcases/kernel/syscalls/statx/statx09.c
+++ b/testcases/kernel/syscalls/statx/statx09.c
@@ -28,7 +28,6 @@
 #include "lapi/fcntl.h"
 #include <inttypes.h>
 
-#define MNTPOINT "mnt_point"
 #define TESTFILE_FLAGGED MNTPOINT"/test_file1"
 #define TESTFILE_UNFLAGGED MNTPOINT"/test_file2"
 
diff --git a/testcases/kernel/syscalls/statx/statx10.c b/testcases/kernel/syscalls/statx/statx10.c
index 42106285e..0e70023cd 100644
--- a/testcases/kernel/syscalls/statx/statx10.c
+++ b/testcases/kernel/syscalls/statx/statx10.c
@@ -33,7 +33,6 @@
 #include "lapi/stat.h"
 #include "lapi/fcntl.h"
 
-#define MNTPOINT "mnt_point"
 #define TESTFILE MNTPOINT"/testfile"
 
 static void verify_statx(void)
diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
index 0cc9822e7..5bde0de7e 100644
--- a/testcases/kernel/syscalls/utime/utime01.c
+++ b/testcases/kernel/syscalls/utime/utime01.c
@@ -18,8 +18,7 @@
 #include "tst_test.h"
 #include "tst_clocks.h"
 
-#define MNT_POINT	"mntpoint"
-#define TEMP_FILE	MNT_POINT"/tmp_file"
+#define TEMP_FILE	MNTPOINT"/tmp_file"
 #define FILE_MODE	0444
 
 static void setup(void)
@@ -64,7 +63,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.needs_root = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]) {
diff --git a/testcases/kernel/syscalls/utime/utime02.c b/testcases/kernel/syscalls/utime/utime02.c
index fdcd40f66..a60f40ea9 100644
--- a/testcases/kernel/syscalls/utime/utime02.c
+++ b/testcases/kernel/syscalls/utime/utime02.c
@@ -23,8 +23,7 @@
 #include "tst_test.h"
 #include "tst_clocks.h"
 
-#define MNT_POINT	"mntpoint"
-#define TEMP_FILE	MNT_POINT"/tmp_file"
+#define TEMP_FILE	MNTPOINT"/tmp_file"
 #define FILE_MODE	0444
 
 #define TEST_USERNAME "nobody"
@@ -80,7 +79,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.needs_root = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]) {
diff --git a/testcases/kernel/syscalls/utime/utime04.c b/testcases/kernel/syscalls/utime/utime04.c
index 7b820ab06..522f4c548 100644
--- a/testcases/kernel/syscalls/utime/utime04.c
+++ b/testcases/kernel/syscalls/utime/utime04.c
@@ -19,8 +19,7 @@
 #include <utime.h>
 #include "tst_test.h"
 
-#define MNT_POINT	"mntpoint"
-#define TEMP_FILE	MNT_POINT"/tmp_file"
+#define TEMP_FILE	MNTPOINT"/tmp_file"
 
 #define FILE_MODE	0444
 #define NEW_MODF_TIME	10000
@@ -55,7 +54,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]) {
 		"vfat",
diff --git a/testcases/kernel/syscalls/utime/utime05.c b/testcases/kernel/syscalls/utime/utime05.c
index 941a3ccee..8232c7f5a 100644
--- a/testcases/kernel/syscalls/utime/utime05.c
+++ b/testcases/kernel/syscalls/utime/utime05.c
@@ -22,8 +22,7 @@
 
 #include "tst_test.h"
 
-#define MNT_POINT	"mntpoint"
-#define TEMP_FILE	MNT_POINT"/tmp_file"
+#define TEMP_FILE	MNTPOINT"/tmp_file"
 
 #define FILE_MODE	0444
 #define MODE_RWX	0777
@@ -41,7 +40,7 @@ static void setup(void)
 {
 	struct passwd *pw;
 
-	SAFE_CHMOD(MNT_POINT, MODE_RWX);
+	SAFE_CHMOD(MNTPOINT, MODE_RWX);
 
 	pw = SAFE_GETPWNAM(TEST_USERNAME);
 	tst_res(TINFO, "Switching effective user ID to user: %s", pw->pw_name);
@@ -69,7 +68,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.needs_root = 1,
 	.mount_device = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.skip_filesystems = (const char *const[]) {
 		"vfat",
diff --git a/testcases/kernel/syscalls/utime/utime06.c b/testcases/kernel/syscalls/utime/utime06.c
index 3ba62a316..0e8df9e03 100644
--- a/testcases/kernel/syscalls/utime/utime06.c
+++ b/testcases/kernel/syscalls/utime/utime06.c
@@ -24,7 +24,6 @@
 #include "tst_test.h"
 
 #define TEMP_FILE	"tmp_file"
-#define MNT_POINT	"mntpoint"
 #define FILE_MODE	0644
 #define TEST_USERNAME "nobody"
 
@@ -39,7 +38,7 @@ static struct tcase {
 	{TEMP_FILE, EACCES, NULL, "No write access"},
 	{"", ENOENT, NULL, "File not exist"},
 	{TEMP_FILE, EPERM, &times, "Not file owner"},
-	{MNT_POINT, EROFS, NULL, "Read-only filesystem"}
+	{MNTPOINT, EROFS, NULL, "Read-only filesystem"}
 };
 
 
@@ -68,6 +67,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 	.needs_rofs = 1
 };
diff --git a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kernel/syscalls/utimes/utimes01.c
index 2bfc1654b..178d9f147 100644
--- a/testcases/kernel/syscalls/utimes/utimes01.c
+++ b/testcases/kernel/syscalls/utimes/utimes01.c
@@ -28,7 +28,6 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#define MNT_POINT "mntpoint"
 #define TESTFILE1 "testfile1"
 #define TESTFILE2 "testfile2"
 #define TESTFILE3 "mntpoint/file"
@@ -98,5 +97,5 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_rofs = 1,
-	.mntpoint = MNT_POINT,
+	.mntpoint = MNTPOINT,
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
