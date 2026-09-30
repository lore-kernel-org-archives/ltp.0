Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469CBCA5FB1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 07:43:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0413E55DA
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:43:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 442F83E55AE
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 09:43:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCAC71000D57
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 09:43:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07C0221B02;
 Wed, 30 Sep 2026 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790754194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YIpzn9NfEymm3OHfTQleb84t/ce6R2ejHBPHksFZXMg=;
 b=vovgJU3Z8CsDaaRJJ8RAcmFHtEpgfNCKU+4Sf7HBG8sU+pg+90LXpvivHeZCmIi4i1UNAL
 ekEomSAXiY50ECFYm7+Bt8PpAjgCc3q1M8k7eW4zS8Iz6ASxpL/aEuInXgrn+6dqufhgWJ
 OL0vpO3l6GaHws5YydB93LlI2m0FLxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790754194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YIpzn9NfEymm3OHfTQleb84t/ce6R2ejHBPHksFZXMg=;
 b=eqXMsEF/cz4O2zTmUJojRtfrNFZHAOSv9i8U7vBMWGquHhaPHMFq8Q/pOJJdmDL06q6Wc6
 9b0sLyHC4FAmz+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790754190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YIpzn9NfEymm3OHfTQleb84t/ce6R2ejHBPHksFZXMg=;
 b=AJO4JTfKfkXCxlkAtfwLFWDGPORwDKVcjJdwsKJmZs803C/6gQ7BzVIPXPluUYJzHSEszs
 lP9JozuSSYO9x0JFaOdiyQppc2hq4Pai0r0WWcYgICfDo78sM6CZ9Oovdkw3jeKESsol3r
 3KVtzIaFFqkZ8cOw93xHkAbOMaUDR34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790754190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YIpzn9NfEymm3OHfTQleb84t/ce6R2ejHBPHksFZXMg=;
 b=nxzMqsNtI6l3stPqhyBnVPq60VxAoc3Nmra4pmdrw+/hVU2A+ru/1KKJ9BzNb93B2NYakw
 iDPvLZvbBb6DbqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E380136AD;
 Wed, 30 Sep 2026 07:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8WTxF429vGqTSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Sep 2026 07:43:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 09:43:08 +0200
MIME-Version: 1.0
Message-Id: <20260930-fix_fw_load02-v2-1-accf7294475c@suse.com>
X-B4-Tracking: v=1; b=H4sIAIu9vGoC/3WNwQ6CMBAFf4Xs2Zq2Wgie/A9DCG23UqPUdAE1h
 H+3xbPHSebNW4AweiQ4FQtEnD35MCSQuwJM3w1XZN4mBsllyWtZM+ffrXu199BZLlmp+YErV2p
 baUibZ8QkbL1L82Oa9A3NmCPZ6D2NIX62w1lk7197Fkywo7HK1cqKSuozTYR7Ex7QrOv6BStYC
 QS7AAAA
X-Change-ID: 20260929-fix_fw_load02-6b0305f6bd7b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790754189; l=3171;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1/j0rjMe+QCq/Q2VE0CFxgZpujwmA0Otj3GVAkDyEpc=;
 b=cyB2FUnKdmfiadiGrOL9CpwJMiopmUGZc1fyfBsbgq2bWZpUSnAXgRaerP4eUZfwMjBFnqsme
 eejKSdlIJgUDxRMerqteSa3Rya9GgnJ5EhVWMI+iTiXAnBkkPvJsPAh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: Handle empty saved configuration values
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Empty string module parameters return EOF on kernels prior to 4.14
commit 96802e6b1dbf ("kernel/params.c: fix an overflow in
param_attr_show"), causing fw_load02 to abort with TBROK on v4.4.

Accept empty values while retaining read-error handling and the original
errno. Restore empty strings with a NUL byte: an empty write does not
invoke the sysfs setter, while a newline would change the saved value.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Fix the following behaviour on kernel < 4.14 96802e6b1dbf

tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_security.c:115: TINFO: SecureBoot sysfs file not available
tst_security.c:94: TINFO: Unable to determine system lockdown state
tst_security.c:115: TINFO: SecureBoot sysfs file not available
tst_tmpdir.c:309: TINFO: Using /tmp/LTP_fw_ZRzLML as tmpdir (btrfs filesystem)
tst_sys_conf.c:103: TBROK: Failed to read anything from '/sys/module/firmware_class/parameters/path': SUCCESS (0)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
---
Changes in v2:
- fix commit message
- fix according to Martin's suggestion
- Link to v1: https://lore.kernel.org/20260929-fix_fw_load02-v1-1-4cd5f95d172b@suse.com
---
 lib/tst_sys_conf.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 80cd83569..f69eb3c7f 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -54,10 +54,10 @@ void tst_sys_conf_save_str(const char *path, const char *value)
 
 int tst_sys_conf_save(const struct tst_path_val *conf)
 {
-	char line[PATH_MAX];
+	char line[PATH_MAX] = {};
 	int ttype, iret;
+	int read_err = 0, saved_errno = 0;
 	FILE *fp;
-	void *ret;
 
 	if (!conf || !conf->path)
 		tst_brk(TBROK, "path is empty");
@@ -92,13 +92,17 @@ int tst_sys_conf_save(const struct tst_path_val *conf)
 		return 1;
 	}
 
-	ret = fgets(line, sizeof(line), fp);
+	if (!fgets(line, sizeof(line), fp))
+		read_err = ferror(fp);
+
+	saved_errno = errno;
 	fclose(fp);
 
-	if (ret == NULL) {
+	if (read_err) {
 		if (conf->flags & TST_SR_IGNORE_ERR)
 			return 1;
 
+		errno = saved_errno;
 		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
 			conf->path);
 	}
@@ -142,7 +146,14 @@ void tst_sys_conf_restore(int verbose)
 			tst_res(TINFO, "Restoring conf.: %s -> %s\n",
 				i->path, i->value);
 		}
-		FILE_PRINTF(i->path, "%s", i->value);
+		/*
+		 * A zero-length write does not invoke the sysfs store callback.
+		 * Write a NUL byte to restore an empty string module parameter.
+		 */
+		if (!i->value[0])
+			FILE_PRINTF(i->path, "%c", '\0');
+		else
+			FILE_PRINTF(i->path, "%s", i->value);
 	}
 }
 

---
base-commit: 1cbe713ca9d55bed7e4d52c6f2216ba3e2089346
change-id: 20260929-fix_fw_load02-6b0305f6bd7b

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
