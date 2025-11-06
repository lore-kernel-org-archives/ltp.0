Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835B7CCF9F8
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:35:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5F493CECFD
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:35:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F683CEA78
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9AC4B14001F4
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2315211ED;
 Thu,  6 Nov 2025 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4h2OU7OXmo01WMlxHBdZJWlRP5IXnQd18vLI8AnAeC8=;
 b=WrgPGQNM04NCpEguPYANLFz3DM0l9O7aerYol7XtOld4UvxKFnNaWvJ5l0YNgBdoIkJv9p
 jrpMLPeh7emzOWVo5whuFj7SpIwCPf5Qpbmt2RzcIuqnEnoXTg6Jdjoy26gdpuzDi3z8ah
 DwnrgqaXZZMqd1yykKdin440CQmrJOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4h2OU7OXmo01WMlxHBdZJWlRP5IXnQd18vLI8AnAeC8=;
 b=OWuY755HUr3BVKlwwgHdP+w/VI9Z//SgPbyZh16x2CNIwPG6SL25c87n57z7vv1wWUp3Zy
 HOUcGOjnwLcheQDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UA+NQH6L;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u4FjHVDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4h2OU7OXmo01WMlxHBdZJWlRP5IXnQd18vLI8AnAeC8=;
 b=UA+NQH6LyR//CRxfNwrvDkIqm9oIbpOvXNf6BvXwYZlxOHA6ariHGAEsu5OMiGoYckxxWh
 P0TIHAD/GhNOexPON5994ZZVJzfWermV+7tuYmk0xNIJiKcUs9vwf5nS3ngeHpEDEstcfv
 FlgDhGqJ07b1LdkXNMOYX0nI14tZRZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4h2OU7OXmo01WMlxHBdZJWlRP5IXnQd18vLI8AnAeC8=;
 b=u4FjHVDF1f+96R5C44JRtvnuQSn/rfHYGkcsMbwBzdl//Wf9jGHVyyuf+haDQSLvKApL3Q
 GKt/W8xo9XDVl2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2020413A31;
 Thu,  6 Nov 2025 16:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z5FaBTnODGkHRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:35:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Nov 2025 17:34:55 +0100
Message-ID: <20251106163500.1063704-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: C2315211ED
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] swapon03: Try to swapon() as many files until
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Changes v1->v2:
* Test first swapon() call (Avinesh). For simplicity and -i working
  properly is swapon() tested twice.
* Use correct variable in TCONF message (Avinesh)
* Improve doc (Li)

3 new cleanup commits:
  swapon03: Don't create swap file twice
  swapon03: Cleanup
  swapon03: Remove grep dependency

Posting a patchset diff below (might be a bit more readable than my
explanation).

Link to v1:
https://lore.kernel.org/ltp/20251105154716.995786-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=481055&state=*

Kind regards,
Petr

Petr Vorel (5):
  swapon03: Don't create swap file twice
  swapon03: Cleanup
  swapon03: Try to swapon() as many files until it fails
  libswap: Remove now unused tst_max_swapfiles()
  swapon03: Remove grep dependency

 include/libswap.h                           |   7 --
 libs/swap/libswap.c                         |  64 ------------
 testcases/kernel/syscalls/swapon/swapon03.c | 105 ++++++++++++--------
 3 files changed, 62 insertions(+), 114 deletions(-)

diff --git testcases/kernel/syscalls/swapon/swapon03.c testcases/kernel/syscalls/swapon/swapon03.c
index 0027f874be..91d797871f 100644
--- testcases/kernel/syscalls/swapon/swapon03.c
+++ testcases/kernel/syscalls/swapon/swapon03.c
@@ -10,9 +10,8 @@
  * number of swap files are already in use.
  *
  * NOTE: test does not try to calculate MAX_SWAPFILES from the internal
- * kernel implementation (which is currently <23, 29> depending on kernel
- * configuration). Instead test exptect that at least 15 swap files minus
- * currently used swap can be created.
+ * kernel implementation, instead make sure few swaps were created before
+ * maximum was reached.
  */
 
 #include <stdio.h>
@@ -24,11 +23,18 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
+/*
+ * MAX_SWAPFILES from the internal kernel implementation is currently <23, 29>,
+ * depending on kernel configuration (see man swapon(2). Chose small enough
+ * value for future changes.
+ */
 #define NUM_SWAP_FILES 15
+
 #define MNTPOINT	"mntpoint"
-#define TEST_FILE	MNTPOINT"/testswap"
+#define TEST_FILE	MNTPOINT "/LTP_" __FILE__ "_testswap"
 
 static int *swapfiles;
+static char *tmpdir;
 
 static void setup_swap(void)
 {
@@ -41,10 +47,8 @@ static void setup_swap(void)
 	used_swapfiles = tst_count_swaps();
 	expected_swapfiles = NUM_SWAP_FILES - used_swapfiles;
 
-	if (expected_swapfiles < 0) {
-		tst_brk(TCONF, "Warning: too many used swap files (%d)",
-			expected_swapfiles);
-	}
+	if (expected_swapfiles < 0)
+		tst_brk(TCONF, "too many used swap files (%d)", used_swapfiles);
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
@@ -53,9 +57,12 @@ static void setup_swap(void)
 			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, *swapfiles);
 			MAKE_SMALL_SWAPFILE(filename);
 
-			/* Quit on a first swap file over max */
-			if (swapon(filename, 0) == -1)
+			/* Quit on a first swap file over max, check for EPERM */
+			if (swapon(filename, 0) == -1) {
+				if (errno != EPERM)
+					tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
 				break;
+			}
 			(*swapfiles)++;
 		}
 		exit(0);
@@ -79,12 +86,14 @@ static void setup_swap(void)
  */
 static void check_and_swapoff(const char *filename)
 {
-	char cmd_buffer[256];
+	char buf[256];
+	int foo;
 
-	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
-
-	if (system(cmd_buffer) == 0 && swapoff(filename) != 0)
-		tst_res(TWARN, "Failed to swapoff %s", filename);
+	snprintf(buf, sizeof(buf), "%s/%s %%*s %%*s %%*s %%s", tmpdir, filename);
+	if (!FILE_LINES_SCANF("/proc/swaps", buf, &foo)) {
+		if (swapoff(filename) != 0)
+			tst_res(TWARN | TERRNO, "swapoff(%s) failed", filename);
+	}
 }
 
 /*
@@ -115,6 +124,8 @@ static void setup(void)
 
 	is_swap_supported(TEST_FILE);
 
+	tmpdir = tst_tmpdir_path();
+
 	swapfiles = SAFE_MMAP(NULL, sizeof(*swapfiles), PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	*swapfiles = 0;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
