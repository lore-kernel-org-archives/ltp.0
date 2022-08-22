Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F72DC32789
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 11:38:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C5BA3CA310
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 13:38:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EA1D3C9A44
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 13:38:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 7A35F1400522
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 13:38:38 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C466912FC;
 Mon, 22 Aug 2022 04:38:39 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2C63F718;
 Mon, 22 Aug 2022 04:38:35 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Mon, 22 Aug 2022 12:39:15 +0100
Message-Id: <20220822113919.196953-1-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] syscalls: Fix various syscall tests when
 compiled with Musl
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

Hi,

There were a few issues with some syscalls tests when they were compiled
with Musl. This series attempts to improve the robustness of some syscall
tests.

changes v1->v2:
* Patch 1/1: Moved the Musl link from source to the commit message
* Patch 4/4: Implement a sighandler to catch segfaults and allow the EFAULT
             tests to pass, instead of just calling the raw [f]statfs syscall.

Tudor Cretu (4):
  lib: Fix initialization of recursive mutex
  syscalls/mprotect01: Invoke the syscall directly instead of the libc
    wrapper
  syscalls/prctl04: Allow rt_sigprocmask in the syscall filter
  syscalls/statfs: Accept segfault instead of EFAULT

 lib/tst_res.c                                 | 25 +++++---
 testcases/kernel/syscalls/fstatfs/fstatfs02.c | 60 ++++++++++++++-----
 .../kernel/syscalls/mprotect/mprotect01.c     |  3 +-
 testcases/kernel/syscalls/prctl/prctl04.c     |  1 +
 testcases/kernel/syscalls/statfs/statfs02.c   | 32 +++++++++-
 5 files changed, 93 insertions(+), 28 deletions(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
