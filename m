Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1907CCF31B4
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 12:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FB2A3C5A7A
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 14:24:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C84C63C5A76
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 14:22:54 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4514E200DC6
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 14:22:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8AD621AE2
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727871766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LJ34ezkklwoqy1FwGv1I5lcgBcdlGTbUM8GiCJMgnP0=;
 b=Y8+icg99sgZ3oscs1X3iEdao0s6q0FYYhoSZgI9T4+XwPWtW/3ddS78pWBvkkkgHJeewmE
 8s4wuf8bUT9lZZ//Pe4JD3mJfxruBSzx6XRc07wL1dZdnq8aF0JSb2eg/vdMLp8IF4MbxG
 HDO2vXZS+KrngNuNE0vyoQc71wpO1WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727871766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LJ34ezkklwoqy1FwGv1I5lcgBcdlGTbUM8GiCJMgnP0=;
 b=hj7MrDTwO+huUSNyQKiiFhwXfAQBJqAUNRmGT3UevWVHEQNjNkwm9QlJLW96xjT9bUHPB1
 HZSmHalG0LQQHgCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727871766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LJ34ezkklwoqy1FwGv1I5lcgBcdlGTbUM8GiCJMgnP0=;
 b=Y8+icg99sgZ3oscs1X3iEdao0s6q0FYYhoSZgI9T4+XwPWtW/3ddS78pWBvkkkgHJeewmE
 8s4wuf8bUT9lZZ//Pe4JD3mJfxruBSzx6XRc07wL1dZdnq8aF0JSb2eg/vdMLp8IF4MbxG
 HDO2vXZS+KrngNuNE0vyoQc71wpO1WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727871766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LJ34ezkklwoqy1FwGv1I5lcgBcdlGTbUM8GiCJMgnP0=;
 b=hj7MrDTwO+huUSNyQKiiFhwXfAQBJqAUNRmGT3UevWVHEQNjNkwm9QlJLW96xjT9bUHPB1
 HZSmHalG0LQQHgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D8413974
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 12:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8tjoJRY7/WbICAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 02 Oct 2024 12:22:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Oct 2024 14:22:43 +0200
Message-Id: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABM7/WYC/33NQQrCMBAF0KuUrI3MTFJaXXkPEanJ1AZqI0kNS
 undTbsQF+Ju/of/ZhKRg+Mo9sUkAicXnR9yUJtCmK4ZriydzVkQkIYdaem8Gftz60zvBwbM11P
 WdYMVt2VdaiXy8h4416t6POXcuTj68FqfJFza/15CibKqNDIxKmPoEB+Rt8bfxMIl+hAIgL8Jk
 iCthQsQWqvQfhHzPL8BaIAWFfgAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727871766; l=2319;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Irk08vi6AkvW8Ytk3LV3c7MltRykxNRjfUJfIFLulAY=;
 b=h7526z3kEmWGlF943k+D8ooL0ocypIezs639zgKWqX5f6vbmG9rYAC1gRYakSDrHP8nGmc2as
 H5UAuGFQmd5DKEi63eVCufv4zvDIFH6q3YpndZ/MX7q072rwPkDK6ly
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Fix ioctl_ficlone(range) failures on certain FS
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
 lib/tst_cmd.c                                      | 125 ++++++++++++++-------
 lib/tst_test.c                                     |  44 ++++++--
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c  |   4 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c  |   4 +-
 .../kernel/syscalls/ioctl/ioctl_ficlonerange01.c   |   4 +-
 .../kernel/syscalls/ioctl/ioctl_ficlonerange02.c   |   4 +-
 testcases/lib/tst_run_shell.c                      |  10 ++
 9 files changed, 154 insertions(+), 56 deletions(-)
---
base-commit: 701212f08d6e850457cc2b10238f28662ef48471
change-id: 20240924-ioctl_ficlone01_fix-88a17ef58543

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
