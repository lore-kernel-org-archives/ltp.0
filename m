Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB665C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 19:46:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854B53CA9D6
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 21:46:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A42D3C8CC3
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:46:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3316510000C6
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:46:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDA501F8F8;
 Thu, 12 May 2022 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652384763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=myawdEglr+7fIMhHUEww5MnyznaZlwkZQ4QO/08x8lk=;
 b=ewDMIuAs2Fno5cTQ3xGxJFMA1MNKsS3yhtmGSbmkm07Rt3fGzInv7GTBKrpzkszrkPH8SX
 B675ZSiZW9y1OTH6RxwFlV+1q8Pnoj1Um19s4jaBRf7+FRtNLlBI54F244797K1w7CZ7zF
 dAIJW8sm0g8qghLJU4aQytdFudW/jSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652384763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=myawdEglr+7fIMhHUEww5MnyznaZlwkZQ4QO/08x8lk=;
 b=n1gIoQVWkgSYYdOaVrefKeMcFr8hbvHciztsF3xkwdRnNzi/TwcwPYj44Kb1hC/X3VoJD2
 ppXs+jdN8M8Nx1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A9FE13ABE;
 Thu, 12 May 2022 19:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Dl6YBPtjfWIkVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 May 2022 19:46:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 21:45:49 +0200
Message-Id: <20220512194557.30911-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/8] shell: $TST_ALL_FILESYSTEMS (.all_filesystems)
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

.all_filesystems implementation for shell.
Motivation is to add .all_filesystems for shell NFS tests.
Now added to nfs07.sh (fast test).

It required to export tst_clear_device() for shell via tst_clear_device.c.
TODO: doc
NOTE: df01.sh and mkfs01.sh should probably be converted to use it.

Kind regards,
Petr

Petr Vorel (8):
  tst_test.sh: Add $TST_MOUNT_DEVICE
  df01.sh: Use TST_MOUNT_DEVICE=1
  tst_test.sh: Improve pattern for allowed variables
  shell: Add test for TST_MOUNT_DEVICE=1
  shell: Add tst_clear_device
  tst_test.sh: Add $TST_ALL_FILESYSTEMS
  shell: Add test for TST_ALL_FILESYSTEMS=1
  nfs07.sh: Use TST_ALL_FILESYSTEMS=1

 doc/shell-test-api.txt                        |   3 +
 lib/newlib_tests/shell/tst_all_filesystems.sh |  27 +++++
 lib/newlib_tests/shell/tst_mount_device.sh    |  21 ++++
 testcases/commands/df/df01.sh                 |   5 +-
 testcases/lib/.gitignore                      |   1 +
 testcases/lib/Makefile                        |   2 +-
 testcases/lib/tst_clear_device.c              |  47 ++++++++
 testcases/lib/tst_test.sh                     | 104 ++++++++++++------
 testcases/network/nfs/nfs_stress/nfs07.sh     |   2 +
 9 files changed, 176 insertions(+), 36 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh
 create mode 100644 testcases/lib/tst_clear_device.c

-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
