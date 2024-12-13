Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C079AE7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734051285; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=1LbdyC94mC1yqs/0eeuRcvwv4PlSiQfRoqTDAJmzy6k=;
 b=lKNnKZ2bQ9qX5l8w6nrwlw4mBeW1Aeiml6iB8+G3g5lVx04F+X5+UhLyvdyatUURINd31
 8Xg9D4Sk044p68zgTemYpYFG3CtniQyBUfg1P1HkE8ZvJm75ZITDlJirDopmO1KI3ih1c4O
 NJCvO5nOKm30rsOsgjlc8aP0QkOZ5R8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2AB93EB188
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 01:54:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 239763EB160
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 01:54:24 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0CFB62E92A
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 01:54:22 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso919325f8f.2
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 16:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734051262; x=1734656062; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vdWLLXVW2wLvL+5rTXkYhvLzq111hofiMqi2GhGsC/0=;
 b=Yb0ulivQ2T/RVvXzB9qF1/S9nYvq0+ZF56lCHu9AgXdYAo1ynLkVinhcOyBOuvGyLV
 abzfi40BLeobvpkcmX449oNwEcRYoUtf3ryREuPgweXZvsNE/4YNEmWcV0Y+jofV7HN3
 Xd8ORl5Znokj+LpR6t0JDQxr5Y5AJ7KtwFjIhlbvtyPeWmS8eGZRlTz3NRQONkLtW3TG
 uo/+z5ltr0siSzdeLymY2oIwI1MU6ZiocpfTVLS78Ylin0/BJlssdTZKJKNVzJEd31uc
 h80vBhwxsum5l3XzUZjA+kmkB8Sl0lWUJnnGvi5q+0LZXtakcMPwlIzSgEX68QDUaxzb
 6JqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734051262; x=1734656062;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdWLLXVW2wLvL+5rTXkYhvLzq111hofiMqi2GhGsC/0=;
 b=ND+l5IGAC394ldruFpmALAau4F+uDhqvOk+xxEbmtTlgHmPWfzmKHFjjNu6aFtBh9s
 9OXTsqCfjKqtTX9YxI+4r7RRYbxgwKObHSfgcjoUqv8ggh3LqcdN3qPsS3VqE7eHNenK
 8FJ7sMbUdyVLh4SPnYteDekVNSPTNApOXnuHETmpJJeYWLldVmyQoQafkIlCsjjn2YwD
 ajPmhUWZX1EzuJuULa9SRFZCrb7oZ3A9WR1HesBRplo2QUf8BgTX7unItIxv59SnUhvK
 YfzOSYiSnupeGpvGK3qP5cTtnFOw0FoNMHG24O/Wyk+m/gYjCLrTzz/1m2Kir2Rnrcm5
 dG2g==
X-Gm-Message-State: AOJu0YyUnfZvohBNOq9vJR46Q/jVEXEdn5EQ/vIwJHN7jmUGi9knxPpx
 gw92eV1nSt1e3lBc3NsRaBeswUPy1mAUEBdNZL7jGP3pGKnpMrqWsnR1Pp634yo=
X-Gm-Gg: ASbGncuuQeSXHiwayz0GPMLHgxB4XoHs+1WHpE7kkuiQcgcmozW/4SMu9zJSzuuo3Ai
 FBM5+CE5g84v5ZqfTaVsu+cDCPhkK6r5/1U97NaGpn/A1flFcKbGhhRny9CH0ApPfmyWnJFg3ST
 YGz7eVCCH3bSEc100yErubG3uZX5gZPTCCltWXYKd2xR2bsG0yQTfJmOcTs1cO6CiUWI6caK+Wi
 wSfGhs7CXsKeSHpDxatUwGcO24UJB26hjYzwTGWj2TLJw==
X-Google-Smtp-Source: AGHT+IE+qeaN9udDfSU6Kq8XpUNMJv367dpC27NwqSwzA2fFlu3FSvRl8WnRA0326d24t1S1v31qBQ==
X-Received: by 2002:a05:6000:178b:b0:385:e35e:9da8 with SMTP id
 ffacd0b85a97d-3888dcd498dmr293109f8f.18.1734051261860; 
 Thu, 12 Dec 2024 16:54:21 -0800 (PST)
Received: from localhost ([152.250.153.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e3ca46f0sm8813619b3a.15.2024.12.12.16.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 16:54:21 -0800 (PST)
Date: Thu, 12 Dec 2024 21:54:12 -0300
MIME-Version: 1.0
Message-Id: <20241212-convert_mmap01-v5-1-258d9d78bb83@suse.com>
X-B4-Tracking: v=1; b=H4sIALOFW2cC/3XMQQ7CIBCF4as0sxYDU2qJK+9hGkPp1LIAGqhE0
 3B3sXuX/0vet0OiaCnBtdkhUrbJBl+jOzVgFu2fxOxUG5CjFCg4M8FnitvDOb1ywS4K516MNHZ
 qgnpaI832fYD3ofZi0xbi5/Cz/K1/qSyZYAbbVmk0mvfill6JziY4GEopX9cskNurAAAA
X-Change-ID: 20241210-convert_mmap01-682f71beb58d
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9931; i=rbm@suse.com;
 h=from:subject:message-id; bh=gznvqoRdTKk5bwQ/a8Gc3QKrmRMzQfolwMFwhrIEYfI=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnW4W6lAYsvfQ/rTZVTEmHIYw4WVswbIE4YuVRE
 izqrtYpHvqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1uFugAKCRDJC4p8Y4ZY
 prqLD/9wDXebvGxOQcgLxvZpKXWgid6brsN589wvnlEfBr01lw9wZkJp26YVJzZFyAzMJYUAjHa
 idjzJnjrDlJ+aV7htL7GuTGtY70/jOgBhEVIbyChCUBgF4xs7N+qyocWd4xJgB0FEClXEn8jC7K
 MpyfckbkHZxlYOT2ULahht1nEC9wXoWWa7Fdkazb3AUnUyybRZp25zBCuIyFdBNe5cKu2c9VkyG
 8Fh9VP1CrXyl0Hbn2wl4WjRIyig6/mM/WPjoyibbTK/ZSbI4iv9iNs3GlMXIoUrPXinrSScSGXO
 orB07jIgCtbJrUe3WtDP9azbSXAkmxMI17EabSwJpLbveuGKolcoa9qVOtu+Vrz0eNkT61CMz5c
 Dz7mjJ5Q3ZBplOXq3FsSzP3ftBff4EeW07r60SVshOp/QQACaUznswGwDQwP94HgV0IaOVTUkaT
 R81tQVia5IVzlXzPuOmc4aVo8PA/P7tJ/3pXlfy/IhsR1PhhjAKNMSIl5n9NU4QRaRY7tyUpOd4
 IVxir44ZpFw0lF+7mKAStB9ffHqCCqw1t0ovJzgvjZuW68kphVe4DatzAceeLe+12S1YP5+vnUF
 o1FZneH+dFrr04nw2csonFIJf7hegfNo/xs4+HSxkw3Jc5ak5n9tYU/MuDf9CvgTgX7WTr+Nedw
 11HLe/BrI7/gTEQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] mmap01: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Ricardo B. Marliere <rbm@suse.com>

Refactor the old mmap01 code into the new LTP API.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Changes in v5:
- Reset file for each test run in a new function set_file().
- Restored STRING to its original content.
- Added call to SAFE_MUNMAP in the child process.

Changes in v4:
- Move file check logic into a new function check_file() instead of using a
  system() call to grep.
- Link to v3: https://lore.kernel.org/r/20241118-convert_mmap01-v3-1-b275c90035f5@suse.com/

Changes in v3:
- Use SAFE_MMAP and SAFE_MUNMAP as suggested by Jan Stancek.
- Re-aligned a few comments.
- Link to v2: https://lore.kernel.org/r/20241114-convert_mmap01-v2-1-a8a1379dec89@suse.com

Changes in v2:
- Fixed metadata alignment.
- Link to v1: https://lore.kernel.org/r/20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com
---
 testcases/kernel/syscalls/mmap/mmap01.c | 264 +++++++++++++-------------------
 1 file changed, 108 insertions(+), 156 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..0ca881691d28aeb567687defe18ed7b3df9006d6 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -1,194 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2024 Ricardo B. Marliere <rbm@suse.com>
  *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * HISTORY
+ *	07/2001 Ported by Wayne Boyer
  */
 
-/*
- * Test Description:
- *  Verify that, mmap() succeeds when used to map a file where size of the
- *  file is not a multiple of the page size, the memory area beyond the end
- *  of the file to the end of the page is accessible. Also, verify that
- *  this area is all zeroed and the modifications done to this area are
- *  not written to the file.
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region.
- *  The memory area beyond the end of file to the end of page should be
- *  filled with zero.
- *  The changes beyond the end of file should not get written to the file.
+ * Verify that mmap() succeeds when used to map a file where size of the
+ * file is not a multiple of the page size, the memory area beyond the end
+ * of the file to the end of the page is accessible. Also, verify that
+ * this area is all zeroed and the modifications done to this area are
+ * not written to the file.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * mmap() should succeed returning the address of the mapped region.
+ * The memory area beyond the end of file to the end of page should be
+ * filled with zero.
+ * The changes beyond the end of file should not get written to the file.
  */
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <stdint.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <sys/shm.h>
-
-#include "test.h"
-
-#define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap01";
-int TST_TOTAL = 1;
+
+#include "tst_test.h"
+
+#define TEMPFILE "mmapfile"
+#define STRING "hello world\n"
 
 static char *addr;
 static char *dummy;
 static size_t page_sz;
 static size_t file_sz;
 static int fildes;
-static char cmd_buffer[BUFSIZ];
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void check_file(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call mmap to map the temporary file beyond EOF
-		 * with write access.
-		 */
-		errno = 0;
-		addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Check if mapped memory area beyond EOF are
-		 * zeros and changes beyond EOF are not written
-		 * to file.
-		 */
-		if (memcmp(&addr[file_sz], dummy, page_sz - file_sz)) {
-			tst_brkm(TFAIL, cleanup,
-				 "mapped memory area contains invalid "
-				 "data");
-		}
-
-		/*
-		 * Initialize memory beyond file size
-		 */
-		addr[file_sz] = 'X';
-		addr[file_sz + 1] = 'Y';
-		addr[file_sz + 2] = 'Z';
-
-		/*
-		 * Synchronize the mapped memory region
-		 * with the file.
-		 */
-		if (msync(addr, page_sz, MS_SYNC) != 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to synchronize mapped file");
-		}
-
-		/*
-		 * Now, Search for the pattern 'XYZ' in the
-		 * temporary file.  The pattern should not be
-		 * found and the return value should be 1.
-		 */
-		if (system(cmd_buffer) != 0) {
-			tst_resm(TPASS,
-				 "Functionality of mmap() successful");
-		} else {
-			tst_resm(TFAIL,
-				 "Specified pattern found in file");
-		}
-
-		/* Clean up things in case we are looping */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0) {
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-		}
-	}
+	int i, fildes, buf_len = sizeof(STRING) + 3;
+	char buf[buf_len];
 
-	cleanup();
-	tst_exit();
-}
+	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
+	SAFE_READ(0, fildes, buf, sizeof(buf));
 
-static void setup(void)
-{
-	struct stat stat_buf;
-	char Path_name[PATH_MAX];
-	char write_buf[] = "hello world\n";
+	for (i = 0; i < buf_len; i++)
+		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
+			break;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	if (i == buf_len)
+		tst_res(TPASS, "Functionality of mmap() successful");
+	else
+		tst_res(TFAIL, "Specified pattern found in file");
 
-	TEST_PAUSE;
+	SAFE_CLOSE(fildes);
+}
 
-	tst_tmpdir();
+static void set_file(void)
+{
+	char *write_buf = STRING;
+	struct stat stat_buf;
 
-	/* Get the path of temporary file to be created */
-	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "getcwd failed to get current working directory");
+	/* Reset file */
+	if (fildes > 0) {
+		SAFE_CLOSE(fildes);
+		SAFE_UNLINK(TEMPFILE);
 	}
 
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
-	}
+	/* Create a temporary file used for mapping */
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
 	/* Write some data into temporary file */
-	if (write(fildes, write_buf, strlen(write_buf)) != (long)strlen(write_buf)) {
-		tst_brkm(TFAIL, cleanup, "writing to %s", TEMPFILE);
-	}
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, write_buf, strlen(write_buf));
 
 	/* Get the size of temporary file */
-	if (stat(TEMPFILE, &stat_buf) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "stat of %s failed",
-			 TEMPFILE);
-	}
+	SAFE_STAT(TEMPFILE, &stat_buf);
 	file_sz = stat_buf.st_size;
+}
 
-	page_sz = getpagesize();
+static void run(void)
+{
+	pid_t pid;
+
+	set_file();
+
+	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
+			 MAP_FILE | MAP_SHARED, fildes, 0);
+
+	/*
+	 * Check if mapped memory area beyond EOF are zeros and changes beyond
+	 * EOF are not written to file.
+	 */
+	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
+		tst_brk(TFAIL, "mapped memory area contains invalid data");
+
+	/*
+	 * Initialize memory beyond file size
+	 */
+	addr[file_sz] = 'X';
+	addr[file_sz + 1] = 'Y';
+	addr[file_sz + 2] = 'Z';
+
+	/*
+	 * Synchronize the mapped memory region with the file.
+	 */
+	if (msync(addr, page_sz, MS_SYNC) != 0) {
+		tst_res(TFAIL | TERRNO, "failed to synchronize mapped file");
+		return;
+	}
 
-	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
+	/*
+	 * Now, search for the pattern 'XYZ' in the temporary file.
+	 * The pattern should not be found and the return value should be 1.
+	 */
+	pid = SAFE_FORK();
+	if (!pid) {
+		check_file();
+		SAFE_MUNMAP(addr, page_sz);
+		exit(0);
 	}
 
-	/* Create the command which will be executed in the test */
-	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
+	SAFE_MUNMAP(addr, page_sz);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
-	free(dummy);
-	tst_rmdir();
+	if (dummy)
+		free(dummy);
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
 }
+
+static void setup(void)
+{
+	set_file();
+	page_sz = getpagesize();
+
+	/* Allocate and initialize dummy string of system page size bytes */
+	dummy = SAFE_CALLOC(page_sz, sizeof(char));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.test_all = run,
+	.forks_child = 1,
+};

---
base-commit: ad651beeed393121ee541e3d07990e9a3d14c0c0
change-id: 20241210-convert_mmap01-682f71beb58d

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
