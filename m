Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1549C54EE9
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 12:21:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1FD83CACD1
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 14:21:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B23883CACAB
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 14:21:10 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 684A96011AF
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 14:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663590067;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=Ul6r504Bvqx7qZcbobu9L0p+7u6zFfJ7x5ftY3AdXRg=;
 b=NX500VMND39opU+WZVXdg3ulzNSww3yrVcbdXFREDDuTpvaFCRnvk17xV+tG8L4e
 GtclSTghk+H5ySlBcGZbEZVrywxfvSCh1eWfCnU5YLgd+DbTvz/h/5E/y6VG7oGxkQL
 wA/YEfwVI09KdRN/7OtViu+yZi0pSs9oVlqHRJkc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663590067;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=Ul6r504Bvqx7qZcbobu9L0p+7u6zFfJ7x5ftY3AdXRg=;
 b=ad8d7vn4QfIBl8OQ4Sd5sRhLqBP+2qhzduMBETqca4onr1UxL2/Xj9bk1nqSGBlU
 6IwOs8O2YtSHigyryE4pHdB30pSJiaNuGvQJAaB71n285+1bVtYQD+HWrxi/VyoYBbX
 uOYsxFznKLaHgSkflfrnyMht9JErdpwdDS+DNg4A=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018355b1edc0-de081137-73fa-4649-80be-4c68e9432534-000000@email.amazonses.com>
Date: Mon, 19 Sep 2022 12:21:07 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.19-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 8ff3f5f
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
* git describe: 8ff3f5f
* test details: https://qa-reports.linaro.org/lkft/ltp/build/8ff3f5f

## Test Regressions (compared to cea142b)
* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11

* qemu_arm, ltp-syscalls
  - epoll_pwait01

* qemu_i386, ltp-cve
  - cve-2018-1000204


## Metric Regressions (compared to cea142b)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to cea142b)
* qemu_i386, ltp-controllers
  - cpuacct_100_100

* qemu_x86_64, ltp-cve
  - cve-2018-1000204


## Metric Fixes (compared to cea142b)
No metric fixes found.

## Test result summary
total: 12630, pass: 10738, fail: 163, skip: 1729, xfail: 0

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
