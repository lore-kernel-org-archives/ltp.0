Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60109C433F5
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 06:13:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26F1C3C972A
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 07:13:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E09B43C9704
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 37AF91A006EA
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 07:13:07 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D5FB4210FD;
 Thu, 27 Jan 2022 06:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1643263986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PiP9DtNX6dqUwo3sQ/DiEXnnSd7wYN2r2OfYS1/z17g=;
 b=STybR8AwuF3HtEAbaLNwaEH8xzNaDy6wqyPs+CRmdg2i6PUAH2zl3mzIJMaYSaQ7jg0eO0
 Z9gUNerR3ONcCQ3xuSjEZp8LZrKMQ6MyDYptKUTTYkojl0olts7OAAQ7d2k39Nb0bv1/X2
 oFzHLGca+e43IlYBVYaBG8GxS4tVLpw=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id A467CA3B81;
 Thu, 27 Jan 2022 06:13:06 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 27 Jan 2022 06:12:19 +0000
Message-Id: <20220127061225.23368-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Add memcontrol03 and declarative CG API
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

This adds a third test from the kselftests. Also I have finally taken
the step of moving the CGroup configuration to tst_test. This doesn't
save a huge amount of typing, but is good for the meta-data.

Richard Palethorpe (6):
  memcontrol02: Remove O_TMPFILE TCONF check
  API: Add tst_reap_child
  memcontrol: Lift out some common definitions into a shared header
  API/cgroup: Declare required controllers and version in test struct
  API/cgroup: Add memory.min
  memcontrol03: Copy from kselftest

 include/tst_cgroup.h                          |  15 +-
 include/tst_test.h                            |  23 ++
 lib/newlib_tests/tst_cgroup01.c               |   2 +-
 lib/newlib_tests/tst_cgroup02.c               |   2 +-
 lib/tst_cgroup.c                              |  21 +-
 lib/tst_test.c                                |  47 ++++
 .../kernel/controllers/memcg/memcontrol01.c   |  13 +-
 .../kernel/controllers/memcg/memcontrol02.c   |  50 +---
 .../kernel/controllers/memcg/memcontrol03.c   | 231 ++++++++++++++++++
 .../controllers/memcg/memcontrol_common.h     |  48 ++++
 testcases/kernel/mem/cpuset/cpuset01.c        |   4 +-
 testcases/kernel/mem/ksm/ksm02.c              |   4 +-
 testcases/kernel/mem/ksm/ksm03.c              |   4 +-
 testcases/kernel/mem/ksm/ksm04.c              |   7 +-
 testcases/kernel/mem/oom/oom03.c              |   4 +-
 testcases/kernel/mem/oom/oom05.c              |   8 +-
 .../sched/cfs-scheduler/cfs_bandwidth01.c     |   6 +-
 testcases/kernel/syscalls/madvise/madvise06.c |   5 +-
 18 files changed, 399 insertions(+), 95 deletions(-)
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol03.c
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol_common.h

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
