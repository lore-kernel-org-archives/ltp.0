Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA37CCF9F8
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:36:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E18393CED0C
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:36:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A86F3CED0A
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 844BC60090F
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33FC71F45F;
 Thu,  6 Nov 2025 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp5pCl5iFzz+BE798q9OUcUe6gJLA3PfhZ+aIeNctqw=;
 b=3GEKbRNAloUlYr0fc88XfmRMnp1D9XA6PK7qieR/FSsc106dYoMkXh36ZN4VeZkg+KdktB
 7V2YRSjgx1kDwxyarTylcj+93+zwU3dNKrKO9lh2iYkVf9hshuY5fmO9U0R63bdIfhkz9y
 SokwGGL1L40fo4fIw7cQHat4IZSdUUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp5pCl5iFzz+BE798q9OUcUe6gJLA3PfhZ+aIeNctqw=;
 b=oKku63FlyN+hqH5aJJglrWvqSREwvGdOo1R6pWwn5MT+8lRqifvu7ASI+0nefHoCS81G2O
 DRZtTnov8RyzCQDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp5pCl5iFzz+BE798q9OUcUe6gJLA3PfhZ+aIeNctqw=;
 b=3GEKbRNAloUlYr0fc88XfmRMnp1D9XA6PK7qieR/FSsc106dYoMkXh36ZN4VeZkg+KdktB
 7V2YRSjgx1kDwxyarTylcj+93+zwU3dNKrKO9lh2iYkVf9hshuY5fmO9U0R63bdIfhkz9y
 SokwGGL1L40fo4fIw7cQHat4IZSdUUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp5pCl5iFzz+BE798q9OUcUe6gJLA3PfhZ+aIeNctqw=;
 b=oKku63FlyN+hqH5aJJglrWvqSREwvGdOo1R6pWwn5MT+8lRqifvu7ASI+0nefHoCS81G2O
 DRZtTnov8RyzCQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE19213A4B;
 Thu,  6 Nov 2025 16:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oM3kLzrODGkHRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:35:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Nov 2025 17:34:58 +0100
Message-ID: <20251106163500.1063704-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106163500.1063704-1-pvorel@suse.cz>
References: <20251106163500.1063704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] swapon03: Try to swapon() as many files until
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
main function).

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Test first swapon() call (Avinesh). For simplicity and -i working
  properly is swapon() tested twice.
* Use correct variable in TCONF message (Avinesh)
* Improve doc (Li)

 testcases/kernel/syscalls/swapon/swapon03.c | 68 ++++++++++++++-------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index d9822c01ef..a8e0cbcdc6 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2009-2025
  * Copyright (c) International Business Machines Corp., 2007
  * Created by <rsalveti@linux.vnet.ibm.com>
- *
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
@@ -20,48 +23,61 @@
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
 
-static int swapfiles;
+static int *swapfiles;
 
 static void setup_swap(void)
 {
 	pid_t pid;
-	int status;
-	int j, max_swapfiles, used_swapfiles;
+	int status, used_swapfiles, expected_swapfiles;
 	char filename[FILENAME_MAX];
 
 	SAFE_SETEUID(0);
 
-	/* Determine how many more files are to be created */
-	max_swapfiles = tst_max_swapfiles();
 	used_swapfiles = tst_count_swaps();
-	swapfiles = max_swapfiles - used_swapfiles;
-	if (swapfiles > max_swapfiles)
-		swapfiles = max_swapfiles;
+	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;
+
+	if (expected_swapfiles < 0)
+		tst_brk(TCONF, "too many used swap files (%d)", used_swapfiles);
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		/*create and turn on remaining swapfiles */
-		for (j = 0; j < swapfiles; j++) {
-
+		while (true) {
 			/* Create the swapfile */
-			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
+			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, *swapfiles);
 			MAKE_SMALL_SWAPFILE(filename);
 
-			/* turn on the swap file */
-			TST_EXP_PASS_SILENT(swapon(filename, 0));
+			/* Quit on a first swap file over max, check for EPERM */
+			if (swapon(filename, 0) == -1) {
+				if (errno != EPERM)
+					tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
+				break;
+			}
+			(*swapfiles)++;
 		}
 		exit(0);
 	} else {
 		waitpid(pid, &status, 0);
 	}
 
-	if (WEXITSTATUS(status))
+	if (WEXITSTATUS(status) || *swapfiles == 0)
 		tst_brk(TBROK, "Failed to setup swap files");
 
-	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
+	if (*swapfiles < expected_swapfiles) {
+		tst_res(TWARN, "Successfully created only %d swap files (>= %d expected)",
+			*swapfiles, expected_swapfiles);
+	} else {
+		tst_res(TINFO, "Successfully created %d swap files", *swapfiles);
+	}
 }
 
 /*
@@ -85,8 +101,8 @@ static void clean_swap(void)
 	int j;
 	char filename[FILENAME_MAX];
 
-	for (j = 0; j < swapfiles; j++) {
-		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
+	for (j = 0; j < *swapfiles; j++) {
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j);
 		check_and_swapoff(filename);
 	}
 
@@ -104,12 +120,20 @@ static void setup(void)
 		tst_brk(TCONF, "swap not supported by kernel");
 
 	is_swap_supported(TEST_FILE);
+
+	swapfiles = SAFE_MMAP(NULL, sizeof(*swapfiles), PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	*swapfiles = 0;
+
 	setup_swap();
 }
 
 static void cleanup(void)
 {
-	clean_swap();
+	if (swapfiles) {
+		clean_swap();
+		SAFE_MUNMAP(swapfiles, sizeof(*swapfiles));
+	}
 }
 
 static struct tst_test test = {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
