Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B239C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:15:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82A693E56B1
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:15:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB5DE3E56A9
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:15:30 +0200 (CEST)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31C7D140007D
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:15:29 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784024129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xrqf2FuuLENsIaqsN9e2GiIeFId22WLpEGPvK4DSQsg=;
 b=OAy/pbEHmwWmDfHvxHtwdIjorbFcBQD64AzYZZ58i4TrQDia7Tnjz8nRDOjbv8rJGguR5r
 Zt4+WpgFrZdKc7f92U6ZvrWF7/jK70cDQD3APhQ6G4kuufrx7t6x1Z9eZZtxyAn9ExN7kW
 aOEdZixAxCCW22lZj5yUCZtxsH2Vlv0=
From: Gang Yan <gang.yan@linux.dev>
To: ltp@lists.linux.it
Date: Tue, 14 Jul 2026 18:14:51 +0800
Message-ID: <20260714101454.8784-1-gang.yan@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] tst_fd.c: fix test_failures on loongarch's old
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
Cc: Gang Yan <yangang@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gang Yan <yangang@kylinos.cn>

Patch1 fixes LTP tst_fd/accept03 test failures on LoongArch64
introduced after commit 209f0c6360da ("Update arch(s) syscalls files")
removed memfd_secret syscall number from loongarch64 syscall table.

Patch 2-3 refactors LTP syscall helper to properly handle missing
syscalls without unexpected TBROK/TFAIL errors.

Gang Yan (3):
  loongarch.in: add memfd_secret syscall
  generate_syscall.sh: add a helper named tst_syscall_base
  tst_fd.c: replace syscall() with tst_syscall_base()

 include/lapi/syscalls/generate_syscalls.sh | 27 +++++++++++++---------
 include/lapi/syscalls/loongarch64.in       |  1 +
 lib/tst_fd.c                               | 22 +++++++++---------
 3 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
