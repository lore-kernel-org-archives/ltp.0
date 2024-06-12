Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5BEC27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 12:11:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474133D0BD5
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 14:11:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63E2F3D0905
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:11:25 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5BF631A00EA2
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:11:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 90F94343F0
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1v9ZVpYFUA+88IlcQedeOdMCWW+L9W0CfFlsu+ve5u0=;
 b=KR+25H0Im0vSQiE/Lumgi+F/WKk6FUOwPlgknia1PhiY7AqKC35Bv+2MkQvgzy/a3/iMHL
 eiiq0FbNF6efQ4HN/ll0sTUafrufxa8qaEPs1EemG7hVrqr3UhvuzqJ/sDoJJ7hKtG9OLt
 88DIsrwtrX4RbmPp+3Uk2B/2c8BW8Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194282;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1v9ZVpYFUA+88IlcQedeOdMCWW+L9W0CfFlsu+ve5u0=;
 b=CNy2QG2ngf93vpa3sRyAp3pa2epqIcB7EDkAjqgd/559yesU31hiTAlYi1RDg4DEkDEDRh
 K7wWgNEYyeNxL7AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KR+25H0I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CNy2QG2n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718194282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1v9ZVpYFUA+88IlcQedeOdMCWW+L9W0CfFlsu+ve5u0=;
 b=KR+25H0Im0vSQiE/Lumgi+F/WKk6FUOwPlgknia1PhiY7AqKC35Bv+2MkQvgzy/a3/iMHL
 eiiq0FbNF6efQ4HN/ll0sTUafrufxa8qaEPs1EemG7hVrqr3UhvuzqJ/sDoJJ7hKtG9OLt
 88DIsrwtrX4RbmPp+3Uk2B/2c8BW8Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718194282;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1v9ZVpYFUA+88IlcQedeOdMCWW+L9W0CfFlsu+ve5u0=;
 b=CNy2QG2ngf93vpa3sRyAp3pa2epqIcB7EDkAjqgd/559yesU31hiTAlYi1RDg4DEkDEDRh
 K7wWgNEYyeNxL7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A86E1372E
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XSBcFmqQaWY7IQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:11:22 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Jun 2024 14:11:04 +0200
Message-ID: <20240612121106.11127-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 90F94343F0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] tst_test per FS options and small cleanup
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

Add per FS mkfs and mount options and move mkfs_opts to the tst_test
struct in two quotactl tests.

v2:
  - put everything into a single filesystems array
  - change fs_type to type in the doc header for struct tst_fs

Cyril Hrubis (2):
  lib: tst_test: Add per filesystem mkfs and mount opts
  syscalls: quotactl: Move mkfs opts into tst_test

 include/tst_test.h                            |  66 ++++++----
 lib/tst_test.c                                | 117 ++++++++++++++----
 .../kernel/syscalls/fanotify/fanotify22.c     |   5 +-
 .../kernel/syscalls/fanotify/fanotify23.c     |   5 +-
 .../kernel/syscalls/getxattr/getxattr04.c     |   5 +-
 testcases/kernel/syscalls/ioctl/ioctl08.c     |   5 +-
 testcases/kernel/syscalls/mmap/mmap16.c       |  22 ++--
 .../kernel/syscalls/quotactl/quotactl01.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl02.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl03.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl04.c     |  22 ++--
 .../kernel/syscalls/quotactl/quotactl05.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |   9 +-
 .../kernel/syscalls/quotactl/quotactl07.c     |   5 +-
 .../kernel/syscalls/quotactl/quotactl08.c     |  22 ++--
 .../kernel/syscalls/quotactl/quotactl09.c     |   9 +-
 testcases/kernel/syscalls/statx/statx05.c     |   5 +-
 testcases/kernel/syscalls/statx/statx06.c     |  11 +-
 testcases/kernel/syscalls/statx/statx07.c     |   5 +-
 testcases/kernel/syscalls/statx/statx09.c     |   5 +-
 20 files changed, 249 insertions(+), 105 deletions(-)

-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
