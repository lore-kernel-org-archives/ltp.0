Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D63D149E7
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1729885063; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=T2LFLMOS4u/52+WeNKGzzobIs1Ek2i8ea0Vs1nrCAEo=;
 b=kMSJUx6ocH5Ls3MtdeuEaZZ6cLDAooFDaVU7dfqroZU9He70YzkuU7XqFVPTh9J3lLspi
 FmBQ7e7fsvHH0OatpE8yfavXWXfQu2bCpzzlN4iZ8iC9qqoyC0MmU+Rda5TkluVXjSOVNOf
 uXiG2DQFtTaWUuiwVn67lDG+F0yGhDk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 616593C7383
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 21:37:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6111C3C7100
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 21:37:21 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B7D61C00820
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 21:37:20 +0200 (CEST)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539e13375d3so2931603e87.3
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729885040; x=1730489840; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e1jNodPhg2kAUi3shTtNBo7Ah+VAeX4FG2TUqkAbU9k=;
 b=DGZiO0K5ff11/OpFd+TjIfA0dp7y/qnAbMgyUSkgrWiu0Kv9/9IM7Lt7qbhu6wsjnv
 asWFVDRkNr/Cj5EvuffV+nrSzeD0KGYoMu3e5hmRaNH49R/cD6hAREQHJmX9tXz7uiY9
 0G+O7rRvC13lIFNnQYdFbqlaN2RYYgJNKxrI9Oop51oSUZyHPNSDND4V8NXCcKU6bPJk
 Wie6IWn9vv35b2kRzN+0xA9TG/2a+euQIyeKzHtJMoR4LFnKdcbEiYWeF5qP6sZEl/3S
 /IRAr0+MBEDaJwwGBHPQXQ5H9ej14Uj/UuZ3xXFw8HYkWFfH5hT5Depy4C8N5W773+Ag
 pjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729885040; x=1730489840;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1jNodPhg2kAUi3shTtNBo7Ah+VAeX4FG2TUqkAbU9k=;
 b=P1sIXbGNKEq3QtGkKS1pucFNBCwQQHonsUgGO+ZGs5ZSCWrxxuETBftMFTAVLBVU1+
 MU+Ooe0rt8EeI54nlrXEDzhaVDRycliBB99PTewq5ullZCLDvfarhqKJ2GLRkRPBdkVi
 YPnRNmHZ2cl4nfrvdiIpgiC2VJ1En6H0cZvtDmQ54vMNmHE77Z411XxXoL2e8FE0vblp
 LPVbCGLqphzq2kiiSnx9TxcsMErRMjmvRfvhqJ2p9y7qA//dZ+XesdhdLgqoJpJa6Iek
 i8czxkoz4Flfsdj/QV4gl1M15LITaNSk28bE2Fny0yx7hUvN/wTBLAKrf+7QMyzAW545
 OXMQ==
X-Gm-Message-State: AOJu0Yzy9drWvzKtkHZ33XKt/5iA6GU+35wxfIcyda80rLRLny17MTTG
 om3N+jipAhfia69GlYd7wtNmHUmmx2DD1hB1NiR1+eJ1E2Av04Q6rWvH9Ol8R1NwXFoaJ+8KiPF
 T
X-Google-Smtp-Source: AGHT+IHt08hJ6o551j+yOUpM+HFEoIbHIdDRfJ8MCVsCz2IKZrkM1pFWIfxFL/i7/0Q2t0Ho8C1mOQ==
X-Received: by 2002:a05:6512:b8d:b0:539:f7c1:5feb with SMTP id
 2adb3069b0e04-53b34a18f19mr165817e87.39.1729885039692; 
 Fri, 25 Oct 2024 12:37:19 -0700 (PDT)
Received: from localhost ([179.228.213.26]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf4418esm12889905ad.15.2024.10.25.12.37.18
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 12:37:19 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:37:14 -0300
MIME-Version: 1.0
Message-Id: <20241025-convert_mmap14-v1-1-6ba672485028@suse.com>
X-B4-Tracking: v=1; b=H4sIAGnzG2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNT3eT8vLLUopL43NzEAkMTXUvjJINEIxNzcxPDVCWgpoKi1LTMCrC
 B0bG1tQBkdw5TYAAAAA==
X-Change-ID: 20241025-convert_mmap14-93b0a247741e
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4584; i=rbm@suse.com;
 h=from:subject:message-id; bh=V9heUIxcStpm7vEu/2BN4SOS2cX0NXyZPTW6D3Ugdbw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnG/NtruuytBAUWo4s9zKLNBrOV/7M2yoOmA3Eh
 pwVfF/UslCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZxvzbQAKCRDJC4p8Y4ZY
 pgnhD/4g/kXah8oBqIr7jgOnwSangIezBUcM0C6kdguAGXRR4piOyfsOMMTsPmrj6v59T/29Iwj
 QOm/esPqGOiI1uQxXfldit7I5Kw/PIX/pi7VRFUC16mIuikmvr66zBHbjsvnh8iY4gG+6fXe/X9
 SNXNXMPyh6maMxkdTjtG0kUEaFDY+W+onHNuPkNULmR3en98gYIbOVP7AkpkHBUAXJQqY3d5WaP
 a6FVIFzKIE+/qEd5epaY2t86x6StdBJhve/MCYI7zTlSgoimE65cKQ4KizG/gYAlK3MaZdzlIY5
 1EhaDTC2/3iZ3vV2wZ4SXs9LZQCPCTL5qi3nITq/+Qeo/qQzEPiZxMK8+HXPbJK7s775GscntFt
 HNLDOrp2XIsYTwJJQo5EpjbGEDu4VOycqXLBsivA/22dcjkHXHxDFAbZMNjh1o9e+CId3niaDZq
 6Z4DeCaox6z8tWpNhSUBf3/ySItO8wC2wnVGCbWP5n/7/U1XzLnTEBSjm13zbLMeGfbr7zDR/yb
 ZBcvkOjHnPSepzvLKO+9Ldf27m2Khu67F4W0M/qMvxm4vLs0vbTzK2SvgEvawCxP8y94sBDO80P
 JAk4Pmjj3iHO1khZ2ny2Sd7PGPjZI1vYk4sMGilGe4LxY2rGyzgpXbMlyLSGbJ5ogb8nEAk+5WH
 Cz0WA74pHOvYAlw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap14: Convert to new API
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

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap14.c | 97 ++++++++++-----------------------
 1 file changed, 30 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index 31632601bbed85b60f1dfee7044bf961b1f2a756..63a2f9e4cab2f7ab12b1ad982bc690f9fabcc252 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -1,22 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
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
  */
 
-/*
+/*\
+ * [Description]
+ *
  * Test Description:
  *  Verify MAP_LOCKED works fine.
  *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
@@ -28,65 +18,45 @@
 #include <stdio.h>
 #include <sys/mman.h>
 
-#include "test.h"
+#include "tst_test.h"
 
 #define TEMPFILE        "mmapfile"
 #define MMAPSIZE        (1UL<<20)
 #define LINELEN         256
 
-char *TCID = "mmap14";
-int TST_TOTAL = 1;
-
 static char *addr;
 
 static void getvmlck(unsigned int *lock_sz);
-static void setup(void);
-static void cleanup(void);
 
-int main(int argc, char *argv[])
+static void run(unsigned int n)
 {
-	int lc;
 	unsigned int sz_before;
 	unsigned int sz_after;
 	unsigned int sz_ch;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		getvmlck(&sz_before);
+	getvmlck(&sz_before);
 
-		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
-			    -1, 0);
+	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
+			-1, 0);
 
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
+	if (addr == MAP_FAILED)
+		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
 
-		getvmlck(&sz_after);
+	getvmlck(&sz_after);
 
-		sz_ch = sz_after - sz_before;
-		if (sz_ch == MMAPSIZE / 1024) {
-			tst_resm(TPASS, "Functionality of mmap() "
-					"successful");
-		} else {
-			tst_resm(TFAIL, "Expected %luK locked, "
-					"get %uK locked",
-					MMAPSIZE / 1024, sz_ch);
-		}
-
-		if (munmap(addr, MMAPSIZE) != 0)
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
+	sz_ch = sz_after - sz_before;
+	if (sz_ch == MMAPSIZE / 1024) {
+		tst_res(TPASS, "Functionality of mmap() "
+				"successful");
+	} else {
+		tst_res(TFAIL, "Expected %luK locked, "
+				"get %uK locked",
+				MMAPSIZE / 1024, sz_ch);
 	}
 
-	cleanup();
-	tst_exit();
+	if (munmap(addr, MMAPSIZE) != 0)
+		tst_res(TFAIL | TERRNO, "munmap failed");
 }
 
 void getvmlck(unsigned int *lock_sz)
@@ -97,7 +67,7 @@ void getvmlck(unsigned int *lock_sz)
 
 	fstatus = fopen("/proc/self/status", "r");
 	if (fstatus == NULL)
-		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
+		tst_res(TFAIL | TERRNO, "Open dev status failed");
 
 	while (fgets(line, LINELEN, fstatus) != NULL)
 		if (strstr(line, "VmLck") != NULL)
@@ -105,20 +75,13 @@ void getvmlck(unsigned int *lock_sz)
 
 	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
 	if (ret != 1)
-		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
+		tst_res(TFAIL | TERRNO, "Get lock size failed");
 
 	fclose(fstatus);
 }
 
-static void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.needs_root = 1,
+	.test = run,
+	.tcnt = 1,
+};

---
base-commit: 34e6dd2d233abcebae435d34d793b6a49d08c190
change-id: 20241025-convert_mmap14-93b0a247741e

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
