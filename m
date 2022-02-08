Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A792DC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:03:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25A6E3C9B47
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 15:03:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713903C24D6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:03:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E5F9F600A6D
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 15:03:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1148F210F9;
 Tue,  8 Feb 2022 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1644329024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9ez1e0j5hVS7T8kS7EixQ25zV0lLwmU4SYsOp7JfXKk=;
 b=IKJyVu+9kBOSu7JXe1ugTR92l78He44QfjH2k02lPvAJh9ULPCgEN4f0KQQtm+99OECZKx
 IAQge6VuOCpOQ3jaDXVPrZk5MWVBR4Qf2UXaYvOT5u9NTGtPYEm2Qb3Ed6qyXStAuDgZ3L
 kuAl0aMQS7aLTu4loU/ZcvdUvQ7RzqI=
Received: from g78.suse.de (unknown [10.163.24.138])
 by relay2.suse.de (Postfix) with ESMTP id D1A46A3B90;
 Tue,  8 Feb 2022 14:03:43 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue,  8 Feb 2022 14:03:19 +0000
Message-Id: <20220208140322.6842-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] memcontrol04 and s/cgroup/cg/
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

Hello,

This adds another test from kselftest and tries to improve the
readability of the cgroup API.

This is probably the last test I will copy for now. However I may
rewrite the tests to clone child processes into a CGroup when the
feature is available.

Richard Palethorpe (3):
  API/cgroup: Add memory.{events, low}
  API/cgroup: Shorten cgroup to cg in most symbols
  memcontrol04: Copy from kselftest

 doc/c-test-api.txt                            |  52 ++--
 include/tst_cgroup.h                          | 112 ++++-----
 include/tst_test.h                            |   2 +-
 lib/newlib_tests/tst_cgroup01.c               |  18 +-
 lib/newlib_tests/tst_cgroup02.c               |  54 ++---
 lib/tst_cgroup.c                              | 112 ++++-----
 lib/tst_test.c                                |   8 +-
 runtest/controllers                           |   1 +
 scripts/coccinelle/cgroup-ver.cocci           |  16 +-
 .../coccinelle/kselftest-cgroup-to-ltp.cocci  |  16 +-
 testcases/kernel/controllers/memcg/.gitignore |   1 +
 .../kernel/controllers/memcg/memcontrol01.c   |  36 +--
 .../kernel/controllers/memcg/memcontrol02.c   |  28 +--
 .../kernel/controllers/memcg/memcontrol03.c   |  60 ++---
 .../kernel/controllers/memcg/memcontrol04.c   | 228 ++++++++++++++++++
 testcases/kernel/mem/cpuset/cpuset01.c        |  14 +-
 testcases/kernel/mem/include/mem.h            |   2 +-
 testcases/kernel/mem/ksm/ksm02.c              |   6 +-
 testcases/kernel/mem/ksm/ksm03.c              |   4 +-
 testcases/kernel/mem/ksm/ksm04.c              |   6 +-
 testcases/kernel/mem/lib/mem.c                |   8 +-
 testcases/kernel/mem/oom/oom03.c              |  18 +-
 testcases/kernel/mem/oom/oom04.c              |   8 +-
 testcases/kernel/mem/oom/oom05.c              |  24 +-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |  40 +--
 testcases/kernel/syscalls/madvise/madvise06.c |  16 +-
 26 files changed, 561 insertions(+), 329 deletions(-)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol04.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
