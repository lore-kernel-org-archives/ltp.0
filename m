Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00768CCFA0D
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 15:47:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C99613CE4C5
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 16:47:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18BA83CE079
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 16:47:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6EA8C1400BF8
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 16:47:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B3321F453;
 Wed,  5 Nov 2025 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762357640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/8DRDkseKOW43qqXwf3ngnz1UX2spJxxN0xT12w5gE=;
 b=hkLRYsdt0F+nYDUxAm5Y8uUP3+hE4MxrAFgUjEPZ31MRuuszFKRp47nqRR5ON8ExXmmiAz
 4dZqTayOPNsQCbmFSyWqjA+z1P9GWvotpMjoi98fSWzU1L4hktOfjCjhQFvKp407Y/UIoY
 nzCN7ctvTknm5Y0Oa6mjApqxAH1gSr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762357640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/8DRDkseKOW43qqXwf3ngnz1UX2spJxxN0xT12w5gE=;
 b=fX82xzOhdPGiNKQ2jtfsMM1VyitZDmHQOFT4113O17KjxmtXZi2b15Y+RmibT/2/jdDBH0
 wQt9A9uhRbS2RwDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hkLRYsdt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fX82xzOh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762357640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/8DRDkseKOW43qqXwf3ngnz1UX2spJxxN0xT12w5gE=;
 b=hkLRYsdt0F+nYDUxAm5Y8uUP3+hE4MxrAFgUjEPZ31MRuuszFKRp47nqRR5ON8ExXmmiAz
 4dZqTayOPNsQCbmFSyWqjA+z1P9GWvotpMjoi98fSWzU1L4hktOfjCjhQFvKp407Y/UIoY
 nzCN7ctvTknm5Y0Oa6mjApqxAH1gSr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762357640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/8DRDkseKOW43qqXwf3ngnz1UX2spJxxN0xT12w5gE=;
 b=fX82xzOhdPGiNKQ2jtfsMM1VyitZDmHQOFT4113O17KjxmtXZi2b15Y+RmibT/2/jdDBH0
 wQt9A9uhRbS2RwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ED62132DD;
 Wed,  5 Nov 2025 15:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Uy5jAohxC2n7HQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Nov 2025 15:47:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Nov 2025 16:47:13 +0100
Message-ID: <20251105154716.995786-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3B3321F453
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] swapon03: Try to swapon() as many files until it
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

Hi,

Previously tst_max_swapfiles() had fine tuning for a specific kernel
version which was fragile due various backports in enterprise kernels.

Let's try to create and use as many swap files until swapon() fails.
Then check for expected EPERM.

+ minor cleanup.

Petr Vorel (3):
  swapon03: Cleanup
  swapon03: Try to swapon() as many files until it fails
  libswap: Remove now unused tst_max_swapfiles()

 include/libswap.h                           |  7 --
 libs/swap/libswap.c                         | 64 ---------------
 testcases/kernel/syscalls/swapon/swapon03.c | 86 +++++++++++----------
 3 files changed, 47 insertions(+), 110 deletions(-)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
