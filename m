Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8884EC433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E13AF3C96A7
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:45:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 209F23C90E7
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:26 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D217600078
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:25 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C08A73F306
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603461;
 bh=oqPtAn++7R40KRPpI2IMvsA661HDZ3iHKPn6coM3Lh4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=E+lS8habGQiIBK65tPYbz0zCDcE7L17A+U4fc0nVjKXdsaG3mEiGrajCTxn6vqgRe
 CwAl3Hl45HpiSMy9+5JpuhPONMb6lUOrV4QSE+ZhkkA43rM/6xi5olBPIysW0z2Xds
 a4pHhOnPvmE9oayx/B2e0n6mbvJftCQI47BxtUdeYnxXqC+rVI8CaTaTJxU9AN2bDD
 kxG5EjqWX1pw/xTOM0atcIpiJoNMpq4qUy0XHjJcvV7LltSJIntzsXtyH1GKYyk9mD
 aEmM0s4cx4E8N3SYeCwTNlKxe5OoQjY8Dgs4S1/BIc12z09KxWAmKLi8ts0GbyhPYM
 jK0ittK/RrYZw==
Received: by mail-lf1-f72.google.com with SMTP id
 u1-20020ac258c1000000b004304234f41aso1754741lfo.8
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqPtAn++7R40KRPpI2IMvsA661HDZ3iHKPn6coM3Lh4=;
 b=yBAK4UF+8JCmu2TkpUcWfKVqBOcrHLH4sHfphaXZVCpcT4m32N5rfPfw9Od9JWFnt9
 E37AW+rr9fwv/bN10tOaHEwj08PGlqOuHiZY98T+dOVVfbYUPh1UNZY9Iy1qD4FVu19g
 jXIsa1FohegysVQtPBXs02D8Lvs3fQ04DraCDAPcKrhHw7wPLaDQ8YU6guthhJUtRazV
 NdFn2DqMZZ1bINtXe9CrsoZUuLD9/FWfDEmaUALQbemzUQdHkmm3vYGJ65pF6KzWrcSR
 r0+qvYvQ/Gi5i7+768kJ/cB8Vm2YxsWq1jQH/p+4oreA6c1RmiCw7wWzSbStgUOPzkUs
 +QQw==
X-Gm-Message-State: AOAM533cu8pkq0yMQXWthr+t0I81hidSNruBTcnxMlK7JNo4n1N4Jw03
 WwXGJyClZ+6bAoNg+rjoKGvAqvMy9ipZOV0Jy4A3x8EaqYQ6R34Y8l9wznswL5hDub52fikMrKO
 cx5H1zhvcR7R5HN3wes9uVuQciw7m
X-Received: by 2002:ac2:4d24:: with SMTP id h4mr28456650lfk.186.1642603461038; 
 Wed, 19 Jan 2022 06:44:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1K1E7ihtc+F7wimj3vouoA7P7lmcrmRtKVJyMshdljmcIx6JptZht6J2xfAdceGmd3Hz7QQ==
X-Received: by 2002:ac2:4d24:: with SMTP id h4mr28456628lfk.186.1642603460797; 
 Wed, 19 Jan 2022 06:44:20 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:20 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:02 -0800
Message-Id: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/16] Expand Cgroup lib and modify controller tests
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

This patchset aims to expand the cgroup_lib shell library to simplify
and centralize the whole mounting and cleanup process that can get
rather confusing and redundant when writing cgroup controller tests from
a shell environment. This is done by having the shell library make calls
to the C cgroup API from a binary utility. 

In this patch set there are a few tests that have been extensively
rewritten to work with the new test API and to use the new functionality
from the cgroup lib. Because the test Cgroup lib handles mounting for v1
and v2 controllers, some tests were modified to also work under cgroup
v2. Some tests that were written for v1 controller also effictively test
v2 controllers, while others were written to test v2 controllers in the
spirit of the test or skipped outright. 

Luke Nowakowski-Krijger (16):
  API/cgroup: Modify tst_cgroup_print_config for easier parsing and
    consumption
  API/cgroup: Add option for specific pid to tst_cgroup_opts
  API/cgroup: Add cgroup_find_root helper function
  API/cgroup: Implement tst_cgroup_load_config()
  API/cgroup: Add more controllers to tst_cgroup
  API/cgroup: Change to TWARN when v2 controllers change
  testcases/lib: Implement tst_cgctl binary
  controllers: Expand cgroup_lib shell library
  controllers: Update cgroup_fj_* to use newer cgroup lib and test lib
  controllers: Update memcg_control_test to newer test lib and cgroup
    lib
  controllers: Update memcg/regression/* to new test and cgroup lib
  controllers: Update memcg_stress_test to use newer cgroup lib
  controllers: update memcg/functional to use newer cgroup lib
  controllers: Update pids.sh to use newer cgroup lib
  controllers: update cpuset_regression_test.sh to use newer cgroup lib
  controllers: update cgroup_regression_test to use newer cgroup lib

 include/tst_cgroup.h                          |   7 +-
 lib/tst_cgroup.c                              | 314 +++++++++++++++++-
 .../cgroup/cgroup_regression_test.sh          |  17 +-
 .../controllers/cgroup_fj/cgroup_fj_common.sh | 105 ++----
 .../cgroup_fj/cgroup_fj_function.sh           | 169 ++++++----
 .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 +++++-----
 testcases/kernel/controllers/cgroup_lib.sh    | 128 +++++--
 .../cpuset/cpuset_regression_test.sh          |  26 +-
 .../controllers/memcg/control/mem_process.c   |  28 +-
 .../memcg/control/memcg_control_test.sh       | 150 +++------
 .../memcg/functional/memcg_force_empty.sh     |   2 +-
 .../controllers/memcg/functional/memcg_lib.sh |  54 +--
 .../memcg/regression/memcg_regression_test.sh | 202 +++++------
 .../memcg/regression/memcg_test_1.c           |  40 +--
 .../memcg/regression/memcg_test_2.c           |  24 +-
 .../memcg/regression/memcg_test_3.c           |  35 +-
 .../memcg/regression/memcg_test_4.c           |  24 +-
 .../memcg/regression/memcg_test_4.sh          |  50 ++-
 .../memcg/stress/memcg_stress_test.sh         |  32 +-
 testcases/kernel/controllers/pids/pids.sh     |  65 +---
 testcases/lib/Makefile                        |   2 +-
 testcases/lib/tst_cgctl.c                     |  69 ++++
 23 files changed, 966 insertions(+), 769 deletions(-)
 create mode 100644 testcases/lib/tst_cgctl.c

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
