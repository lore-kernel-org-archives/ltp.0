Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D59EECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 11:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10EE33CAA64
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 13:30:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C811C3C07BD
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:30:35 +0200 (CEST)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61546600F31
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1662723032;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=5l7K8eQ2sUKyWVFInCdnWoofMJELyPdTC+FVOO0kYng=;
 b=CfinbeQ0LGK6dIvAmXFKAxrQ/HttCSfhxBum9x/ojShdZ+vn2c68N6RBAUb2gtvt
 AY4pouynyzdZ3C/GbPrIvCGjYWnJraHWGkQPEOZtRnDCiun/UEp0TZplS7UrzhoBF9q
 WZCm8rtUSkZk7C9g8DTXB5vOsP6MbgWnG131S3i4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1662723032;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=5l7K8eQ2sUKyWVFInCdnWoofMJELyPdTC+FVOO0kYng=;
 b=C0COK2y3bOSTY6UYO3aj83O2jytlVBXeLv2tGFbSJU5OxHj4aHLJ/L3A3R98Lxa6
 8Ltc+BOqjXWFh8LwF1Ml9jgusIu3RY5NgyQs6QnDGvxkgHU2owl3CGayoopnaldVRWS
 QmDIcsWtiaJtptdjYNm6HhAk6trJOz/yTzwsseGo=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000183220405e8-4646fd9c-c0bf-4d8c-a163-b7818abd87c5-000000@email.amazonses.com>
Date: Fri, 9 Sep 2022 11:30:32 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.09-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 17763bb
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
* git describe: 17763bb
* test details: https://qa-reports.linaro.org/lkft/ltp/build/17763bb

## Test Regressions (compared to fef92f1)
No test regressions found.

## Metric Regressions (compared to fef92f1)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fef92f1)
* bcm2711-rpi-4-b, ltp-mm
  - mm01

* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11

* qemu_arm, ltp-crypto
  - af_alg07

* qemu_i386, ltp-controllers
  - cpuacct_100_100

* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to fef92f1)
No metric fixes found.

## Test result summary
total: 12287, pass: 10437, fail: 155, skip: 1695, xfail: 0

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
