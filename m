Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591DACEBF8C
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFCA03C4FE9
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:50:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5C1D3C4F64
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:32 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78BA5100B8A4
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:49:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 034BC21BAE
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=QtlkvtjMV2dlH6+/csGbpArgc7NCXSOgisEGhPDrRqFLasNKuqBJmxpjWFN1XsoqQJou+n
 yPveCj8sXKKUfEusrZaauCnpn7drfw0T67pFmHqf7OeQWqJM/+8U5dz25YkPEoMl5C5Dz0
 4Tp7YfUGtFeQZUBTk5QiMTnnwEiCCc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=tfPcHG5WAY8H2x/Gty8/zyx6l3bf5X0wOD6sxUN7T0v8ZSGHdNngMkSZrGonUG64Y2vZCs
 8wEmbRFSkgFcIpBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QtlkvtjM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tfPcHG5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727430572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=QtlkvtjMV2dlH6+/csGbpArgc7NCXSOgisEGhPDrRqFLasNKuqBJmxpjWFN1XsoqQJou+n
 yPveCj8sXKKUfEusrZaauCnpn7drfw0T67pFmHqf7OeQWqJM/+8U5dz25YkPEoMl5C5Dz0
 4Tp7YfUGtFeQZUBTk5QiMTnnwEiCCc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727430572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FaIlo2MtosGXk4lbJMs1XRvQ13CI93A5jJ3vN5Av6Mg=;
 b=tfPcHG5WAY8H2x/Gty8/zyx6l3bf5X0wOD6sxUN7T0v8ZSGHdNngMkSZrGonUG64Y2vZCs
 8wEmbRFSkgFcIpBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E176D13AA0
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +NEyNat/9ma9TQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 09:49:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 27 Sep 2024 11:49:24 +0200
MIME-Version: 1.0
Message-Id: <20240927-generate_syscalls-v2-4-108f5f2ad318@suse.com>
References: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
In-Reply-To: <20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727430571; l=903;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=X5ukYIoXI2fMpUQeRfVZhelgZI22MCEPCKa0ZMROjO4=;
 b=QItzCqIHwPLLeOOK5ubc0dcbp/0x4Mv3HIZ3RwYDAZ5Y/MgGWhwadSpnGOo2KG+HoHGs8sb/k
 qe9y65n8wNWCzATN7sf7IB61OjBVzRzCrUgHfqJBchd4dXybHItYmhL
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 034BC21BAE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] Delete obsolete strip_syscall.awk file
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
