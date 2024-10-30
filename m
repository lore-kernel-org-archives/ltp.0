Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AB7D6B6D1
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730320541; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FtrnvjHrPtv/sNbeJcZX3C4E6DCb4dRlx/G2CKBztD4=;
 b=PIW13fvjVF7mEtpT/pmnXboqL9oTP9TwDDtvDUwCO0vW1vV1nFj4tp2lkOB53vE4MfuRz
 lFrQjqHO8It1RmEnUrQbWGjYiE37HZ6aA89THPiyk0NRGuiHTouqfuG6eq8InMnzHjre4Un
 Ix2gGpSG+vFBSmSuSRbscOAwxDuDqeM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 991F23CB6E6
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 21:35:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAF7D3C60FE
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 21:35:20 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9DC3A1400199
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 21:35:19 +0100 (CET)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f0f9ee49so306234e87.1
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730320519; x=1730925319; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0FfUYclb7/l2zS3yKUxcg74BIsJDC/9iIfgII1lC/gI=;
 b=OlA5zGJ3vHZfEyejXW2zVhoUQDYQvGjNxCBFRm96j6FEB6g6TsqZkY7a77iEr8u5qc
 aWzq/J51ir13+8HfbrTfEaj3xo2VL+tjCVbtU6zRJD0apw67wtsq94NaQDmvJb9g4ehm
 EnPVdGXgdPDtvMF7NKIxN2PBg0muyG/eD4pp/FRADB8FX/cgmVEmvQDBlbrukVHYUsrA
 5K/zTdmleVQhVOnDOysgjz93UnoxWG6MfCat8uX1RiujQ98139FcEV76TaAKC+BMcVHX
 FskV6jaZGnG1BUH+Wsvs7GG/DkOGQy6QBBnHor7rtBNHXQhM3xfRp2NMt4HPztJF0B68
 ijGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730320519; x=1730925319;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0FfUYclb7/l2zS3yKUxcg74BIsJDC/9iIfgII1lC/gI=;
 b=K6kBwwTTlTkOMnkEI4hTljrwm+YNaZcLMMlKEG2lvlydQTIXdi8P+AY1OXCXlQ79uq
 xMNc1JboUPXhq29LFA7+/8RQLc9Pm//LUbVelyA1nCqH6Lq8Vv0bAuMAXSul9na64fB1
 rNvAqbxNhUiPMlnAQz2MusZpJSo9VqOXN3aXQAyc4lDzNQlvXdlRTm0ArIGFK/R8NeMj
 LqgmAcXiVFy0ZR+17E9b/YW5AfcHkCHemR61o6eI84QOg6Idcm0kC2On+zpCiLnAz9j5
 Z8/UWdEQfgSLGl4/KJgcrOL2M9DwljXgIlspGVgSr59uJ4VCCP6CVruchC4ghU48k7hK
 hUDg==
X-Gm-Message-State: AOJu0YxR8ZGLzZCTA+4FetDYVcH3bKue0fZP62YtkYCsQ6NpUWlYGe7X
 AFPnRB8NTZixjHTFhsTLhmFknzCqfBPXl4aUsP7cSSj2Rsn+B6SimgibFH2ht6WzFCrnLnjsqcw
 P
X-Google-Smtp-Source: AGHT+IG4zy2Jck22p5YLw8VxG9rXCB1Ekd9Un2UsTsNwlyHHhJBiZCklYmF9cydbex8yYoD+U1GtmQ==
X-Received: by 2002:a05:6512:15a9:b0:539:ecef:376d with SMTP id
 2adb3069b0e04-53b34a33d05mr8474497e87.54.1730320518611; 
 Wed, 30 Oct 2024 13:35:18 -0700 (PDT)
Received: from localhost ([179.228.213.26]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc089d2fsm84939735ad.309.2024.10.30.13.35.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 13:35:18 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:33:03 -0300
MIME-Version: 1.0
Message-Id: <20241030-convert_mmap14-v2-1-d0f66c5a7d18@suse.com>
X-B4-Tracking: v=1; b=H4sIAP6XImcC/3XMQQ7CIBCF4as0sxYDIy21K+9hGkNxtCyABirRN
 Nxd7N7l/5L3bZAoWkowNBtEyjbZ4GvgoQEza/8kZu+1ATlKwbFlJvhMcb05pxch2fk0cY1SKSk
 I6mmJ9LDvHbyOtWeb1hA/u5/Fb/1LZcEE6ybdKZR9y7G/pFeiowkOxlLKF8yrLmmrAAAA
X-Change-ID: 20241025-convert_mmap14-93b0a247741e
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5334; i=rbm@suse.com;
 h=from:subject:message-id; bh=Z55xyp+GJeqGh+6r0WVKCbn72Nse+q9b6JWfzpA280o=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnIpiDt1SF6K5DmE4UnRDvJ4JBJgDRqjeXl9Ns/
 3G+ihk9PtCJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZyKYgwAKCRDJC4p8Y4ZY
 pnoXD/0bhucAblpyFBYWTHRVDpTXNkSkAkDGg4cIGambjgGl6XwX0VO7bDB7R9I8BK44GOQt+UT
 +k8vVenBRTZ9DuAxpZV0xSaihNGQg4tcCCwn6YiuKXgZQi0xdrW/GH33s69O0EwfP2MQLkcDciP
 J5LMrQxyxY46GaHvVGgVQKXJabYVVu208Lnndq3weyAebcYM1+T599xwW5jTsN3xD+JkB1wvJcE
 8mPmdQpALX3lS678kb3+c7VaRQy8dopHaBoJZhOPEpQcebTL80aHioR1zlg5w1ueM7Jy/EQtrhi
 Nqj8PFTVrQgyrHS5TOtklxAkROLusH3RVa75flfAE/ppZT+habceqQEpQy1jrxt4WJoEz2wfkLY
 r62FnfaJtFtvkx/ywdEQ8+cEQs2pjX40S3XGfwkHffoL7u2wnHNCMmvcIF2KGX2I9RlbUgQiMvg
 EIaa3+Qnk1qZwKu6ATSsQY760BLFV/m/pAdO22Fyy9sqiOQFnoL6rEfLtM20ZODvYhfRQUSGya0
 rMTa3WMKA3k5GgZIvAWPorQSsO94y/EG8fd83gm3yiYb3NYNu9/n7TC1YTzGiPhnVQe+mVp1/fT
 E5nvQ9QsAPNr+mDTjTQvbE3hpfFkozsTwj/ur+dQImS+Zb4YPvAYhMm9KCXxCyJ9+chPPQIYucl
 +ADlAkr8dI5i5LA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mmap14: Convert to new API
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

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Changes in v2:
- Included "tst_safe_stdio.h" and used some of its macros
- Improved readability
- Fixed the description for better metadata parsing
- Fixed a warning regarding the unused "n" in run()
- Link to v1: https://lore.kernel.org/r/20241025-convert_mmap14-v1-1-6ba672485028@suse.com
---
 testcases/kernel/syscalls/mmap/mmap14.c | 133 ++++++++++----------------------
 1 file changed, 42 insertions(+), 91 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap14.c b/testcases/kernel/syscalls/mmap/mmap14.c
index 31632601bbed85b60f1dfee7044bf961b1f2a756..de35982f91aaa0fc7ee706498938b4e97140dfcb 100644
--- a/testcases/kernel/syscalls/mmap/mmap14.c
+++ b/testcases/kernel/syscalls/mmap/mmap14.c
@@ -1,124 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
- *
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
+ * Copyright (c) 2024 Ricardo B. Marliere <rbm@suse.com>
  */
 
-/*
- * Test Description:
- *  Verify MAP_LOCKED works fine.
- *  "Lock the pages of the mapped region into memory in the manner of mlock(2)."
+/*\
+ * [Description]
+ *
+ * Verify basic functionality of mmap(2) with MAP_LOCKED.
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and this region should be locked into memory.
+ * mmap(2) should succeed returning the address of the mapped region,
+ * and this region should be locked into memory.
  */
 #include <stdio.h>
 #include <sys/mman.h>
 
-#include "test.h"
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #define TEMPFILE        "mmapfile"
 #define MMAPSIZE        (1UL<<20)
 #define LINELEN         256
 
-char *TCID = "mmap14";
-int TST_TOTAL = 1;
-
 static char *addr;
 
-static void getvmlck(unsigned int *lock_sz);
-static void setup(void);
-static void cleanup(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	unsigned int sz_before;
-	unsigned int sz_after;
-	unsigned int sz_ch;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		getvmlck(&sz_before);
-
-		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
-			    MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
-			    -1, 0);
-
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		getvmlck(&sz_after);
-
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
-	}
-
-	cleanup();
-	tst_exit();
-}
-
-void getvmlck(unsigned int *lock_sz)
+static void getvmlck(unsigned int *lock_sz)
 {
-	int ret;
 	char line[LINELEN];
 	FILE *fstatus = NULL;
 
-	fstatus = fopen("/proc/self/status", "r");
-	if (fstatus == NULL)
-		tst_brkm(TFAIL | TERRNO, NULL, "Open dev status failed");
+	fstatus = SAFE_FOPEN("/proc/self/status", "r");
 
 	while (fgets(line, LINELEN, fstatus) != NULL)
 		if (strstr(line, "VmLck") != NULL)
 			break;
 
-	ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
-	if (ret != 1)
-		tst_brkm(TFAIL | TERRNO, NULL, "Get lock size failed");
+	SAFE_SSCANF(line, "%*[^0-9]%d%*[^0-9]", lock_sz);
 
-	fclose(fstatus);
+	SAFE_FCLOSE(fstatus);
 }
 
-static void setup(void)
+static void run(void)
 {
-	tst_require_root();
+	unsigned int sz_before;
+	unsigned int sz_after;
+	unsigned int sz_ch;
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	getvmlck(&sz_before);
 
-	TEST_PAUSE;
-}
+	addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS, -1, 0);
 
-static void cleanup(void)
-{
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap() of %s failed", TEMPFILE);
+		return;
+	}
+
+	getvmlck(&sz_after);
+
+	sz_ch = sz_after - sz_before;
+	if (sz_ch == MMAPSIZE / 1024) {
+		tst_res(TPASS, "mmap() locked %uK", sz_ch);
+	} else {
+		tst_res(TFAIL, "Expected %luK locked, get %uK locked",
+				MMAPSIZE / 1024, sz_ch);
+	}
+
+	SAFE_MUNMAP(addr, MMAPSIZE);
 }
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.test_all = run,
+};

---
base-commit: 34e6dd2d233abcebae435d34d793b6a49d08c190
change-id: 20241025-convert_mmap14-93b0a247741e

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
