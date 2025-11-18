Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E57ACEDD93
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 14:36:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C7ED3CEE61
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 15:36:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 303863CE9D6
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 15:36:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4790C600481
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 15:36:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02F702119A;
 Tue, 18 Nov 2025 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763476575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cetStZnnRpxjZtBUXbihP3/tv6f6xVqrwxObMdmQcnA=;
 b=OJw28bae9XlwM6zcW+zi5jmw4Aj4pPtDBIjLhPIlnn+oaPtaRi6SuEbUAi/1Ffl4QYCUnk
 Z0j9Sh9S8n4HuYLnRQ2fcveq50EdyJyGZ1b/BDiQpDYPwBGauR/XNeYfSNijEAV53VqmJR
 2Y9j6ZyRDA5XaN+J5dRIqHmJfSe72e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763476575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cetStZnnRpxjZtBUXbihP3/tv6f6xVqrwxObMdmQcnA=;
 b=w8HRtDDZYiokkMTc1Y5OOYvJfA2nlrAqhc/XhbAEyppkL0BAOF28Q0jw3kDWRDAy6qFV6I
 AYwPpi7pJKZtbXCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763476575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cetStZnnRpxjZtBUXbihP3/tv6f6xVqrwxObMdmQcnA=;
 b=OJw28bae9XlwM6zcW+zi5jmw4Aj4pPtDBIjLhPIlnn+oaPtaRi6SuEbUAi/1Ffl4QYCUnk
 Z0j9Sh9S8n4HuYLnRQ2fcveq50EdyJyGZ1b/BDiQpDYPwBGauR/XNeYfSNijEAV53VqmJR
 2Y9j6ZyRDA5XaN+J5dRIqHmJfSe72e0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763476575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cetStZnnRpxjZtBUXbihP3/tv6f6xVqrwxObMdmQcnA=;
 b=w8HRtDDZYiokkMTc1Y5OOYvJfA2nlrAqhc/XhbAEyppkL0BAOF28Q0jw3kDWRDAy6qFV6I
 AYwPpi7pJKZtbXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE9E53EA61;
 Tue, 18 Nov 2025 14:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKxlLV6EHGnZCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Nov 2025 14:36:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Nov 2025 15:36:07 +0100
Message-ID: <20251118143607.45308-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118143607.45308-1-pvorel@suse.cz>
References: <20251118143607.45308-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] swapon03: Try to swapon() as many files until
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

Also test swapon() 2x, first in the setup() when first failure happen,
then in the test function (easier than propagate errno from fork to the
main function). Therefore add -i2 into runtest/syscalls.

It was required to increase cmd_buffer size to avoid directive output
may be truncated warning.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Add -i2 to runtest/syscalls.
* Slightly simpler code (no mmap() needed) due cleanup in a previous
  commit (removed fork()).

 runtest/syscalls                            |  2 +-
 testcases/kernel/syscalls/swapon/swapon03.c | 54 +++++++++++++--------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 54d94c0ca2..80dedef749 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1646,7 +1646,7 @@ swapoff02 swapoff02
 
 swapon01 swapon01
 swapon02 swapon02
-swapon03 swapon03
+swapon03 swapon03 -i2
 
 #Exclusive syscall() for POWER6 machines only
 switch01 endian_switch01
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index c014a48912..548a5a522f 100644
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
+ * kernel implementation, instead make sure few swaps were created before
+ * maximum was reached.
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
+#define NUM_SWAP_FILES 15
+
 #define MNTPOINT	"mntpoint"
 #define TEST_FILE	MNTPOINT"/testswap"
 
@@ -27,31 +37,33 @@ static int swapfiles;
 
 static int setup_swap(void)
 {
-	int j, max_swapfiles, used_swapfiles;
+	int used_swapfiles, expected_swapfiles;
 	char filename[FILENAME_MAX];
 
-	/* Determine how many more files are to be created */
-	max_swapfiles = tst_max_swapfiles();
 	used_swapfiles = tst_count_swaps();
-	swapfiles = max_swapfiles - used_swapfiles;
-	if (swapfiles > max_swapfiles)
-		swapfiles = max_swapfiles;
+	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;
 
-	/*create and turn on remaining swapfiles */
-	for (j = 0; j < swapfiles; j++) {
+	if (expected_swapfiles < 0)
+		tst_brk(TCONF, "too many used swap files (%d)", used_swapfiles);
 
-		/* Create the swapfile */
-		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
-		SAFE_MAKE_SMALL_SWAPFILE(filename);
+	SAFE_MAKE_SMALL_SWAPFILE(TEST_FILE);
+	swapfiles++;
 
-		/* turn on the swap file */
-		TST_EXP_PASS_SILENT(swapon(filename, 0));
-		if (!TST_PASS)
-			tst_brk(TFAIL, "Failed to setup swap files");
+	while (true) {
+		/* Create the swapfile */
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, swapfiles);
+		MAKE_SMALL_SWAPFILE(filename);
+
+		/* Quit on a first swap file over max, check for EPERM */
+		if (swapon(filename, 0) == -1) {
+			if (errno != EPERM)
+				tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
+			break;
+		}
+		swapfiles++;
 	}
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-	MAKE_SMALL_SWAPFILE(TEST_FILE);
 
 	return 0;
 }
@@ -61,7 +73,7 @@ static int setup_swap(void)
  */
 static int check_and_swapoff(const char *filename)
 {
-	char cmd_buffer[256];
+	char cmd_buffer[FILENAME_MAX+28];
 	int rc = -1;
 
 	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
@@ -82,8 +94,8 @@ static void clean_swap(void)
 	int j;
 	char filename[FILENAME_MAX];
 
-	for (j = 0; j < swapfiles; j++) {
-		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
+	for (j = 1; j < swapfiles; j++) {
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j);
 		check_and_swapoff(filename);
 	}
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
