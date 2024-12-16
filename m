Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFADBE77180
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734380866; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=d2EEd1TjPVes/jV6F98I8yFl8BJxhFq1eOEv316P0ks=;
 b=GEsMHBtby8JRXJGvXvXniI1DJz/33nW/bmjzSEgO12uP9YlLEESQefgXjVgNRiGblMgSv
 /ESjk/k8xSNS9kodfJoDbYe64pfoKWP6sf9qSV+8qRI8Ym0X0I70uMdZuLxA340t8aP9RHb
 YBwXHguS5LpFk/fBiax6cfICEfs9/zo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49A93EC525
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 21:27:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF7F43EC4E4
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 21:27:25 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E5C961BD6733
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 21:27:24 +0100 (CET)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so2300408f8f.1
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 12:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734380844; x=1734985644; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TFGREVig3reQgnRPUscrzoWEvKQamX6854bCQ/Gwt1I=;
 b=WcCdgcV3TH8QiXTTrLjOrdreTck8WlDK6Vq6USCEFTfXmsGHMHz/jmT17s9GDYIZLA
 ZuogkM90CP7Ys5U4uSKA3SX+k/TsHz4wqADfvp1j83gOmpW7p+u7kh0x7aOt02z+0Y+O
 vfCrn37Yk4UprGfQm0EDrH2iHNdF2oNbaid8cVuFFJnQuycl0d7Hj+co5kZpdXDy6eXs
 hMyRuJk41/Po5mLnfWfL8BCaqNSu4k7oep/cecFh/s+fdupps8B6GmzIFRejF8MFeXLX
 mlJ09tmz1L+zrA5SEp3P6MTr2I+DilR6d6trf/Eu4HgyOMbbyOc0dG4tgQZZHbSx0R0H
 Up8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734380844; x=1734985644;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TFGREVig3reQgnRPUscrzoWEvKQamX6854bCQ/Gwt1I=;
 b=IgghH9hG+qz29nu1FRXcfweSkHsThU333AbbZwXGKNCiX7lppivtR9gAnfLVcNzA2t
 xhjtkd9fGAD/fsNjw8REZHEtqfpyx+uxrqIN2/WnYEy64M8aWC907qgWBkF33qA+blMM
 SKhVQj+Z/zXD7Zm2zKpx0nRi5DPEgAqXweiAi3tYy3ZE4FNKgKAd6lYUxogRnHgeLxxD
 Obe57SZvo5k5c3O3vGBXw7vjkLUPV0R2hVLxYLpgEzJWwheuQupEi44Y25U7ljo7+TXU
 XghDCP+G2s8oGulWIpLOZTSrzAOQYB+GcZzJrK3c+rzEpiPLbkjFTe4xAVmbOqsNeP4n
 1elA==
X-Gm-Message-State: AOJu0YwTyYP99JgAo+X5XgWTYUw7AiVcdxicblVodEFS6bOxY+haYpwT
 ulhwcAkQWXcjJEXz99VZSNYmBSwMyo1V4RXWIdrQ+R0vM3KyIGl/AS1mVIkVJhY6/FopxXujSUv
 r
X-Gm-Gg: ASbGncvQLrkr1o8rnLoZXK46nR4w1sr0IWIFWq9SxvnOyPzZLCRDoK2jUCTUP4/2N09
 3p6WUiRdcyAe9k//RVOd9k6MLPUNMJG6mBrX6pqGCV5k+QZrdrxQHVpT0vliWpL8jrO9/AqvI6S
 ICsST+hPBTIpCWBv+zhtEi/ftX88aBZ2d4WyCT3S8W93wANJ/1YKMJf7TJf1JiTLfjKv5iFFHY+
 8edbEkTco4hSOZdT2KiMIkSf2Z4gw4a+FUhPvG9Qbc=
X-Google-Smtp-Source: AGHT+IHRzlJF+fnUu5Pab1oIi4Z0UeiSPc7wr1P+cgni8F8o3q6J++LJ0uOjV1F9ln30agmFTfcEOg==
X-Received: by 2002:a05:6000:1acd:b0:388:cacf:24bc with SMTP id
 ffacd0b85a97d-388da5b5d42mr714018f8f.54.1734380843989; 
 Mon, 16 Dec 2024 12:27:23 -0800 (PST)
Received: from localhost ([177.95.19.124]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918badfaasm5192479b3a.153.2024.12.16.12.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 12:27:23 -0800 (PST)
Date: Mon, 16 Dec 2024 17:27:19 -0300
MIME-Version: 1.0
Message-Id: <20241216-convert_mmap01-v7-1-db7d27af57d7@suse.com>
X-B4-Tracking: v=1; b=H4sIACaNYGcC/33OTQ6CMBCG4auQrq3pD7TFlfcwxrRlkC6gpMVGQ
 7i7hRXR6PKb5HkzM4oQHER0KmYUILno/JCHPBTIdnq4A3ZN3ogRVlJGCbZ+SBCmW9/rkVAsFGs
 lNWAq1aCMxgCte27ByzXvzsXJh9fWT+V6/ZlKJabYMs6VZlYTSc/xEeFofY/WUqr2mn3pKmuWv
 6gbqYxR/EOL/1pk3VAljFCWt6Te6WVZ3kQQZjEnAQAA
X-Change-ID: 20241210-convert_mmap01-682f71beb58d
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10352; i=rbm@suse.com;
 h=from:subject:message-id; bh=+Ihmri27xtaL+3hdZQVTd52vIxJ5OD4evJjLjF0VgTA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnYI0oaIJECOm05uqv4/zOC5Pzui81aq3TqFsa+
 aIgiD9eD/uJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ2CNKAAKCRDJC4p8Y4ZY
 phoXD/452wwku5CJGYmr5xatPayi22Gauc5Cu2z0sSHxFlXjEr5yidVli8VoliwYQyzw37fFcgf
 siqo3r84CGUgPVJ7SRe7kktneEDNy7AbKTppiqjbvdy1agQFrmHGMXoXR70Gek8imlEQbCdMT0x
 TKZC3nPfdUMI1IXH1r1rv829mPNQpAWzD8xH2AXKMhyQ4cjoczneXca3ao4N+fXLyqkkuHRMBp8
 +7/iWJKBdN2kqyvcO8UEtdL+cOIwEftHEHBxvtsXK91Mpi6KcMvy0LMl29w16aOTaqux3MJcGUQ
 SCxFqDDJtP2WAz16VE+CeAVRfIhygQwSCW0iVoryzhcxkkBbCTjAVJl8TqyFqUQXjT6AxWYq1+e
 bYWAblkgn9295XSAtgdwFduD8yKjTjoWNSsVmmPtMkHr3oFgNpP3Qd5t/XBm/rqgiwfNousqgEO
 jku1khMDXnbiDg87RjZUHMwp8iIn3XoNaFJPhkVseTZ1pRUMLEyusZuUBy9Wo5WavVfXNVzHMhV
 6l5XpdFSgcA++xXQywpxKVGfTd7zZGc2feda0KHFEZZISiUkuiYYKuHbxSD/TVgfeciQ2W6CJAu
 AI5+5DXH0ax22bxiUMfSIJ+LAe/Rn/noA9xviCB0A8xde6/VcjLzq70xAMLl8E8lqKHsbe7Jz3r
 NirX6WPTM6Q4p8w==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] mmap01: Convert to new API
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Changes in v7:
- Use SAFE_MSYNC as suggested by Petr Vorel
- Small metadata alignment fix
- Get rid of unused variable 'pid'
- Link to v6: https://lore.kernel.org/r/20241212-convert_mmap01-v6-1-d186b68c3f09@suse.com

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
 testcases/kernel/syscalls/mmap/mmap01.c | 259 +++++++++++++-------------------
 1 file changed, 102 insertions(+), 157 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..0fb2c8cf3ebeea538c02ca6f89002c7a7501825b 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -1,194 +1,139 @@
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
+ * filled with zero. The changes beyond the end of file should not get
+ * written to the file.
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
+		tst_res(TPASS, "Specified pattern not found in file");
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
-
-	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
+static void run(void)
+{
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
+	SAFE_MSYNC(addr, page_sz, MS_SYNC);
+
+	/*
+	 * Now, search for the pattern 'XYZ' in the temporary file.
+	 * The pattern should not be found and the return value should be 1.
+	 */
+	if (!SAFE_FORK()) {
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
+	dummy = SAFE_CALLOC(page_sz, 1);
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
