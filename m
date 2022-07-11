Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D151C43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 22:31:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E36983CA74C
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 00:31:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B02E3CA5B2
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 00:31:43 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 906BB1A001FE
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 00:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657578701;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=aL1Fqwbuhda80wQmlXdu+7r3nRD0B9la1CE0GVnAXWM=;
 b=h7EclHOObf8HNn19a2M0dedSqcudnjveeP3iosueWpR+TECUCmTPBmExQxNL7gM3
 CwJtK4nCyqolxcUT/LCdQWvfHVbKaV1Qzwm2ucHTBY8hL2W2nWu2yZSas6luku6eN50
 AKe5MvBdcFFURs0ULrh4UnCwNCkhQtB+U2ocscPU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657578701;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=aL1Fqwbuhda80wQmlXdu+7r3nRD0B9la1CE0GVnAXWM=;
 b=g5XtG7jjUfMfuXjeD36AcbA3NOmo0m1vByIU2bzTGaefTJOpVYy578Z7BlaSbWUe
 hx0IyJ56EcxSzYGhW3BagmbBmyTLDe20Yg7hRj0aO/fteJmq8tuFaVfiVRYzTy3UCTG
 AlPoKDsRHDCenXdaEAuf4qeCLYv6tdYxZpWywmVQ=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181ef63c001-bfff3f5b-3e8b-4eb3-819e-cf236c7f8246-000000@email.amazonses.com>
Date: Mon, 11 Jul 2022 22:31:40 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.11-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 3866cf0
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
* kernel: 5.17.15
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: eed68052d2016d9f96d6656435099762608120e3
* git describe: 3866cf0
* test details: https://qa-reports.linaro.org/lkft/ltp/build/3866cf0

## Test Regressions (compared to 9ed8ba0)
* qemu_arm64, ltp-crypto
  - af_alg07


## Metric Regressions (compared to 9ed8ba0)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 9ed8ba0)
* bcm2711-rpi-4-b, ltp-fs
  - read_all_proc

* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11


## Metric Fixes (compared to 9ed8ba0)
No metric fixes found.

## Test result summary
total: 12654, pass: 10658, fail: 60, skip: 1936, xfail: 0

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
