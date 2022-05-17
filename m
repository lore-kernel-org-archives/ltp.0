Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A3C433EF
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 15:22:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE3603CAA76
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 17:22:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 347F93CAA2C
 for <ltp@lists.linux.it>; Tue, 17 May 2022 17:22:16 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 70E9F14004F8
 for <ltp@lists.linux.it>; Tue, 17 May 2022 17:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652800934;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=7CC2cnm+FG2xXu2fWJqOmGU6h536PfPbbjBZ+ZSOS6A=;
 b=TvOI9j6cuoqws3BR/I+xThT+Qvm+HQAHFHdiPBoZNG3WOqUHhl8c3UxQpmSDliiQ
 SYg8/P3btm13COBmf4MAT7AFAHkOk96qZYK/CW9M4xmTcMwKCs9fFgwBzTrmEUgQe5Y
 oXZyeQusIokmJAU4SlB95jv0DeqZ8IO9pGYJ9KQU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652800934;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=7CC2cnm+FG2xXu2fWJqOmGU6h536PfPbbjBZ+ZSOS6A=;
 b=QWaT/ZYwGABQ4Z7dCswnt8X45nY40iB69R4ZWbZWIueY62rkU1ya6hQbt+9DEVJL
 bZO6/MTzCV4GkVHNdVgTYP0U1WtTZM8bAxgtflTbZQ25bqAlMRSz/7z27TWP231HSJG
 JryIcvcy5Gzjn20PcRwvs1KgpKxSnwyAm9WHqXis=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180d29ccf65-041064b5-d82e-4695-9fcc-3599975f2643-000000@email.amazonses.com>
Date: Tue, 17 May 2022 15:22:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.17-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for be1888a
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
* kernel: 5.17.8
* git: 
* git branch: linux-5.17.y
* git commit: 039120668dacf48247c0760b12e3eacd6d6b08a2
* git describe: be1888a
* test details: https://qa-reports.linaro.org/lkft/ltp/build/be1888a

## Test Regressions (compared to fc37232)
* qemu_arm64, ltp-cve-tests
  - cve-2019-8912

* qemu_arm64, ltp-fs-tests
  - read_all_proc

* qemu_x86_64, ltp-controllers-tests
  - memcg_stat_rss

* qemu_x86_64, ltp-syscalls-tests
  - futex_waitv02
  - futex_waitv03


## Metric Regressions (compared to fc37232)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fc37232)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Fixes (compared to fc37232)
No metric fixes found.

## Test result summary
total: 12074, pass: 10073, fail: 66, skip: 1935, xfail: 0

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
