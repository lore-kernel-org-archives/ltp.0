Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D0AC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 06:39:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE2153CE227
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:39:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 164223CB23F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:38:49 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF9D86000F6
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 07:38:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1DC21FB82;
 Mon, 22 Jan 2024 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705905527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rUidAVapD1y7uwrcWLRFbhheKYNT5ed+uXWrPehw0Gc=;
 b=woqOE9ITnNxUVnLx0gOAGrEd6v4r62eRE/MDkuXruYP7rRkLMMB3S7crgLO3OSk5NxdGhT
 iX6nB/MnHESBWGhlFEaajt0Af0rkUkJQR1Ufbe3ECbVWITXvf6TTwNs9w+I1JE4vAO7e9n
 WLXARDzv7DSmyrOfExuUqu6NuDpgY8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705905527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rUidAVapD1y7uwrcWLRFbhheKYNT5ed+uXWrPehw0Gc=;
 b=oDshsbFOCTrxYTMw/YAaifPJY14xB0eUbk2JKua4cIXsxQrR62SsWqvq7FYtvVe0xvxvgf
 hy6mLpua/vip+3BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705905526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rUidAVapD1y7uwrcWLRFbhheKYNT5ed+uXWrPehw0Gc=;
 b=l1vulc+AFA5NC0Y699fl2X0h0vXv64gPAP6U1R/KlNTf1RGW36+e2uRBLsZIpYrPDb9A0W
 PXacPlPuY6qcakDVBtLaNqo+WTX8ZJZdc5Iv737MAwGBHY4M7FOLn0+jpz/uv39Fk6iC4+
 7q2CxvXjCIXyVps+JqPziZrctH9yESE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705905526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rUidAVapD1y7uwrcWLRFbhheKYNT5ed+uXWrPehw0Gc=;
 b=Juq6Btpc3hkO0VwXHpCa4mxEJnqvA57QPG12vgmLv80qgBm39baV1Kpzq2OlV/sW/nkqw1
 C3pFngGrmuSf34CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77DB513995;
 Mon, 22 Jan 2024 06:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5AK/G3YNrmWLPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 06:38:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 07:38:30 +0100
Message-ID: <20240122063830.62477-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l1vulc+A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Juq6Btpc
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[44.73%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A1DC21FB82
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] keyctl05: Require root
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

Modprobe always require root.

Fixes: f4e132233 ("keyctl05: Add modprobe dns_resolver")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I hate require root for setup work, but in this case is needed in order
to get dns_resolver tested. I'm sorry to forget on this.

Kind regards,
Petr

 testcases/kernel/syscalls/keyctl/keyctl05.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index a79a5763b..78ac490da 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -228,6 +228,7 @@ static void do_test(unsigned int i)
 }
 
 static struct tst_test test = {
+	.needs_root = 1,
 	.tcnt = 3,
 	.setup = setup,
 	.test = do_test,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
