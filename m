Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBC6D74969
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 09:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A0073D0520
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 10:42:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 253033CDC06
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 10:42:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F31D61401120
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 10:42:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64FCE336B8;
 Fri, 19 Dec 2025 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766137342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3QQpqjF1m+h/yLWc3Kd1Dd1d6SZDuEXhUphMiicEwmA=;
 b=K7mTlHJD9boBm3kYgGVJqTB6XT6/GL0qU3F4t6AgPJhIdVw4rebnnpuE+lhx5ttGGHcEC8
 AGQ4UzkqJS7W4Nn2dJsl3jGpwIU0ZeGHg/8/8rEK7/GKQukeGyQa5GrDAJpGGvztH0M6wB
 XLKKrQn8M/NvniJQDo8LOTKEg08DdX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766137342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3QQpqjF1m+h/yLWc3Kd1Dd1d6SZDuEXhUphMiicEwmA=;
 b=cA/ndWoBMDOdm09xHafN+3Z5W+KT8MRw6XdshjwFulZcAIjrhbxTvxquj0GLmLU/3jazgc
 KiZfmzmnsRoUXjAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K7mTlHJD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="cA/ndWoB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766137342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3QQpqjF1m+h/yLWc3Kd1Dd1d6SZDuEXhUphMiicEwmA=;
 b=K7mTlHJD9boBm3kYgGVJqTB6XT6/GL0qU3F4t6AgPJhIdVw4rebnnpuE+lhx5ttGGHcEC8
 AGQ4UzkqJS7W4Nn2dJsl3jGpwIU0ZeGHg/8/8rEK7/GKQukeGyQa5GrDAJpGGvztH0M6wB
 XLKKrQn8M/NvniJQDo8LOTKEg08DdX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766137342;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3QQpqjF1m+h/yLWc3Kd1Dd1d6SZDuEXhUphMiicEwmA=;
 b=cA/ndWoBMDOdm09xHafN+3Z5W+KT8MRw6XdshjwFulZcAIjrhbxTvxquj0GLmLU/3jazgc
 KiZfmzmnsRoUXjAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 353BD3EA63;
 Fri, 19 Dec 2025 09:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PM4XDP4dRWmEBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Dec 2025 09:42:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Dec 2025 10:42:19 +0100
Message-ID: <20251219094219.151887-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 64FCE336B8
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files until
 it fails
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
Cc: Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Previously tst_max_swapfiles() had fine tuning for a specific kernel
version which was fragile due various backports in enterprise kernels.

Let's try to create and use as many swap files until swapon() fails.
Then check for expected EPERM.

It was required to increase cmd_buffer size to avoid directive output
may be truncated warning.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v3->v4:
* Do *not* skip testing when expected minimum swap files was already
  used in SUT (Cyril)
* Rename variables (Cyril)
* Run test only once (remove -i2 from runtest file)

Link to v3:
https://lore.kernel.org/ltp/20251118143607.45308-3-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20251118143607.45308-3-pvorel@suse.cz/
 testcases/kernel/syscalls/swapon/swapon03.c | 49 ++++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index c014a48912..e8dca1e283 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -6,9 +6,12 @@
  */
 
 /*\
- * This test case checks whether swapon(2) system call returns:
+ * Test checks whether :man2:`swapon` system call returns EPERM when the maximum
+ * number of swap files are already in use.
  *
- *  - EPERM when there are more than MAX_SWAPFILES already in use.
+ * NOTE: test does not try to calculate MAX_SWAPFILES from the internal
+ * kernel implementation, instead make sure at least 15 swaps were created
+ * before the maximum of swaps was reached.
  */
 
 #include <stdio.h>
@@ -20,6 +23,13 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+/*
+ * MAX_SWAPFILES from the internal kernel implementation is currently <23, 29>,
+ * depending on kernel configuration (see man swapon(2). Chose small enough
+ * value for future changes.
+ */
+#define MIN_SWAP_FILES 15
+
 #define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT"/testswap"
 
@@ -27,31 +37,28 @@ static int swapfiles;
 
 static int setup_swap(void)
 {
-	int j, max_swapfiles, used_swapfiles;
+	int used_swapfiles, min_swapfiles;
 	char filename[FILENAME_MAX];
 
-	/* Determine how many more files are to be created */
-	max_swapfiles = tst_max_swapfiles();
 	used_swapfiles = tst_count_swaps();
-	swapfiles = max_swapfiles - used_swapfiles;
-	if (swapfiles > max_swapfiles)
-		swapfiles = max_swapfiles;
-
-	/*create and turn on remaining swapfiles */
-	for (j = 0; j < swapfiles; j++) {
+	min_swapfiles = MIN_SWAP_FILES - used_swapfiles;
 
+	while (true) {
 		/* Create the swapfile */
-		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
-		SAFE_MAKE_SMALL_SWAPFILE(filename);
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, swapfiles);
+		MAKE_SMALL_SWAPFILE(filename);
+
+		/* Quit on a first swap file over max, check for EPERM */
+		if (swapon(filename, 0) == -1) {
+			if (errno == EPERM && swapfiles > min_swapfiles)
+				break;
 
-		/* turn on the swap file */
-		TST_EXP_PASS_SILENT(swapon(filename, 0));
-		if (!TST_PASS)
-			tst_brk(TFAIL, "Failed to setup swap files");
+			tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
+		}
+		swapfiles++;
 	}
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-	MAKE_SMALL_SWAPFILE(TEST_FILE);
 
 	return 0;
 }
@@ -61,7 +68,7 @@ static int setup_swap(void)
  */
 static int check_and_swapoff(const char *filename)
 {
-	char cmd_buffer[256];
+	char cmd_buffer[FILENAME_MAX+28];
 	int rc = -1;
 
 	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
@@ -83,11 +90,9 @@ static void clean_swap(void)
 	char filename[FILENAME_MAX];
 
 	for (j = 0; j < swapfiles; j++) {
-		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j);
 		check_and_swapoff(filename);
 	}
-
-	check_and_swapoff(TEST_FILE);
 }
 
 static void verify_swapon(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
