Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D99DC02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 22:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736893649; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fYd4cFWT8/NF8taJ+uk+GTOjmTBNtz9coIsX2+dpkNA=;
 b=arFG988BCvFKhdu8c7oTydv8kIlY1DYAulsx3HkFokqPUSULNS8FNn5GyBwfJiX9V3+Xd
 c4ZN+RlnMj+lME+JA9HZqipvzdCiPBATGDWfhxyF149NbacIOje2t4YdMdG8pg7RSCV/t1I
 mmToKB+UmL/RX9iqoVEXYPIlAlD6+Dk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 007D43C7B30
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 23:27:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AE323C7B5D
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:26:47 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DEEC1BC4B6E
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:26:47 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso11681936a12.3
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736893606; x=1737498406;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9i3BaGRr0IAPNfvl9OsKLUYr2QzIsmikTOsNqC5SJ4=;
 b=FDI9w1qjSmI4y4tqRnYS9eKP5X8/MY3ZlIUy/8pJvU/3+93E0PQFkU1XyqCxcThHmD
 KNSs1ezUxLh9VZLKKs6z8pS1bWfzT3vPBlhEaDwfTWRruOzWsCD3gIQUA7JRVtGgO0m7
 2Vmpuz5Q5uXwmTYw8eNyY6jbrHgMQltauTCPGCPKussssH8H/Db98VjulY/g7/W4hj+S
 i+oRMjDk4e3Kv+vZlcxGrE1oJ/dw+tVI234mb5tylflmOBBx4vSbnnCwzqLXpku42X+f
 ovn/fhewjNx6AFYT0YEaeOV6o+uCPPsYKe4iK708U3UkHdH5qyBcx/rNzQNsaFfs2kYd
 uUfQ==
X-Gm-Message-State: AOJu0YyX5jmDCWPRpEJCKOP5xsg79fn0u/TrF4K4u7mcnlVfGHnwx9Aa
 Qt2eCpXjHSnEWXQGstZWaZKOblwP1URyqMI53VSSwABNTx1F4BlBBEh1/CvhnTE6NdvMUgo8CpZ
 P
X-Gm-Gg: ASbGnctexdqkAVIySjdPkBxnHkYoIY+DFHgz5UW2KNXKxKw9uvGyMP8cq8zcwHr5qz5
 fbo1jFypzmRHgkEZ0JnTV8fzWSOVjvVsYmpsk4T8V6/EO/p3zCoAu/ObP9NIrPcYkny7Yyp5Fke
 4qSwaW9J/p1mvSS3UJnVnIKcQye5MrJWf0BOJrfyfuzZq0lJQjvNNc87OjiqxKcQ9nQtIzK72ll
 5W4xcK7ZYhyZONXoVy/p7Vu8bcOKj6s5VLqb/YU8g==
X-Google-Smtp-Source: AGHT+IFHUeTz54cFbjd4JfwoN+T6u/DQeUdIk9cD97xFrdJSTXeojv1YfD74kOz3KFBoJ35ENN7lDw==
X-Received: by 2002:a17:907:3f26:b0:ab2:da92:d0bc with SMTP id
 a640c23a62f3a-ab2da92d9cemr1999117266b.3.1736893606418; 
 Tue, 14 Jan 2025 14:26:46 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f882756603sm4724280eaf.29.2025.01.14.14.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 14:26:44 -0800 (PST)
Date: Tue, 14 Jan 2025 19:26:31 -0300
MIME-Version: 1.0
Message-Id: <20250114-conversions-v1-1-7869a9f786d0@suse.com>
References: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
In-Reply-To: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6209; i=rbm@suse.com;
 h=from:subject:message-id; bh=kCLwRSKkJckfs5DBmDwWjoF+WeJxQFO8oY5+ZUQClU0=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhuSb17CahsMoLUVZkkFENHGlIDhNwIGF8zF5+
 Ovsv3rJmlyJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4bkmwAKCRDJC4p8Y4ZY
 pjYaD/9G+AYHB6SX8zHB+Agd/jr8rioQ90kEAxrwmfhqhLZqPHcYOAFxd0165vEO878dg6/tt3g
 oqM6LRcnORhcXo4baChVznmpq69vKAtlDxeB2JUM3KVcait3XZCIBEFeaDSmBhAg91teOyTYmwB
 AexV73p4KkKfDNGxoQCA4DyZLCVXqYGpaE4Y2ew7KvWCZAXeYtD3QS/aV9ND499K0teZZSS1ZD7
 Px6/SDnzcBela5+FgK6DUkowp51/t0LypR8HuYKhkASu9CNo4FbWBL20kJ7qbkGdM0FVlaBOcoJ
 IFCq2AXDrcxeffkBuqj/te2BC4EQ5JuOe5BT6oAMJP9O7k5Xgapm3nbAG6S1AlTReNRecN14ftq
 D582HXyr+xRy8hoGjrwhHvhexaqz9HgxuNJLA9eo05bCJOFMPY2H/DU251AugtYW0Zt6W7jiMoj
 nWGZxSCMxuFCuxVT7QF7CxW7NQxWCWop5F/rBAuqEtjhA982sErcu5DZWhmytayag7mGESxnUte
 IGydZ2YqDpZAV9tmfwVrQD7HRDT2Cd1CWQL7dx0sxBGui4y9U/ll5B84l88swg+Agf/4ixetWQU
 PZSKd2COdq+uKaZ3WRLRt0WCXt/HMji9mPq67t+jZOeWn59v5SPOjaWtzzR2tU5WndY6pvc6fTb
 Fo4SIHg8p1YB9mQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] mmap001: Convert to new API
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

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap001.c | 206 ++++++++-----------------------
 1 file changed, 49 insertions(+), 157 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap001.c b/testcases/kernel/syscalls/mmap/mmap001.c
index dabb7d1e4998b1097e179abe23555926f5841117..bc9b4155e8b53f942ef694fdf3187c0e544a97cd 100644
--- a/testcases/kernel/syscalls/mmap/mmap001.c
+++ b/testcases/kernel/syscalls/mmap/mmap001.c
@@ -1,183 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2000 Juan Quintela <quintela@fi.udc.es>
  *                    Aaron Laffin <alaffin@sgi.com>
+ * Copyright (c) 2025 Linux Test Project
+ */
+
+/*\
+ * [Description]
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- *
- * mmap001.c - Tests mmapping a big file and writing it once
+ * Tests mmapping a big file and writing it once
  */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-char *TCID = "mmap001";
-int TST_TOTAL = 5;
-static char *filename = NULL;
-static int m_opt = 0;
+static int fd = -1;
+static int m_opt = 1000;
 static char *m_copt;
 
-static void cleanup(void)
-{
-	free(filename);
-
-	tst_rmdir();
-}
-
 static void setup(void)
 {
-	char buf[1024];
-	/*
-	 * setup a default signal hander and a
-	 * temporary working directory.
-	 */
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	snprintf(buf, 1024, "testfile.%d", getpid());
-
-	if ((filename = strdup(buf)) == NULL) {
-		tst_brkm(TBROK | TERRNO, cleanup, "strdup failed");
-	}
-
-}
-
-static void help(void)
-{
-	printf("  -m x    size of mmap in pages (default 1000)\n");
+	if (tst_parse_int(m_copt, &m_opt, 1, INT_MAX))
+		tst_brk(TBROK, "Invalid size of mmap '%s'", m_copt);
 }
 
-/*
- * add the -m option whose parameter is the
- * pages that should be mapped.
- */
-option_t options[] = {
-	{"m:", &m_opt, &m_copt},
-	{NULL, NULL, NULL}
-};
-
-int main(int argc, char *argv[])
+static void run(void)
 {
 	char *array;
-	int lc;
 	unsigned int i;
-	int fd;
 	unsigned int pages, memsize;
 
-	tst_parse_opts(argc, argv, options, help);
-
-	if (m_opt) {
-		memsize = pages = atoi(m_copt);
-
-		if (memsize < 1) {
-			tst_brkm(TBROK, cleanup, "Invalid arg for -m: %s",
-				 m_copt);
-		}
-
-		memsize *= getpagesize();	/* N PAGES */
-
-	} else {
-		/*
-		 * default size 1000 pages;
-		 */
-		memsize = pages = 1000;
-		memsize *= getpagesize();
-	}
-
-	tst_resm(TINFO, "mmap()ing file of %u pages or %u bytes", pages,
-		 memsize);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		fd = open(filename, O_RDWR | O_CREAT, 0666);
-		if ((fd == -1))
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "opening %s failed", filename);
-
-		if (lseek(fd, memsize, SEEK_SET) != memsize) {
-			TEST_ERRNO = errno;
-			close(fd);
-			tst_brkm(TBROK | TTERRNO, cleanup, "lseek failed");
-		}
+	memsize = m_opt;
+	pages = m_opt;
+	memsize *= getpagesize();
 
-		if (write(fd, "\0", 1) != 1) {
-			TEST_ERRNO = errno;
-			close(fd);
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "writing to %s failed", filename);
-		}
+	tst_res(TINFO, "mmap()ing file of %u pages or %u bytes", pages,
+		memsize);
 
-		array = mmap(0, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
-		if (array == MAP_FAILED) {
-			TEST_ERRNO = errno;
-			close(fd);
-			tst_brkm(TBROK | TTERRNO, cleanup,
-				 "mmapping %s failed", filename);
-		} else {
-			tst_resm(TPASS, "mmap() completed successfully.");
-		}
+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT);
+	SAFE_LSEEK(fd, memsize, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\0", 1);
 
-		tst_resm(TINFO, "touching mmaped memory");
+	array = SAFE_MMAP(NULL, memsize, PROT_WRITE, MAP_SHARED, fd, 0);
 
-		for (i = 0; i < memsize; i++) {
-			array[i] = (char)i;
-		}
+	tst_res(TINFO, "touching mmaped memory");
+	for (i = 0; i < memsize; i++)
+		array[i] = (char)i;
 
-		/*
-		 * seems that if the map area was bad, we'd get SEGV,
-		 * hence we can indicate a PASS.
-		 */
-		tst_resm(TPASS,
-			 "we're still here, mmaped area must be good");
-
-		TEST(msync(array, memsize, MS_SYNC));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "synchronizing mmapped page failed");
-		} else {
-			tst_resm(TPASS,
-				 "synchronizing mmapped page passed");
-		}
-
-		TEST(munmap(array, memsize));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO,
-				 "munmapping %s failed", filename);
-		} else {
-			tst_resm(TPASS, "munmapping %s successful", filename);
-		}
+	/*
+	 * Seems that if the map area was bad, we'd get SEGV,
+	 * hence we can indicate a PASS.
+	 */
+	tst_res(TPASS, "we're still here, mmaped area must be good");
 
-		close(fd);
-		unlink(filename);
+	SAFE_MSYNC(array, memsize, MS_SYNC);
+	SAFE_MUNMAP(array, memsize);
+}
 
-	}
-	cleanup();
-	tst_exit();
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.options =
+		(struct tst_option[]){
+			{ "m:", &m_copt,
+			  "Size of mmap in pages (default 1000)" },
+			{},
+		},
+};

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
