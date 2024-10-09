Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37338CED63E
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 09:46:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB8DD3C27B4
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:46:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3EE3C259D
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:45:30 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A83CC1402E2A
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:45:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E05621F53
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 09:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728467129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=yw5GbkoIUodvdi9Xf5obMHD4oxIqM9SucPsO8hTI54uCgIyj/uPdHIBnJotBWvTMCRn/t5
 up8/ZNEGGPnUriHOtq48r7qyISHIl3DtV0ykjfYReKvrThk0Zsf/e43EfrXg6Q8GMjQ2NY
 66r8WmvClLEP2/p/k8LEcRZO068GbFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728467129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=7YPAXNznyOHi8CUG8OjPen0IPwLvrlwFcMtBhWLTfby0ABp4s58LAt2OQejzT2gThToItw
 Fnu1w41X0qTLSSDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728467128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=QsliTjdi93btZ7z7AFSSl1mrS1GJnm8wc9bgCQYBeHyd+L6wEysNv28y7NjbBU2V7InlqF
 DXAAB+ak37ZRVQoVQ0y3++yKF5yEtfuB3jibsDlRjTXyhDSipcXrvvvCVcbK3PsyA0tpuq
 9Bzdkcb03exGEfRVj7RFx72RqIBQzp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728467128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=bAunKLeoVTRDnMLj0ih1QNGi+/UcEjaGc9vk/uxzttUq8DDGmgxF1vzo3L/fX8PwsVCHpU
 KLmHywbhmMOrp9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDBEF13AAF
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 09:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ePCFL7dQBmfRZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 09:45:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 11:45:18 +0200
MIME-Version: 1.0
Message-Id: <20241009-generate_syscalls-v4-3-5328a785bbad@suse.com>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728467126; l=903;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=X5ukYIoXI2fMpUQeRfVZhelgZI22MCEPCKa0ZMROjO4=;
 b=GfWON2+l8S6zwQeq3x/oCeOnTULtp3W68g/CjJUBw1QGdtw2fYwaqpUo/BVa0q/eRUilSMA7u
 eJ6X1de5CtmC+MPYfCJC/NsnFuO0eyKYdrtPyjdM3JRCF+5SaheAIjo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[i386.in:url,suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] Delete obsolete strip_syscall.awk file
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/syscalls/strip_syscall.awk | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/lapi/syscalls/strip_syscall.awk b/include/lapi/syscalls/strip_syscall.awk
deleted file mode 100755
index e8dff422e..000000000
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
