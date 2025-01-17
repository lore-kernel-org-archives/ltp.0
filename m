Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE37C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFD9C3C7AD8
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:56:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14D453C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:55:43 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C973633859
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:55:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1A91F38E;
 Fri, 17 Jan 2025 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737122142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RtMUvO9OvkYKbBlLJzuwb5wWEmhtRcjk1vo4eMw2KZU=;
 b=Cfssoi/Uk/FysgljEXIKJIOD7DBDKVkHouEl1jRO285gh/BBt+9FhMaQSiLtZnh97nGSlf
 1FKZTbHzBE1eS5VEPjENtR45xkXNWUP13XRrsaIaDGZZ8KHEPDdbfbkWHzzA0lkc2+23a9
 mpbM30d4FPuK3o2lH61+xCtS65J+mpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737122142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RtMUvO9OvkYKbBlLJzuwb5wWEmhtRcjk1vo4eMw2KZU=;
 b=3g3pUJ4q+7bsKuIpd+oM9L0UH/MkXnwjxSLQEIETEydK4Fm+gyJYetQWq5ySAus5ZQfcAs
 FhW8KIF5bpER+mAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737122142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RtMUvO9OvkYKbBlLJzuwb5wWEmhtRcjk1vo4eMw2KZU=;
 b=Cfssoi/Uk/FysgljEXIKJIOD7DBDKVkHouEl1jRO285gh/BBt+9FhMaQSiLtZnh97nGSlf
 1FKZTbHzBE1eS5VEPjENtR45xkXNWUP13XRrsaIaDGZZ8KHEPDdbfbkWHzzA0lkc2+23a9
 mpbM30d4FPuK3o2lH61+xCtS65J+mpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737122142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RtMUvO9OvkYKbBlLJzuwb5wWEmhtRcjk1vo4eMw2KZU=;
 b=3g3pUJ4q+7bsKuIpd+oM9L0UH/MkXnwjxSLQEIETEydK4Fm+gyJYetQWq5ySAus5ZQfcAs
 FhW8KIF5bpER+mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12F7139CB;
 Fri, 17 Jan 2025 13:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x2WtNV1himeydgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 13:55:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 14:55:38 +0100
Message-ID: <20250117135539.773036-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.75 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; SUBJECT_HAS_CURRENCY(1.00)[];
 NEURAL_HAM_LONG(-0.95)[-0.955]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_net.sh: print test link type instead of $RHOST
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

When message was added back in 18739ff06e, both rsh and ssh used $RHOST.
Later, when 5f8ca6cf04 network namespaces support (TST_USE_NETNS=1) was
added it would have been better to print test link type (rsh/ssh/netns
at the time). Do it now.

NOTE: more debug info can be printed with TST_NET_RHOST_RUN_DEBUG=1
therefore no need to add more info about the connection here.

Fixes: 5f8ca6cf04 ("network: test_net.sh: allow to run network tests on a single machine")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ee0ae1cad7..9a8b8d7214 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -263,7 +263,7 @@ tst_rhost_run()
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
 		[ "$safe" ] && \
-			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
+			tst_brk_ TBROK "'$cmd' failed on $use: '$output'"
 	fi
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
