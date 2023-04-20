Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C5EC77B73
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 16:09:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FE9E3CBF7C
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 18:09:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56D483CBF72
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 18:09:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 0BB0460083E
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 18:09:20 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7611480
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 09:10:01 -0700 (PDT)
Received: from e126380.arm.com (unknown [10.57.59.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 049103F6C4
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 09:09:16 -0700 (PDT)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Thu, 20 Apr 2023 17:09:08 +0100
Message-Id: <20230420160910.809091-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] setpgid: Test EPERM error paths more reliably
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

The current EPERM case in setpgid02 can fail in systems running the
login shell as init (PID 1).

Change the failing case to fail due to an invalid PGID instead of
a different session, but add a case in setpgid03 to continue
testing this error path in the kernel.

This is because setpgid03 already has the necessary scaffolding ready
by forking and synchronizing with a child that does setsid().


CI Build: https://github.com/Teo-CD/ltp/actions/runs/4756354740

Teo Couprie Diaz (2):
  setpgid02: Use pid_max as PGID for EPERM
  setpgid03: Add test for PGID in different session

 testcases/kernel/syscalls/setpgid/setpgid02.c | 14 +++++++-------
 testcases/kernel/syscalls/setpgid/setpgid03.c |  4 ++++
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
