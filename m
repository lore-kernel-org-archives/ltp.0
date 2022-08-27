Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8744AECAAD5
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 00:28:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED24D3CA4FF
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 02:28:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBBE93C8765
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5E2461000654
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 02:28:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 459F2224BB;
 Sat, 27 Aug 2022 00:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661560100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9ST8LofRZYc1z+00Wxb2byBNzMQnqeGppp7Jwc2HHlg=;
 b=WdJlQzHt862MQ8WvJ/NAIrPi3WNmFJjmOng/DJWSJhd3JGmz9ExyIAoA390uhq0KKWTgJu
 zJmXiRgOGh1MXqFh2kjAyT/OPbRmAVRiuU7bJKW+WtB/1rixXX9qxtDyLX4FpRuW0TFTGS
 czXjPjwTYiNzKhaDCjkcbgfg8inKdxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661560100;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9ST8LofRZYc1z+00Wxb2byBNzMQnqeGppp7Jwc2HHlg=;
 b=ECDvLpx0ooIMsFFzvuPKJW5XTdEgDFOL1/6yvLsxw8OEJ4OCQYjeDkr7qqDFyf73Erm3ua
 e6uNMuMc4socJGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBD0A133A6;
 Sat, 27 Aug 2022 00:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W8KOMyNlCWNQCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 00:28:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Sat, 27 Aug 2022 02:28:09 +0200
Message-Id: <20220827002815.19116-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Track minimal size per filesystem
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

This patchset require to be on the top of:

[RFC,1/1] API: Allow to use xfs filesystems < 300 MB
https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

It replaces previous effort to just increase loop device size to 300 MB
https://lore.kernel.org/ltp/20220818100945.7935-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=314303&state=*

This patchset tracks minimal filesystem requirements as we agreed.
It fixes both C and shell API.

** Please test the patchset in your setup. **

I tried to find all tests with problems, but likely I missed some.

I have no idea why sendfile09 fails:

tst_test.c:1540: TINFO: Timeout per run is 0h 00m 30s
sendfile09.c:88: TPASS: sendfile() with offset at 0
Test timeouted, sending SIGKILL!
tst_test.c:1590: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1591: TBROK: Test killed! (timeout?)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0

df01.sh and mkfs01.sh (except -f exfat) are shell tests which use loop
device. mkfs01.sh -t exfat fails (not yet in the runtest file).

If applied, "v3 shell: nfs: $TST_ALL_FILESYSTEMS (.all_filesystems)"
patchset will need to be rebased (not a problem, I'd just like to get
both into LTP release in September)
https://patchwork.ozlabs.org/project/ltp/list/?series=312567&state=*
https://lore.kernel.org/ltp/20220804121946.19564-1-pvorel@suse.cz/

Kind regards,
Petr

Petr Vorel (6):
  tst_fs_type: Add nsfs, vfat, squashfs to tst_fs_type_name()
  API: tst_device: Track minimal size per filesystem
  tst_test: Use 16 MB also for tmpfs
  tst_device: Use getopts
  tst_device: Add support -f filesystem
  tst_test.sh: Pass used filesystem to tst_device

 include/old/old_device.h                      |  6 +-
 include/tst_fs.h                              | 21 ++++-
 lib/tst_device.c                              | 36 +++++++--
 lib/tst_fs_type.c                             | 34 ++++++++
 lib/tst_test.c                                |  9 ++-
 testcases/kernel/fs/squashfs/squashfs01.c     |  1 +
 .../kernel/syscalls/fanotify/fanotify05.c     |  1 +
 testcases/kernel/syscalls/preadv2/preadv203.c |  1 +
 .../kernel/syscalls/readahead/readahead02.c   |  1 +
 testcases/lib/tst_device.c                    | 81 ++++++++++++-------
 testcases/lib/tst_test.sh                     |  4 +-
 testcases/misc/lvm/cleanup_lvm.sh             |  2 +-
 testcases/misc/lvm/prepare_lvm.sh             |  8 +-
 13 files changed, 157 insertions(+), 48 deletions(-)

-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
