Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613F6E7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 01:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734052076; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Gf4ozXizFNwiw3Xgk2NJd4A4FJazpLnLRqwAKGbBvNk=;
 b=YKWAR7u7CXZmN62+mJ7bzY7qVvy8GLZLhyLlc4ii1mi15wgBUO2397QQxjnPdRwNzOnn1
 TkQ5/30F7S0yTvcg5FXy4SNbsbzf1TtXn+Xum9K3lnTN+AOsgTBaqjWA9Bc/bgTEjbqj9bG
 XonjJALWsCWAiI1CLJQ4CYAKYUHUjTY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8379D3EB18B
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 02:07:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 225193E9803
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 02:07:34 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E51521A01228
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 02:07:33 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so671598f8f.0
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 17:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734052053; x=1734656853; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UGoX+5yJfnZPdDwe+Ev+Cldh2DXRv91QqYMsMJRoIIk=;
 b=bniM0OkfVKCs5PqeX+V1Phv+/iUq+PP9D+fyw4uB3KjSO+qIIf0hANz+ozE79QnEba
 uHw9T9flFwEV0W1Y4G8wqWBSniXbNsmJsIEB6jioiwkjr7BVgY/vPJOmEq703zvakDS5
 0Y198yAjWktfTWdVOxMDuGVcYa63xgm2ojgTyTYnkGPnMNpDjueD1RseWf6b0rcLEVaX
 KvqyN4HJkf+SB1M5kNgYgVcn+xYKEygx35jinl0Zcfuuyw83x9rDJ9LKd+tIZPl0uNgc
 9t7gVaQjSdS08o6Q4fSRE5Iu6udJyj/IoWbNiO0zdl5eLQ1GtVUBYw22eELSf38eTVkZ
 5W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734052053; x=1734656853;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UGoX+5yJfnZPdDwe+Ev+Cldh2DXRv91QqYMsMJRoIIk=;
 b=d7pJGINXzT+rxBRtDUAASQ/AoP7N5fkjOiJ38ixNhytxJdHvvNZ+HfVA4XB8YlVFOg
 g98MENtkYaOXqNMriOKNECZByJKZ93IbOf7Wb2gp9U/xGZp783dd+0tiT+PHeMRuPqqD
 myiFlHmGJ0Qk55lIyvU/Fw/i7I1xBytZCnkBR3+JLnqOjiMRUsJ9ANrcGN2LfPKX/HmO
 9mzKz7cL2xnpPLce4L5DD9iPi/R0kCd5G3F1qz9FHnfEZKYUJ1/dQtuwJYSDrHIpwP99
 CnZEYvyrxdO5LejVQm+GkPLRMbSz1oUkMAbzTJnZaYrcpW4Ff9tQtSs++3Yu2atey8uM
 WcZw==
X-Gm-Message-State: AOJu0YxaijeWIva1NfxYC9j3AItKCHDxaH1DlAJ+y3E121mWMcsw+9qb
 yfh5QgEVemgL3W5azKcmXi/7R0HuTjCu/4Kyy+yW/P/bS+P/zglU4XkW0FFkItpSm+czRxcN7Fc
 v
X-Gm-Gg: ASbGncuLQ8ciYkpRTtC89QlP5GlYPSHPxwNb5N6btoqv30Q6W+F+wZKW+/vY662/+W9
 do2McUnxM/x/8eRDbt07+3DrQdl9JJmVQx903m0RQEVbxR1gaVZDpEF6cETFAzIl5FqEU3/Odgz
 RGrP+gEHUwtcj64Xm8ewbSCwwwkUqk/wqPgAm+XMoP5yp4EGdZk2i5eg19DjWP1/u24Kv4aKbrR
 t0SdiNtsD5RdoH+iShvT3KT4yzfMMWbrvuAhbfKGwzXXQ==
X-Google-Smtp-Source: AGHT+IEHdf62ZQSwhmPS5JAoxQE30qBbV74PXt0HQDI8hpovZZHED15djG0glMtQonHkNrL8ylXAAg==
X-Received: by 2002:a05:6000:1567:b0:385:f7d2:7e9b with SMTP id
 ffacd0b85a97d-38880adaaa2mr377795f8f.30.1734052052812; 
 Thu, 12 Dec 2024 17:07:32 -0800 (PST)
Received: from localhost ([152.250.153.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f3189asm129682435ad.248.2024.12.12.17.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 17:07:32 -0800 (PST)
Date: Thu, 12 Dec 2024 22:07:27 -0300
MIME-Version: 1.0
Message-Id: <20241212-convert_mmap01-v6-1-d186b68c3f09@suse.com>
X-B4-Tracking: v=1; b=H4sIAM6IW2cC/3WOywqDMBBFf0Vm3ZRkfKWu+h+llCSONQuNJDa0i
 P/e6EooXZ4L53AXCOQtBWiyBTxFG6wbE1SnDEyvxicx2yYG5FgIFJwZN0by82MY1MQFqyR2tdC
 kS9lCkiZPnX3vwds9cW/D7Pxn78diW/+mYsEEM5jnUqFRvBbX8Ap0Nm6ArRTLo40/dplsTC8ub
 S21lvnBXtf1C/JsmRTpAAAA
X-Change-ID: 20241210-convert_mmap01-682f71beb58d
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10214; i=rbm@suse.com;
 h=from:subject:message-id; bh=5H6ibQ8DKqiS/1JvntE2gvG9MOBpmB3iW6WvbQJuoQY=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnW4jS8aXwMnxGnaia4gCOy5xZxMEca4Pp16Zfd
 lShXWarx9aJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1uI0gAKCRDJC4p8Y4ZY
 pjyZD/0WvyOg4j9Cus0MLY01DKc/yjm6+ZfmlTgdqgqwR6BeasAAkG9nsSIpSeXZ1mCsyKFPby9
 PzkmeVyE/9PmXEBNcnNtXqYwqlMU9TIov1lA65z/48UYENq87Tjm/89MY992stFktJk5+b/x46x
 n2DcuZ2xEFYCBXjoj9speIqNU6bwqSblQOpPjXUd8UkFcDYyf8mj3GUN9qVz02OmggdoagauXJL
 iSf6NC/SZ9E1JDNrOBW1pMiuXGOxh+zx63uD4+yek2+lkASOVnlp1yyk/oOp8qJFUQ4D6LJI4+C
 nooJVEZbfhdiONGT4PoYf2aX3Z7aEKoA8pWDh7Qxz+Q7znq2WVyNpgUmjgsmgblSIGnGWLZzJ9e
 FutgOwgUHwXArlATq/uScKxJZOWCWTK3Af+mnnCnxlfl9dOPnTdPMicRAIUsbOsQFJa39XbmfPC
 m91WAc99OXHWF5kwFh/aLi08UHp/8O4F+5w0FOykyCZcXYfoia3D4Fynhr7hWsU50zAaGP9bRgZ
 vbEEuDFdPEs7im/fqttetfZRtn/w+vo9J9lPymqf81C4ePaeufAEjyR1pF80ZYEJ1gqfBPZuA6D
 7QyLZCdXKyf380jlFJvIMFUgXBJ7kFDVMCAoBBSEnxrsupb3hfNM0PXWyKsnLu4r8SQYP04gZzK
 ueeRXIDse3NvUnQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] mmap01: Convert to new API
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
Changes in v6:
- Removed call to set_file() in setup(), otherwise it's called twice in the
  first run().
- Link to v5: https://lore.kernel.org/r/20241212-convert_mmap01-v5-1-258d9d78bb83@suse.com

Changes in v5:
- Reset file for each test run in a new function set_file().
- Restored STRING to its original content.
- Added call to SAFE_MUNMAP in the child process.
- Link to v4: https://lore.kernel.org/ltp/20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com/

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
 testcases/kernel/syscalls/mmap/mmap01.c | 263 +++++++++++++-------------------
 1 file changed, 107 insertions(+), 156 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..0ada71ee5d066be44fa52d8c21d8e21685d9dc44 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -1,194 +1,145 @@
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
