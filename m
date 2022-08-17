Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504D8C25B08
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 13:38:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DB8C3C9F24
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 15:38:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73373C9CF4
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id ECEDF60082B
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:38:23 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8240A113E;
 Wed, 17 Aug 2022 06:38:23 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D54543F67D;
 Wed, 17 Aug 2022 06:38:21 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 17 Aug 2022 14:39:28 +0100
Message-Id: <20220817133929.234873-2-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817133929.234873-1-tudor.cretu@arm.com>
References: <20220817133929.234873-1-tudor.cretu@arm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] utils/compat_16: Add a make option to disable the
 build of compat_16 tests.
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

utils/newer_64.mk has a make option that disables the build of newer_64
tests. Similarly, add a make option to utils/compat_16.mk to disable the
build of compat_16 tests.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 testcases/kernel/syscalls/utils/compat_16.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
index e81a00c40..71fcc4b89 100644
--- a/testcases/kernel/syscalls/utils/compat_16.mk
+++ b/testcases/kernel/syscalls/utils/compat_16.mk
@@ -54,7 +54,9 @@ SRCS			?= $(sort $(wildcard $(abs_srcdir)/*.c))
 
 MAKE_TARGETS		:= $(notdir $(patsubst %.c,%,$(SRCS)))
 MAKE_TARGETS_OBJS_WO_COMPAT_16	:= $(addsuffix .o,$(MAKE_TARGETS))
+ifneq ($(TST_COMPAT_16_SYSCALL),no)
 MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
+endif
 
 # XXX (garrcoop): This code should be put in question as it cannot be applied
 # (no .h file, no TST_USE_NEWER64_SYSCALL def).
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
