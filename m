Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FF8C433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE95160E75
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE95160E75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 032773C6751
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:00:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72D463C6337
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8FE96010BE
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE0D11FD52
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QFvUysOp5HJl3+sa6EhMjQNnTjQZjv/DYPw4XIjPoFY=;
 b=cpB/EugEBmoWVDRQ57mp7iixcCBsZpg724znW94mlsbOTzdQ/Npmq35vS/2QU7KaxFjnSN
 HyA2Hqes2Ulu0HY03YDcp5iMOX2+MzrsGcDBuPwVQiUO/+nx8arUWVRHczNsGeSG9S48WY
 cpp+17J4JnZmTLzCJ6SuNbKS0CyAUu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QFvUysOp5HJl3+sa6EhMjQNnTjQZjv/DYPw4XIjPoFY=;
 b=rLuWCLAPxtqoVT/2Eik12m8QJ2g6i1Wq9QNjdA+ZLDU6lhyN3MhEjFwJJ1nTD6ChmDSm+t
 kTeoZrG99fWPg3Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B95E613C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9W1JLKzUdmGHLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:44 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:28 +0200
Message-Id: <20211025160134.9283-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Introduce a concept of test max_runtime
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

This patchset introduces a concept of test max_runtime and convert all
tests that were (mis)using timeout to get around timeouts when a test
runtime was longer than expected timeout.

Generally this removes quite a bit of code and makes things simpler
since it's easier to set up a runtime and compute test timeout based on
that rather than the other way around.

If this gets merged I may follow up with other changes, there are a few
tests that deliberately set up timeout to be 10 or 20 seconds in order
to timeout faster than the default 360. So logicall followup would be
setting the default timeout somewhat shorter and get rid of these as
well.

Cyril Hrubis (6):
  lib: tst_test: Move timeout scaling out of fork_testrun()
  lib: Add .max_runtime and tst_remaining_runtime()
  mtest06/mmap3: Convert to tst_remaining_runtime()
  syscalls/gettimeofday02: Convert to tst_remaining_runtime()
  cve-2015-3290: convert tst_remining_runtime()
  lib: Add tst_set_runtime() & remove tst_set_timeout()

 include/tst_fuzzy_sync.h                      |  7 ++-
 include/tst_test.h                            | 19 +++++-
 include/tst_timer_test.h                      |  3 +
 lib/newlib_tests/.gitignore                   |  4 +-
 lib/newlib_tests/test18.c                     | 22 -------
 lib/newlib_tests/test_max_runtime01.c         | 28 +++++++++
 lib/newlib_tests/test_max_runtime02.c         | 29 +++++++++
 lib/newlib_tests/test_max_runtime03.c         | 35 +++++++++++
 lib/newlib_tests/tst_fuzzy_sync01.c           |  1 +
 lib/newlib_tests/tst_fuzzy_sync02.c           |  1 +
 lib/newlib_tests/tst_fuzzy_sync03.c           |  1 +
 lib/tst_test.c                                | 62 ++++++++++++-------
 lib/tst_timer_test.c                          |  4 +-
 runtest/mm                                    |  2 +-
 testcases/cve/cve-2014-0196.c                 |  1 +
 testcases/cve/cve-2015-3290.c                 |  8 +--
 testcases/cve/cve-2016-7117.c                 |  1 +
 testcases/cve/cve-2017-2671.c                 |  1 +
 testcases/kernel/crypto/af_alg02.c            |  4 +-
 testcases/kernel/crypto/af_alg07.c            |  1 +
 testcases/kernel/crypto/pcrypt_aead01.c       |  3 +-
 testcases/kernel/mem/mtest01/mtest01.c        |  9 ++-
 testcases/kernel/mem/mtest06/mmap1.c          | 27 ++------
 testcases/kernel/mem/mtest06/mmap3.c          | 12 +---
 testcases/kernel/mem/thp/thp04.c              |  1 +
 testcases/kernel/pty/pty03.c                  |  1 +
 testcases/kernel/pty/pty05.c                  |  1 +
 testcases/kernel/sound/snd_seq01.c            |  2 +-
 testcases/kernel/sound/snd_timer01.c          |  1 +
 testcases/kernel/syscalls/bind/bind06.c       |  2 +-
 .../clock_nanosleep/clock_nanosleep02.c       |  1 +
 .../syscalls/epoll_pwait/epoll_pwait03.c      |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait02.c |  1 +
 .../kernel/syscalls/epoll_wait/epoll_wait04.c |  2 +-
 .../syscalls/futex/futex_cmp_requeue01.c      |  2 +-
 .../kernel/syscalls/futex/futex_wait05.c      |  1 +
 .../syscalls/gettimeofday/gettimeofday02.c    | 35 +----------
 testcases/kernel/syscalls/inotify/inotify09.c |  1 +
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
 .../kernel/syscalls/move_pages/move_pages12.c |  4 +-
 .../kernel/syscalls/nanosleep/nanosleep01.c   |  1 +
 testcases/kernel/syscalls/poll/poll02.c       |  1 +
 testcases/kernel/syscalls/prctl/prctl09.c     |  1 +
 testcases/kernel/syscalls/pselect/pselect01.c |  1 +
 testcases/kernel/syscalls/select/select02.c   |  1 +
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |  1 +
 .../kernel/syscalls/setsockopt/setsockopt06.c |  1 +
 .../kernel/syscalls/setsockopt/setsockopt07.c |  1 +
 .../syscalls/timerfd/timerfd_settime02.c      |  1 +
 testcases/kernel/syscalls/writev/writev03.c   |  1 +
 testcases/network/can/cve/can_bcm01.c         |  1 +
 testcases/network/packet/fanout01.c           |  1 +
 testcases/network/sockets/vsock01.c           |  1 +
 53 files changed, 219 insertions(+), 137 deletions(-)
 delete mode 100644 lib/newlib_tests/test18.c
 create mode 100644 lib/newlib_tests/test_max_runtime01.c
 create mode 100644 lib/newlib_tests/test_max_runtime02.c
 create mode 100644 lib/newlib_tests/test_max_runtime03.c

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
