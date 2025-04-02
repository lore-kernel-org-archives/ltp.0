Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C94DC36018
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 22:42:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B9423CB24E
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 00:42:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E18B3CB1DE
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 00:41:59 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A7F26200085
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 00:41:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5171E21190;
 Wed,  2 Apr 2025 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743633715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XT7rj0/Cz/+/EEDXuYdmSpadvBB+qbjLeHy3DwPVYCg=;
 b=HyVuhBdZkFniAFRbX/sd8L22kyyxROAxUc9iD6rh9qZ1HHEfUakcAsJhqIWpRPtLvudQ75
 S7apAr8UNc5gcdIR9JY9UO7L6CbJsrX0ECLRPdg8Hw/Hjs6QnUty5EexLi8qrRKQ56Nv9M
 Ci6Rh5FSUEW67lDCFLQ4rwkFFytYLwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743633715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XT7rj0/Cz/+/EEDXuYdmSpadvBB+qbjLeHy3DwPVYCg=;
 b=UobkpgZZAl3t7bru6TKxXuPywBWtVoi42qijF4QmgQUu/xQjZnzB2wwRZCcj1OwhXIUn4l
 2kg3Rh7O4xIRoKAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HyVuhBdZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UobkpgZZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743633715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XT7rj0/Cz/+/EEDXuYdmSpadvBB+qbjLeHy3DwPVYCg=;
 b=HyVuhBdZkFniAFRbX/sd8L22kyyxROAxUc9iD6rh9qZ1HHEfUakcAsJhqIWpRPtLvudQ75
 S7apAr8UNc5gcdIR9JY9UO7L6CbJsrX0ECLRPdg8Hw/Hjs6QnUty5EexLi8qrRKQ56Nv9M
 Ci6Rh5FSUEW67lDCFLQ4rwkFFytYLwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743633715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XT7rj0/Cz/+/EEDXuYdmSpadvBB+qbjLeHy3DwPVYCg=;
 b=UobkpgZZAl3t7bru6TKxXuPywBWtVoi42qijF4QmgQUu/xQjZnzB2wwRZCcj1OwhXIUn4l
 2kg3Rh7O4xIRoKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C7B9137D4;
 Wed,  2 Apr 2025 22:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r62UCTO97WekOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 02 Apr 2025 22:41:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Apr 2025 00:41:48 +0200
Message-ID: <20250402224148.435022-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5171E21190
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH] ima_violations.sh: Fix min kernel version
 for test4+
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

Although 79eb71fae5 claims test[4-8] require kernel 6.14, it's actually for 6.15.
2 kernel commits were part of integrity-v6.15 and merged into mainline
as a2d4f473df11. They will be part of 6.15-rc1.

While at it, document these kernel commits.

Fixes: 79eb71fae5 ("ima_violations.sh: require kernel v6.14 for minimizing violations tests")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi, all,

I'm sorry not catching this:
https://lore.kernel.org/linux-integrity/174319448478.2953471.5705766506609559454.pr-tracker-bot@kernel.org/T/#t

We got this because openSUSE Tumbleweed reached 6.14 few days ago.
Merged as
https://github.com/linux-test-project/ltp/commit/34e13f8a76e801b8f4c3444beed2ed358324066e

Kind regards,
Petr

 .../kernel/security/integrity/ima/tests/ima_violations.sh   | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index c6b929a233..1d2f1d9447 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -5,6 +5,8 @@
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
+# test[4-6] test 6.15 commit 5b3cd801155f ("ima: limit the number of open-writers integrity violations")
+# test[7-8] test 6.15 commit a414016218ca ("ima: limit the number of ToMToU integrity violations")
 
 TST_SETUP="setup"
 TST_CLEANUP="cleanup"
@@ -176,8 +178,8 @@ test4()
 {
 	tst_res TINFO "verify limiting single open writer violation"
 
-	if tst_kvcmp -lt 6.14; then
-		tst_brk TCONF "Minimizing violations requires kernel 6.14 or newer"
+	if tst_kvcmp -lt 6.15; then
+		tst_brk TCONF "Minimizing violations requires kernel 6.15 or newer"
 	fi
 
 	local search="open_writers"
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
