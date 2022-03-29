Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60446C433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 16:21:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E894C3C9EB1
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 18:21:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABBB73C14BC
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 18:21:08 +0200 (CEST)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 492E320009C
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 18:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648570864;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=l4MqjOa7BgjiRJsyQRpDTki9Tmyp89XmMgiLt5GW23A=;
 b=ai3lZPbWIvsp54mp9Qj52R5JfbrUERIhDNFXXmy0hXxnlHn7m/ghBt3ALOK2hiaL
 /hl00vK6wg8y1MCt9f/R1db+4+/4fUpyGy8GePxiXB3bxaUn33MqDnMonm8KK0CQaXN
 7QA7x101ERZk+xuo3kd+rLc0zDP5vO7qh4QipHRw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648570864;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=l4MqjOa7BgjiRJsyQRpDTki9Tmyp89XmMgiLt5GW23A=;
 b=XG5hVPa/gDn+N50/ulR3ev52np1cGZBcbtwWcCjJ7iM7ITlZCUY6y72z2Ihi9yY4
 KED15s/M4UAzS5H9c7ZniMrdR6h9XVQ8ptvhVaDITIWgsSvArW0IQB3u1rkiDWp27tK
 EY+o3OdFXGfc1kLk+zj+aZK9B1N/ukkAqHtCoFaU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fd67b124c-3d805d56-57ca-4d55-95b3-1aff2d378fd9-000000@email.amazonses.com>
Date: Tue, 29 Mar 2022 16:21:04 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.29-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 3747410
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
* git describe: 3747410
* test details: https://qa-reports.linaro.org/lkft/ltp/build/3747410

## Test Regressions (compared to 7b16c02)
* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 7b16c02)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7b16c02)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-fs-tests
  - read_all_proc

* qemu_x86_64, ltp-syscalls-tests
  - futex_cmp_requeue01


## Metric Fixes (compared to 7b16c02)
No metric fixes found.

## Test result summary
total: 12041, pass: 10073, fail: 49, skip: 1919, xfail: 0

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
