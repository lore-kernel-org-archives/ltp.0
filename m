Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA99E77184
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 14:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1ACB3ECB2F
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 15:51:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 769233EBEDA
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 15:50:50 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CAFA9100E33C
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 15:50:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEE861F45E;
 Tue, 17 Dec 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734447047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Nnlp5yfqoWcNQOBdw61nlM1HoFeluw0doA7+NeHlVM=;
 b=Uyd4jGj3+RgpnpLJMegvKxJywlj2ZkpS8k1YqftUYt+y0UCXy96/Va94QvjCV6NBBlhanf
 ZBN60AOYFLqz8iM35m6aqvFiSu5H6hmx+dL+poYvGEuZCb1aGyUz8iauKGEvrWC0Pp04qp
 65WSHtv1+4FkYKqk8rNfWE2SKmel8QM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734447047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Nnlp5yfqoWcNQOBdw61nlM1HoFeluw0doA7+NeHlVM=;
 b=q7tG0LnHgiRDJPmgC8IVkbt5i1xDLG4nkfxCxmHQrnRWbn/G0brhc50cFYcOIysEdZOVUd
 nIiuUZwUn6VvlICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D5513A4B;
 Tue, 17 Dec 2024 14:50:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8ICbIMePYWfJFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Dec 2024 14:50:47 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 15:50:41 +0100
Message-ID: <20241217145041.44600-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217145041.44600-1-pvorel@suse.cz>
References: <20241217145041.44600-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: CEE861F45E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ip_tests.sh: Update TST_NEEDS_CMDS
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

Add 'ip' (obviously), 'lsmod' and 'modprobe'.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/iproute/ip_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index 0b1d5a85e6..77940481a1 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -12,7 +12,7 @@ TST_TESTFUNC="test"
 TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="cat awk diff"
+TST_NEEDS_CMDS="awk cat diff ip lsmod modprobe"
 TST_NEEDS_DRIVERS="dummy"
 
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
