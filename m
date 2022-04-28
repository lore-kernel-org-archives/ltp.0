Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A1FC433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:40:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8776E3CA769
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:40:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 177663C8972
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:34 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 45771100094A
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:33 +0200 (CEST)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25EFC3F21D
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178432;
 bh=gsktzDsYP+1Oi7UicMKk9RGa/wOUGtylTdMJeF0RP9U=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=lrafUPphh0YDNUOhQb8+UVU3VofN4Xkw7Ny0TexEhWEw2LuIuLVBBJL13H6HEmuij
 Lzb+jV9QL0IMdiL1EATFMa/1ICxel2Gd7ot3TElyLbiBMLyrQal1nsuR6kAFNdteP0
 pzhMdp15hZs1WN/DRR7Ceyj5S+nHmHst3BxSC5Bw+/SXZZ0bsrh2rbAzpxBl+r/LoZ
 DAp7UyKe9r7RMC5GlnsL0SvZeqVgOquJkBurLxbMqp1gNqTrfwkVk2RdEMzLE6JAnY
 1Czi0cDd8hmbLjm+zoUmXScueY8O8uQLHWwN4wvWZ3mW2ORT4AxJQmhjL/zNAv/udh
 WQVQQY3HXx9EA==
Received: by mail-pf1-f200.google.com with SMTP id
 d5-20020a62f805000000b0050566b4f4c0so3277327pfh.11
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gsktzDsYP+1Oi7UicMKk9RGa/wOUGtylTdMJeF0RP9U=;
 b=v8X0jbvT3iEAVrxcCVSfqPRB6z7UEnhBtOErgWOa4hIDSuaHPtqa2OmYTOsmZC1OxP
 z8GCqeyq9ER/dpBM1flnfIHTHcvQEM2frn9RGmxdOtaRTb927PwvHGYQ20dD1skmk7Lg
 dBTLaLYnAo7q5l9ubQlmmqCPm9kTIUFrtXUstZiIFr6UmJ64RLAAuQ130VkhDaH+Evhe
 yCHSrKk4KgYS5U8sEKxYKjIMpl8YaYDyySt0pH2qbCDvjv7GyH5iq0WX0McXM5e9OEx4
 7lDpIMqTfY5qDSzNIR+FNPwTNtghBN6cSDnDIM1Ilbi8SJHHcgb3WJOuPojd3hhKk53L
 lRyg==
X-Gm-Message-State: AOAM532gitNmCGbaLjXe+db2z6z8SIjusJTSzZ/VODus18jRNnFQLm25
 Vis/7XP7BhwPbhNaPl397HG8hwfYYRnjrk7JQCYGvdSCvJYbV+3SG7yCDxxJqLbnwNxjWqZoeDL
 U4iYw0yEXMyQ+CLxMZPNTWRDvSyoO
X-Received: by 2002:a17:902:b606:b0:158:f7d1:c085 with SMTP id
 b6-20020a170902b60600b00158f7d1c085mr35141998pls.12.1651178430269; 
 Thu, 28 Apr 2022 13:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbBVu+3nn3PMdOZ84il7ERBAdkPX1cTEG/Dw0LC52ug+vMlsrsT8ghP2ltGN2xlCMFzYltbw==
X-Received: by 2002:a17:902:b606:b0:158:f7d1:c085 with SMTP id
 b6-20020a170902b60600b00158f7d1c085mr35141973pls.12.1651178429961; 
 Thu, 28 Apr 2022 13:40:29 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:29 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:25 -0700
Message-Id: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 00/19] Expand Cgroup lib and modify controller tests
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

Luke Nowakowski-Krijger (19):
  API/cgroup: Modify tst_cg_print_config for parsing and consumption
  API/cgroup: Add option for specific pid to tst_cg_opts
  API/cgroup: Add cgroup_find_root helper function
  API/cgroup: Add CTRL_NAME_MAX define
  tst_test_macros: Add TST_TOSTR macro
  API/cgroup: Implement tst_cg_load_config
  API/cgroup: Add more controllers to tst_cgroup
  API/cgroup: refuse to mount blkio when io controller is mounted
  testcases/lib: Implement tst_cgctl binary
  testcases/lib: Add tst_flag2mask function
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
 lib/tst_cgroup.c                              | 215 +++++++++++++++++-
 .../cgroup/cgroup_regression_test.sh          |  31 +--
 .../controllers/cgroup_fj/cgroup_fj_common.sh | 113 +++------
 .../cgroup_fj/cgroup_fj_function.sh           | 169 ++++++++------
 .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +-
 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 +++++++-------
 testcases/kernel/controllers/cgroup_lib.sh    | 141 ++++++++++--
 .../cpuset/cpuset_regression_test.sh          |  26 +--
 .../controllers/memcg/control/mem_process.c   |  28 +--
 .../memcg/control/memcg_control_test.sh       | 150 +++---------
 .../memcg/functional/memcg_force_empty.sh     |   2 +-
 .../controllers/memcg/functional/memcg_lib.sh |  54 +++--
 .../memcg/regression/memcg_regression_test.sh | 202 ++++++++--------
 .../memcg/regression/memcg_test_1.c           |  40 ++--
 .../memcg/regression/memcg_test_2.c           |  24 +-
 .../memcg/regression/memcg_test_3.c           |  38 ++--
 .../memcg/regression/memcg_test_4.c           |  24 +-
 .../memcg/regression/memcg_test_4.sh          |  50 ++--
 .../memcg/stress/memcg_stress_test.sh         |  32 +--
 testcases/kernel/controllers/pids/pids.sh     |  67 +-----
 testcases/lib/Makefile                        |   2 +-
 testcases/lib/tst_cgctl.c                     |  87 +++++++
 testcases/lib/tst_test.sh                     |  13 ++
 25 files changed, 927 insertions(+), 793 deletions(-)
 create mode 100644 testcases/lib/tst_cgctl.c

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
