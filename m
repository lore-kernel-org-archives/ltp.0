Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F4FC433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 17:11:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45BF63CAAF8
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 19:11:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C15103C21CF
 for <ltp@lists.linux.it>; Thu, 19 May 2022 19:11:21 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDE29140006F
 for <ltp@lists.linux.it>; Thu, 19 May 2022 19:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652980279;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=a6pY+U4ubJLtc7wqDfJec5kLQmA0uPnBY+sAvzk20uw=;
 b=HVealOdg63EbbIsLG9G/fxJN6vMD3lTe0i26hkhXKgUkvqVu55F7IzHbFzAJUCrp
 vUVapJgZA2rpCZjdwv/tMXpjsgHkGH8SjV76kQrS57SmevmTyQ5W10r4mssF8tFemZI
 eKUftf4xOfhIifYLdw/MM+KcShzXUWTXDYUbnkwE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652980279;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=a6pY+U4ubJLtc7wqDfJec5kLQmA0uPnBY+sAvzk20uw=;
 b=e7ukGSkTP/vtb0WFUzvha5FUzVqYzmIJ1hf/W8fhovX/qdg1pR035oeAsQHN2KQk
 iGSsCPx9zBiawO/HWTbi9X3T+TXwb04RHqGH/+Pj/NDyva79eOwTvsIuoEMbPKLzzpl
 ZiiEn08mKYBkOJKKXYzcP8lfhaof4I2Zdi/Leruo=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180dd4d689d-25e595f9-9127-4257-94ee-1f81a149e611-000000@email.amazonses.com>
Date: Thu, 19 May 2022 17:11:19 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.19-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for cd4dbf7
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
* git describe: cd4dbf7
* test details: https://qa-reports.linaro.org/lkft/ltp/build/cd4dbf7

## Test Regressions (compared to fd5c29e)
* bcm2711-rpi-4-b, ltp-crypto-tests
  - af_alg07

* qemu_arm64, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to fd5c29e)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fd5c29e)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912


## Metric Fixes (compared to fd5c29e)
No metric fixes found.

## Test result summary
total: 11731, pass: 9776, fail: 55, skip: 1900, xfail: 0

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
