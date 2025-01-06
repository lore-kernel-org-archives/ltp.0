Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46A5E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:04:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 142683C4C17
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 15:04:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AF483C291A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 15:04:16 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1FB02639D9A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 15:04:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 874612115D;
 Mon,  6 Jan 2025 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736172254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cP2LD8W8cdgm0JfLPty/45k+MKO9JfDBSXXbOKFpYFQ=;
 b=AvZQm5USmg/q3mT0MoOrPY9DUCqkEqaJ9VqaDBDR9KZC5Bsqc8hLrbS7oh77XsXxjHaCKb
 4jDvzfAN3Jmh6OazmrmeWWUMW8zHKeCmFWort4m2GF9149Tg1C/fydoaHGW26Aw2UOuCTw
 8hX2qqOkNVyfBnpEbcd6pcjixbrdl14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736172254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cP2LD8W8cdgm0JfLPty/45k+MKO9JfDBSXXbOKFpYFQ=;
 b=OB8NoqbCq0IaFWb3w3moWyLFqiFQDujyL/F4IS8HAToYKq0DdX54O/OHWxHf+Ixdc4CL8y
 2xtf5f+Bp0pG85Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AvZQm5US;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OB8NoqbC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736172254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cP2LD8W8cdgm0JfLPty/45k+MKO9JfDBSXXbOKFpYFQ=;
 b=AvZQm5USmg/q3mT0MoOrPY9DUCqkEqaJ9VqaDBDR9KZC5Bsqc8hLrbS7oh77XsXxjHaCKb
 4jDvzfAN3Jmh6OazmrmeWWUMW8zHKeCmFWort4m2GF9149Tg1C/fydoaHGW26Aw2UOuCTw
 8hX2qqOkNVyfBnpEbcd6pcjixbrdl14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736172254;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cP2LD8W8cdgm0JfLPty/45k+MKO9JfDBSXXbOKFpYFQ=;
 b=OB8NoqbCq0IaFWb3w3moWyLFqiFQDujyL/F4IS8HAToYKq0DdX54O/OHWxHf+Ixdc4CL8y
 2xtf5f+Bp0pG85Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96390137DA;
 Mon,  6 Jan 2025 14:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /IR0I93ie2dhNAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jan 2025 14:04:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Jan 2025 15:04:02 +0100
Message-ID: <20250106140402.52196-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 874612115D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] runtest/ltp-aiodio.part4: Remove duplicate entries
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

Duplicate content was added in 67ce2884aa (2006).

It probably did not make sense to run it more times even at the time,
but it certainly does not make sense now (runltp and kirk run tests
sequentially one by one).

While at it, remove bogus comments.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ltp-aiodio.part4 | 55 ++--------------------------------------
 1 file changed, 2 insertions(+), 53 deletions(-)

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index de00b8a786..8e7354296d 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -1,65 +1,14 @@
 aio01 aio01
 aio02 aio02
 
-#Running dio_sparse & dirty tests
 DI000 dirty
 DS000 dio_sparse
-DI001 dirty
-DS001 dio_sparse
-DI002 dirty
-DS002 dio_sparse
-DI003 dirty
-DS003 dio_sparse
-DI004 dirty
-DS004 dio_sparse
-DI005 dirty
-DS005 dio_sparse
-DI006 dirty
-DS006 dio_sparse
-DI007 dirty
-DS007 dio_sparse
-DI008 dirty
-DS008 dio_sparse
-DI009 dirty
-DS009 dio_sparse
-#iteration on dio_sparse
-DIO00 dio_sparse
-DIO01 dio_sparse
-DIO02 dio_sparse
-DIO03 dio_sparse
-DIO04 dio_sparse
-DIO05 dio_sparse
-DIO06 dio_sparse
-DIO07 dio_sparse
-DIO08 dio_sparse
-DIO09 dio_sparse
-#Running aiodio_append
 AD000 aiodio_append
-AD001 aiodio_append
-AD002 aiodio_append
-AD003 aiodio_append
-AD004 aiodio_append
-AD005 aiodio_append
-AD006 aiodio_append
-AD007 aiodio_append
-AD008 aiodio_append
-AD009 aiodio_append
-#Running dio_append
 ADI000 dio_append
-ADI001 dio_append
-ADI002 dio_append
-ADI003 dio_append
-ADI004 dio_append
-ADI005 dio_append
-ADI006 dio_append
-ADI007 dio_append
-ADI008 dio_append
-ADI009 dio_append
-#Running dio_truncate
+
 DIT000 dio_truncate -n 1
 DIT001 dio_truncate
-DIT002 dio_truncate
-#Running dio_read
+
 DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 32M
 DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 32M
 DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 32M
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
