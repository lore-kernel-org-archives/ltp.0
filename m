Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D9DCEACC2
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 13:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A81043C591E
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 15:53:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 718943C58E2
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:52:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6900A10089A6
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:52:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BDE91F818
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727790735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gJ5OHx3Qsjj/q5rqnNvwA0ccuCpj+KQiX+6pfQDFDPU=;
 b=Hcm8mgqfrUqKmqvXoFMDBi4Roe12eAOU6uTowom+GqtJ5eFTRT9nbilmJ4d67jkEHe8c8Z
 jxIRMU/PlLo8WGDwjbPvw2CjFqDe94hrGxmbm6S5I9ivM/JHaRkchfnolQko+EWehESmf7
 DkdDNtlhSvxoQeUOtQxw0fnChVIK8G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727790735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gJ5OHx3Qsjj/q5rqnNvwA0ccuCpj+KQiX+6pfQDFDPU=;
 b=uFisPqMB92fVyD496OP8eHJ9uaalKfrkqEG4t4sKl8ofL4+AMnOTYHh2cWOcDqWinrkOO5
 gWBMBzHuTIIn6TAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727790735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gJ5OHx3Qsjj/q5rqnNvwA0ccuCpj+KQiX+6pfQDFDPU=;
 b=Hcm8mgqfrUqKmqvXoFMDBi4Roe12eAOU6uTowom+GqtJ5eFTRT9nbilmJ4d67jkEHe8c8Z
 jxIRMU/PlLo8WGDwjbPvw2CjFqDe94hrGxmbm6S5I9ivM/JHaRkchfnolQko+EWehESmf7
 DkdDNtlhSvxoQeUOtQxw0fnChVIK8G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727790735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gJ5OHx3Qsjj/q5rqnNvwA0ccuCpj+KQiX+6pfQDFDPU=;
 b=uFisPqMB92fVyD496OP8eHJ9uaalKfrkqEG4t4sKl8ofL4+AMnOTYHh2cWOcDqWinrkOO5
 gWBMBzHuTIIn6TAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C6013A73
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 13:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sc7dC4/++2bJFQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 01 Oct 2024 13:52:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 01 Oct 2024 15:52:02 +0200
Message-Id: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIL++2YC/32NUQrCMBBEr1L220g2TUn0y3tIkRK3dqEmJalBK
 bm7sQfwb97AvNkgUWRKcG42iJQ5cfAV1KEBNw3+QYLvlUFJpeVJacHBrfNtZDcHTxJregtrBzQ
 0drbTLdTlEqnWu/XaV544rSF+9pOMv/a/L6NAYYxGUoStc+qSXomOLjyhL6V8ATqmNUm1AAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727790735; l=2032;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IE4zus0GiNdgpAlqfVIbckdb1YztX40No7jBLJzaUAo=;
 b=2jj60kJ1lNXzx489LpJzFyz0FtKIwC/wpbL8OYXJE6Yr2WgVW6v561bRrfMm0rOhMABeqZXjG
 ZjkrsSx+cyhAS+SY4Z8QWDS9nSEyuzWLB602p6ftWtK9wn6TLro3g2P
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Fix ioctl_ficlone(range) failures on certain FS
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
 lib/tst_cmd.c                                      | 130 ++++++++++++++++-----
 lib/tst_test.c                                     |  25 ++--
 testcases/kernel/syscalls/ioctl/ioctl_ficlone01.c  |   7 +-
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c  |   7 +-
 .../kernel/syscalls/ioctl/ioctl_ficlonerange01.c   |   7 +-
 .../kernel/syscalls/ioctl/ioctl_ficlonerange02.c   |   7 +-
 testcases/lib/tst_run_shell.c                      |  10 ++
 9 files changed, 167 insertions(+), 41 deletions(-)
---
base-commit: 47aff4decc81ac837fd745278def6883fc2f197b
change-id: 20240924-ioctl_ficlone01_fix-88a17ef58543

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
