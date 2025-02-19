Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2397AC021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 18:20:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A279B3C4C0B
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 19:20:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CF8C3C4EC7
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 19:19:41 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6BD162313D9
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 19:19:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB448216DF;
 Wed, 19 Feb 2025 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739989174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gIWUA2TILeu1njVMXfRRtb7dMzEQdDlVzIn4sqxFzl0=;
 b=AAuCYwF19sGBTK/IEpwx0Fxm8XO2A9oAe8PLmqrcNkDjAA7fcbM2ei+jT8vh1m3XmeMf8o
 FSHMgCo72UqCcQAmsmvpiG8Jv0hq79BDzMQK08xEhUeNajo4mJVlI+8ERDk/eeVAi/03Gy
 oYG9TFAxt24PINpaZnTKkMzTTUkwcAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739989174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gIWUA2TILeu1njVMXfRRtb7dMzEQdDlVzIn4sqxFzl0=;
 b=dHxWhvz/HJNyCufBBPk4xXWd/ocjmT+pQa30pi5cqItyhjHdFMI3qrjDh2fJ/+X6hNEGHB
 OeaKd1O3KY12vgCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Jtu9bCg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cfwI9rUh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739989173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gIWUA2TILeu1njVMXfRRtb7dMzEQdDlVzIn4sqxFzl0=;
 b=1Jtu9bCgRVEAGRQi8idFXV+ldWNgh7PsJEZY1nPKiU+io80J8ojHoxxHmUGv4FqxRtS6D6
 PBtYtFBgLHn+QnEtjaGO2+pFoW8gpyXyqlbAynz8yCXC1U9KmQJh6eSx5UsRGWBHwWSI3Y
 7X2NsM6IeMtOraC/imjZyoNvhBdxpNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739989173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gIWUA2TILeu1njVMXfRRtb7dMzEQdDlVzIn4sqxFzl0=;
 b=cfwI9rUhYcDCVdmTdG/MgP6BK433YDwJMqmF+sFworUiGKcVPgnVKfyoRiAudWgk4bJN3I
 CJNIenJP+ZXPuADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AC013715;
 Wed, 19 Feb 2025 18:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UPHEJbUgtmeqawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 18:19:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 19:19:24 +0100
Message-ID: <20250219181926.2620960-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: DB448216DF
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ima_setup.sh: Postpone loading policy after test
 setup
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Usual approach for LTP is to quit test early on missing prerequisites
(e.g. disabled SELinux in ima_selinux.sh). This is even more important
for IMA tests run with LTP_IMA_LOAD_POLICY=1, where it's useful to avoid
loading policy if test will be skipped with TCONF (often requires reboot).

Therefore first check $REQUIRED_BUILTIN_POLICY (value of ima_policy
kernel cmdline parameter, it can TCONF), then run the test specific
setup and finally run the policy if needed.

Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Link to v1:
https://patchwork.ozlabs.org/project/ltp/patch/20250217130839.2392666-2-pvorel@suse.cz/

Changes from v1:
* Instead of explicitly state that test setup should be run before
loading policy just postpone loading policy after running test setup.

 .../kernel/security/integrity/ima/tests/ima_setup.sh  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1f1c267c4b..9732aa7b43 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -245,6 +245,8 @@ load_ima_policy()
 
 ima_setup()
 {
+	local load_policy
+
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
 
 	IMA_DIR="$SECURITYFS/ima"
@@ -265,11 +267,16 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
-	if ! verify_ima_policy; then
+	verify_ima_policy
+	load_policy=$?
+
+	# Run setup in case of TCONF before loading policy
+	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
+
+	if [ "$load_policy" = 1 ]; then
 		load_ima_policy
 	fi
 
-	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
 
 ima_cleanup()
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
