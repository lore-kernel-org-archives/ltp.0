Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AC7CC6B03
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 12:03:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4244D3EA824
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:03:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9720C3EA812
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D9E460071B
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 14:02:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 769A121F3E;
 Tue, 13 Oct 2026 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txsoV5fggwuOBjNZnQat1QmD/F0IlfkUPYI/pk8ITBU=;
 b=qbmNsBgLke//zCZgQQkmToDD/+l9YDP6O4ny0LNV7nQYCm26Kben7FEVnwtVM8l6tvUj6J
 Up4ygfAFc98oGgI1VqBLyGZDVDmU9dI8Zbwt9qGf4Hqj576y5E9ZeA3KwuPvZefDAHnIVJ
 IaTgEW18UJmYe2pVCXXOs7I7GY08wfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txsoV5fggwuOBjNZnQat1QmD/F0IlfkUPYI/pk8ITBU=;
 b=KxqXC4eTsoC0VV10ykjQQBmo8NcvG2V3NfAg9GL+zWobDNaURtnK09pbr++zIgNGXzBxSv
 LJUydCJFgboYs1Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791892922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txsoV5fggwuOBjNZnQat1QmD/F0IlfkUPYI/pk8ITBU=;
 b=M4iOQGN1BByyg1bKU3yV4q3tWPcTSzv/FFO+CfaigFLd1xkQ9vNwmCbpGBrauW8wYq+A74
 I0h1CJ/UKIdeU/MBewEwkB93ckjCqOuKmw0s4GGei42y7+MP0nLyVMG/70ttlDwExsvf4p
 rYJvjv6ACEpEqvAE8Su4ELWZKeDp7pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791892922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txsoV5fggwuOBjNZnQat1QmD/F0IlfkUPYI/pk8ITBU=;
 b=kLFSXOzBeRgOHcXBSV5gOfqVLqCyKXG18xz47JY8FmotP3hbIJNzSGCFX9rrwHF6r0C9o9
 wZQPXkUEsLvqx/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 920EE1352C;
 Tue, 13 Oct 2026 12:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jWLfDrgdzmouEgAAD6G6ig:T9
 (envelope-from <andrea.cervesato@suse.de>); Tue, 13 Oct 2026 12:02:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 14:02:04 +0200
MIME-Version: 1.0
Message-Id: <20261013-fix_core_lib_deepseek-v2-8-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-0-7a6670fd6fd6@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791892920; l=1318;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=uaXIeqqv2mjA/szAN3FFSGD+eG91eyXZnLbc2b8IuxU=;
 b=NeOB5ng6yA3P+n5iPcUcG5Gadzgn2vhWmAXcVI0OXT032MwbbwS3hxYmF9zXtQWet6ux87iwN
 cxVg21l/AyyAW6An3ed+A0fZJPXF78swvjebDtrasXY7qitZabsVSNR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/15] ujson: writer: Return error when newline()
 fails
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

When out_ch(self, '\n') fails, newline() returns 0 instead of 1,
masking output write errors from the caller. ujson_obj_finish() and
ujson_arr_finish() also ignore the newline() return value. Return 1
on write failure and propagate it to the caller.

Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 libs/ujson/ujson_writer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index 040ae680e..c203ee079 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -179,7 +179,7 @@ static int do_padd(ujson_writer *self)
 static int newline(ujson_writer *self)
 {
 	if (out_ch(self, '\n'))
-		return 0;
+		return 1;
 
 	if (do_padd(self))
 		return 1;
@@ -261,8 +261,8 @@ int ujson_obj_finish(ujson_writer *self)
 
 	clear_depth_bit(self);
 
-	if (!first)
-		newline(self);
+	if (!first && newline(self))
+		return 1;
 
 	return out_ch(self, '}');
 }
@@ -304,8 +304,8 @@ int ujson_arr_finish(ujson_writer *self)
 
 	clear_depth_bit(self);
 
-	if (!first)
-		newline(self);
+	if (!first && newline(self))
+		return 1;
 
 	return out_ch(self, ']');
 }

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
