Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16607C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:53:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1C243C9CF4
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:53:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C483D3C98CE
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:12 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EB8C20004A
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:11 +0200 (CEST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47F5C3F12D
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436790;
 bh=pIJLWr7fr3oY/znYyHVM76bWkKK8D4f79ORIWbnwRIQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=G3hj4bwXVidXOMXl7A5X9dBF010X7Lev7ZC6bio8Wumdrltj1llpZtW5s920g9ZH7
 drsgj4uv0rNlIclgwD68MJKHyjqYcym/5U8K1lrrhGeGWERN89n5L2Ir39TSYG+DNX
 30xWvpMzQ/EgZMrHp3tChIsW/oqL9qg5/wpRLCrEWpyleH0hXKYGlebBlTtxztc2Se
 OolWIXgQbfFV9ztZlrpi/QVJc22PmCs22n0v3or9BCnautGZD3f3JTlyRC4ZotaGU8
 XZHGL63Hak8O2oR0N+KNtkcdXQ2oUOm+V3zhAA6JEgJmw6zNvA6/epkVnEX9oHIbMR
 EdeRNSWtBKqXQ==
Received: by mail-pg1-f198.google.com with SMTP id
 h185-20020a636cc2000000b00419b8e7df69so1343031pgc.18
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pIJLWr7fr3oY/znYyHVM76bWkKK8D4f79ORIWbnwRIQ=;
 b=Df2ViXzBVSBuWo6mslUZv5QE6PVz7QLjGJZKkg7hF8swmt0/nn2lO3XscWMAB3TjNV
 hJVPlQ7hac/kFbaZkCrNtvOYXE9eTidxjj0OQ6HucdIFkrxEgQa9QYBZUqMjNR8KOyqg
 Qv2GoZTM2C7m9OC9JXfNDN2F3oUvxzHaweJ+Im+4eZGw4nEoGBMvaUCMor4lyVk1+FzO
 nILcm9bm3GVXBnuUWk9IfMhIxKghcuWTVdzev4VZ2hpe5aEzuyaqr4uV4SoKADePGq/L
 IZXiYOiUw5xca6oAqpa78G+F72ZBpP16m9LJz08LPkcQ3SxE1ND960OygDd5oFt9Usns
 yaAg==
X-Gm-Message-State: AJIora+ajnezV+P5FulkRRKfSxQuoXIPQigbbVDvFlcptvTaJ2MdV+XU
 pZqP9wmOIG4nSpRUDeoRUd2kQuEzkhiNg6VXCQOJVIm+Jq/M+FpS8hSSZrPEoHvPc30ahZ2FUex
 eC5vXE8KiwxMkUfnM44DINWzwtpcn
X-Received: by 2002:a17:902:d2d1:b0:16d:37b3:f8b3 with SMTP id
 n17-20020a170902d2d100b0016d37b3f8b3mr154340plc.98.1658436787650; 
 Thu, 21 Jul 2022 13:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1um3K9r6CmLXCczDxpMI1rRncnwgnerdwMzjFkbjd2Ofx85OC3EeWnhMuoj/s3XJ58MLkEiVA==
X-Received: by 2002:a17:902:d2d1:b0:16d:37b3:f8b3 with SMTP id
 n17-20020a170902d2d100b0016d37b3f8b3mr154310plc.98.1658436787306; 
 Thu, 21 Jul 2022 13:53:07 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:06 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:10 -0700
Message-Id: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 00/18] Expand Cgroup lib and modify controller tests
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

Luke Nowakowski-Krijger (18):
  API/cgroup: Modify tst_cg_print_config for parsing and consumption
  API/cgroup: Add option for specific pid to tst_cg_opts
  API/cgroup: Add cgroup_find_root helper function
  API/cgroup: Add CTRL_NAME_MAX define
  tst_test_macros: Add TST_TO_STR and TST_STR macro
  API/cgroup: Implement tst_cg_load_config
  API/cgroup: Add more controllers to tst_cgroup
  API/cgroup: refuse to mount blkio when io controller is mounted
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

 include/tst_cgroup.h                          |  17 +-
 include/tst_test_macros.h                     |   3 +
 lib/tst_cgroup.c                              | 216 +++++++++++++++++-
 .../cgroup/cgroup_regression_test.sh          |  31 +--
 .../controllers/cgroup_fj/cgroup_fj_common.sh | 115 +++-------
 .../cgroup_fj/cgroup_fj_function.sh           | 172 ++++++++------
 .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 171 +++++++-------
 testcases/kernel/controllers/cgroup_lib.sh    | 133 +++++++++--
 .../cpuset/cpuset_regression_test.sh          |  26 +--
 .../controllers/memcg/control/mem_process.c   |  28 +--
 .../memcg/control/memcg_control_test.sh       | 149 +++---------
 .../memcg/functional/memcg_force_empty.sh     |   2 +-
 .../controllers/memcg/functional/memcg_lib.sh |  54 +++--
 .../memcg/regression/memcg_regression_test.sh | 203 ++++++++--------
 .../memcg/regression/memcg_test_1.c           |  40 ++--
 .../memcg/regression/memcg_test_2.c           |  24 +-
 .../memcg/regression/memcg_test_3.c           |  38 ++-
 .../memcg/regression/memcg_test_4.c           |  24 +-
 .../memcg/regression/memcg_test_4.sh          |  50 ++--
 .../memcg/stress/memcg_stress_test.sh         |  32 +--
 testcases/kernel/controllers/pids/pids.sh     |  67 +-----
 testcases/lib/Makefile                        |   2 +-
 testcases/lib/tst_cgctl.c                     |  87 +++++++
 24 files changed, 909 insertions(+), 799 deletions(-)
 create mode 100644 testcases/lib/tst_cgctl.c

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
