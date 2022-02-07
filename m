Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF5DC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 14:16:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06D333C9B00
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 15:16:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1939F3C0720
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7B7D11400B89
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 15:16:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B9F94210FF;
 Mon,  7 Feb 2022 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644243391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=svidmMVOKIBLPB5estIYW3BUcUJaB6kt+DetDUVJubw=;
 b=cveHNDrrK8bX2CFoqUeihy+ptyTOykI5WOBWbo8oYjquQRKLyQYVndMPsgc0hyKx2hNaTN
 tVQShRLUXzYk0w80sZEgJYxhUkxf4sn4JnxNqCwtbhq8BWV6HYr+IrTwWoQmxapmr57zDh
 AdvDk01Lo/Wa+CojfB02//eB6Ffv7K8=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id BD215A3B81;
 Mon,  7 Feb 2022 14:16:30 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon,  7 Feb 2022 14:16:13 +0000
Message-Id: <20220207141618.2844-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/5] Add memcontrol03 and declarative CG API
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This adds a third test from the kselftests. Also I have finally taken
the step of moving the CGroup configuration to tst_test and making it
declarative. Since V2 of the patch this does save a lot of typing and
removes the need to remember to call cleanup. It also puts the CGroup
info into the metadata.

V3:
* Simplify by adding tst_cgroup.h to tst_test.h as suggested by Li Wang
* rm options defaults as suggested by Li
* use abbreviation for controller, same as version as suggesdted by Li
* rm useless checks for V1 in memcontrol03 as suggested by Cyril
* fix format compile error in cfs_bandwidth01 as reported by Li
* Move the group_name fix into the printf patch; reported by Cyril

V2:
* Updated docs
* Updated library tests
* Moved the test/drain cg ptr out of the test struct and allocate
  it statically. This resulted in some overly clever init code
  being removed as well.
* Renamed parent cgs to trunk and child to leaf as technically trunk
  nodes can be both parents and children.
* Matched the cg names in the comments with the variable names
  using enums. So it's easier to see that the description matches
  the code.
* Use waitpid as suggested by Cyril and remove the patch adding
  tst_reap_child.
* unlink the tmpfile to hopefully prevent random storage full errors
  when using -i. We already seek to 0.
* init the fd to -1
* Make tst_cgroup_group_mk sprintf like as suggested by Cyril.

Richard Palethorpe (5):
  memcontrol: Lift out some common definitions into a shared header
  API/cgroup: Declare required controllers and version in test struct
  API/cgroup: Add memory.min
  API/cgroup: Make tst_cgroup_group_mk sprintf like
  memcontrol03: Copy from kselftest

 doc/c-test-api.txt                            | 102 ++++---
 include/tst_cgroup.h                          |  34 +--
 include/tst_test.h                            |   7 +
 lib/newlib_tests/tst_cgroup01.c               |   3 +-
 lib/newlib_tests/tst_cgroup02.c               |  27 +-
 lib/tst_cgroup.c                              |  91 ++++---
 lib/tst_test.c                                |  21 ++
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol01.c   |  20 +-
 .../kernel/controllers/memcg/memcontrol02.c   |  45 +---
 .../kernel/controllers/memcg/memcontrol03.c   | 253 ++++++++++++++++++
 .../controllers/memcg/memcontrol_common.h     |  47 ++++
 testcases/kernel/mem/cpuset/cpuset01.c        |  25 +-
 testcases/kernel/mem/include/mem.h            |   1 -
 testcases/kernel/mem/ksm/ksm02.c              |  19 +-
 testcases/kernel/mem/ksm/ksm03.c              |  13 +-
 testcases/kernel/mem/ksm/ksm04.c              |  16 +-
 testcases/kernel/mem/oom/oom03.c              |  24 +-
 testcases/kernel/mem/oom/oom04.c              |  15 +-
 testcases/kernel/mem/oom/oom05.c              |  34 ++-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |  20 +-
 testcases/kernel/syscalls/madvise/madvise06.c |  29 +-
 23 files changed, 534 insertions(+), 314 deletions(-)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol03.c
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol_common.h

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
