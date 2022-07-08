Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42410C433EF
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 04:52:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9356F3CA318
	for <ltp@archiver.kernel.org>; Fri,  8 Jul 2022 06:52:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18F2A3CA2C1
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 06:52:16 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 02A711000A66
 for <ltp@lists.linux.it>; Fri,  8 Jul 2022 06:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657255934;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=QLWk4XjoUxZjcdzOc/172wKWu2SrGHHEc8DHPvc4u3g=;
 b=vDZptBoZ6tDL0LXGpktjt30Pa3yIre1SusCISOCW0Mt9MwHYHbq1PknmtTMLiNqC
 V1gV3K6q7KprfeZRAC4KlIElPtvPCJNcJnF7vKeyyVr4hX1qWyWw+HiBaYPi3lYQCFR
 ferNaKNQBP0wg69XBt3KL2ljRzNwufYBPowDrLT8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657255934;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=QLWk4XjoUxZjcdzOc/172wKWu2SrGHHEc8DHPvc4u3g=;
 b=Hpw55sLDctjAKXd6hGcifiN5r5wi/XoqJowcMf7DwsT3zVZCam45zs9bSzlf41Qp
 13krNF91jeI9V/CkD+RJgBl/b7q1/Q8av1nRiqCp9UxHVzNjqrSw8Yosv3w2vu2WNbc
 2IOMRN9NmJeyO4NJVeRUxmTgD6a1HQBaaMAiktOc=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181dc26b749-38dc8249-9cf5-48e3-8fb9-093c781e30a4-000000@email.amazonses.com>
Date: Fri, 8 Jul 2022 04:52:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.08-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 17d354e
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
* git describe: 17d354e
* test details: https://qa-reports.linaro.org/lkft/ltp/build/17d354e

## Test Regressions (compared to 7b3c5d5)
* qemu_arm64, ltp-cve
  - cve-2019-8912


## Metric Regressions (compared to 7b3c5d5)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7b3c5d5)
* qemu_arm, ltp-syscalls
  - accept02


## Metric Fixes (compared to 7b3c5d5)
No metric fixes found.

## Test result summary
total: 12654, pass: 10651, fail: 63, skip: 1940, xfail: 0

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
