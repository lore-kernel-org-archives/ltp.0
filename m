Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805EDC38145
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 13:38:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 266153CA8C0
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 15:38:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63E7B3CA8A3
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8DACB600855
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 15:37:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58E5C5BF1B;
 Fri,  2 Sep 2022 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662125835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ia5+1sia3rjWJukq5mA1el2Kp5s5aetYqgR/8wiohj0=;
 b=N3qiE3yFpBYO8TPgVSoZjel2dvSdJv1puMve5HQlz/ae1JM28BrOE1yMSdj+SlbxNDNOlA
 BEwuZaXG0vU0tkZHgxfFdEgGqykSvDLOhF1GQ/hTZjmPxGyp+tZSVCoy+fAFH2hhKFqaPG
 BOkNDLm5/G0CzscXjr7ieLzH9oDV4rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662125835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ia5+1sia3rjWJukq5mA1el2Kp5s5aetYqgR/8wiohj0=;
 b=XunIS5UvFiTNjvoSPeNZgYKafwkoAGBYfgXOMMWjrgT/lOLIS5keGYqet7mSTNb7eLElmR
 ZFzEzCYFLIa6IzBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FC3C1330E;
 Fri,  2 Sep 2022 13:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hD1uAgsHEmObBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 13:37:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  2 Sep 2022 15:37:01 +0200
Message-Id: <20220902133710.1785-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/9] shell: df01.sh: $TST_ALL_FILESYSTEMS
 (.all_filesystems)
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Note, I'm not sure if changes in commit "tst_supported_fs: Implement
skip list" in tst_supported_fs.c will not be heavily rewritten due
tracking minimal filesystem usage. But if the commit looks ok, it'd be
nice to get this merged first.

Kind regards,
Petr

change v3->v4:
* dropped NFS tests change for now (plan to get to this soon, as that
  is the motivation for whole work)
* convert df01.sh (to at least something is using it)
* new variable $TST_FS_TYPE_FUSE
* rebased (some commits were merged)

new commits
worth to review
* df01.sh: Convert to TST_ALL_FILESYSTEMS=1
* tst_test.sh: Introduce TST_FS_TYPE_FUSE
some minor cleanup
* shell: Print mount command in tst_mount()
* shell API/tests: Require root for TST_{FORMAT,MOUNT}_DEVICE

Petr Vorel (9):
  shell: Print mount command in tst_mount()
  shell API/tests: Require root for TST_{FORMAT,MOUNT}_DEVICE
  tst_supported_fs: Implement skip list
  tst_supported_fs: Support skip list when query single fs
  shell: Add $TST_SKIP_FILESYSTEMS + tests
  tst_test.sh: Introduce TST_FS_TYPE_FUSE
  tst_test.sh: Add $TST_ALL_FILESYSTEMS
  shell: Add test for TST_ALL_FILESYSTEMS=1
  df01.sh: Convert to TST_ALL_FILESYSTEMS=1

 doc/shell-test-api.txt                        |  13 +-
 include/tst_fs.h                              |  10 ++
 lib/newlib_tests/shell/tst_all_filesystems.sh |  27 ++++
 lib/newlib_tests/shell/tst_format_device.sh   |   1 +
 lib/newlib_tests/shell/tst_mount_device.sh    |   1 +
 .../shell/tst_mount_device_tmpfs.sh           |   1 +
 .../shell/tst_skip_filesystems.sh             |  35 +++++
 .../shell/tst_skip_filesystems_skip.sh        |  17 ++
 lib/tst_supported_fs_types.c                  |  18 +++
 runtest/commands                              |   8 +-
 runtest/smoketest                             |   2 +-
 testcases/commands/df/df01.sh                 |  32 ++--
 testcases/lib/tst_supported_fs.c              |  56 +++++--
 testcases/lib/tst_test.sh                     | 147 ++++++++++++------
 testcases/misc/lvm/generate_lvm_runfile.sh    |   2 +-
 testcases/misc/lvm/prepare_lvm.sh             |   2 +-
 16 files changed, 282 insertions(+), 90 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
