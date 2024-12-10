Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85A3E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 21:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733866760; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=iNif88jFhh2nNFlTQWIEyPTBLArY7vb12NJsXRM4RhY=;
 b=Qfi9OntWQFSbiO7Emv4/0E/o5+raoKFox9D6nfyL13Jrb659paEkdIUULXi8lRd20nso/
 7d3f86AoWj+GpMGOOiRX557/MHeyuqbkGREEJGktitgS1YJp8DiAQ43i4lt3aZ+Ecdu5qRQ
 pF/i/lZyD0bMpixEYV+Hy6OFIRD6ilU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2346A3E930D
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 22:39:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B75483E92D3
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 22:38:58 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F444101480A
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 22:38:57 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so4066685f8f.1
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733866736; x=1734471536; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nDwNsVMQ7XgWhN8nIXV14ofus8tCawisMKRvVc9J+Ws=;
 b=CnNUX00zL830dTzMg7F/atjdaGQQM91v288K1IQ6jMybFJowR0KjCP2nqxahpWmKWB
 MmYBL6P+TyZY0ZJldvsCF4mUHsa7Cu/JuwJfB4VyidQsvbt99qAusddPwdy5J1sKnDE0
 QwQiAFRahPkE8SPGbxJshZJcih4+hYOouFTrvqBIRF4lWHR3uR89n+wA2m5+eJDjY1DW
 t4IIm1mkvuudyuuCjCrNFIWfCHmVKMUG3z38jHJWhiFR6hvXn35jB1kiMv9Hu0nWHD+v
 XL0gFCneEARnaQj4qDeSQv1Pfx7+WvxCMDr9HY1mAH/1WXPCYCj7WBXroY2OaeQ3pBG+
 0ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733866736; x=1734471536;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nDwNsVMQ7XgWhN8nIXV14ofus8tCawisMKRvVc9J+Ws=;
 b=nN0UWP5PceQzCkw7+tb4U2O40GjTP6Pf38gwZ1isnqjMzmLdjY4Gc2agAn4Z0S2/H1
 Gb26pWEYmLLOw7Q/JUQme9sIt9obV7c27EQhVoVF/o/64x3zh7sZc89lpWKVa7A0zO2d
 sButO+FAMybVzpQmatZphc0D5tSR2bF/GSaQXV7ir5wepyd74Oz9lW9dgpJj8123X00C
 h+c1HHZ0XTRvnr+Ud0TQcG3Hzk8fv8be/mFgbzVbIZP0uUptJzNhHsCcOaEfWv1nmgF4
 y+VBv9Y6I5+wXfiZdoikzH0c6dvE9uYmAp+VRAkUdgn5T7+Y3UTJy9d1uufHYZdqNps6
 p6Iw==
X-Gm-Message-State: AOJu0YzB6bCbApqLKSuBiV3eDTyvRvnbklZEBWaOUgyCWbzlYybQ1uq0
 H8PDc0i+FD6twquToewIJ42ZmhgsvQI7LgKI3VduqqMdpg4hCwUGljhG13rXduZ71mys8FAszme
 o
X-Gm-Gg: ASbGnctg/BU4t6jn0wPYvrbTouSbCug62CkQdnWHCtWc8ErxasUI6/eHWVlu+i0ND1Z
 n3V3uN0IosdiBBvTjQnmiAfVBeSAiiou0YnIkz7a/TPcYgtTpg6W8/mfyti5DKiJPGa/UQLbZB+
 ZDdd/OCUXGy47fACGcb2nGM9sy/Zs9W98WAP7iTLFbD7hYADVVQoKLXX0atu5rZYnIHcJpbJEBW
 iEaBFit75gips++1uSvZ8gDeFE3G8ctxNKucBQAJg==
X-Google-Smtp-Source: AGHT+IHVF/NXcveEJ+ARe1cl66bc7+gccJFHFvdmVkui7kK7W7sZ554hMqzCSzVPFgHxjogt75qrYA==
X-Received: by 2002:a5d:64e8:0:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-3864cea22d3mr380197f8f.27.1733866736272; 
 Tue, 10 Dec 2024 13:38:56 -0800 (PST)
Received: from localhost ([152.250.153.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f29c17sm94670185ad.244.2024.12.10.13.38.55
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 13:38:55 -0800 (PST)
Date: Tue, 10 Dec 2024 18:38:52 -0300
MIME-Version: 1.0
Message-Id: <20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com>
X-B4-Tracking: v=1; b=H4sIAOu0WGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxNDI0MD3eT8vLLUopL43NzEAgNDXTMLozRzw6TUJFOLFCWgpoKi1LTMCrC
 B0bG1tQAnGwP+YAAAAA==
X-Change-ID: 20241210-convert_mmap01-682f71beb58d
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9492; i=rbm@suse.com;
 h=from:subject:message-id; bh=a8CMWwxCL7MHJvf3ZDspdICctfTo87B4qM41szN7bjw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnWLTtrvzZM8ueGXgC0AKyHQqhYjj5SqvMPs6M0
 oCI+6oB1g6JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1i07QAKCRDJC4p8Y4ZY
 pkSAD/9iOSzNsUWOLPvZtI6POzrgnTG6rIUTTbMti5ypcnL3a9gXOETxQuYk0VQWGLecbL8zcfu
 ZsmPnduzGqvz3DVMOuMBI1AujAYEKATQPjN7fGYygIUUCFWesHLVhg5QASmJIJbKPH/wJuKRtri
 e2z8+C+pDcALOKkT+22XvFD+lBT8M23WDhJYX5BtQv0pq1+E+QBc614hktCuCZiKPsIZ9QL2V6u
 DtKKB7LvVMFk3VCVEj1jsXI3NINls9czsgEVtWTBUaj1c5IB0hOdMbqqu2wxcfQTN/QZNdrJ5gq
 x+2gq0NzCBF0SlXtUyVXpwN2rx0Tc1C/cNN/vzljuqSEs5keOch7h43KIMOyqSqk7CNtD88dI8q
 uTKcpLqFtnMkvBModWUA10fr/lw14j8zegCcwKXzJFOudk3jvN6F29DzDfhoLjVHeW7drBxhtTa
 QBnD9KTNRAOX1w195d5+FN8GFjuL8VC4kB7FmOjBjniWQI+sB6/4BFxJtL18BGesQD469cSD2qw
 UnqjC+QMo7i/czkk1dav6gE6YxsHK1o36+JAKb2XZ6f3sRJYbg5AwbC+fx0OPS7pEsFarcGNtqT
 xWWHW4lk/y/C9WNbxPUagC+ZMSa6eEx0dUGrw1ARaxY7njS8yd4hnPjqulAqrSZBpl7q87TqTQT
 nN0YBSAj/cBIlVg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] mmap01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Ricardo B. Marliere <rbm@suse.com>

Refactor the old mmap01 code into the new LTP API.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
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
 testcases/kernel/syscalls/mmap/mmap01.c | 255 ++++++++++++--------------------
 1 file changed, 97 insertions(+), 158 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..fff39d0ff6e1c271616d1391904f7011fbb2675e 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -1,194 +1,133 @@
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
+#define STRING "hello world"
 
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
+
+	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
+	SAFE_READ(0, fildes, buf, sizeof(buf));
+
+	for (i = 0; i < buf_len; i++)
+		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
+			break;
 
-	cleanup();
-	tst_exit();
+	if (i == buf_len)
+		tst_res(TPASS, "Functionality of mmap() successful");
+	else
+		tst_res(TFAIL, "Specified pattern found in file");
+
+	SAFE_CLOSE(fildes);
 }
 
-static void setup(void)
+static void run(void)
 {
-	struct stat stat_buf;
-	char Path_name[PATH_MAX];
-	char write_buf[] = "hello world\n";
+	pid_t pid;
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
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	/*
+	 * Now, search for the pattern 'XYZ' in the temporary file.
+	 * The pattern should not be found and the return value should be 1.
+	 */
+	pid = SAFE_FORK();
+	if (!pid) {
+		check_file();
+		exit(0);
+	}
 
-	TEST_PAUSE;
+	SAFE_MUNMAP(addr, page_sz);
+}
 
-	tst_tmpdir();
+static void cleanup(void)
+{
+	if (dummy)
+		free(dummy);
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
+}
 
-	/* Get the path of temporary file to be created */
-	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "getcwd failed to get current working directory");
-	}
+static void setup(void)
+{
+	char *write_buf = STRING;
+	struct stat stat_buf;
 
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
 
 	page_sz = getpagesize();
 
 	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
-	}
-
-	/* Create the command which will be executed in the test */
-	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
+	dummy = SAFE_CALLOC(page_sz, sizeof(char));
 }
 
-static void cleanup(void)
-{
-	close(fildes);
-	free(dummy);
-	tst_rmdir();
-}
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
