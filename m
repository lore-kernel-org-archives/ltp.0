Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3902E6897A
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:59:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BCCC3CBF6D
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 12:59:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5733CBF77
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:57:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E84D11F0155
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:57:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3D5F1FE52;
 Thu, 31 Oct 2024 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730375864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdI0qDpKUOs2XaSh+hPyt9S2Rfdj5WQxJEo08i3e1rE=;
 b=qtni7DZlwDyv5hrYG5g+CsiOkoLCNBQbRZjiTZY/yvNRQOcGw57o6IL3kDxd6ySTi+mekt
 MQHNaA8qQ0dpEcaYjTJaE7XTvNvFFyG+NZws0m0Yf/wQjsLUOxcDZHTe3X9jn0lPueopq3
 3zH10dH4TPguYrI9hekvnQnO78Kl/vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730375864;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdI0qDpKUOs2XaSh+hPyt9S2Rfdj5WQxJEo08i3e1rE=;
 b=tHeq8h2Cn+quhPOxROVoxvucHFAmtCq81Cj31PouO8ec3X4oOMXoD2AejKrd+FNZ0fHti+
 k+VBWHDkmVGIcIDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730375863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdI0qDpKUOs2XaSh+hPyt9S2Rfdj5WQxJEo08i3e1rE=;
 b=2Otw3g1hAGuZ/3RAOXZEA2helCyfH/rgl+p++701JEOkyOkitVXnT0hKzZg/H4i3J1dDDz
 j6XyUuDC1guYE5cdniioRb8Bcq+cOMjjzkv+p8kLdXSuVXfg1KhcZbT3HnLUNB20RV9alk
 0Pc2Bi7NT00ByjebnH2Lh1YRZS5pmlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730375863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdI0qDpKUOs2XaSh+hPyt9S2Rfdj5WQxJEo08i3e1rE=;
 b=2JKXC4ErU9YuHXMvcmxIpNaYD9uo9t6Pfk1yX4WottEltjBlclPnMyt8gGJy3YGFL9/eBa
 yG3hqs+/zR0EmSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 890C413A53;
 Thu, 31 Oct 2024 11:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sG29GrVwI2dxWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Oct 2024 11:57:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 31 Oct 2024 12:57:34 +0100
MIME-Version: 1.0
Message-Id: <20241031-generate_syscalls-v7-3-f3e26c06814e@suse.com>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
In-Reply-To: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730375857; l=1094;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=F7I1keLFvhriKu4IZMOwZ51V8RIvSwlzc5gA76cLfTQ=;
 b=MLFFCNtzRCb55I16ozTpT5SHgb+jkZiAKxoZyzVDz/RnoQ67qip2REmnA6DJSe0jF1W+AOMtr
 Sgpzb23v0cVBE7mSXO5R3TPsO6imseGy4lA71rBiOBKzRC0qnVweZ1O
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email, i386.in:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/4] Delete obsolete strip_syscall.awk file
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

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/strip_syscall.awk | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/lapi/syscalls/strip_syscall.awk b/include/lapi/syscalls/strip_syscall.awk
deleted file mode 100755
index e8dff422e2667745c144ed984a4d66461fcce0c6..0000000000000000000000000000000000000000
--- a/include/lapi/syscalls/strip_syscall.awk
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/usr/bin/awk -f
-#
-# Dumb script that can be used to strip all of the syscall information from
-# the arch-respective unistd*.h.
-#
-# Examples:
-#
-# 1. Grab the i386 32-bit syscalls from unistd_32.h and put them in i386.in
-# strip_syscall.awk arch/x86/include/asm/unistd_32.h > i386.in
-#
-
-/^#define[[:space:]]+__NR_[0-9a-z]+/ {
-
-	sub (/#define[[:space:]]+__NR_/, "", $0);
-	sub (/[[:space:]]*(\/\*.*)/, "", $0);
-	sub (/[[:space:]]+/, " ", $0);
-
-	print
-}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
