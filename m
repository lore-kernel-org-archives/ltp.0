Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE7C25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 13:38:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06A623C9DB4
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 15:38:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E15C53C9B4F
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 6E8DB1A009BB
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:21 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C27113E;
 Wed, 17 Aug 2022 06:38:20 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A6DD3F67D;
 Wed, 17 Aug 2022 06:38:18 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 17 Aug 2022 14:39:27 +0100
Message-Id: <20220817133929.234873-1-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] utils/compat_16: Allow build.sh to disable the
 compat_16 tests
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

The option that allows disabling the compat_16 tests has been erroneously
removed in a previous change, so re-add it. Also, enable build.sh to use
make options such as TST_NEWER_64_SYSCALL or TST_COMPAT_16_SYSCALL.

Tudor Cretu (2):
  utils/compat_16: Add a make option to disable the build of compat_16
    tests.
  build.sh: Allow specifying additional make options

 build.sh                                     | 2 +-
 testcases/kernel/syscalls/utils/compat_16.mk | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
