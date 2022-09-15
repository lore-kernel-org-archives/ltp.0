Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A437ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:20:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A4203CAC2E
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 13:20:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3A4A3CAB98
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:20:27 +0200 (CEST)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6D2F602473
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663240824;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=fuKqLDEY5rNU60uejnSXXdlsoEKsVimciYL0//j6odQ=;
 b=U8LFu90Ip1zkgYwxtcWDQKtm2I1JLVmUlhoCaplkjUUp3saSp7pUjLWEvSlaVeLa
 P3DSrE44ibPZSt2DH2SfvNvcWqDOzhvUvSRY4dcpHUeyd0yUv3NiR9Mq3W0RpIIjSbH
 NA9p0zA/SMoexwIaaFrMM6UdfXd5Ft+KMuPL6HlA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663240824;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=fuKqLDEY5rNU60uejnSXXdlsoEKsVimciYL0//j6odQ=;
 b=Ezr2Luk87AihVbgyaaePmHUhQVMET2K39KPgqMnMTUkaI6E8Ak/gR7oahNeFl9e1
 YHZO2ICGOCIgupb24JrpCTexNB95k1N7seGePwQWOEnBQtejFk1Uhp45LYExv5dgKYT
 ywKs8FpYORdM+/hCO8zcfQGvOGUOxlbw41u5l2d4=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018340e0e6d9-da1b0a7d-495f-428f-9549-02dc49b51e86-000000@email.amazonses.com>
Date: Thu, 15 Sep 2022 11:20:24 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.15-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for fea3c47
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
* git describe: fea3c47
* test details: https://qa-reports.linaro.org/lkft/ltp/build/fea3c47

## Test Regressions (compared to c987801)
* qemu_arm64, ltp-controllers
  - cpuacct_100_100


## Metric Regressions (compared to c987801)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to c987801)
* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11

* qemu_arm, ltp-mm
  - ksm03


## Metric Fixes (compared to c987801)
No metric fixes found.

## Test result summary
total: 12621, pass: 10734, fail: 163, skip: 1724, xfail: 0

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
