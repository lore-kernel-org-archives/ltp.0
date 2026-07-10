Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED1EC44501
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 05:56:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA34C3E273F
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:56:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9FF23E27A5
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 60FDA2000EF
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:56:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16386765FE;
 Fri, 10 Jul 2026 05:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4PqnsxTDC4El3zplwWzDse33QNRq30hMhHZKGWfehI=;
 b=H3KM2CPc0trafD4afui8G8EbuWbXXIrBk7Iitb+QU6uxdC6OIpNFMqZQB3lA5gxTFfiRkL
 CzDq03l2JVt0PLtleKEsCHEIidkYnB2v3cj4zR8QlgSTwtLe2ECHcRmgTYOAxUlschEDpY
 4PHKVd4Lk1A5uuGNjLYADwMuhgFfSEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4PqnsxTDC4El3zplwWzDse33QNRq30hMhHZKGWfehI=;
 b=29LLSycvEtz9WOepaFnqvni+ww0+JAATGItG0SNs/rr8wqvgdhzRGajydEh4lFZWxmMxG2
 FEkPBW7eFLApCLAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H3KM2CPc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=29LLSycv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783662960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4PqnsxTDC4El3zplwWzDse33QNRq30hMhHZKGWfehI=;
 b=H3KM2CPc0trafD4afui8G8EbuWbXXIrBk7Iitb+QU6uxdC6OIpNFMqZQB3lA5gxTFfiRkL
 CzDq03l2JVt0PLtleKEsCHEIidkYnB2v3cj4zR8QlgSTwtLe2ECHcRmgTYOAxUlschEDpY
 4PHKVd4Lk1A5uuGNjLYADwMuhgFfSEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783662960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4PqnsxTDC4El3zplwWzDse33QNRq30hMhHZKGWfehI=;
 b=29LLSycvEtz9WOepaFnqvni+ww0+JAATGItG0SNs/rr8wqvgdhzRGajydEh4lFZWxmMxG2
 FEkPBW7eFLApCLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE936779BF;
 Fri, 10 Jul 2026 05:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WHM8OW+JUGp7TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 05:55:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 07:55:50 +0200
Message-ID: <20260710055556.1109220-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710055556.1109220-1-pvorel@suse.cz>
References: <20260710055556.1109220-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 16386765FE
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/8] metadata: test.sh: Print the test name and
 result
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
* The same as in v1

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
