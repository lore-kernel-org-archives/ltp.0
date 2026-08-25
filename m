Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80A6C5B572
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 04:55:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84F663CFAFA
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 06:55:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AD3F3C900A
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:55:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C531200989
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:55:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D1E11F74D;
 Tue, 25 Aug 2026 04:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787633726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mie/3cyqpZyf3RoQzfKnk4+1jJU3yj1P9pXr8AwwcrA=;
 b=uY13ePyOvRaUvznH24mhTkqYBL8y6kWj3RnEuoYIFnul+Nzsomi2Mt6oRnWu0ilh1Z1vbc
 Q5gE+eg4X6n6scQJJM0G2GhZUOPmkwBJ3sRxWwnURch9yKntfk8Otk6tI9Y29X/fTCIDnE
 XjWzwbIhujOs4yXjym127DHCyaHarJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787633726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mie/3cyqpZyf3RoQzfKnk4+1jJU3yj1P9pXr8AwwcrA=;
 b=XV7WW0/trvHgmlftJpjj/sw3gCX2Ii+G+AMCquRr/ze7KIox5TFtSBwt0bHW+bof1Q9dER
 hrC9B4RdEnVmTUAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gPyeStDy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hCyCTfzi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787633722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mie/3cyqpZyf3RoQzfKnk4+1jJU3yj1P9pXr8AwwcrA=;
 b=gPyeStDydjbqWw/q8bbibYV7GfRC/F/ipssauE1qACRqzUNmHPGF2mycHYl8wrASwnfPI8
 LrHTWrXLHXxO+j2HQS/31pGkGtz5LGI06ofUVU/bhIWkn2+z//sqtSvmn/kHi4PLbmKRPS
 kIV3ItdINtNq+EsgEBMssttbxJL6THY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787633722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mie/3cyqpZyf3RoQzfKnk4+1jJU3yj1P9pXr8AwwcrA=;
 b=hCyCTfzi/G639RpGet2P6g8VqXfMGhrkPItoV/6YIuNQSWe4WeCBaJOToj2dxESNQ5wZcD
 L++Md6H775Jy1zCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30CE613331;
 Tue, 25 Aug 2026 04:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K3+SCjogjWqGQAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 25 Aug 2026 04:55:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 06:55:15 +0200
Message-ID: <20260825045515.24503-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 4D1E11F74D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: test.sh: Backport tst_cmd_available (DRY)
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

Backport tst_cmd_available() from tst_test.sh in order to have 'command -v'
used only once. That helps to maintain LTP preferred way to check
command in shell.

Follow-up: 772e7d6851 ("lib: test: check systemd in tst_virt_hyperv() as tst_test.sh")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index edae1313ed..0d4f3fe4d2 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -148,6 +148,11 @@ tst_rmdir()
 	fi
 }
 
+tst_cmd_available()
+{
+	command -v $1 >/dev/null 2>&1
+}
+
 #
 # Checks if commands passed as arguments exists
 #
@@ -155,9 +160,7 @@ tst_require_cmds()
 {
 	local cmd
 	for cmd in $*; do
-		if ! command -v $cmd > /dev/null 2>&1; then
-			tst_brkm TCONF "'$cmd' not found"
-		fi
+		tst_cmd_available $cmd || tst_brkm TCONF "'$cmd' not found"
 	done
 }
 
@@ -331,7 +334,7 @@ tst_virt_hyperv()
 {
 	local v
 
-	command -v systemd-detect-virt > /dev/null 2>&1 || return 1
+	tst_cmd_available systemd-detect-virt || return 1
 
 	v="$(systemd-detect-virt)"
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
