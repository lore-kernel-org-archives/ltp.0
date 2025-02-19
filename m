Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B9CC021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 18:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E55AE3C4FBC
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 19:19:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D90F3C3000
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 19:19:37 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AEFD1BDD86D
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 19:19:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42E0D216E0;
 Wed, 19 Feb 2025 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739989174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqhX+T7lpkr5ywY6YAcw8c+O+wn1nX6khswRb2kiXYk=;
 b=gpRQkusOWi2ffCdna/zlNDsN5c6Q5NYFvinDnEw49lsVnYpuiqvvRkUInr8Ujz7uN/+g0r
 Mf5EIyrS41luI+mJcafHqvj7/b3yObXqR7u6q0bj4RCQ9pXSKoJnwmxkuSq03Hjbai57Ti
 ntEFoW++czk9VEFDs0zgTiLSEUf94Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739989174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqhX+T7lpkr5ywY6YAcw8c+O+wn1nX6khswRb2kiXYk=;
 b=Bsw3E+nweNjvzK9MhWys6eAU0y46xzNxrPrHxVnPsBkGh88bSUfymcOf4QPNltowwHGFPJ
 /Xgsla2RkdXiQWAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gpRQkusO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bsw3E+nw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739989174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqhX+T7lpkr5ywY6YAcw8c+O+wn1nX6khswRb2kiXYk=;
 b=gpRQkusOWi2ffCdna/zlNDsN5c6Q5NYFvinDnEw49lsVnYpuiqvvRkUInr8Ujz7uN/+g0r
 Mf5EIyrS41luI+mJcafHqvj7/b3yObXqR7u6q0bj4RCQ9pXSKoJnwmxkuSq03Hjbai57Ti
 ntEFoW++czk9VEFDs0zgTiLSEUf94Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739989174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqhX+T7lpkr5ywY6YAcw8c+O+wn1nX6khswRb2kiXYk=;
 b=Bsw3E+nweNjvzK9MhWys6eAU0y46xzNxrPrHxVnPsBkGh88bSUfymcOf4QPNltowwHGFPJ
 /Xgsla2RkdXiQWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1C5D137DB;
 Wed, 19 Feb 2025 18:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCfSNbUgtmeqawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 18:19:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Feb 2025 19:19:25 +0100
Message-ID: <20250219181926.2620960-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219181926.2620960-1-pvorel@suse.cz>
References: <20250219181926.2620960-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 42E0D216E0
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ima_setup.sh: Check 'cat' exit code when loading
 policy
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

Parsing stderr should be enough, but check also 'cat' exit code
in case of error message change or other problem.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 9732aa7b43..83fcefb4fc 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -209,6 +209,7 @@ verify_ima_policy()
 load_ima_policy()
 {
 	local file="$TST_DATAROOT/$REQUIRED_POLICY_CONTENT"
+	local ret
 
 	if [ "$LTP_IMA_LOAD_POLICY" != 1 ]; then
 		if [ "$IMA_MISSING_POLICY_CONTENT" = 1 ]; then
@@ -228,6 +229,7 @@ load_ima_policy()
 	fi
 
 	cat "$file" 2> log > $IMA_POLICY
+	ret=$?
 	if grep -q "Device or resource busy" log; then
 		tst_brk TBROK "loading policy failed"
 	fi
@@ -236,6 +238,10 @@ load_ima_policy()
 		tst_brk TCONF "loading unsigned policy failed"
 	fi
 
+	if [ $ret -ne 0 ]; then
+		tst_brk TBROK "loading policy failed"
+	fi
+
 	IMA_POLICY_LOADED=1
 
 	tst_res TINFO "example policy successfully loaded"
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
