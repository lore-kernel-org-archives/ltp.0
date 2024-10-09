Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461DCEDD99
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:03:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA6443C30EC
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 16:03:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 532593C2667
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:02:58 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73ADF2001D4
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:02:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7676921ABE;
 Wed,  9 Oct 2024 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nTU/FORzoN4zwbHJzdnfYvZ6O8jc6/wPQ1S3jEqcyc=;
 b=GwlhEVWnatRjPycbLbHGQxJtXaa2lFFEHyKt1lCAIh2ZAqYrUWLexJercZ3rGx7H2KAjAj
 t9W8mFDdKrLdjRaPh+sMnSY5Eyh5cIgxx4anaqso4u26h8iXDvt8OXxY3ujMoZFlGnrf1o
 O68tmwCGddCfTTuVWExZCjxxGkZErMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nTU/FORzoN4zwbHJzdnfYvZ6O8jc6/wPQ1S3jEqcyc=;
 b=4WASEoPizXdVa/TLyTFOgBJNA25XU/hgCJ1i4VTFSjVmgQqNpI0oVHrc7xKxH6GqMcsHyq
 WlJMgvaWMPd3gLAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GwlhEVWn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4WASEoPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nTU/FORzoN4zwbHJzdnfYvZ6O8jc6/wPQ1S3jEqcyc=;
 b=GwlhEVWnatRjPycbLbHGQxJtXaa2lFFEHyKt1lCAIh2ZAqYrUWLexJercZ3rGx7H2KAjAj
 t9W8mFDdKrLdjRaPh+sMnSY5Eyh5cIgxx4anaqso4u26h8iXDvt8OXxY3ujMoZFlGnrf1o
 O68tmwCGddCfTTuVWExZCjxxGkZErMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3nTU/FORzoN4zwbHJzdnfYvZ6O8jc6/wPQ1S3jEqcyc=;
 b=4WASEoPizXdVa/TLyTFOgBJNA25XU/hgCJ1i4VTFSjVmgQqNpI0oVHrc7xKxH6GqMcsHyq
 WlJMgvaWMPd3gLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2DDA13A58;
 Wed,  9 Oct 2024 14:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hmVsHw6NBmcIPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 14:02:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 16:02:39 +0200
Message-Id: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAACNBmcC/33N0YrCMBAF0F+RPG9kZpKSdJ/2PxaRmJmuAbeRR
 osi/XejD1Kk+Db3wj1zU0WGJEV9r25qkDGVlPsamq+VivvQ/4lOXLMiIAstWZ1yPB22XYqH3At
 gvS7a+4BOusY31qi6PA5S66f6u6l5n8opD9fnkxEf7WdvRI3aOYtCgiZG+innIuuY/9WDG+lFI
 AAuE6RBM8MOCJkN8hth5gQtE6YSTsC5Fj13bN8IOyf8MmErIUFM4BCNie2MmKbpDoXHd5J+AQA
 A
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728482574; l=2762;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=E9zkH2G+wwFI9K4hflgoesKBZEsASv3l0tspfNejr4Q=;
 b=4Y+mnWVzPUKln/1XcrJmc6cbE1UbfzQQxe/sQL6KYo4C+u4WV36HtHT9ZeN/4TCfeK5RQNymR
 9g4sjAXGn30DH1rvCWYe3Ey5Lt65ECQVyCEDGNJFSomYClP3wqkfdwM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 7676921ABE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] Fix ioctl_ficlone(range) failures on certain FS
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

Filesystems implementing copy-on-write are usually supported by the kernel
from a certain version. This is the case of XFS which carried an
experimental support for CoW from 4.9 until 4.16.
At the same time, some mkfs tools might not support CoW before a certain
version. This is the case of mkfs.xfs < 1.5.0.

For these reasons, this LTP patch series is meant to cover a particular
scenario, where kernel and mkfs tools versions have to be cross-checked
in order to run ioctl_ficlone(range) tests.

Two new flags have been added to the tst_fs struct:
- mkfs_ver: test the mkfs tool version before using it and eventually
  skip test if it's not satisfied
- min_kver: test the minimum kernel version and skip the test if running
  kernel is too old

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- alphabetical order for JSON lookup table
- better handling of op string in tst_cmd.c
- Link to v4: https://lore.kernel.org/r/20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com

Changes in v4:
- change error message for min kernel and fs
- fix return when only one FS is given
- sort lookup table for tst_fs struct
- Link to v3: https://lore.kernel.org/r/20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com

Changes in v3:
- invert skip flag logic in check_kver and tst_check_cmd, so now it
  TBROK if defined
- test skip if FS is not supported by kernel
- remove bcachefs version check
- Link to v2: https://lore.kernel.org/r/20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com

Changes in v2:
- add mkfs_ver
- add min_kver
- fix mkfs.xfs version when using CoW
- fix bcachefs version
- Link to v1: https://lore.kernel.org/r/20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com

---
Andrea Cervesato (3):
      Filter mkfs version in tst_fs
      Add minimum kernel requirement for FS setup
      Setup minimal kernel for ioctl_clone(range) tests

 include/tst_private.h                              |   6 +-
 include/tst_test.h                                 |   9 ++
 lib/tst_cmd.c                                      | 131 +++++++++------------
 lib/tst_test.c                                     |  40 +++++--
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c  |   4 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c  |   4 +-
 .../kernel/syscalls/ioctl/ioctl_ficlonerange01.c   |   4 +-
 .../kernel/syscalls/ioctl/ioctl_ficlonerange02.c   |   4 +-
 testcases/lib/tst_run_shell.c                      |  10 ++
 9 files changed, 123 insertions(+), 89 deletions(-)
---
base-commit: 701212f08d6e850457cc2b10238f28662ef48471
change-id: 20240924-ioctl_ficlone01_fix-88a17ef58543

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
