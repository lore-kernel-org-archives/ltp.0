Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10BAE6B27C
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 14:12:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC5793CD6BE
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 15:12:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 251AD3CD6B7
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:31 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 170E723C855
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 15:11:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CD1821CAA
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LzbFi3Fh9jan1wAHUmm56bmbqeOsH1eP1g4pCaxF7Hg=;
 b=hUSDF6H8JU/6b8Pzba+ig8UYfY2gamts/0ItbMpkImpYq1vOMocvbdmNmvimCqyaQZeyks
 MuyY8zDuOnm0XCB8AUI+PPJAj67anZerG+B9abi18C8tPBl3bAQoGvWzewGU94rIABjtAE
 ypxqTqC4PhKzVygo0l2OCWYnNjezTtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LzbFi3Fh9jan1wAHUmm56bmbqeOsH1eP1g4pCaxF7Hg=;
 b=ZtbnWoUHLdp+sldRLcWpcnElVgVbzXAZVN5nuY1ZC4wplcMgB6uT41UMO0GqxNVFkbSo6T
 lQy+Ls5Uh+9eOOCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hUSDF6H8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZtbnWoUH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730470289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LzbFi3Fh9jan1wAHUmm56bmbqeOsH1eP1g4pCaxF7Hg=;
 b=hUSDF6H8JU/6b8Pzba+ig8UYfY2gamts/0ItbMpkImpYq1vOMocvbdmNmvimCqyaQZeyks
 MuyY8zDuOnm0XCB8AUI+PPJAj67anZerG+B9abi18C8tPBl3bAQoGvWzewGU94rIABjtAE
 ypxqTqC4PhKzVygo0l2OCWYnNjezTtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730470289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=LzbFi3Fh9jan1wAHUmm56bmbqeOsH1eP1g4pCaxF7Hg=;
 b=ZtbnWoUHLdp+sldRLcWpcnElVgVbzXAZVN5nuY1ZC4wplcMgB6uT41UMO0GqxNVFkbSo6T
 lQy+Ls5Uh+9eOOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA4613722
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 14:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4lDCGpHhJGf1BAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 14:11:29 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 15:11:05 +0100
Message-ID: <20241101141111.104803-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7CD1821CAA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:mid, suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Add LVM and NFS tests for file data integrity
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

Most of the existing read/write tests don't verify whether the data written
to the filesystem can also be correctly read back. Add a new reusable test
program that will check file data integrity. The test randomly switches
between multiple read/write syscalls and allows setting direct (unbuffered)
I/O mode independently for read or write operations.

Also enable the new test in LVM and NFS runfiles with all combinations
of direct and buffered I/O operations.

Martin Doucha (5):
  Move preadv()/pwritev() backup definitions to LAPI
  Add safe readv()/writev() functions
  Add test for file data integrity
  Add support for setting loop device size in shell tests
  Add test for data integrity over NFS

 doc/developers/writing_tests.rst              |   2 +-
 include/lapi/pwritev2.h                       |  26 --
 include/lapi/{preadv2.h => uio.h}             |  30 +-
 include/tst_safe_macros.h                     |  13 +
 include/tst_safe_prw.h                        |  58 ++++
 lib/tst_safe_macros.c                         |  45 +++
 runtest/net.nfs                               |  11 +
 testcases/kernel/fs/fsplough/.gitignore       |   1 +
 testcases/kernel/fs/fsplough/Makefile         |   8 +
 testcases/kernel/fs/fsplough/fsplough.c       | 279 ++++++++++++++++++
 testcases/kernel/syscalls/preadv/preadv.h     |  22 --
 testcases/kernel/syscalls/preadv/preadv01.c   |   2 +-
 testcases/kernel/syscalls/preadv/preadv02.c   |   2 +-
 testcases/kernel/syscalls/preadv/preadv03.c   |   2 +-
 testcases/kernel/syscalls/preadv2/preadv201.c |   2 +-
 testcases/kernel/syscalls/preadv2/preadv202.c |   2 +-
 testcases/kernel/syscalls/preadv2/preadv203.c |   2 +-
 testcases/kernel/syscalls/pwritev/pwritev.h   |  22 --
 testcases/kernel/syscalls/pwritev/pwritev01.c |   2 +-
 testcases/kernel/syscalls/pwritev/pwritev02.c |   2 +-
 testcases/kernel/syscalls/pwritev/pwritev03.c |   2 +-
 .../kernel/syscalls/pwritev2/pwritev201.c     |   2 +-
 .../kernel/syscalls/pwritev2/pwritev202.c     |   2 +-
 testcases/lib/tst_test.sh                     |   3 +-
 testcases/misc/lvm/datafiles/runfile.tpl      |   4 +
 testcases/network/nfs/nfs_stress/nfs10.sh     |  36 +++
 26 files changed, 498 insertions(+), 84 deletions(-)
 delete mode 100644 include/lapi/pwritev2.h
 rename include/lapi/{preadv2.h => uio.h} (50%)
 create mode 100644 testcases/kernel/fs/fsplough/.gitignore
 create mode 100644 testcases/kernel/fs/fsplough/Makefile
 create mode 100644 testcases/kernel/fs/fsplough/fsplough.c
 delete mode 100644 testcases/kernel/syscalls/preadv/preadv.h
 delete mode 100644 testcases/kernel/syscalls/pwritev/pwritev.h
 create mode 100755 testcases/network/nfs/nfs_stress/nfs10.sh

-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
