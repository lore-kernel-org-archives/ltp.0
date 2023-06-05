Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A20DEB64D9
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 07:58:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 612E63CB833
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 09:58:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F05D13CB563
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 06:41:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3FF181A006A4
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 06:41:35 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 536E26114B;
 Mon,  5 Jun 2023 04:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AE5C433D2;
 Mon,  5 Jun 2023 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685940092;
 bh=3aJhbsgcAbjTn1Ueo2xwDp1hgCFxVtnDWvkwiS9igxU=;
 h=From:To:Cc:Subject:Date:From;
 b=oB4qMAeje807BWXjWY4Y2ZBb9rXk1HOmNzHgYBjnDiSC114KkYtU6JuGdzCTAXVCx
 RAtGyQPQFD1CJnnyQsJpZTXddQuJ8FRbdOV9r14TiPiGrh8uohKRMhWw3Rzd/n9umN
 vjhnD9HHCbWaYUlfk8B+neJP8LpFu2cunzb0MssjZy+yvoO3+6GtRDc0j9dy/Piapl
 yUxnp+saPweTwcrVGYcbrt9lStm84IQjRi9p8uEUEIVEb4qEIcdPHjCLOioGS3foF8
 8rTaT7mia/kPujV3vqfJTB6BxI9V81nihXI+BdnnaB8Rh9q8UJRC3rrG4kyPOPYEkh
 CU0yK10fjJmpw==
From: Damien Le Moal <dlemoal@kernel.org>
To: ltp <ltp@lists.linux.it>,
	Linus Walleij <linus.walleij@linaro.org>
Date: Mon,  5 Jun 2023 13:41:29 +0900
Message-Id: <20230605044131.798383-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 19 Jun 2023 09:58:05 +0200
Subject: [LTP] [PATCH 0/2] Improve ioprio tests
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The ioprio syscall tests rely on ltp internal definitions of the
IOPRIO_XXX() macro defining priority classes and levels. With changes
to the ioprio API to support command duration limits, these internal
definitions are incomplete, causing test case ioprio_set03 to fail.

Avoid this issue by having the iprio tests use the kernel header file
definitions if that header exists. This enables additional checks in
the header file [1] which restores the expected results with test
ioprio_set03.

[1] https://lore.kernel.org/linux-block/20230530061307.525644-1-dlemoal@kernel.org/

Note: a review of this patch on the kernel block mailing list would be
very appreciated.

Damien Le Moal (2):
  ioprio: use ioprio.h kernel header if it exists
  ioprio: Use IOPRIO_PRIO_NUM to check prio range

 configure.ac                                  |  1 +
 testcases/kernel/syscalls/ioprio/ioprio.h     | 33 ++++++++++++++-----
 .../kernel/syscalls/ioprio/ioprio_set03.c     |  2 +-
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
