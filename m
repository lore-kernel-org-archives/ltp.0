Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72684C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 22:28:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B2E13C921A
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 00:28:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4CD93C9098
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 00:27:59 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00E3160085D
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 00:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654813677;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=UPPRSmlLqqRmdQVZXdslZD7aJApx3ubkStV37pspFQY=;
 b=QSizg1bigfAiBKyMsA+JL9M/LoBm+T2B3HHTc2sNYAOfP+YBYBhXDCxALw/ErjHN
 abkdUkK0enrvuIm9u0CPMBrvuyMnBAj9hlwxMjBeOLUKC8s3sWA3QgbgiQNCOLf+qG+
 Mb20UJq/h+IlhiSLP1TStk+fa19yTc/zhnqsZ2Jo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654813677;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=UPPRSmlLqqRmdQVZXdslZD7aJApx3ubkStV37pspFQY=;
 b=SAsUQ9D9EvUgzlk4qSub6SdeSgI8IQknEbty79xWl7X3zKjLuWdRxNTgMM7KMSLy
 6Zptjac3wKCZzLJf6dEcy0JOhyXtaR4CT417M5yOJ/dNI68+ufRe9jv2W2ti9gBYogs
 41QEkJHn03WlP1JB07zb4m0xzsZ0Nrpk3LSm8F7s=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001814a94d658-c031969d-181f-40c4-a411-0a6aea39f924-000000@email.amazonses.com>
Date: Thu, 9 Jun 2022 22:27:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.09-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-39-ge98f946
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
* kernel: 5.17.13
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: 8eb69e8f0d4544de764ab03c5b292ead949d9ac1
* git describe: 20220527-39-ge98f946
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-39-ge98f946

## Test Regressions (compared to 20220527-34-gc5a5f50)
* bcm2711-rpi-4-b, ltp-crypto-tests
  - af_alg07

* qemu_arm, ltp-syscalls-tests
  - accept02
  - futex_waitv01

* qemu_i386, ltp-syscalls-tests
  - futex_waitv01


## Metric Regressions (compared to 20220527-34-gc5a5f50)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-34-gc5a5f50)
No test fixes found.

## Metric Fixes (compared to 20220527-34-gc5a5f50)
No metric fixes found.

## Test result summary
total: 12639, pass: 10636, fail: 62, skip: 1941, xfail: 0

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
