Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71335C001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C02B03CECB1
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:19:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6D4A3CECAD
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 348DD1000414
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:57:22 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D97332F4;
 Mon, 23 Oct 2023 06:58:01 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com
 [10.1.194.65])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606613F64C;
 Mon, 23 Oct 2023 06:57:20 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 14:56:44 +0100
Message-Id: <20231023135647.2157030-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Oct 2023 16:18:31 +0200
Subject: [LTP] [PATCH 0/3] Various fixes for out-of-bound uaccess
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
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

This series addresses various situations where syscalls tests cause the
kernel to access arbitrary data, beyond the bounds of the object that
the test meant to specify.

Patch 1 and 2 are straightforward fixes for tests that don't pass
syscall arguments correctly.

Patch 3 is a little subtler, in that the argument is appropriately
passed, but the kernel ends up accessing arbitrary data due to the
referenced buffer being too small.

These issues were caught while running the syscalls suite on
Morello [1], using the pure-capability ABI [2]. Thanks to the capability
representation, pointers carry bounds that match the object they refer
to. The kernel accesses user memory via such capabilities, and as a
result a syscall will fail (-EFAULT) if any uaccess goes out of bounds.

A CI run can be found here [3].

Cheers,
Kevin

[1] https://www.morello-project.org/
[2] https://git.morello-project.org/morello/kernel/linux/-/wikis/Morello-pure-capability-kernel-user-Linux-ABI-specification
[3] https://github.com/kevin-brodsky-arm/ltp/actions/runs/6610988117

Kevin Brodsky (3):
  syscalls/{,f}setxattr: Fix passing of value pointer
  syscalls/msgctl06: Pass an appropriate struct to msgsnd()
  Provide a PATH_MAX-long buffer when expecting ENAMETOOLONG

 include/old/usctest.h                             | 12 ++----------
 testcases/kernel/syscalls/fsetxattr/fsetxattr01.c |  2 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c   |  6 +++++-
 testcases/kernel/syscalls/rename/rename10.c       |  2 +-
 testcases/kernel/syscalls/setxattr/setxattr01.c   |  2 +-
 5 files changed, 10 insertions(+), 14 deletions(-)

-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
