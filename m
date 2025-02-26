Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B33C18E7C
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 14:32:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13AEA3C9CFB
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 15:32:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C723C9CD3
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:31:26 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EEB902264C8
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:31:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB8F01F388;
 Wed, 26 Feb 2025 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfMu/3JfrbA5bNoi/djTx87vXcvQXuUqqSgX609cN+Q=;
 b=EszCvGrZJUoWmy6zdb7fu/XJAehW6sXTKLb/sNkdwBaLgEcnZk3YJW4gWJFwlkMhr8aBDo
 jG2DDLr7FVQ6N+K+oCB7MjC7V8aOHpX6/om+7HmAdDtpFljRLrbbEetCnnCyiHRrD7s2XK
 FZobkycOYZ8+8esTj5YyKeUyrZWZ+o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfMu/3JfrbA5bNoi/djTx87vXcvQXuUqqSgX609cN+Q=;
 b=XMb5565BKhzQYDOkN2/X9DlI9QwBxhn4XIEPDj1hKMyRB0Syc3xLqG4dz2/OVvu72Awwii
 cb7+4uaKKOjNLIDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EszCvGrZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XMb5565B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfMu/3JfrbA5bNoi/djTx87vXcvQXuUqqSgX609cN+Q=;
 b=EszCvGrZJUoWmy6zdb7fu/XJAehW6sXTKLb/sNkdwBaLgEcnZk3YJW4gWJFwlkMhr8aBDo
 jG2DDLr7FVQ6N+K+oCB7MjC7V8aOHpX6/om+7HmAdDtpFljRLrbbEetCnnCyiHRrD7s2XK
 FZobkycOYZ8+8esTj5YyKeUyrZWZ+o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfMu/3JfrbA5bNoi/djTx87vXcvQXuUqqSgX609cN+Q=;
 b=XMb5565BKhzQYDOkN2/X9DlI9QwBxhn4XIEPDj1hKMyRB0Syc3xLqG4dz2/OVvu72Awwii
 cb7+4uaKKOjNLIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F2E61377F;
 Wed, 26 Feb 2025 14:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iL7IDrklv2edRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 26 Feb 2025 14:31:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Feb 2025 15:31:13 +0100
Message-ID: <20250226143113.3016480-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226143113.3016480-1-pvorel@suse.cz>
References: <20250226143113.3016480-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CB8F01F388
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_HAS_CURRENCY(1.00)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid, suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] ima_setup.sh: Use $TST_REBOOT
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

Replace test specific $IMA_POLICY_LOADED with shell API specific
$TST_REBOOT.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_setup.sh      | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1f1c267c4b..79435eb185 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -236,9 +236,9 @@ load_ima_policy()
 		tst_brk TCONF "loading unsigned policy failed"
 	fi
 
-	IMA_POLICY_LOADED=1
+	TST_REBOOT=1
 
-	tst_res TINFO "example policy successfully loaded"
+	tst_res TINFO "WARNING: example policy successfully loaded due LTP_IMA_LOAD_POLICY=1, reboot recommended"
 	IMA_FAIL="TFAIL"
 	IMA_BROK="TBROK"
 }
@@ -281,10 +281,6 @@ ima_cleanup()
 	for dir in $UMOUNT; do
 		umount $dir
 	done
-
-	if [ "$IMA_POLICY_LOADED" = 1 ]; then
-		tst_res TINFO "WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended"
-	fi
 }
 
 set_digest_index()
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
