Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2B3C433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:45:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F36923CA9C7
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:45:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 578B23CA94A
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 08AFC1000955
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F35EF1F74B;
 Tue,  3 May 2022 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c/dt0skID+DMWz/uWGhbyocN7mXtDJzGT++h2hPE0xo=;
 b=DOlAYmj7Nf50EBNNyorM6oZ3c+Xm751D5SI9sbUKYey+Ax1rvwZK6bBVV1H3YKyOWhe3PZ
 ltwe3+usdbgFrIqJgCnFsV/5Apoq8oKDUiFaVtIHHRtH/iOV3K27raXC4HJunewOtUtbE9
 iOYp6CigsdmpXcx1y9185s2jt48NpbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=c/dt0skID+DMWz/uWGhbyocN7mXtDJzGT++h2hPE0xo=;
 b=U0FbmKL0rUZwjpcdiURm8KZENh/k7x6P/TZfoa4JgC+pZBWHHz8S01vsw37ZyQc7Orp9lr
 lZ1WS/NXJbfusmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0B0813ABE;
 Tue,  3 May 2022 17:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kfn+NRtqcWLMPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:44:59 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:46:48 +0200
Message-Id: <20220503174718.21205-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/30] Introduce runtime and conver tests
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patchset introduces a concept of runtime, which is described well
enough in the first patch of the series and converts all tests that were
previously using timeout API to runtime API.

The main change to the v1 of the patchset is that the runtime is now per
iteration, e.g. if we run the test for all_filesystem the runtime
applies to a single filesystem only. And at the same time the overall
test timeout is a sum of static timeout and runtime. The static part of
the timeout is meant to cover test teardown and any inaccuracy in the
test runtime accounting.

The patches that convert tests to runtime API fall into these classes:

- fzsync tests
- faster timeout tests
- I/O tests
- timer precision tests
- oom tests
- misc tests that run for some time (controlled by command line
  parameter)

fzsync tests
============

These tests previously defined their runtime based on scale factor that
used slice of the default timeout (300s) for the test runtime.

Now the runtime is explicitly encoded in the test, which I find much
more user friendly because it's clear how long will the test run.

faster timeout tests
====================

There were several tests that set low timeout becuase the test may lock
up. In these cases the timeout was simply removed because the default
value (30s) should be small enough.

I/O tests
=========

The aiodio tests were modified so that their runtime is capped to
30 minutes by default. That means that even on very slow machine they
finish in a reasonable time.

timer precision tests
=====================

These test simply set the test timeout to be 110% of the sum of the
sleep_time * samples. That is to accomodate for the context switches and
upkeeping between the calls in the timer library.


oom tests
=========

Here we just set the .max_iteration_runtime to TST_RUNTIME_UNLIMITED,
which has the very same effect as .timeout = -1 previously had.

misc test
=========

In this case the test code was simplified quite a lot since the runtime
is now passed in a unified way and parsed in the test library.

TODO:

This patchset is reasonably complete in a sense that it removes the
timeout API at the end. Still there are a few things to consider:

- is reusing the -I parameter a good idea? Wouldn't adding new parameter
  (-r) be better?

- there are quite likely tests that run for more than a second or a two
  and should be made runtime aware

- anything else?

Cyril Hrubis (30):
  Introduce a concept of max runtime
  mtest06/mmap1: Convert to runtime
  mtest06/mmap3: Convert to runtime
  mtest01/mtest01: Convert to runtime
  cve/cve-2015-3290: Convert to runtime
  crypto/af_alg02: Convert to runtime.
  crypto/pcrypt_aead01: Convert to runtime
  syscalls/clock_gettime01: Remove useless timeout
  syscalls/fanotify22: Remove useless timeout
  syscalls/gettimeofday02: Convert to runtime.
  syscalls/inotify06: Convert to runtime.
  syscalls/inotify01: Remove now useless timeout
  syscalls/perf_event_open03: Convert to runtime
  syscalls/readv01: Remove now useless timeout
  syscalls/tgkill03: Remove now unused timeout
  syscalls/setsockopt09: Remove now useless timeout
  syscalls/userfaultfd01: Remove now useless timeout
  syscalls/move_pages12: Convert to runtime
  syscalls/rt_sigqueueinfo01: Remove now useless timeout
  mem/mallocstress: Convert to runtime
  mem/{oom,min_free_kbytes}: Convert to runtime
  crypto/af_alg02: Convert to runtime
  fuzzy_sync: Convert to runtime
  ltp-aiodio/dio_sparse,aiodio_sparse: Convert to runtime.
  ltp-aiodio/read_checkzero: Remove
  ltp-aiodio/dio_{truncate,append}: Convert to runtime
  ltp-aiodio/dio_read: Convert to runtime
  ltp-aiodio/aiodio_append: Convert to runtime
  timer_test: Convert to runtime
  tst_test: Remove timeout stubs

 doc/user-guide.txt                            |   4 +
 include/tst_fuzzy_sync.h                      |  19 +--
 include/tst_test.h                            |  31 +++-
 lib/newlib_tests/.gitignore                   |   5 +-
 lib/newlib_tests/test10.c                     |  22 ---
 lib/newlib_tests/test12.c                     |  21 ---
 lib/newlib_tests/test13.c                     |   1 -
 lib/newlib_tests/test_children_cleanup.c      |   1 -
 .../{test18.c => test_runtime01.c}            |  10 +-
 lib/newlib_tests/test_runtime02.c             |  31 ++++
 lib/tst_test.c                                | 144 +++++++++++++-----
 lib/tst_timer_test.c                          |  12 +-
 runtest/ltp-aiodio.part4                      |   2 -
 testcases/cve/cve-2015-3290.c                 |   8 +-
 testcases/kernel/crypto/af_alg02.c            |   4 +-
 testcases/kernel/crypto/af_alg07.c            |   1 +
 testcases/kernel/crypto/pcrypt_aead01.c       |   3 +-
 testcases/kernel/io/ltp-aiodio/.gitignore     |   1 -
 .../kernel/io/ltp-aiodio/aiodio_append.c      |  25 ++-
 .../kernel/io/ltp-aiodio/aiodio_sparse.c      |  26 +++-
 testcases/kernel/io/ltp-aiodio/common.h       |  12 +-
 testcases/kernel/io/ltp-aiodio/dio_append.c   |   4 +
 testcases/kernel/io/ltp-aiodio/dio_read.c     |   9 ++
 testcases/kernel/io/ltp-aiodio/dio_sparse.c   |   6 +-
 testcases/kernel/io/ltp-aiodio/dio_truncate.c |   6 +
 .../kernel/io/ltp-aiodio/read_checkzero.c     |  84 ----------
 testcases/kernel/mem/mtest01/mtest01.c        |  14 +-
 testcases/kernel/mem/mtest06/mmap1.c          |  24 +--
 testcases/kernel/mem/mtest06/mmap3.c          |  12 +-
 testcases/kernel/mem/mtest07/mallocstress.c   |  11 +-
 testcases/kernel/mem/oom/oom01.c              |   2 +-
 testcases/kernel/mem/oom/oom02.c              |   2 +-
 testcases/kernel/mem/oom/oom03.c              |   2 +-
 testcases/kernel/mem/oom/oom04.c              |   2 +-
 testcases/kernel/mem/oom/oom05.c              |   2 +-
 testcases/kernel/mem/thp/thp04.c              |   1 +
 .../kernel/mem/tunable/min_free_kbytes.c      |   2 +-
 testcases/kernel/pty/pty03.c                  |   2 +-
 testcases/kernel/pty/pty05.c                  |   1 +
 testcases/kernel/pty/pty06.c                  |   1 +
 testcases/kernel/pty/pty07.c                  |   1 +
 testcases/kernel/sound/snd_seq01.c            |   2 +-
 testcases/kernel/sound/snd_timer01.c          |   1 +
 testcases/kernel/syscalls/bind/bind06.c       |   2 +-
 .../syscalls/clock_gettime/clock_gettime01.c  |   1 -
 .../kernel/syscalls/fanotify/fanotify22.c     |   1 -
 .../syscalls/gettimeofday/gettimeofday02.c    |  15 +-
 testcases/kernel/syscalls/inotify/inotify06.c |   7 +-
 testcases/kernel/syscalls/inotify/inotify09.c |   1 +
 testcases/kernel/syscalls/inotify/inotify11.c |   1 -
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |   2 +-
 .../kernel/syscalls/move_pages/move_pages12.c |   4 +-
 .../perf_event_open/perf_event_open03.c       |  15 +-
 testcases/kernel/syscalls/readv/readv01.c     |   1 -
 .../rt_sigqueueinfo/rt_sigqueueinfo01.c       |   1 -
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |   1 +
 .../kernel/syscalls/setsockopt/setsockopt06.c |   2 +-
 .../kernel/syscalls/setsockopt/setsockopt07.c |   1 +
 .../kernel/syscalls/setsockopt/setsockopt09.c |   1 -
 testcases/kernel/syscalls/tgkill/tgkill03.c   |   1 -
 .../syscalls/timerfd/timerfd_settime02.c      |   1 +
 .../syscalls/userfaultfd/userfaultfd01.c      |   1 -
 testcases/kernel/syscalls/writev/writev03.c   |   2 +-
 63 files changed, 339 insertions(+), 296 deletions(-)
 delete mode 100644 lib/newlib_tests/test10.c
 delete mode 100644 lib/newlib_tests/test12.c
 rename lib/newlib_tests/{test18.c => test_runtime01.c} (58%)
 create mode 100644 lib/newlib_tests/test_runtime02.c
 delete mode 100644 testcases/kernel/io/ltp-aiodio/read_checkzero.c

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
