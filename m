Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEE4CA0ED1
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755230088; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+UpKP2wNIWtxiEB4T6LD7Tpey8wsoSOlJ9BBsQgepwk=;
 b=WYNYsFlXumbHBbg6K6aE6IcFtQwnEVfyLj0ao7iX9Y75WNwYkpxVsBTpO4WN73PE+PlpD
 LAHPo5yAIYrGtrqIAnlagGmUeLwGvA4YVuPe9QjI9mLUTu4+nEtf2ZqaLaQa/45SzLo4ZKW
 AbiYiiNssb030XuKJf3qMV8fVjgpZrQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AADD03CBF17
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 05:54:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4224B3C2CC6
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 05:54:27 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 951801400759
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 05:54:26 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afcb7347e09so258592966b.0
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755230065; x=1755834865; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+C+mYuD+csXj4tV5azC+EGnP3WDYCQqpDbUaUrk5qiA=;
 b=Z2b19wZPPT91XLTuXjMA1hQCDjtkOc6SS3OjdavqzGoeE6Jx3cuvxZTqmU96yqm5TS
 seqg9j8a6DgNM9kVA/fXaWaPKzkn3taKzyReDvd7W2VFXS2tIu0ZqdW5ubxU/sj2JIc+
 f+fA46PWF7x/BbeNAh6AJSIzQdwQZaiirZlYEsK9D3eVcBb4+QdBMmdEDcG4MSJNh6tq
 Bz4VHYdOTmQI+zOzUeC6YZT5bBDY/cVEzLkWElDvnv1irdpV/xoMFjoD8Gl9yF7TDFBZ
 0FYCbrhgcEJG/LI2H/QodaZlqiStaVCa6yDWUBVXXCtWXu/x/xuqEOR4OqFFfQGoUIHN
 zJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755230065; x=1755834865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+C+mYuD+csXj4tV5azC+EGnP3WDYCQqpDbUaUrk5qiA=;
 b=ZCIrIsKLVIsQOpQlRQoHujP2/yAjomIpKapipxW4KAm2rBH9QRWnEvHaBu7xAsuxZP
 Md2Zuk+MCSlFyjjTqdrBtqWewX671utja4E5YclvEE8SPX3jhfTYMQbuUVxHsirv6jUX
 BsjV9Sdg6/UdJ9XYtoOufAD3nsyoJCUgLqGgPiGJehZG49gmwoc2LJgmgDhXMXUkAeBA
 SLw5Mygdn0jqXYvA+IchFk9ZPecNIfILT2kjVYD+04SHW/oE+xiv1lpV0+45saGv2CrS
 aPQKlAbYtMgMUloUyJt8RdaehNltpDbtbGicHWPwEuDX7UvHrcgmDi2E+PiSINUZZS+x
 5ZUw==
X-Gm-Message-State: AOJu0YyvhRnAfJihc4xRhUPst5cuRNFIzxa2fkZsQOirVjCwgrxoOVJP
 9NQVDFT4aJo2iqHAAxf/BQr6Ryv8UCOPw1DrGlexZF5RVlH1FILav4ild2UToVD2GwROWmVKw4i
 gcf0=
X-Gm-Gg: ASbGncuEKjJKJI31Z7kkpbWkhcUgHlFXpPJDja8IcDkCIIHgiQ1a51kaUyzReMjcmib
 fcUMpY+5GTkMwDukNZeHwx6gaj5treLwftPAOCmNeLT4ZR3R5J0qIVN011W8ifF5i3gmDFsOclT
 WhMwt+lSrnkFrgLCokawgW6dkF+oRgEJvndecWdn6gb5mjLp6wTDARgrM+kyHojW8IblQgVDoYO
 +QHoxsYW9oenXiyfW96qFiUO3uP1c+ZEJLK0Xj6JiVSabizlBIjBabQyD7PnQIjkbOwwR/3pX4m
 QHZM6EBjF1ZFOAyUornjwFs4DNVf/cut6EzAbFSWvqe44gS4qkdx23i8F7aS5aLeocrvZz2ji0g
 4SscELWM7YBI=
X-Google-Smtp-Source: AGHT+IEqDx6/7Bf4wnet3F4UYD0PkncekSXXlLc5eI4zENEaxcu0ZFPsRggz19sEoTx59kynSe/Rrg==
X-Received: by 2002:a17:907:7f8e:b0:af9:a8b4:4ff0 with SMTP id
 a640c23a62f3a-afcdc30a600mr43035166b.40.1755230065272; 
 Thu, 14 Aug 2025 20:54:25 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afcdce9ed8fsm33396466b.53.2025.08.14.20.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 20:54:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 15 Aug 2025 03:54:12 +0000
Message-ID: <20250815035415.23499-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] openat02: Convert to new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/openat/openat02.c | 344 +++++++++++---------
 1 file changed, 182 insertions(+), 162 deletions(-)

diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index 012b135e7..05bf1df38 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -1,65 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2014 Fujitsu Ltd.
- * Author: Xing Gu <gux.fnst@cn.fujitsu.com>
+ * Copyright (c) 2014 Fujitsu Ltd Xing Gu <gux.fnst@cn.fujitsu.com>
+ * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ *   This test case will verify following scenarios of openat.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
+ * - openat() succeeds to open a file in append mode, when
+ *   'flags' is set to O_APPEND.
  *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * - openat() succeeds to enable the close-on-exec flag for a
+ *   file descriptor, when 'flags' is set to O_CLOEXEC.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-/*
- * Description:
- *   Verify that,
- *   1)openat() succeeds to open a file in append mode, when
- *     'flags' is set to O_APPEND.
- *   2)openat() succeeds to enable the close-on-exec flag for a
- *     file descriptor, when 'flags' is set to O_CLOEXEC.
- *   3)openat() succeeds to allow files whose sizes cannot be
- *     represented in an off_t but can be represented in an off_t
- *     to be opened, when 'flags' is set to O_LARGEFILE.
- *   4)openat() succeeds to not update the file last access time
- *     (st_atime in the inode) when the file is read, when 'flags'
- *     is set to O_NOATIME.
- *   5)openat() succeeds to open the file failed if the file is a
- *     symbolic link, when 'flags' is set to O_NOFOLLOW.
- *   6)openat() succeeds to truncate the file to length 0 if the file
- *     already exists and is a regular file and the open mode allows
- *     writing, when 'flags' is set to O_TRUNC.
+ * - openat() succeeds to allow files whose sizes cannot be
+ *   represented in an off_t but can be represented in an off_t
+ *   to be opened, when 'flags' is set to O_LARGEFILE.
+ *
+ * - openat() succeeds to not update the file last access time
+ *   (st_atime in the inode) when the file is read, when 'flags'
+ *   is set to O_NOATIME.
+ *
+ * - openat() succeeds to open the file failed if the file is a
+ *   symbolic link, when 'flags' is set to O_NOFOLLOW.
+ *
+ * - openat() succeeds to truncate the file to length 0 if the file
+ *   already exists and is a regular file and the open mode allows
+ *   writing, when 'flags' is set to O_TRUNC.
  */
 
 #define _GNU_SOURCE
-
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
-#include <sys/wait.h>
 #include <stdlib.h>
+#include <errno.h>
+#include <string.h>
 #include <stdio.h>
-#include <stdint.h>
-#include <mntent.h>
-
-#include "test.h"
-#include "safe_macros.h"
-#include "lapi/fcntl.h"
-#include "openat.h"
+#include "lapi/mount.h"
+#include "tst_test.h"
 
 #define TEST_APP "openat02_child"
-
-#define TEST_FILE "test_file"
-#define SFILE "sfile"
-#define LARGE_FILE "large_file"
-
+#define MOUNT_POINT "mntpoint"
+#define TEST_FILE MOUNT_POINT"/test_file"
+#define SFILE MOUNT_POINT"/sfile"
+#define LARGE_FILE MOUNT_POINT"/large_file"
 #define STR "abcdefg"
 
-static void setup(void);
-static void cleanup(void);
+static int dir_fd, fd;
+static int fd_invalid = 100;
+static int fd_atcwd = AT_FDCWD;
+static char glob_path[256];
 
 static void testfunc_append(void);
 static void testfunc_cloexec(void);
@@ -68,220 +58,250 @@ static void testfunc_noatime(void);
 static void testfunc_nofollow(void);
 static void testfunc_trunc(void);
 
-static void (*testfunc[])(void) = {
-	testfunc_append,
-	testfunc_cloexec,
-	testfunc_largefile,
-	testfunc_noatime,
-	testfunc_nofollow,
-	testfunc_trunc,
+static struct test_case {
+	void (*testfunc)(void);
+} test_cases[] = {
+	{
+		.testfunc = testfunc_append,
+	},
+	{
+		.testfunc = testfunc_cloexec,
+	},
+	{
+		.testfunc = testfunc_largefile,
+	},
+	{
+		.testfunc = testfunc_noatime,
+	},
+	{
+		.testfunc = testfunc_nofollow,
+	},
+	{
+		.testfunc = testfunc_trunc,
+	},
 };
 
-char *TCID = "openat02";
-int TST_TOTAL = ARRAY_SIZE(testfunc);
-
-int main(int ac, char **av)
-{
-	int lc;
-	int i;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		for (i = 0; i < TST_TOTAL; i++)
-			(*testfunc[i])();
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void setup(void)
-{
-	TEST_PAUSE;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	tst_tmpdir();
-
-	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "test file");
-
-	SAFE_SYMLINK(cleanup, TEST_FILE, SFILE);
-}
-
-void testfunc_append(void)
+static void testfunc_append(void)
 {
 	off_t file_offset;
 
-	SAFE_FILE_PRINTF(cleanup, TEST_FILE, "test file");
-
-	TEST(openat(AT_FDCWD, TEST_FILE, O_APPEND | O_RDWR, 0777));
-
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "openat failed");
-		return;
-	}
+	TST_EXP_FD(openat(AT_FDCWD, TEST_FILE, O_APPEND | O_RDWR, 0777));
 
-	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, TEST_RETURN, STR, sizeof(STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, TST_RET, STR, sizeof(STR) - 1);
 
-	file_offset = SAFE_LSEEK(cleanup, TEST_RETURN, 0, SEEK_CUR);
+	file_offset = SAFE_LSEEK(TST_RET, 0, SEEK_CUR);
 
 	if (file_offset > (off_t)(sizeof(STR) - 1))
-		tst_resm(TPASS, "test O_APPEND for openat success");
+		tst_res(TPASS, "test O_APPEND for openat success");
 	else
-		tst_resm(TFAIL, "test O_APPEND for openat failed");
+		tst_res(TFAIL, "test O_APPEND for openat failed");
 
-	SAFE_CLOSE(cleanup, TEST_RETURN);
+	SAFE_CLOSE(TST_RET);
 }
 
-void testfunc_cloexec(void)
+static void testfunc_cloexec(void)
 {
 	pid_t pid;
 	int status;
 	char buf[20];
 
-	TEST(openat(AT_FDCWD, TEST_FILE, O_CLOEXEC | O_RDWR, 0777));
-
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "openat failed");
-		return;
-	}
+	TST_EXP_FD(openat(AT_FDCWD, TEST_FILE, O_CLOEXEC | O_RDWR, 0777));
 
-	sprintf(buf, "%ld", TEST_RETURN);
+	sprintf(buf, "%ld", TST_RET);
 
-	pid = tst_fork();
+	pid = SAFE_FORK();
 
 	if (pid < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
+		tst_brk(TBROK | TERRNO, "fork() failed");
 
 	if (pid == 0) {
 		if (execlp(TEST_APP, TEST_APP, buf, NULL))
 			exit(2);
 	}
 
-	SAFE_CLOSE(cleanup, TEST_RETURN);
+	SAFE_CLOSE(TST_RET);
 
-	SAFE_WAIT(cleanup, &status);
+	SAFE_WAIT(&status);
 
 	if (WIFEXITED(status)) {
 		switch ((int8_t)WEXITSTATUS(status)) {
 		case 0:
-			tst_resm(TPASS, "test O_CLOEXEC for openat success");
+			tst_res(TPASS, "test O_CLOEXEC for openat success");
 		break;
 		case 1:
-			tst_resm(TFAIL, "test O_CLOEXEC for openat failed");
+			tst_res(TFAIL, "test O_CLOEXEC for openat failed");
 		break;
 		default:
-			tst_brkm(TBROK, cleanup, "execlp() failed");
+			tst_brk(TBROK, "execlp() failed");
 		}
 	} else {
-		tst_brkm(TBROK, cleanup,
-				 "openat2_exec exits with unexpected error");
+		tst_brk(TBROK, "openat2_exec exits with unexpected error");
 	}
 }
 
-void testfunc_largefile(void)
+static void testfunc_largefile(void)
 {
 	int fd;
 	off_t offset;
 
-	fd = SAFE_OPEN(cleanup, LARGE_FILE,
+	fd = SAFE_OPEN(LARGE_FILE,
 				O_LARGEFILE | O_RDWR | O_CREAT, 0777);
 
 	offset = lseek(fd, 4.1*1024*1024*1024, SEEK_SET);
 	if (offset == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "lseek64 failed");
+		tst_brk(TBROK | TERRNO, "lseek64 failed");
 
-	SAFE_WRITE(cleanup, SAFE_WRITE_ALL, fd, STR, sizeof(STR) - 1);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR) - 1);
 
-	SAFE_CLOSE(cleanup, fd);
+	SAFE_CLOSE(fd);
 
-	TEST(openat(AT_FDCWD, LARGE_FILE, O_LARGEFILE | O_RDONLY, 0777));
+	TST_EXP_FD(openat(AT_FDCWD, LARGE_FILE, O_LARGEFILE | O_RDONLY, 0777));
 
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL, "test O_LARGEFILE for openat failed");
+	if (TST_RET == -1) {
+		tst_res(TFAIL, "test O_LARGEFILE for openat failed");
 	} else {
-		tst_resm(TPASS, "test O_LARGEFILE for openat success");
-		SAFE_CLOSE(cleanup, TEST_RETURN);
+		tst_res(TPASS, "test O_LARGEFILE for openat success");
+		SAFE_CLOSE(TST_RET);
 	}
 }
 
-void testfunc_noatime(void)
+static void testfunc_noatime(void)
 {
 	struct stat file_stat, file_newstat;
 	char buf;
 	const char *flags[] = {"noatime", "relatime", NULL};
 	int ret;
 
-	ret = tst_path_has_mnt_flags(cleanup, NULL, flags);
+	char path[PATH_MAX];
+	char *tmpdir;
+
+	tmpdir = tst_tmpdir_path();
+	snprintf(path, sizeof(path), "%s/%s", tmpdir, MOUNT_POINT);
+	ret = tst_path_has_mnt_flags(path, flags);
 	if (ret > 0) {
-		tst_resm(TCONF, "test O_NOATIME flag for openat needs "
+		tst_res(TCONF, "test O_NOATIME flag for openat needs "
 			"filesystems which are mounted without "
 			"noatime and relatime");
 		return;
 	}
 
-	SAFE_STAT(cleanup, TEST_FILE, &file_stat);
+	SAFE_STAT(TEST_FILE, &file_stat);
 
 	sleep(1);
 
-	TEST(openat(AT_FDCWD, TEST_FILE, O_NOATIME | O_RDONLY, 0777));
+	TST_EXP_FD(openat(AT_FDCWD, TEST_FILE, O_NOATIME | O_RDONLY, 0777));
 
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "openat failed");
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "openat failed");
 		return;
 	}
 
-	SAFE_READ(cleanup, 1, TEST_RETURN, &buf, 1);
+	SAFE_READ(1, TST_RET, &buf, 1);
 
-	SAFE_CLOSE(cleanup, TEST_RETURN);
+	SAFE_CLOSE(TST_RET);
 
-	SAFE_STAT(cleanup, TEST_FILE, &file_newstat);
+	SAFE_STAT(TEST_FILE, &file_newstat);
 
 	if (file_stat.st_atime == file_newstat.st_atime)
-		tst_resm(TPASS, "test O_NOATIME for openat success");
+		tst_res(TPASS, "test O_NOATIME for openat success");
 	else
-		tst_resm(TFAIL, "test O_NOATIME for openat failed");
+		tst_res(TFAIL, "test O_NOATIME for openat failed");
 }
 
-void testfunc_nofollow(void)
+static void testfunc_nofollow(void)
 {
-	TEST(openat(AT_FDCWD, SFILE, O_NOFOLLOW | O_RDONLY, 0777));
-
-	if (TEST_RETURN == -1 && TEST_ERRNO == ELOOP) {
-		tst_resm(TPASS, "test O_NOFOLLOW for openat success");
-	} else {
-		tst_resm(TFAIL, "test O_NOFOLLOW for openat failed");
-		SAFE_CLOSE(cleanup, TEST_RETURN);
-	}
+	TST_EXP_FD_OR_FAIL(openat(AT_FDCWD, SFILE, O_NOFOLLOW | O_RDONLY, 0777),
+			   ELOOP);
 }
 
-void testfunc_trunc(void)
+static void testfunc_trunc(void)
 {
 	struct stat file_stat;
 
-	TEST(openat(AT_FDCWD, TEST_FILE, O_TRUNC | O_RDWR, 0777));
+	TST_EXP_FD(openat(AT_FDCWD, TEST_FILE, O_TRUNC | O_RDWR, 0777));
 
-	if (TEST_RETURN == -1) {
-		tst_resm(TFAIL | TTERRNO, "openat failed");
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "openat failed");
 		return;
 	}
 
-	SAFE_FSTAT(cleanup, TEST_RETURN, &file_stat);
+	SAFE_FSTAT(TST_RET, &file_stat);
 
 	if (file_stat.st_size == 0)
-		tst_resm(TPASS, "test O_TRUNC for openat success");
+		tst_res(TPASS, "test O_TRUNC for openat success");
 	else
-		tst_resm(TFAIL, "test O_TRUNC for openat failed");
+		tst_res(TFAIL, "test O_TRUNC for openat failed");
+
+	SAFE_CLOSE(TST_RET);
+}
+
+static void verify_openat(unsigned int n)
+{
+	struct test_case *tc = &test_cases[n];
 
-	SAFE_CLOSE(cleanup, TEST_RETURN);
+	tc->testfunc();
 }
 
-void cleanup(void)
+static void setup(void)
 {
-	tst_rmdir();
+	SAFE_FILE_PRINTF(TEST_FILE, "test file");
+	SAFE_SYMLINK(TEST_FILE, SFILE);
 }
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+	if (dir_fd > 0)
+		SAFE_CLOSE(dir_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = verify_openat,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.all_filesystems = 1,
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_POINT,
+	.filesystems = (struct tst_fs[]) {
+		{
+			.type = "ext2",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{
+			.type = "ext3",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{
+			.type = "ext4",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{
+			.type = "xfs",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{
+			.type = "btrfs",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{
+			.type = "bcachefs",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{
+			.type = "tmpfs",
+			.mnt_flags = MS_STRICTATIME,
+		},
+		{}
+	},
+	.skip_filesystems = (const char *[]) {
+		"vfat",
+		"exfat",
+		"ntfs",
+		NULL
+	}
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
