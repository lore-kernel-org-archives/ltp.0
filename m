Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A556C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 21:11:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 696B63CFE6C
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 23:11:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED90B3CF918
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:10:51 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 204C8601022
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 23:10:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED883225AB;
 Thu, 25 Apr 2024 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714079450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VpXhhQ4OJsqgaUyjCKjJjCg03Tb7lP3nwOQGAw+vfJ8=;
 b=yJpcMUPMroiNsAGQuPuAxgG+lf5OkhyrsXfUpCY6Gc/GqR7ngg/2FLPGrjWSxOM6ppAExg
 PrTApmD4hpX1wbAvO+4/INUnhv4YjiogmCWtzvt/wUdJoPRrpYjcf32QFePqBlMRaPkP/L
 twJxaQ0QWIN3K5YCAs6t75+Fs+xzmxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714079450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VpXhhQ4OJsqgaUyjCKjJjCg03Tb7lP3nwOQGAw+vfJ8=;
 b=WxN4XSp9NtLTUIG0XG47luJaRMInjbKC9eXilswqNSsh5/Amk9XL2dPI4zISdnkUXp2Btu
 pfSR4+vY7m5tedDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RQlRxzTV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8F+ZrDaF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714079449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VpXhhQ4OJsqgaUyjCKjJjCg03Tb7lP3nwOQGAw+vfJ8=;
 b=RQlRxzTV82TMN+nGPyhQBi3tdZ5X7dry0R30aCokARYhpfsn7dyRysAaXuGh+9Yy3OZ3oT
 wl1WMVnXBSF5ljk2mVbiLL+azXfKuAGple3i2k9bUTP7WWU5RgEsaVOihUw2UkGsTOytj4
 eKqSywFrvw7rZ4MnI7ZdvOnLlbf6IHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714079449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VpXhhQ4OJsqgaUyjCKjJjCg03Tb7lP3nwOQGAw+vfJ8=;
 b=8F+ZrDaFq9iaBG4iSLFHPE686HXN0M+DeH1WOrEPKgeREaxE7VusILPQhXt0rTjvtp/Ed+
 w8Lgz26MBYpo97Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7C401393C;
 Thu, 25 Apr 2024 21:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o4CwL9nGKmbQaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 21:10:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 25 Apr 2024 23:10:40 +0200
Message-ID: <20240425211042.299714-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ED883225AB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] swap{on,off} fixes for page size > 4KB
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

Changes v2->v3:
* s/MAKE_MINIMAL_SWAPFILE/MAKE_SMALL_SWAPFILE/

Petr Vorel (2):
  libswap: Add {SAFE_,}MAKE_SMALL_SWAPFILE() macros
  libswap: Use {SAFE_,}MAKE_MINIMAL_SWAPFILE()

 include/libswap.h                             | 18 ++++++++++++++++++
 libs/libltpswap/libswap.c                     |  2 +-
 testcases/kernel/syscalls/swapoff/swapoff02.c |  2 +-
 testcases/kernel/syscalls/swapon/swapon02.c   |  4 ++--
 testcases/kernel/syscalls/swapon/swapon03.c   |  4 ++--
 5 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
