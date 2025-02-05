Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78A1C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 21:58:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B43F3C9267
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 22:58:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 634143C9265
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 22:57:17 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7832E140E6D9
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 22:57:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF1E621162;
 Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6295139D8;
 Wed,  5 Feb 2025 21:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oMRaJ7zeo2eYEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Feb 2025 21:57:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Feb 2025 22:57:08 +0100
Message-ID: <20250205215709.1526151-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205215709.1526151-1-pvorel@suse.cz>
References: <20250205215709.1526151-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DF1E621162
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED 2/2] ima_setup.sh: Quit the test on
 unsuitable IMA policy
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
