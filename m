Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1B6C43334
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 16:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BE883C7FCC
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 18:46:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA5413C2C3F
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 18:46:10 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 16D0A1A00A4D
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 18:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654101968;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=4cCmCkhT//g1K6WUiUwlXZ6qbzXHTYAUune2WdfsL9U=;
 b=tfDFD7yDW2iCfR0MrSm/b/cLgXOwuLbWojI6XRP0zxOaB6hUXeToWHEJMg51NbgM
 BHvPV25hjMBcAgElRZceBuoPq9LbYUBZzpsSM8gQmwkgbYbuFB8IAEe6lcGmv96p+u6
 5ZEirm3A6kK51tLrAY4QJ75gxXZL1AHG7/icJz/c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654101968;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=4cCmCkhT//g1K6WUiUwlXZ6qbzXHTYAUune2WdfsL9U=;
 b=STPX3UzmPtfMxlabG5fpa/2lhk+7YKAfRHOM+klS9FlHsqkTa5vlAR0/T90eOjWJ
 zx6SYz32LLXB6WCLgyCQO0v7Oq4hRGdGfMs7Mqm1MRWsV0/0js++6y0eGOOm9J63JTZ
 F/GUK+BrTquIM8BEvJcH3+ObViPkOgKsCKWudjBE=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018120290344-13eab9d0-2a99-4466-9da3-a14d302a11be-000000@email.amazonses.com>
Date: Wed, 1 Jun 2022 16:46:07 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.01-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-16-g0570964
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
* kernel: 5.17.11
* git: 
* git branch: linux-5.17.y
* git commit: e960d734930b58bd6ce00c631ea117af0764473c
* git describe: 20220527-16-g0570964
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-16-g0570964

## Test Regressions (compared to 20220527-14-gd2a5676)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912


## Metric Regressions (compared to 20220527-14-gd2a5676)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-14-gd2a5676)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Fixes (compared to 20220527-14-gd2a5676)
No metric fixes found.

## Test result summary
total: 12607, pass: 10627, fail: 59, skip: 1921, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test
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
