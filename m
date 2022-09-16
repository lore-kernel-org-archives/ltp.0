Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8CDC54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 10:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCB533CAC7C
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 12:20:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3F4A3CAC4F
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 12:19:53 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AAC021A019A1
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 12:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663323591;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=/Coku8WvE2zxLAkzv0mCBIn0dThAnMbO8Oxb9eK+s/0=;
 b=GB+lJosomZnaX1yB0Z8GtQIlYAkIQZ9jQiC1BvWEOJjdFRQZNckouTmWXmUtNniJ
 ix5berV64CI3cE3XgRXR4UF1vapXB32LJDK9zQBW0hJqIamhkpEeaMavSRshc69U5SS
 e44dmRzsfwIvTkD7HdyzOqIlWIKR0r2rXC2PqnAk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663323591;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=/Coku8WvE2zxLAkzv0mCBIn0dThAnMbO8Oxb9eK+s/0=;
 b=fd5XFwDsGta6EV8R/7Dr//9KeVZ1VEo/qB7pFVmC70VbKQr8GBSO2EzwKvRNWN2M
 /UEeFXtInsVfaOQSWnkoN5PctnpsC3oYUol6HoO6vhSkIZbsFibW7WcOrSKQivyDkqq
 DjhO03w/wOX4ZHYMHrvGq/pox5gUE7rEHcL04QWI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018345cfd02a-9ed7efe6-62d8-4302-a558-10fdca0ad28f-000000@email.amazonses.com>
Date: Fri, 16 Sep 2022 10:19:50 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.16-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for e454394
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
* git describe: e454394
* test details: https://qa-reports.linaro.org/lkft/ltp/build/e454394

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

* qemu_arm64, ltp-controllers
  - memcg_move_charge_at_immigrate
  - memcg_stat_rss


## Metric Regressions (compared to fea3c47)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fea3c47)
* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to fea3c47)
No metric fixes found.

## Test result summary
total: 12630, pass: 10713, fail: 187, skip: 1730, xfail: 0

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
