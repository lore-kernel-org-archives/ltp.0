Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E44ECAAD3
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 12:01:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33B773CAC9E
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 14:01:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CD9F3CAC5F
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 14:00:47 +0200 (CEST)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7EBB4600667
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 14:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663416044;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=LXBciQUyJuMG7Dmqfa/iYViVXgLoHHF1AR+eU6JkRrw=;
 b=Nf1N5N/XQ/w+WULtX2PGf/hOPwCEAL5Xe9iOD7KQMm7H8R9tIAg4ebdHOkDOGhy1
 tyol/ED3Hy/s88IGtfBF4cXDavAB2dDBeq1kIR11dduKABnZdVroKPsuwSDeNGnJUdb
 VYADNJIy/0WSOPWECOeBKNX9sI5NT3Yu85BSIzCg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663416044;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=LXBciQUyJuMG7Dmqfa/iYViVXgLoHHF1AR+eU6JkRrw=;
 b=S3XrDAnfyUwOUkLS/Gq++hodVuS/WAITVfxKKkdHGq+BErqm/DukapJpegGCOYzQ
 lJKbaxsvYUGpmDTizWzjOZpjA5Fqrco1zjI5sFUHtGWOcUFW/8J8Q3TgLNuF5VnOJGo
 WUdIvDEZAkcqs49bwXkPQ5T0MP/O+4Inr1WD7hOY=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
Date: Sat, 17 Sep 2022 12:00:44 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.17-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for cea142b
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
* git describe: cea142b
* test details: https://qa-reports.linaro.org/lkft/ltp/build/cea142b

## Test Regressions (compared to 98140f3)
* qemu_i386, ltp-controllers
  - cpuacct_100_100

* qemu_x86_64, ltp-cve
  - cve-2018-1000204


## Metric Regressions (compared to 98140f3)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 98140f3)
* qemu_arm64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to 98140f3)
No metric fixes found.

## Test result summary
total: 12630, pass: 10739, fail: 161, skip: 1730, xfail: 0

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
