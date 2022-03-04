Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FA0C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:19:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF6CF3CA3A7
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:19:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D49833CA3AC
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2D45E601D7E
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:34 +0100 (CET)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CC7143F610
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435911;
 bh=+4lPdYfsBFhxB/RG6P6UoCTmDJkAo9fODjBlMEI8bRM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Dw6O7tf7YCu8kTLv3bX7zwRqvgkH6ZTFgp4l5sqEBRM00arDlSWFG3LRRQ9d3HZw3
 xwMV7E6DEbT3KfyW6Db0diChlJYn7ncJDxGoZUeuNkGIW5htoODoqiFfDUqe5XROQa
 i0iIvw7XRnkh/aK4+BlAY2wf2RMAmKt42MzlTEFB7HOHC+pEQOQlSECMoUMngmiLxZ
 XGc42g3uJfWL6b1BEYAltqjOq/XL7cskzdErlinJVKzJQXdc1F3wTRXidh403V6fnr
 Y4wEBsVTNiSF0QIqbd6Aqv8giRwUFVwACC9h4zi0BeU1LQPTP+J2dhZuvKrDmRNzwv
 pjXzeLqu4zvag==
Received: by mail-pf1-f200.google.com with SMTP id
 a200-20020a621ad1000000b004e191fdcb4dso5935254pfa.1
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+4lPdYfsBFhxB/RG6P6UoCTmDJkAo9fODjBlMEI8bRM=;
 b=tUXhEXJBYqBXndVVm5yjPeOcL2Pu/R8fFx2qU8wpGu7tthCxAMPPbhuxvnvVHUotGD
 amA/zLV+Nto3wWvQzwu6ctIK/SPEWZMvuWYy0YGfuBCBC7X1UowPQ5NF/Ko7vMU2EJu0
 GbTEJq1c0juhHUOvxafatZr3SYhyW7qSFxSdd3P4QhEb130The5nZQBiC38QaQzVxf1u
 Cr++WPPFlHctiCv+6Y+4n0MxwvKSQohmIHQwY26yUjFpikPc6JHOHJi+CQGvJsDWqi7p
 +Fpf2jutkI0efnP4E34Z1/MfkDZmb5817hxQxOpN4UsQGNFaNKqBWd8MNbx9e6xJxyS8
 avcA==
X-Gm-Message-State: AOAM530F4dX77lBbFDoyzKetKuWtHx1ZefxvcLGCPfxG7jZhZz0X/A4o
 4Y6t3NKhgDjGVDNFHL5q8wh5KnDDfewZDGWj1uDkH+OBiypQa9bh+jtOZbvNjv9fKFXH7P244kY
 DFX/eKyW/oU4IgKEfRtDTFh5Fimsh
X-Received: by 2002:a05:6a00:1910:b0:4f3:aa39:1e17 with SMTP id
 y16-20020a056a00191000b004f3aa391e17mr1081916pfi.54.1646435909859; 
 Fri, 04 Mar 2022 15:18:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweNKG+31zPcsPDGhWjJRk4tVrukiJgZ0hE1Y7fJBBtMQ9eBMSNo4mK1iN5GsaHLgNuMRGUQg==
X-Received: by 2002:a05:6a00:1910:b0:4f3:aa39:1e17 with SMTP id
 y16-20020a056a00191000b004f3aa391e17mr1081887pfi.54.1646435909450; 
 Fri, 04 Mar 2022 15:18:29 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:27 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:10 -0800
Message-Id: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/16] Expand Cgroup lib and modify controller tests
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
  API/cgroup: Modify tst_cg_print_config for parsing and consumption
  API/cgroup: Add option for specific pid to tst_cg_opts
  API/cgroup: Add cgroup_find_root helper function
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
 lib/tst_cgroup.c                              | 203 +++++++++++++++++-
 .../cgroup/cgroup_regression_test.sh          |  17 +-
 .../controllers/cgroup_fj/cgroup_fj_common.sh | 113 +++-------
 .../cgroup_fj/cgroup_fj_function.sh           | 169 ++++++++-------
 .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +--
 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 +++++++--------
 testcases/kernel/controllers/cgroup_lib.sh    | 129 +++++++++--
 .../cpuset/cpuset_regression_test.sh          |  26 +--
 .../controllers/memcg/control/mem_process.c   |  28 +--
 .../memcg/control/memcg_control_test.sh       | 150 ++++---------
 .../memcg/functional/memcg_force_empty.sh     |   2 +-
 .../controllers/memcg/functional/memcg_lib.sh |  54 ++---
 .../memcg/regression/memcg_regression_test.sh | 202 ++++++++---------
 .../memcg/regression/memcg_test_1.c           |  40 ++--
 .../memcg/regression/memcg_test_2.c           |  24 +--
 .../memcg/regression/memcg_test_3.c           |  38 ++--
 .../memcg/regression/memcg_test_4.c           |  24 +--
 .../memcg/regression/memcg_test_4.sh          |  50 ++---
 .../memcg/stress/memcg_stress_test.sh         |  32 ++-
 testcases/kernel/controllers/pids/pids.sh     |  67 +-----
 testcases/lib/Makefile                        |   2 +-
 testcases/lib/tst_cgctl.c                     |  87 ++++++++
 23 files changed, 883 insertions(+), 783 deletions(-)
 create mode 100644 testcases/lib/tst_cgctl.c

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
