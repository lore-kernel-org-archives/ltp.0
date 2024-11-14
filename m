Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C56BD68B18
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731592711; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=aRXKsQwVSUJG2oiYsA3rNMEeuTh3KD0ejDWVhjHJnXs=;
 b=Kd7sGLwOaZRjsCxoP1RTQ86wH/YxBgHJluVjAywrG7bBRBOHTQQAX5XJg1ox3y4vhibxm
 YEc7gwybbQGrqh68QEaKeyO8zeqKoGkSRXi5u2TbBkkoJHg+KcmHEa/G3v9aokTPNmshyue
 elyQFYMbhFeZixWxd2fnv6u9wb7Z50I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DAB23D6EFB
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:58:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA39A3D6D8F
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 14:58:10 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BCEF2658F18
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 14:58:07 +0100 (CET)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso6641601fa.1
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 05:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731592687; x=1732197487; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WtHp1+acB/474uL7N7wt1SUjFI38U4vCmnzLKfBaYH8=;
 b=agcJrGdLruk1anWZ8c5Jx5YHMzV8khX48UxzS3LwuYVZxX3XTiFtL38MyLrBuPMqvV
 K0wfHIdAprYlAbI2BMrnRkMRNqs+DtAQjriMxvHUx2S7GlgQvOUPEnF+tkrGNV3i92Ax
 tsIbKuX/WvuXI6cYXIClDRulcMcpPkEi7S0mnCgqgMjE9ppsrpcy40Ns7gIGGkVddk/N
 9XZvAZufV1tijl4/qULmQzdPbe70eBZzY0ssgWPUxoYDkD1BYVRLi3jlQuxCO+xDmUf8
 Brvsp8kfeTG3vX0blFh0jgkcwu6cJbXm9r00FpSS65XpENWX4nNsWQxdNrouWySWv422
 ChfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731592687; x=1732197487;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WtHp1+acB/474uL7N7wt1SUjFI38U4vCmnzLKfBaYH8=;
 b=QLvqB8HC/4ov1hbyTO/z35+88f0WwVjY8yJ4C/MSLrEmC+g+QFSwp/cYZVqaMEL/A+
 90Mvt08eM5cd8u8HLQGksWRqpe+TuBodiJj5PgWDUiVnYgJfsYeEUhV8YDJdu+P+CwAH
 YIW2zQD+s6+v3PmEpmKZN1x1WMT955oP+dwjdSlRCQN/8KvwZiKILVPi2AdhAWkk3ZUZ
 5wgcA8oFj2TX2ZF9CnzCyZmP7s6DivcXyydWp5AkY/UYnMiB9WDl761PAAN8EGVlLIt+
 mFGSFvOlfQtKrWpeb6Za+8Cbf5PyH2jTPKhRhcYFbKnGHIJSCxIw3J/SXGBgn/qKIzEz
 NGLQ==
X-Gm-Message-State: AOJu0YyB6p0zWVFLnDS64RC7/YShH0LKMinr2dH1tzQJb3gTzP9nsbdk
 i2/hXmxtDQR0A+JZhgXeE5Ngfk3jYOJu2HDgSH7BOj3lptQsm2CgOTMTQYjS9WaVe7o94iZOipi
 s
X-Google-Smtp-Source: AGHT+IEJHmNxISNXsoG2UVUmcgorGyEZWutfk0Qy+8SVeeHuJPSkSZMMlTEioUZmQB0VcTcDMGvJZg==
X-Received: by 2002:a05:651c:e15:b0:2ff:53c7:a79f with SMTP id
 38308e7fff4ca-2ff53c7a8admr17731731fa.7.1731592686739; 
 Thu, 14 Nov 2024 05:58:06 -0800 (PST)
Received: from localhost ([179.228.213.10]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5eea0230e35sm318841eaf.33.2024.11.14.05.58.03
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 05:58:05 -0800 (PST)
Date: Thu, 14 Nov 2024 10:58:00 -0300
MIME-Version: 1.0
Message-Id: <20241114-convert_mmap01-v2-1-a8a1379dec89@suse.com>
X-B4-Tracking: v=1; b=H4sIAOcBNmcC/3XMQQrCMBCF4auUWRuZicEWV96jFKnJaLNoUjI1K
 CV3N3bv8n/wvg2Ek2eBS7NB4uzFx1BDHxqw0xierLyrDRq1IaKTsjFkTuttnscFSbm7xo4RdYc
 E9bQkfvj3DvZD7cnLGtNn9zP91r9UJkWKW3dGbg0aa67yEj7aOMNQSvkCgxhZM6sAAAA=
X-Change-ID: 20241113-convert_mmap01-db208e002801
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8915; i=rbm@suse.com;
 h=from:subject:message-id; bh=EMH0X0HTib1UX3Otm09kiPNf20g/W4+kYm63C8IWVcY=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnNgHpBa7ieN2E5O71x+ZGbp3fgVAH6TSM2fd1Y
 gpyu3rQluCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZzYB6QAKCRDJC4p8Y4ZY
 plDgEACOmbq72GjWG5ptshz7EOTjXkDEdfJQ5J5oeTSiTuXlYJepB3GJ2LWSJ+V5oiZaBLSHbiP
 lcuqi8iATzjOi7K6FyNhCcjt2u9GhjNkHhMx/GY/6PmHDDH7x+bEl1oXrz3aCkuPvKIbkqSkYmM
 UEHvjsi99ZPGVUOMzTJiHURq9/6jorldswAljlo5Hic5JExAdqHb3AFpbsezLR4IsVcJV7wpAlB
 pCc6N7EvZTQHUtvAAa8+yfSSm1dYAWFRKsoGTIgQbGU2ffq9HiD4Iq067CLZ4IsWe3g/bMltF1x
 XLWN4FKpQyZ11GdrsHsRJcEy8wPOv3xLeXstRNaouadIpjcAA+6QBbvlPWJHZXb5ec4Tmx/1ojt
 YRbTevqFzdycb9z78K6DCtjQNBhO0Bm8iZpYwELfGG9fclmv0Rtcy6BwkGhggJTG+89WxN/mNcT
 1ES+jY9anrdC78ciDRknp6Ur9Wz/CjFfnEoTRkSlwMIyMM/IFt7nyRszLd5uJ0e4mftOmfNauSs
 bWVcIsRrtyAkAQ2m1yb35KGJUmSjR36O6VxmEVugWGhGgbnvlcUS0oRbPFyj9j/jWAEWvZDmGIw
 QexMr/qgWlGKFehzqTx2akgjhyj1nk8aQ1NGEPRlolOfOlYuWtHkuLDh8omdnGVywdGLDHWX5sL
 hw2bX9I8cneyY8Q==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap01: Convert to new API
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
Changes in v2:
- Fixed metadata alignment
- Link to v1: https://lore.kernel.org/r/20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com
---
 testcases/kernel/syscalls/mmap/mmap01.c | 245 ++++++++++++--------------------
 1 file changed, 90 insertions(+), 155 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..07fc4dc0239525913934d8db4651d3fb2aca47e8 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -1,57 +1,30 @@
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
+ * Verify that, mmap() succeeds when used to map a file where size of the
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
 
 static char *addr;
 static char *dummy;
@@ -60,135 +33,97 @@ static size_t file_sz;
 static int fildes;
 static char cmd_buffer[BUFSIZ];
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
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
+	addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
+		    MAP_FILE | MAP_SHARED, fildes, 0);
+
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
+		return;
+	}
+
+	/*
+	 * Check if mapped memory area beyond EOF are
+	 * zeros and changes beyond EOF are not written
+	 * to file.
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
+	 * Synchronize the mapped memory region
+	 * with the file.
+	 */
+	if (msync(addr, page_sz, MS_SYNC) != 0) {
+		tst_res(TFAIL | TERRNO, "failed to synchronize mapped file");
+		return;
+	}
+
+	/*
+	 * Now, search for the pattern 'XYZ' in the temporary file.
+	 * The pattern should not be found and the return value should be 1.
+	 */
+	if (system(cmd_buffer) != 0) {
+		tst_res(TPASS, "Functionality of mmap() successful");
+	} else {
+		tst_res(TFAIL, "Specified pattern found in file");
+		return;
+	}
+
+	/*
+	 * Clean up things in case we are looping
+	 * Unmap the mapped memory
+	 */
+	if (munmap(addr, page_sz) != 0) {
+		tst_res(TFAIL | TERRNO, "munmap failed");
+		return;
 	}
+}
 
-	cleanup();
-	tst_exit();
+static void cleanup(void)
+{
+	if (dummy)
+		free(dummy);
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
 }
 
 static void setup(void)
 {
 	struct stat stat_buf;
-	char Path_name[PATH_MAX];
 	char write_buf[] = "hello world\n";
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get the path of temporary file to be created */
-	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "getcwd failed to get current working directory");
-	}
-
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
+	dummy = SAFE_CALLOC(page_sz, sizeof(char));
 
 	/* Create the command which will be executed in the test */
-	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
+	snprintf(cmd_buffer, sizeof(cmd_buffer),
+		 "grep XYZ %s > /dev/null", TEMPFILE);
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
+};

---
base-commit: 865be36ffce81e795854d0bdd1cda17b4d5fd37d
change-id: 20241113-convert_mmap01-db208e002801

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
