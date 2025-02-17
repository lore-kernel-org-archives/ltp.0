Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F977C021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 18:33:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61CC53C9C4D
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 19:33:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05743C0294
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 19:33:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 250B567CABD
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 19:33:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1DC61F443;
 Mon, 17 Feb 2025 18:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739817210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
 b=JrAOlgsUCz2E7jGyfyR3RtV5YXUrU9rq084ATTwIutW41tQ7IuxLXpntnsnpO890+cd1QQ
 +KqRiFXCm+PsjqdlhBoY9vHzrEdOQ5bYx53EeMFfQwRA3jDElBDTBSmeXMNeAdo+ZsdRMQ
 Ba5AUhhaO4Kc0DcwtKKeX+xGLZbVbHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739817210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
 b=k6f4SKwqcrFEq8BafM+PwcRe4Fcf/+vgPvQaXzf1SFrG3gK5D5+ngruYoHl5YalyAtCZkw
 NNnQEizdgpaJ5WAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ljaZ9XhE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="99h0b/VG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739817209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
 b=ljaZ9XhEmIaeYmksiA8MnmMlFQ/1RdphYNhILxXRwpN3k2DHFsqjpNDRZzUjPJeMBkk4fH
 FuUvQWD37w830lDyMZf/sddAhgNR4NitOtIqBptQ59WPWrNRkRZxw+X6Z57PlEAsVsq9CZ
 jURTolag9qNAbQtbWoD5M6WO0W6kaxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739817209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RO28s2JbTmZ2ORFUutwm2rH7SuUmXZGUH6MAzf7uOxI=;
 b=99h0b/VGzz77lqGNkRs6UmOF9OQTsTUdbbTMTnXlxe2rJM2ErlYn8jD7OVqrugL+6MS27Z
 HDE7QiwoTK70aTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 500B5133F9;
 Mon, 17 Feb 2025 18:33:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z7saEfmAs2c0eAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 18:33:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 19:33:22 +0100
Message-ID: <20250217183322.2429271-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: C1DC61F443
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] ima_setup.sh: Quit the test on unsuitable
 IMA policy
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

Fixing 2 bug:

1) Test wrongly continued testing on SUT with unsuitable IMA policy when
LTP_IMA_LOAD_POLICY=1 was *not* set.  That caused ima_keys.sh and
ima_kexec.sh TFAIL instead of TCONF.

2) Also don't attempt to load policy when needed but LTP_IMA_LOAD_POLICY=1
was *not* set.

This also reverts a5c47143b5 ("ima_measurements.sh: Check policy for test3")
which required the previous behavior. To restore behavior in the future
loading policy will need to be rewritten to allow check only for a
particular test or ima_measurements.sh can be split to require TCB
policy only for 3rd test.

Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../integrity/ima/tests/ima_measurements.sh        |  2 +-
 .../security/integrity/ima/tests/ima_setup.sh      | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index d1e41b789a..60350f3926 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -77,7 +77,7 @@ test3()
 	tst_res TINFO "verify not measuring user files"
 	tst_check_cmds sudo || return
 
-	if [ "$IMA_POLICY_CHECKED" != 1 ]; then
+	if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
 		tst_res TCONF "test requires specific policy, try load it with LTP_IMA_LOAD_POLICY=1"
 		return
 	fi
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 69ee5a3d65..366e1257dc 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -190,10 +190,10 @@ verify_ima_policy()
 			while read line; do
 				if ! grep -q "$line" $IMA_POLICY; then
 					tst_res TINFO "WARNING: missing required policy content: '$line'"
+					IMA_MISSING_POLICY_CONTENT=1
 					return 1
 				fi
 			done < $file
-			IMA_POLICY_CHECKED=1
 		else
 			tst_res TINFO "policy is not readable, failure will be treated as TCONF"
 			IMA_FAIL="TCONF"
@@ -208,13 +208,11 @@ load_ima_policy()
 {
 	local file="$TST_DATAROOT/$REQUIRED_POLICY_CONTENT"
 
-	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$IMA_POLICY_CHECKED" != 1 ]; then
-		tst_res TCONF "missing required policy, example policy can be loaded with LTP_IMA_LOAD_POLICY=1"
-		return 0
-	fi
-
-	if [ "$IMA_POLICY_CHECKED" = 1 ]; then
-		tst_res TINFO "valid policy already loaded, ignore LTP_IMA_LOAD_POLICY=1"
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 ]; then
+		if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
+			tst_brk TCONF "missing required policy, example policy can be loaded with LTP_IMA_LOAD_POLICY=1"
+		fi
+		return
 	fi
 
 	tst_res TINFO "trying to load '$file' policy:"
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
