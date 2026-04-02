Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D780BD39418
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:14:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54BEC3E2A16
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D7CD3D8D59
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:13:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD448600820
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:13:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED76F5BD8E
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G9MywwHAi9ybD6HN7vt1WLkkI0HRzKmu5cTAf2Jx6Ao=;
 b=EyReZzf5UNBZpq6sb87S1QyEeOsqv8Mc0Kya6fxw0+gOQ/zL1CwAZdCmJyAfhiPK5x3mU/
 XuiT6Js72EWRUFZ+7ohYY9xoq2F6yFMe+10Suc6coSopROpdN+UZhys3m4k6rOk8OHoO27
 y+WKk3lymrFwmS4ASgXnmYPQgzmSGjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G9MywwHAi9ybD6HN7vt1WLkkI0HRzKmu5cTAf2Jx6Ao=;
 b=+ttJmD1PHiebVnzxBxyt/y5x4pFDUquKcES+q52Q5UpbvtIa/NhVbSBQkK1BOA8Hy/b3VO
 tB2lk4eaktzGgRAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Fk/hxnKg";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yfqZL+yJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G9MywwHAi9ybD6HN7vt1WLkkI0HRzKmu5cTAf2Jx6Ao=;
 b=Fk/hxnKgD77dn5yvkR3ZMlRPkjRHI8mwGl0q8NpE9Fe9TrDHBI243+/QdhPxci3gQuynvj
 ZY9taZl9Bg394bsHCSJ/dyVBW4HatVQGerzOJt6Yp5vToG78H3alSICLp3OKX/M3KWOf/9
 5BJPQagSc2Ulcasp327Ihh/2LHFlXW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G9MywwHAi9ybD6HN7vt1WLkkI0HRzKmu5cTAf2Jx6Ao=;
 b=yfqZL+yJ1U0l58HP8v8sf6bkj/9Dn3Kf7IF+QYv+da03g2AIe54autXH7hhyhW77h0IclC
 Tcpu7kogw2iNbpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE5144A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H7tvNINdzmmWDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:13:55 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:39 +0200
Message-ID: <20260402121356.31266-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_DN_NONE(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Queue-Id: ED76F5BD8E
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/17] Replace needs_drivers with needs_kconfigs
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

The needs_drivers and needs_kconfigs options had overlapping
functionality. This patchset gets rid of needs_drivers by adding module
checks to needs_kconfigs.

Cyril Hrubis (17):
  syscalls: ioctl08: Remove .needs_drivers
  lib: shell: Remove needs_drivers from JSON parser
  lib: tst_kernel: Add tst_check_module_driver()
  lib: tst_kconfig: Add module presence checks
  tests: kvm: Switch from needs_drivers to needs_kconfigs
  tests: zram03: Switch from needs_drivers to needs_kconfigs
  tests: squashfs01: Switch from needs_drivers to needs_kconfigs
  tests: ioctl: Switch from needs_drivers to needs_kconfigs
  tests: madvise11: Switch from needs_drivers to needs_kconfigs
  tests: quotactl: Switch from needs_drivers to needs_kconfigs
  tests: uevent: Switch from needs_drivers to needs_kconfigs
  cve: tcindex01: Switch from needs_drivers to needs_kconfigs
  tests: can: Switch from needs_drivers to needs_kconfigs
  tests: fsetxattr: Switch from needs_drivers to needs_kconfigs
  sctp: Switch from needs_drivers to needs_kconfigs
  lib: tst_test: Remove now unused needs_drivers
  doc: metadata: Remove needs_drivers from docs

 doc/developers/writing_tests.rst              |  3 --
 doc/old/C-Test-API.asciidoc                   | 13 +++---
 include/tst_kernel.h                          | 10 +++++
 include/tst_test.h                            |  5 ---
 lib/tst_kconfig.c                             | 41 +++++++++++++++++++
 lib/tst_kernel.c                              | 12 +++---
 lib/tst_test.c                                |  9 ----
 metadata/README.md                            | 15 +++----
 testcases/cve/tcindex01.c                     |  5 +--
 testcases/kernel/device-drivers/zram/zram03.c |  4 +-
 testcases/kernel/fs/squashfs/squashfs01.c     |  4 +-
 testcases/kernel/kvm/kvm_pagefault01.c        |  4 +-
 testcases/kernel/kvm/kvm_svm01.c              |  4 +-
 testcases/kernel/kvm/kvm_svm02.c              |  4 +-
 testcases/kernel/kvm/kvm_svm03.c              |  4 +-
 testcases/kernel/kvm/kvm_svm04.c              |  4 +-
 testcases/kernel/kvm/kvm_vmx01.c              |  4 +-
 testcases/kernel/kvm/kvm_vmx02.c              |  4 +-
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   |  4 +-
 testcases/kernel/syscalls/ioctl/ioctl08.c     |  4 --
 testcases/kernel/syscalls/ioctl/ioctl09.c     |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop01.c      |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop02.c      |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop03.c      |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop04.c      |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop06.c      |  4 +-
 .../kernel/syscalls/ioctl/ioctl_loop07.c      |  4 +-
 testcases/kernel/syscalls/madvise/madvise11.c |  5 +--
 .../kernel/syscalls/quotactl/quotactl01.c     |  4 +-
 .../kernel/syscalls/quotactl/quotactl04.c     |  4 +-
 .../kernel/syscalls/quotactl/quotactl06.c     |  4 +-
 .../kernel/syscalls/quotactl/quotactl08.c     |  4 +-
 .../kernel/syscalls/quotactl/quotactl09.c     |  4 +-
 testcases/kernel/uevents/uevent01.c           |  4 +-
 testcases/kernel/uevents/uevent02.c           |  4 +-
 testcases/kernel/uevents/uevent03.c           |  4 +-
 testcases/lib/tst_run_shell.c                 |  5 ---
 testcases/network/can/cve/can_bcm01.c         |  6 +--
 .../network/can/filter-tests/can_filter.c     |  6 +--
 .../can/filter-tests/can_rcv_own_msgs.c       |  6 +--
 .../func_tests/test_1_to_1_initmsg_connect.c  |  4 +-
 42 files changed, 135 insertions(+), 118 deletions(-)

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
