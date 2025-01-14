Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370E0E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736893702; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fFxwe9aKsko9u9U/VCszOiPJjO6Afx+Tc9jxA+8xtWI=;
 b=T+wuQj4MxZHPytV+/cBwCjlRc8YPYvgOazrYFpmDXzYe2t0PI+8xoIJhoyZWwDrt58GXM
 wsLd00OxTC4WzgtY8GMDH86N3vXzoWGi/t4GT9x27IZwqFIDgLNW/ZXC+S5GgIl84Ou4QYs
 9tyrqXQEu72T0zW+Wy6Yq+yOfsO6fJk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D5AF3C7B5B
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 23:28:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C46C73C7B5C
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:27:01 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85539101AF20
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:27:00 +0100 (CET)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so987440166b.1
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:27:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736893619; x=1737498419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vft6rbST+ikO96MWzBgfSzVDzklvPVU5bfiBw5Tzblg=;
 b=qIhWwJgmFRYg/UDIkHYyTtzVw0/EpZ5E3RvcQ0Sa191ZPs7eutM012xCioB71Tcw0d
 x3T8Shk7DxVGWJxifDwewVVl6hYD236vcw4IbZZN1ud8Zyz2iDUJeVWf0iWZ2jW51NnB
 QKcqE1Xt+ayjXyqdb89BnU5hbDwX+fkVRTQVlv68Pq5r8gLriCfal/x74lttCt/UhGmV
 xdMlPvxe1C8zJi+/+K2BoqhtfNOtGOAxjtCVT2FbqUBPYUnbl8yy4fosLY83Cpo0w1us
 8nkx1IXlbymngPjdjuwenNmxWAiOw73P3v+9FwHtjFXV7ydRPfL2vwW7MCgpLTcY96JV
 QgOg==
X-Gm-Message-State: AOJu0Yw1NWC21H4ZlgeaE1WWMnIIRCzEYuU/xCjbIlsiSDmKta0Sq7pK
 Cy8onBjq/Iwv586zuLiKsC9JfpnEiBqtcQI7vZswxqyNPblTdv4TzXsOp7hmDOooRKKX4Ove9G0
 k
X-Gm-Gg: ASbGncvpiwhcpQnCGxB6e+qomOpWgbBvWXOlc9K5qD0JrGpy41XK1Ht7/m9BLlxbQBo
 DtmbjMBlqEkpbQNaQdCMJHK6/PO82An5it/lFuE4bjRmxmIhA/tNR4tUrWFWrMXOavWJI/HLIBP
 kQObklr2uOvCxOOr3yLDyPjyFuBOtoNFFF+12r3yG/52EWrLEd49Wq/Sgf+USjO/jgvRaNXc8hj
 HnOPlW76H47z8k6mmKVqOuYYGgcM1jNONNgI21qMA==
X-Google-Smtp-Source: AGHT+IHiK81qbf+qIwWtlgOxDWqSGRM7DzaAu1lLhoqPQoUaDLElXWaIPNZqM+TO8F5799IxD14bFg==
X-Received: by 2002:a17:907:3f15:b0:aab:f8e8:53ce with SMTP id
 a640c23a62f3a-ab2ab67658bmr2338058066b.11.1736893619164; 
 Tue, 14 Jan 2025 14:26:59 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f8826425cdsm4655406eaf.14.2025.01.14.14.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 14:26:56 -0800 (PST)
Date: Tue, 14 Jan 2025 19:26:33 -0300
MIME-Version: 1.0
Message-Id: <20250114-conversions-v1-3-7869a9f786d0@suse.com>
References: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
In-Reply-To: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7191; i=rbm@suse.com;
 h=from:subject:message-id; bh=d9LkgF1v4VJUoi4/fYIND5az/m3T2LFfb+IQ3uP62Ko=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhuScsm3pq2xmIKIXPo9dnuz5XcFNhkX0t7WAD
 nwqYWbd7RiJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4bknAAKCRDJC4p8Y4ZY
 pujfD/9fd7a+qt2g+4mRYMIwfxk9MCbuMdUFKAx+DRGWKquvAJzTtQ0zckL3USEf0pqHD4DwgAW
 JgZCJ5HJ/stSLd4ClVWXEkd7daOL5La1XlYB9rADFtiSJ8oLMDf53210aBSKHWimTHH1R00lOxe
 Po3HKUd0QyTCxamnqb5yYvbx1WM7CNLzm4mfZNGiwlNjJWa1dPEpCgGshPq/VOXiF/pGOW/9YWH
 c8IxTSJH8jq/x1zsZWqucBReamfDuqMG8OBI5p9IECct614inHSVW9cZkKhSyn4kbusLH9ED5U7
 idPwZmY4Ln4IQM34BHIsQJgj1flhUIPe8jt5XFM7o3SqI01ZlB+PJoqBoFADilDYADLCmc7h9Vj
 8jG7xJNlnOvdLUjZRHMAlppqgyyWhSW/7u3prSvRXd1yxmePtczNO2aHEmNwfF2IWT1X2LGQF6e
 Z+71UZ1uw/nw2Ic2gdaj32HuBPaL68bdxsCwrQQsEdaBHSplNC0wmCPOReTL9pVPd7M7aXKhJQF
 JpOmP/Eo9SszQpvAdLblgyIn0G6fzKHj4SVoNyeXc+GfhBvhL3DBt+Ji8vqcjeimFjr9/RMsV7U
 Uwt8AK+6/XS8vZnGtKmzCdZX1LhmtTXAzCBb8+mTgpNCYKRlpIr6Hi8zSl3fEbG25mW38CL4N8Q
 hdNO1TKkgADC6AA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] mmap10: Convert to new API
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
 testcases/kernel/syscalls/mmap/mmap10.c | 198 +++++++++++---------------------
 1 file changed, 66 insertions(+), 132 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index b844af07fd78d69c5cf5afc3039a54685c982776..3436457e7c6ca89b3dd98058bb6cc72308f8ff99 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -1,27 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * Copyright (c) 2010 Red Hat, Inc.
+ * Copyright (c) 2025 Linux Test Project
  */
 
-/*
+/*\
+ * [Description]
+ *
  * mmap/munmap /dev/zero: a common way of malloc()/free() anonymous
  * memory on Solaris.
  *
@@ -52,155 +37,104 @@
  * address range was an optimization to make the subsequent pagefault
  * times faster on RHEL5 that has been removed/changed upstream.
  */
-#include <sys/types.h>
-#include <sys/stat.h>
+
+#include "safe_macros_fn.h"
+#include "tst_test.h"
 #include <sys/wait.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <fcntl.h>
-#include "test.h"
-#include "config.h"
-
-#define SIZE (5*1024*1024)
-#define PATH_KSM "/sys/kernel/mm/ksm/"
 
-char *TCID = "mmap10";
-int TST_TOTAL = 1;
+#define SIZE (5 * 1024 * 1024)
+#define PATH_KSM "/sys/kernel/mm/ksm/"
 
-static int fd, opt_anon, opt_ksm;
+static int fd;
+static char *opt_anon, *opt_ksm;
 static long ps;
 static char *x;
 
-void setup(void);
-void cleanup(void);
-void mmapzero(void);
-void help(void);
-
-static option_t options[] = {
-	{"a", &opt_anon, NULL},
-	{"s", &opt_ksm, NULL},
-	{NULL, NULL, NULL}
-};
-
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, options, help);
-
 	if (opt_ksm) {
 		if (access(PATH_KSM, F_OK) == -1)
-			tst_brkm(TCONF, NULL,
-				 "KSM configuration is not enabled");
+			tst_brk(TCONF, "KSM configuration is not enabled");
 #ifdef HAVE_DECL_MADV_MERGEABLE
-		tst_resm(TINFO, "add to KSM regions.");
+		tst_res(TINFO, "add to KSM regions.");
 #else
-		tst_brkm(TCONF, NULL, "MADV_MERGEABLE missing in sys/mman.h");
+		tst_brk(TCONF, "MADV_MERGEABLE missing in sys/mman.h");
 #endif
 	}
+
 	if (opt_anon)
-		tst_resm(TINFO, "use anonymous pages.");
+		tst_res(TINFO, "use anonymous pages.");
 	else
-		tst_resm(TINFO, "use /dev/zero.");
+		tst_res(TINFO, "use /dev/zero.");
 
-	setup();
-
-	tst_resm(TINFO, "start tests.");
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		mmapzero();
-	}
+	ps = SAFE_SYSCONF(_SC_PAGESIZE);
+}
 
-	cleanup();
-	tst_exit();
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
 }
 
-void mmapzero(void)
+static void run(void)
 {
-	int n;
+	pid_t pid;
+
+	tst_res(TINFO, "start tests.");
 
 	if (opt_anon) {
-		x = mmap(NULL, SIZE + SIZE - ps, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		x = SAFE_MMAP(NULL, SIZE + SIZE - ps, PROT_READ | PROT_WRITE,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	} else {
-		if ((fd = open("/dev/zero", O_RDWR, 0666)) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "open");
-		x = mmap(NULL, SIZE + SIZE - ps, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE, fd, 0);
+		fd = SAFE_OPEN("/dev/zero", O_RDWR, 0666);
+		x = SAFE_MMAP(NULL, SIZE + SIZE - ps, PROT_READ | PROT_WRITE,
+			      MAP_PRIVATE, fd, 0);
 	}
-	if (x == MAP_FAILED)
-		tst_brkm(TFAIL | TERRNO, cleanup, "mmap");
 #ifdef HAVE_DECL_MADV_MERGEABLE
-	if (opt_ksm) {
+	if (opt_ksm)
 		if (madvise(x, SIZE + SIZE - ps, MADV_MERGEABLE) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "madvise");
-	}
+			tst_brk(TBROK | TERRNO, "madvise");
 #endif
 	x[SIZE] = 0;
 
-	switch (n = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		if (munmap(x + SIZE + ps, SIZE - ps - ps) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup, "munmap");
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_MUNMAP(x + SIZE + ps, SIZE - ps - ps);
 		exit(0);
-	default:
-		break;
 	}
 
-	switch (n = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		if (munmap(x + SIZE + ps, SIZE - ps - ps) == -1)
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "subsequent munmap #1");
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_MUNMAP(x + SIZE + ps, SIZE - ps - ps);
 		exit(0);
-	default:
-		switch (n = fork()) {
-		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		case 0:
-			if (munmap(x + SIZE + ps, SIZE - ps - ps) == -1)
-				tst_brkm(TFAIL | TERRNO, cleanup,
-					 "subsequent munmap #2");
+	} else {
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			SAFE_MUNMAP(x + SIZE + ps, SIZE - ps - ps);
 			exit(0);
-		default:
-			break;
 		}
-		break;
 	}
 
-	if (munmap(x, SIZE + SIZE - ps) == -1)
-		tst_resm(TFAIL | TERRNO, "munmap all");
-
-	while (waitpid(-1, &n, WUNTRACED | WCONTINUED) > 0)
-		if (WEXITSTATUS(n) != 0)
-			tst_resm(TFAIL, "child exit status is %d",
-				 WEXITSTATUS(n));
-}
-
-void cleanup(void)
-{
-}
-
-void setup(void)
-{
-	tst_require_root();
+	SAFE_MUNMAP(x, SIZE + SIZE - ps);
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
+	while (waitpid(-1, &pid, WUNTRACED | WCONTINUED) > 0)
+		if (WEXITSTATUS(pid) != 0)
+			tst_res(TFAIL, "child exit status is %d",
+				WEXITSTATUS(pid));
 
-	if ((ps = sysconf(_SC_PAGESIZE)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "sysconf(_SC_PAGESIZE)");
+	tst_res(TPASS, "mmap/munmap operations completed successfully");
 }
 
-void help(void)
-{
-	printf("  -a      Test anonymous pages\n");
-	printf("  -s      Add to KSM regions\n");
-}
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.options =
+		(struct tst_option[]){
+			{ "a", &opt_anon, "Test anonymous pages" },
+			{ "s", &opt_ksm, "Add to KSM regions" },
+			{},
+		},
+};

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
