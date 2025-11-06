Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97821CCF9F8
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D3673CED0C
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:35:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 969C93CEA78
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1E707600AAA
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:35:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B75B31F785;
 Thu,  6 Nov 2025 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6AdGM9XKrPXUQ2RMHUzGh8Hi9f9ZG1rV/MrsKyz/4U=;
 b=Un/d6Fx0KEjMp2/fpafo4SsBWDlF+GLJ6Ap1jnkYtZciovVeA2aVV8wciiHHI+BcUmejEA
 lWab9K/lUK2rTbAznebF5w92e6GKKpkfMCIipcJpJ0OsVYLO5g0H5JjiDJjbOlA2WP1Az0
 TzKIqroRQ2OQQxWVpsZ5MHvXZdKCV3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6AdGM9XKrPXUQ2RMHUzGh8Hi9f9ZG1rV/MrsKyz/4U=;
 b=CDgRsTOQTZsBdF89jBsvI+A4sYL/jUc1E/dVJkr4PDuKT4j/J/IRrcfaTL3N73c3Hthr4C
 9rOyBciIH0PkqXDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762446906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6AdGM9XKrPXUQ2RMHUzGh8Hi9f9ZG1rV/MrsKyz/4U=;
 b=Un/d6Fx0KEjMp2/fpafo4SsBWDlF+GLJ6Ap1jnkYtZciovVeA2aVV8wciiHHI+BcUmejEA
 lWab9K/lUK2rTbAznebF5w92e6GKKpkfMCIipcJpJ0OsVYLO5g0H5JjiDJjbOlA2WP1Az0
 TzKIqroRQ2OQQxWVpsZ5MHvXZdKCV3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762446906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6AdGM9XKrPXUQ2RMHUzGh8Hi9f9ZG1rV/MrsKyz/4U=;
 b=CDgRsTOQTZsBdF89jBsvI+A4sYL/jUc1E/dVJkr4PDuKT4j/J/IRrcfaTL3N73c3Hthr4C
 9rOyBciIH0PkqXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75DF513A31;
 Thu,  6 Nov 2025 16:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJVsGzrODGkHRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:35:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Nov 2025 17:34:57 +0100
Message-ID: <20251106163500.1063704-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106163500.1063704-1-pvorel@suse.cz>
References: <20251106163500.1063704-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] swapon03: Cleanup
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

- Remove unused return code in check_and_swapoff() and setup_swap(). The
  purpose was to run cleanup() in the end of the setup() if creating
  swap fails, but return code is always 0. Also cleanup() should be run
  when test exits with tst_brk() anyway.
- Change return code from TFAIL to TBROK.
- Add missing brackets.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v1.
I can split this if you like.

 testcases/kernel/syscalls/swapon/swapon03.c | 23 +++++++--------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 01a3b6d8ac..d9822c01ef 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -25,7 +25,7 @@
 
 static int swapfiles;
 
-static int setup_swap(void)
+static void setup_swap(void)
 {
 	pid_t pid;
 	int status;
@@ -54,33 +54,27 @@ static int setup_swap(void)
 			TST_EXP_PASS_SILENT(swapon(filename, 0));
 		}
 		exit(0);
-	} else
+	} else {
 		waitpid(pid, &status, 0);
+	}
 
 	if (WEXITSTATUS(status))
-		tst_brk(TFAIL, "Failed to setup swap files");
+		tst_brk(TBROK, "Failed to setup swap files");
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
-
-	return 0;
 }
 
 /*
  * Check if the file is at /proc/swaps and remove it giving swapoff
  */
-static int check_and_swapoff(const char *filename)
+static void check_and_swapoff(const char *filename)
 {
 	char cmd_buffer[256];
-	int rc = -1;
 
 	snprintf(cmd_buffer, sizeof(cmd_buffer), "grep -q '%s.*file' /proc/swaps", filename);
 
-	if (system(cmd_buffer) == 0 && swapoff(filename) != 0) {
+	if (system(cmd_buffer) == 0 && swapoff(filename) != 0)
 		tst_res(TWARN, "Failed to swapoff %s", filename);
-		rc = -1;
-	}
-
-	return rc;
 }
 
 /*
@@ -110,10 +104,7 @@ static void setup(void)
 		tst_brk(TCONF, "swap not supported by kernel");
 
 	is_swap_supported(TEST_FILE);
-	if (setup_swap() < 0) {
-		clean_swap();
-		tst_brk(TBROK, "Setup failed, quitting the test");
-	}
+	setup_swap();
 }
 
 static void cleanup(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
