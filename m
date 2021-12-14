Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318D4C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 09:07:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5729B3C8C37
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:07:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE5053C7616
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:07:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE5EF600A51
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 10:07:32 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F35F1212B5;
 Tue, 14 Dec 2021 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639472851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=60Z6de0fK8d6iQzJrBe+4I/pWrsJ+mQyqUbLMjkKwC8=;
 b=lv3Ee4mqQbmbX/KaavMJwlYyVhvsrf7tyCvO8qsQcso16jR4jNNypCNuvsEyvaodyEjLDM
 VX1N+JbIlXmQcZpynv9dv2TsAn4zashdbqwaA4UYCOcGDGZ0a0Kpb7OJymlc61hlYXsSDr
 jIboGTq/HD9ASNSO/umShPqOXkw6Y9o=
Received: from g78.suse.de (unknown [10.163.24.42])
 by relay2.suse.de (Postfix) with ESMTP id B3B31A3B81;
 Tue, 14 Dec 2021 09:07:31 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Dec 2021 09:06:44 +0000
Message-Id: <20211214090648.14292-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Begin converting kselftest memcg tests
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

This is the begining of a piecmeal conversion of the memcg
kselftests. The first test is fairly redundant. However it allows for
some organizational discussion.

The motivation for converting these tests is as follows:

1. It's easier to run these tests across our full product range
   as part of the LTP.
2. The LTP CGroup library allows testing on V1 and V2.
   The kselftest's only support V2.
3. The kselftests appear to cover some things which
   existing LTP tests do not.

Richard Palethorpe (4):
  API: cgroup: Add safe_cgroup_occursin
  API: cgroup: Add cgroup.controllers
  memcontrol01: Import first memcg kselftest
  scripts/coccinelle: Helper for converting CGroup selftests

 include/tst_cgroup.h                          |  8 ++
 lib/tst_cgroup.c                              | 13 ++++
 runtest/controllers                           |  3 +
 .../coccinelle/kselftest-cgroup-to-ltp.cocci  | 40 ++++++++++
 testcases/kernel/controllers/memcg/.gitignore |  1 +
 .../kernel/controllers/memcg/memcontrol01.c   | 77 +++++++++++++++++++
 6 files changed, 142 insertions(+)
 create mode 100644 scripts/coccinelle/kselftest-cgroup-to-ltp.cocci
 create mode 100644 testcases/kernel/controllers/memcg/memcontrol01.c

-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
