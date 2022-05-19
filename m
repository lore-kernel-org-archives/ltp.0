Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13453C433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 15:36:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 395673C21CD
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 17:36:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F272B3C01CF
 for <ltp@lists.linux.it>; Thu, 19 May 2022 17:36:23 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 37FB7100096B
 for <ltp@lists.linux.it>; Thu, 19 May 2022 17:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652974580;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=bhvI/YFChxNWyXf929hdEtoNY+hbaAatGoKk6AF/HZE=;
 b=goUvUBJjK1VT494pC/pi+Jgt7BKr1mgVCvbKIJqoI3N5mXmWUSzk1yO8BXwOFLSo
 3MSGfs1yFHHAYlmmqmkthXDXtv9Bto/o+IEMW3meyz1BeyQ5qW3hVT7DuXVy6HW9R6H
 lupcDd70RQFvKg2ZPYFw8zlwWEaPf5JYg0hXvCqs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652974580;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=bhvI/YFChxNWyXf929hdEtoNY+hbaAatGoKk6AF/HZE=;
 b=bPS30hNfaxNjV/0xZ5UFHZo8pdbap7FCl5C/Qfm//w5ny0BPAxgamj5O9IvleXO5
 ainBzKB5a8nY9iiWP4Hw+JBHzUfkfLVEpHzoBK01anEm7M9buTgXFjpc2mmFvorTOq9
 HLhGW5/GKx8aCx0qSsrXOncnl1H06pksmhR3vwKI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180dcf6726f-2bc4faff-7491-474a-86fa-c873bd200f56-000000@email.amazonses.com>
Date: Thu, 19 May 2022 15:36:20 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.19-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for fd5c29e
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
* kernel: 5.17.9
* git: 
* git branch: linux-5.17.y
* git commit: 5c2fc53857eb993952e932da8222b11b063c2581
* git describe: fd5c29e
* test details: https://qa-reports.linaro.org/lkft/ltp/build/fd5c29e

## Test Regressions (compared to 517540b)
No test regressions found.

## Metric Regressions (compared to 517540b)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 517540b)
* bcm2711-rpi-4-b, ltp-crypto-tests
  - af_alg07

* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Fixes (compared to 517540b)
No metric fixes found.

## Test result summary
total: 12021, pass: 10038, fail: 61, skip: 1922, xfail: 0

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
