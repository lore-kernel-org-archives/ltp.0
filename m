Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C41CCA47F
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 21:42:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83C223C9278
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 23:42:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88E063C03B1
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 23:42:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC44F600C89
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 23:42:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCE151FE8F;
 Thu,  9 Jun 2022 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654810950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=srfUH11vAxusP56w7n6Jj5rGzywayqKayZosYErFi+4=;
 b=Atq4LeH9wjksbXCZxuz8zThRbrVu52eWmZAarOza0hUzZszU6LMB/p31bFCdgUBmaMOpn1
 K1luvVj3j7quhiA978DI/fuqwSFc07/CKghAfGBf4Bf5t84DHCUu/dbhty7CkajvcctSij
 m0Ro6aY+MuXPgUWSZCNo1W/nYRAr02U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654810950;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=srfUH11vAxusP56w7n6Jj5rGzywayqKayZosYErFi+4=;
 b=W18+EopwgLPDIEhnw1c1uTBQ2iWRuQbANbWxJRkZLEyNoH5cwA/SPxq1zJ505AStRDA6jM
 lwqBKPRGlnh5g/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DE3C13A8C;
 Thu,  9 Jun 2022 21:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 45B6HEVpomIQDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jun 2022 23:42:14 +0200
Message-Id: <20220609214223.4608-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] shell: nfs: $TST_ALL_FILESYSTEMS
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
Cc: linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
 "J . Bruce Fields" <bfields@fieldses.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this is quite ready $TST_ALL_FILESYSTEMS (i.e. support for LTP shell API
to run test on all available filesystems, equivalent of .all_filesystems
in C API). It's used in NFS tests, where I have questions (RFC).

As it uses testcases/lib/tst_supported_fs.c binary it supports the same
features as C API:
* detect supported filesystems
* run only on single filesystem with $LTP_SINGLE_FS_TYPE (debugging)

825e10a91 ("Skip tmpfs in all-filesystem shell tests")


TODO API:
* filtering filesystems when test does not run on certain filesystem
* (i.e. nfs01.sh on vfat) with $TST_SKIP_FILESYSTEMS (equivalent of
  skip_filesystems variable in C API)
* testcases/lib/tst_supported_fs.c skips tmpfs by default since
  825e10a91 ("Skip tmpfs in all-filesystem shell tests"). After
  implementing $TST_SKIP_FILESYSTEMS it could be removed.

TODO NFS tests:
* Do not require restart NFS server (otherwise legacy testcases/lib/daemonlib.sh
  would have to be used)

Comments are welcome.

Code is also at: https://github.com/pevik/ltp/tree/shell/all_filesystems.v2

Kind regards,
Petr

Petr Vorel (9):
  tst_test.sh: Add $TST_MOUNT_DEVICE
  df01.sh: Use TST_MOUNT_DEVICE=1
  tst_test.sh: allow ' in pattern for allowed variables
  shell: Add test for TST_MOUNT_DEVICE=1
  tst_test.sh: Add $TST_ALL_FILESYSTEMS
  tst_device: Remove unnecessary braces
  tst_device: Add clear command
  shell: Add test for TST_ALL_FILESYSTEMS=1
  nfs: Use TST_ALL_FILESYSTEMS=1

 doc/shell-test-api.txt                        |   3 +
 lib/newlib_tests/shell/tst_all_filesystems.sh |  27 +++++
 lib/newlib_tests/shell/tst_mount_device.sh    |  21 ++++
 testcases/commands/df/df01.sh                 |   5 +-
 testcases/lib/tst_device.c                    |  25 ++++-
 testcases/lib/tst_test.sh                     | 104 ++++++++++++------
 testcases/network/nfs/nfs_stress/nfs_lib.sh   |  25 +++--
 7 files changed, 159 insertions(+), 51 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
