Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D38EC433F5
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 12:43:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBBA03CA2DC
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 14:43:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC1E3CA1A5
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 14:43:05 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C515B1A01208
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 14:43:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648816983;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=jAYwRAnmgeR8WC6FOVx0qeG0ZpkBAuvtpY7tXLUo2FY=;
 b=RyT7mvPvlSFDwCT4bHI7n49sa6+c1Ioi+Tgs6mqLUWGc+xuKpBiNADfMfy09VeAm
 yJt0JJRTb/5sN0/QWv3jGPPfwELq/JX1uPQbhdXGIdkoauqka08TjjI8WUWxvZnxv2k
 ykFWsTCL81Eztt3j2BKJtLzhtb/XY/Iw6OGmaNZo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648816983;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=jAYwRAnmgeR8WC6FOVx0qeG0ZpkBAuvtpY7tXLUo2FY=;
 b=DF6iuS9a2sn3n1nRugvb27OWgqmgJxu5oEWoLp1NIPAlEAPGm/2bkwqwa+mba7rx
 dPDx2dPJYFGmX9JXuYauyKBYiqrYA51BgZBHTevkmfhbm7YywUUpVEcHCLRNX5mUPTf
 Ij25UEKs7Y/BRcqcIrGrueBSRYGWuKBuYqkHB1iU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fe5268bf0-1a844943-6d3c-4347-b25c-9100f7030d35-000000@email.amazonses.com>
Date: Fri, 1 Apr 2022 12:43:03 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.01-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 163cca9
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
* kernel: 5.16.18
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 9fec77b5f094c1bbd0432c3f98d20cca8fc07321
* git describe: 163cca9
* test details: https://qa-reports.linaro.org/lkft/ltp/build/163cca9

## Test Regressions (compared to 9851deb)
* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-syscalls-tests
  - futex_waitv03

* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 9851deb)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 9851deb)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11


## Metric Fixes (compared to 9851deb)
No metric fixes found.

## Test result summary
total: 11767, pass: 9824, fail: 47, skip: 1896, xfail: 0

## Build Summary

## Test suites summary
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
