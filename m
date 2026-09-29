Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88F7CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 14:15:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92573E5873
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 16:15:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E75D63E57E8
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:15:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 17FA2600BAF
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 16:15:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB3331F7FA;
 Tue, 29 Sep 2026 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790691323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8t3NT+Z79vXcsFa5DvRXbFpRJc82RrMLqhDtJlVv858=;
 b=HBzq9HM4LlUmkZSVJbzyac2AxNqNkXW0EX439S7NY7vq9X6ml1Jaxg4bGhvJ+uL0J1922H
 u47251hwFycEh3wFOWSuN0TZqqKeHwClCGbgW0KZFH4+zdpykIAQFqu6YmUojuhx+Bb1PY
 LVz+qFkSl2JPIUWtmrQ5de3z8b5UHuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790691323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8t3NT+Z79vXcsFa5DvRXbFpRJc82RrMLqhDtJlVv858=;
 b=6fbXKeIgVROyIYzS2kibZ8xH1E9/3kAGBO5jgGuPNqO+x9DWssnXVcB12wNjx5lhjD12S7
 PUbo4MWAwyvDs8Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=n6tQr9E5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=roVP5tT5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790691319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8t3NT+Z79vXcsFa5DvRXbFpRJc82RrMLqhDtJlVv858=;
 b=n6tQr9E5WH9rP33t+GKyp+wq/58EfHGGOmCXhbkuYlIOcWvpN6zP5cUdYRmSnmsocM2yzp
 iynqxT+1sFxb4Xd2Ts13YR4xmrTTKZWfMl/QvinwgNrtHjZ6aMu2aTrsR5srcEM/JP1vdX
 ZJXDUTrUrV6AtJe1Y3fAKuN89WMi7yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790691319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8t3NT+Z79vXcsFa5DvRXbFpRJc82RrMLqhDtJlVv858=;
 b=roVP5tT5q3BP7mSyWn6XolN/Fk4t6iyWubSxcXFuAs+YMXL4IKFNZP5N0ggYdM5lOsoPpj
 MIdY084r9NxeeEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6668E133F1;
 Tue, 29 Sep 2026 14:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TpNnD/fHu2rnTwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Sep 2026 14:15:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Sep 2026 16:15:19 +0200
MIME-Version: 1.0
Message-Id: <20260929-fix_fw_load02-v1-1-4cd5f95d172b@suse.com>
X-B4-Tracking: v=1; b=H4sIAPbHu2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNL3bTMivi08vic/MQUAyNdsyQDYwPTNLOkFPMkJaCegqJUoAKwedG
 xEH5xaVJWanIJyBCl2loAl7MJUXEAAAA=
X-Change-ID: 20260929-fix_fw_load02-6b0305f6bd7b
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790691319; l=2900;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QrLQDuK2sN6VnVzXWqKoNk3XL1Q+OyfO/BX824wHzFA=;
 b=1baLegTCHzm333Xdxx9XpYxzR+1MDc6gBooFzAaWPEF5eSX8Ej7x3YgLwFaPjprXRaGjCpb6g
 aHqLR83uDqRA8K9NOS6AMpHe8TN60seyhHqiOL0AOn/HtDO4HAF8ire
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AB3331F7FA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Handle empty saved configuration values
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

Empty string module parameters return EOF on older kernels, causing
fw_load02 to abort with TBROK on v4.4.

Accept empty values while retaining read-error handling and the original
errno. Restore empty strings with a NUL byte: an empty write does not
invoke the sysfs setter, while a newline would change the saved value.

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
 lib/tst_sys_conf.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 80cd83569..a62af4a94 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -56,6 +56,7 @@ int tst_sys_conf_save(const struct tst_path_val *conf)
 {
 	char line[PATH_MAX];
 	int ttype, iret;
+	int read_err, saved_errno;
 	FILE *fp;
 	void *ret;
 
@@ -93,14 +94,23 @@ int tst_sys_conf_save(const struct tst_path_val *conf)
 	}
 
 	ret = fgets(line, sizeof(line), fp);
+	saved_errno = errno;
+	read_err = ferror(fp);
+
 	fclose(fp);
 
 	if (ret == NULL) {
-		if (conf->flags & TST_SR_IGNORE_ERR)
-			return 1;
+		if (read_err) {
+			if (conf->flags & TST_SR_IGNORE_ERR)
+				return 1;
+
+			errno = saved_errno;
+			tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
+				conf->path);
+		}
 
-		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
-			conf->path);
+		/* Empty string module parameters can return EOF on older kernels. */
+		line[0] = '\0';
 	}
 
 	tst_sys_conf_save_str(conf->path, line);
@@ -142,7 +152,14 @@ void tst_sys_conf_restore(int verbose)
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
base-commit: 0596b09f22f449cb300e8ad2d08d8b186f551a05
change-id: 20260929-fix_fw_load02-6b0305f6bd7b

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
