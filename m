Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317DDECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:37:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1DAE3CAC24
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:36:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 462AD3CABA8
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10C5B200388
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:45 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B29B20234;
 Thu, 15 Sep 2022 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663234605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZV3hAtc7zNmXyYnjtziu7FfTKZ/nmf1vEvgGogpBs3o=;
 b=TFAEK8y/EqWRE8Fb0kUqeQB8ZFp2nWOOZsV3SANy6pJU7yJvTY8taSA2TBcJR+ntrdKLxd
 3vMjyX4BmFOSocveDCNGa8pO1DqmNjWmTgFqyKouvSzfRwCJQd9LGdNhNtQx1mfAnc5P5k
 FswKZaXl8fPu+01gn7FBkREzOuWbqtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663234605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZV3hAtc7zNmXyYnjtziu7FfTKZ/nmf1vEvgGogpBs3o=;
 b=nLbVRt0DeNaA3FyMuabQeDvSpKJxrUUULU6asuUgxVYDvucYeK78zI9OrZ26rwUVUkW7k9
 8H1WfJcC82Q2FwAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C646E13310;
 Thu, 15 Sep 2022 09:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id VMOJLSzyImPGIgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 09:36:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 11:36:31 +0200
Message-Id: <20220915093639.2261-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/8] shell: df01.sh: $TST_ALL_FILESYSTEMS
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

Note, I give up on some duplicity in the code,
i.e. instead adding tst_fs_is_current_fs_supported()
I proposed in [1], I just make duplicity:

    if (tst_fs_in_skiplist(fs_type, skiplist))
        tst_brk(TCONF, "%s is not supported by the test", fs_type);

	if (!filesystems[0])
		tst_brk(TCONF, "There are no supported filesystems");

I also didn't implement different exit code for test not supported and
test being skipped TST_FS_UNAVAILABLE and TST_FS_UNSUPPORTED (Martin [2]).
It should be obvious from previous messages or we can easily implement
it after the release.

changes v5->v6
* Remove TST_FS_TYPE_FUSE (put the code just to df01.sh and
  tst_all_filesystems.sh test (Cyril [3])
* Remove tst_fs_is_supported_skiplist(), implement tst_fs_in_skiplist()
  instead.
* new commit to whitelist | in filtering variables

[1] https://lore.kernel.org/ltp/YyCJnQR7ORn3phVn@pevik/
[2] https://lore.kernel.org/ltp/70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz/
[3] https://lore.kernel.org/ltp/Yx9QFWuRMjDUAafp@yuki/


Petr Vorel (8):
  tst_supported_fs: Implement skip list
  zram01.sh: Use tst_supported_fs -s tmpfs
  tst_supported_fs: Support skip list when query single fs
  shell: Add $TST_SKIP_FILESYSTEMS + tests
  tst_test.sh: Add $TST_ALL_FILESYSTEMS
  tst_test.sh: Allow | after whitelisted variable
  shell: Add tests for TST_ALL_FILESYSTEMS=1
  df01.sh: Convert to TST_ALL_FILESYSTEMS=1

 doc/shell-test-api.txt                        |  11 +-
 lib/newlib_tests/shell/tst_all_filesystems.sh |  21 +++
 .../shell/tst_all_filesystems_skip.sh         |  16 +++
 .../shell/tst_skip_filesystems.sh             |  35 +++++
 .../shell/tst_skip_filesystems_skip.sh        |  17 +++
 lib/tst_supported_fs_types.c                  |   1 +
 runtest/commands                              |   8 +-
 runtest/smoketest                             |   2 +-
 testcases/commands/df/df01.sh                 |  28 +---
 .../kernel/device-drivers/zram/zram01.sh      |   3 +-
 testcases/lib/tst_supported_fs.c              |  71 +++++++--
 testcases/lib/tst_test.sh                     | 136 ++++++++++++------
 testcases/misc/lvm/generate_lvm_runfile.sh    |   2 +-
 testcases/misc/lvm/prepare_lvm.sh             |   2 +-
 14 files changed, 265 insertions(+), 88 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems_skip.sh
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
