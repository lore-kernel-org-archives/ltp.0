Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4924C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:02:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31D1F3E2947
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:02:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 083853E5C8E
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:01:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 92DC46008DF
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:01:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6E575DE9;
 Thu,  9 Jul 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783602112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HR5Q+nd8JrUl548fci/PvE53FlsJILQt7kjKfSSlkw=;
 b=y12dJRiIFC62amPgMzPOqWsqMEQ2+X512TYy/Bld4/rd4UBKtx6YN/5iwVs7TlxqeeF+hi
 ysPYJ9DOPeWMN2xi1vpZ6GIA+HcfLVDCX3Q+jmpkCeryjaZgGcEGeoEhT4vC+aCXBg9BdM
 0TKQMMaI1FoiExgE1/juQ9MN50EIhjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783602112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HR5Q+nd8JrUl548fci/PvE53FlsJILQt7kjKfSSlkw=;
 b=c2PPCXxNZ1Ffj7yPlbVcF8c1+Zhs8Y2wBaEz7jjOqaDwuEQIqCJ1tfmHebcoRlgKASDgjZ
 RffWryesNNGO6SCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QYxfHN9a;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="r4/veJSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783602108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HR5Q+nd8JrUl548fci/PvE53FlsJILQt7kjKfSSlkw=;
 b=QYxfHN9acrgNxeyOyybBwzb0aKmmMrDdBS7PlYf86YeBbjNK2sinCFdzsrNzD3VOEUjVuZ
 FL85XrQlY+X9lLJp+shsyt/bbDxhOKKwEgf/+U8hFaM4cSjo7ifufL4zUODJ2R75irDZ5A
 jMoFOnNzVHYCb+0pgFeHpOJakZ43Kec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783602108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4HR5Q+nd8JrUl548fci/PvE53FlsJILQt7kjKfSSlkw=;
 b=r4/veJSgloJVy4Ccbnvp+Eef8hcWTImCluenGkwUIkxeUg6gD9mEbsFAs1jyWmawBAnJRt
 1c+B2/3pBQ4vXUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9306779B4;
 Thu,  9 Jul 2026 13:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BNGMLubT2rtFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jul 2026 13:01:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jul 2026 15:01:35 +0200
Message-ID: <20260709130135.927868-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709130135.927868-1-pvorel@suse.cz>
References: <20260709130135.927868-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D6E575DE9
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] metadata: test.sh: Print the test name and result
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

Always print the test name with the result. This helps a readability
in the CI.

    * multiline_macro.c [OK]
    * regression.c [FAIL]
    regression.c output differs!
    --- tmp.json	2026-07-09 14:27:15.590074023 +0200
    +++ regression.c.json	2026-07-09 14:27:06.083967188 +0200
    @@ -6,7 +6,7 @@
	 ]
	],
	"doc": [
    -    "Test for regression group derived from the linux-git tag."
    +    "Test for regression group derived from the foo tag."
	],
	"groups": [
	 "regression"
    * tags.c [OK]

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 metadata/tests/test.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/metadata/tests/test.sh b/metadata/tests/test.sh
index 475d721df0..a9ebc768f9 100755
--- a/metadata/tests/test.sh
+++ b/metadata/tests/test.sh
@@ -3,13 +3,15 @@
 fail=0
 
 for i in *.c; do
+	printf "* $i "
 	../metaparse $i > tmp.json
 	if ! diff tmp.json $i.json >/dev/null 2>&1; then
-		echo "***"
+		echo '[FAIL]'
 		echo "$i output differs!"
 		diff -u tmp.json $i.json
-		echo "***"
 		fail=1
+	else
+		echo '[OK]'
 	fi
 done
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
