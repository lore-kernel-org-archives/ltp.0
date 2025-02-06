Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C212CC02198
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:35:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B4203C04A5
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:35:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3CAF3C04A5
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:34:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 56D351C2FD03
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:34:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6867F210F6;
 Thu,  6 Feb 2025 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738856081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzR2OqRfuNeCsMrfLUTTK128Gb4Af1s25YIYzNEFFUU=;
 b=gjSo9X/zS7/wjQ8fe7KoI9Qv3FnEWHkYAFBwgRO0xOgFwR0bNjW6cVptjwE3i001RjQwAe
 YmCXx6C0N5ITAHcNJybin1sx1cGGaUnuX1+aZOvqdYKTNrtCDx7AIHIJ1Ld9zmxx3Lr/vN
 eUQbZSS0+zl5gsomfDIkSRvOdOcLijg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738856081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzR2OqRfuNeCsMrfLUTTK128Gb4Af1s25YIYzNEFFUU=;
 b=j79r38cPkvSgujlY7iJPViDbnRYxAj6bE7H9NyotfOFiRgHTY3noiwx4AdEnZDwkVq6G3e
 ZaJ6QHtImtK1y7Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="gjSo9X/z";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j79r38cP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738856081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzR2OqRfuNeCsMrfLUTTK128Gb4Af1s25YIYzNEFFUU=;
 b=gjSo9X/zS7/wjQ8fe7KoI9Qv3FnEWHkYAFBwgRO0xOgFwR0bNjW6cVptjwE3i001RjQwAe
 YmCXx6C0N5ITAHcNJybin1sx1cGGaUnuX1+aZOvqdYKTNrtCDx7AIHIJ1Ld9zmxx3Lr/vN
 eUQbZSS0+zl5gsomfDIkSRvOdOcLijg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738856081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzR2OqRfuNeCsMrfLUTTK128Gb4Af1s25YIYzNEFFUU=;
 b=j79r38cPkvSgujlY7iJPViDbnRYxAj6bE7H9NyotfOFiRgHTY3noiwx4AdEnZDwkVq6G3e
 ZaJ6QHtImtK1y7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 307AB13AB2;
 Thu,  6 Feb 2025 15:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CArKCpHWpGcUOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 15:34:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  6 Feb 2025 16:34:32 +0100
Message-ID: <20250206153435.1602181-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206153435.1602181-1-pvorel@suse.cz>
References: <20250206153435.1602181-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6867F210F6
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] doc/Makefile: Improve clean target
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

Delete generated files - sync with .gitignore.

Fixes: 4a72aada87 ("New LTP documentation")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index c5f60dfa1e..f5757eadc6 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -12,4 +12,4 @@ spelling:
 	sphinx-build -b spelling -d build/doctree . build/spelling
 
 clean:
-	rm -rf html/
+	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
