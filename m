Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92592ECAAD3
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 10:15:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39633CACB1
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 12:15:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BA683CAA94
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 12:15:40 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6BAFE140043C
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 12:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663409738;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=qv3LzqibS1IowOmdwmuXw/TaXN5uzprHJMV8CmclVzM=;
 b=spbQL4Ch9VEmNuICfxVLj6BViEG+ZoU7q8RoM6Q1lXP+wlxd+vAX8smZzdvHyFsU
 EMEGTSP8jXZ8MS7081A8MKQ2MkGP/kB5ioDt3iwRKjO9uwA/+vBC0z3k7IKvvNwPMvm
 u0MXE7NaZKYpHdHeDhn4najr5eEstKJcafV/fO1I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663409738;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=qv3LzqibS1IowOmdwmuXw/TaXN5uzprHJMV8CmclVzM=;
 b=cycWvnzLdwCnGK7qdEhnQL0FrHDweiMoLc9rBHYwzOlY8uLPi16o39wiq83V3h9h
 06l1SymXi+eflQTSAlXqO9XZKclyVaer7uuPUfdmwdbeGC7PpxcZ9OArMQTqYTaxA03
 DIWR7kMdwNy7u9uzo50CtfUvD0ORcRkqxovRKsNg=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001834af2501f-e449ae9f-c1fb-4f6e-bc5e-5d258af11ee1-000000@email.amazonses.com>
Date: Sat, 17 Sep 2022 10:15:37 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.17-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 5f8aecd
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
Cc: lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

## Build
* kernel: 5.18.19
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.18.y
* git commit: 22a992953741ad79c07890d3f4104585e52ef26b
* git describe: 5f8aecd
* test details: https://qa-reports.linaro.org/lkft/ltp/build/5f8aecd

## Test Regressions (compared to fea3c47)
* bcm2711-rpi-4-b, ltp-controllers
  - cgroup_fj_function_memory
  - cgroup_fj_stress_memory_10_3_each
  - cgroup_fj_stress_memory_10_3_none
  - cgroup_fj_stress_memory_10_3_one
  - cgroup_fj_stress_memory_1_200_each
  - cgroup_fj_stress_memory_1_200_none
  - cgroup_fj_stress_memory_1_200_one
  - cgroup_fj_stress_memory_200_1_each
  - cgroup_fj_stress_memory_200_1_none
  - cgroup_fj_stress_memory_200_1_one
  - cgroup_fj_stress_memory_2_2_each
  - cgroup_fj_stress_memory_2_2_none
  - cgroup_fj_stress_memory_2_2_one
  - cgroup_fj_stress_memory_2_9_each
  - cgroup_fj_stress_memory_2_9_none
  - cgroup_fj_stress_memory_2_9_one
  - cgroup_fj_stress_memory_3_3_each
  - cgroup_fj_stress_memory_3_3_none
  - cgroup_fj_stress_memory_3_3_one
  - cgroup_fj_stress_memory_4_4_each
  - cgroup_fj_stress_memory_4_4_none
  - cgroup_fj_stress_memory_4_4_one
  - memcg_test_3

* bcm2711-rpi-4-b, ltp-mm
  - mm01

* qemu_arm, ltp-mm
  - ksm03


## Metric Regressions (compared to fea3c47)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fea3c47)
* qemu_i386, ltp-controllers
  - cpuacct_100_100

* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to fea3c47)
No metric fixes found.

## Test result summary
total: 12630, pass: 10715, fail: 185, skip: 1730, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-syscalls
* ltp-tracing

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
