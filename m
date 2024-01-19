Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3ADC4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 13:53:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21A7F3CE2D3
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 14:53:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CBB43CBB56
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 14:52:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DFB9960118E
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 14:52:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE2271F7F1;
 Fri, 19 Jan 2024 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705672377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xjqqToMsWhYPqVT9iuA9qaHS4xef6118oV7MWbM8huU=;
 b=Ir+thWtqpoZ+3KX7Xech1qazTL8Zl1vxxGd6xOJsL+v7b12PpcVc+nxUr4uMp1H0Qs1sL0
 ++1LC1zOyA32lUlKsoVxz2/eLfOKxxXgzjv/j2M8zp01bMm7gpgho/vdnPWg554R9nobmG
 rdnfpNz2MqcFvEpEm8F1I1u1Io1I/z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705672377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xjqqToMsWhYPqVT9iuA9qaHS4xef6118oV7MWbM8huU=;
 b=RrlfB02MUW5JPtWeGSvHR2rWG8TzOHsMCKmaccUCV0T961G3bEJhXXkFVeqbZMl3mnbsTN
 G/g8hh9xcktw+UDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705672376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xjqqToMsWhYPqVT9iuA9qaHS4xef6118oV7MWbM8huU=;
 b=hQNRkOgEzv2VcQK2ag/nmutpQcOFn2Vh/6SoRu8mY6lQfsml4M0naTxIFLypyV0L5cgtDp
 JvvrsydvJDgTnqaB80Y3wEHz6wJTOoLql33PVSmBNQATLvZB76h3zieHOPohfbPd3P5FiH
 bu2JVuLEeX95AWRgagHmAKvFwKLQQYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705672376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xjqqToMsWhYPqVT9iuA9qaHS4xef6118oV7MWbM8huU=;
 b=/9BL4UfplcLsXCT1dK24ZrYNpR4BHMNHumw/rKKjnJUhOvVVII/DlCy8HYuo9YFUBt3kNx
 9wswgf2raJxFNGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0C4C1388C;
 Fri, 19 Jan 2024 13:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zr/zLbh+qmUWJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Jan 2024 13:52:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 14:52:52 +0100
Message-ID: <20240119135252.32420-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[44.75%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] libswap: Pass enum instead of int to
 make_swapfile()
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

Not only that enum is better than int (we should not rely on
TST_CMD_PASS_RETVAL being 1, but also it was missing
TST_CMD_TCONF_ON_MISSING, thus on systems without mkswap test reported
wrong results on filesystems which supports swap:

TFAIL: mkswap on ext2/ext3/ext4 failed

Now it correctly print:

tst_cmd.c:75: TCONF: Couldn't find '___mkswap' in $PATH at tst_cmd.c:75

Fixes: ec51970b7 ("lib/tst_cmd_*(): Turn int pass_exit_val into enum")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

obviously OK, but before git freeze I rather post than directly push.

Kind regards,
Petr

 libs/libltpswap/libswap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index d014325e5..13610709e 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -30,7 +30,8 @@ int make_swapfile(const char *swapfile, int safe)
 	argv[1] = swapfile;
 	argv[2] = NULL;
 
-	return tst_cmd(argv, "/dev/null", "/dev/null", safe);
+	return tst_cmd(argv, "/dev/null", "/dev/null", safe ?
+				   TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
 }
 
 /*
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
