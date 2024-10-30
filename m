Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB35D2AB2C
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 08:54:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 713C43CAA69
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 09:54:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631813C7270
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:53:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E1E3A6469D3
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:53:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A046A21E4C;
 Wed, 30 Oct 2024 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730278398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aMl8D7YwC7WWMKvB5K5Y699pDsfmtKwLoj4TKgDvGc=;
 b=0k/UzuPbIY/bggZVUJaBTeWm+q7s9AUxic0SbgNSpC0wV3BKc4ya37HvqQTZln0wA++5k5
 iLp4Y8FZFPIV54J6g10ZgBUrZOOSHr27yw/If8JgYZM8clEiay/BhsqrdZbHOWZZYMHh5l
 fANm7UWspV8PeBVkOXERj9rPsx5iAS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730278398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aMl8D7YwC7WWMKvB5K5Y699pDsfmtKwLoj4TKgDvGc=;
 b=M1ILsfHXuDF+zgNT90Ha7d4trgMyBshq3SAQN5a4fxmdNSscDV9FJpMV+VATRqPw09yGLp
 GSIYKCnQmEcAnpDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730278398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aMl8D7YwC7WWMKvB5K5Y699pDsfmtKwLoj4TKgDvGc=;
 b=0k/UzuPbIY/bggZVUJaBTeWm+q7s9AUxic0SbgNSpC0wV3BKc4ya37HvqQTZln0wA++5k5
 iLp4Y8FZFPIV54J6g10ZgBUrZOOSHr27yw/If8JgYZM8clEiay/BhsqrdZbHOWZZYMHh5l
 fANm7UWspV8PeBVkOXERj9rPsx5iAS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730278398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9aMl8D7YwC7WWMKvB5K5Y699pDsfmtKwLoj4TKgDvGc=;
 b=M1ILsfHXuDF+zgNT90Ha7d4trgMyBshq3SAQN5a4fxmdNSscDV9FJpMV+VATRqPw09yGLp
 GSIYKCnQmEcAnpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CD3413AEB;
 Wed, 30 Oct 2024 08:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mEG5HP7zIWdCGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Oct 2024 08:53:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Oct 2024 09:53:02 +0100
MIME-Version: 1.0
Message-Id: <20241030-generate_syscalls-v5-3-eed6a87dc787@suse.com>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
In-Reply-To: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730278397; l=1049;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=KQ81uc2r3TZV4ZQ2qdSlxL0AxqzPYfsG+7vvkVWEhQo=;
 b=5kyS3bf63JxSu5sELUxwdAo2gU7P/xoPB2hZc2+Zt7yv3QAgH2QRWUn/PHTY8GQAxcO3RIXl3
 IuyaaqcBZ4uCmc/rtEgfpapaZ6HEix31O+keFtSJSDez8FtOyzNShJU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] Delete obsolete strip_syscall.awk file
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
