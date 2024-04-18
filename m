Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB16C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:14:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 007333CF511
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:14:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B14E3CFC17
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:24 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC1641007C86
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DF0A3501D;
 Thu, 18 Apr 2024 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w/bMcVi2XUrbMBFVFAvTtrss0CJ1VLhYtjHNd11vu9A=;
 b=U00ZzwS8XjRGGTKkvEnSZjKvVntd48TXJuQr+r5OHUEyEEWWTxGpYAIfccaX/wTkaIoc/l
 LBW57z3Yq2vUxwniLSWHiz9qmhWZEhsTFwYxES552r5kyydaxVO52m7ERKXwOX4rvIO71M
 bqQbz9CxX2dMoEz7qqVOBbDGigYX8Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w/bMcVi2XUrbMBFVFAvTtrss0CJ1VLhYtjHNd11vu9A=;
 b=MayfOnuv6XFkbzvVpMaxugR+1gbsDCWqGoOqqBghTu8rilbDt9nOFhgja517Jw1gSVuXgy
 Evb1AqSV83RwKIDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Ok9/NDQ3";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kRFJ4xJI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w/bMcVi2XUrbMBFVFAvTtrss0CJ1VLhYtjHNd11vu9A=;
 b=Ok9/NDQ3H+jqKiReJ0BQBwxHccvTu99r0XIjq75Jv4F6WcTv2oVNKqDw9jng0+ZUtyHIAh
 7GRS35/rm2eBy/X7AzLP0xuPYbukgVyG38fpgmAIRRfIpJRwKoBOzWqQ5sgsVThMM3p4fA
 mrOng6lo1Jk0z2KP6H1LAtpszlxCrTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=w/bMcVi2XUrbMBFVFAvTtrss0CJ1VLhYtjHNd11vu9A=;
 b=kRFJ4xJIl8mw8Zw0uXpN6ZoWVGMlRjf7uKD6tdBiiRWhNRKVKv/B4A5BNvdV9OAZ9yfDB9
 qCZPPfjQTA/82aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B1D113687;
 Thu, 18 Apr 2024 14:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uLXTHH8qIWbOHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 14:13:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 16:13:09 +0200
Message-ID: <20240418141312.99794-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9DF0A3501D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] swap{on,off} fixes for page size > 4KB
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

Hi Li, Cyril,

this is supposed just to fix our swap{on,off} tests on kernel with page
size > 4KB.

NOTE: while I first wanted to also convert include/libswap.h docs to the
new format, I'll postpone it to a separate effort to speedup this fix.

This is a replacement of "libswap: Change TWARN message to TINFO":

https://lore.kernel.org/ltp/20240417090222.707302-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20240417090222.707302-1-pvorel@suse.cz/

Kind regards,
Petr

Petr Vorel (3):
  swapoff0[12]: Remove unneeded tst_brk()
  libswap: Add {SAFE_,}MAKE_MINIMAL_SWAPFILE() macros
  libswap: Use {SAFE_,}MAKE_MINIMAL_SWAPFILE()

 include/libswap.h                             | 17 +++++++++++++++++
 libs/libltpswap/libswap.c                     |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff01.c |  4 +---
 testcases/kernel/syscalls/swapoff/swapoff02.c |  4 +---
 testcases/kernel/syscalls/swapon/swapon02.c   |  4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   |  4 ++--
 6 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
