Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E54C433EF
	for <ltp@archiver.kernel.org>; Tue, 31 May 2022 17:00:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD6BE3C2DA6
	for <ltp@archiver.kernel.org>; Tue, 31 May 2022 19:00:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 282473C02C2
 for <ltp@lists.linux.it>; Tue, 31 May 2022 19:00:15 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 055311A00A44
 for <ltp@lists.linux.it>; Tue, 31 May 2022 19:00:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654016412;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=72Lx/vAQPiCRqVXLYehOTi9i3TvrCv2Svqgfd2r0JGA=;
 b=OQVA2wR7Zdhbgx+nV4DIdJmdzaRp0+sr2/+7qYFZj9ko0DBjQIN+MuhbYPaoFCId
 Zye2Ivwt+VC2qeRqT0MYH9KrMqdnk7j+DIqWMtF6k9AwPWlh0Yx1hBxSVe5nUIYbctA
 7FSV6tU9vIybanOxk+pR/HJtMxCo69vxzYUlSmGA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654016412;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=72Lx/vAQPiCRqVXLYehOTi9i3TvrCv2Svqgfd2r0JGA=;
 b=Q1pJ5GC3nNYbchxqHzF/4aTsprHsF74JpjGnWFxIgMh6HSvp6jFuOwS6A+3kHSEs
 MWBLHFvCcv4ww2I0EGziHXl5WAkw2D/zo/mecRKLTNzLgT4GB31QC10CAX02sj/QENV
 C3JTPMTli8+yP2GUGfu3xjxXqiIAw5xK70jDSOCo=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001811b0f89d6-80bb83b3-69e7-434b-b7e6-cdd643f10675-000000@email.amazonses.com>
Date: Tue, 31 May 2022 17:00:12 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.31-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-10-g8ffc871
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
* git describe: 20220527-10-g8ffc871
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-10-g8ffc871

## Test Regressions (compared to 20220527-7-gb924b21)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 20220527-7-gb924b21)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-7-gb924b21)
* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912

* qemu_arm64, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 20220527-7-gb924b21)
No metric fixes found.

## Test result summary
total: 11953, pass: 10139, fail: 50, skip: 1764, xfail: 0

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
