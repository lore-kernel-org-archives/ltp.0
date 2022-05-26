Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCEBC433F5
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 15:59:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DCAF3C0F6E
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 17:59:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3C7E3C0596
 for <ltp@lists.linux.it>; Thu, 26 May 2022 17:59:42 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDA281000DED
 for <ltp@lists.linux.it>; Thu, 26 May 2022 17:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1653580780;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=NQrxYoG3WSO3bXJoF/5Cl67gWNDaUrKIgX6/rNtJbkc=;
 b=tZdFH20BSvFTppLEfQPdmJxuH32ArwOEqYEzLtSh2bS6WDvpJOolvNCTlBpG4Uu0
 yBh/HPpb3aZ2YuXUfaEN7Kdkek9t9lsYVVesWus9H2KN+eXFu2FpW2yJW+poFjdE4cv
 vlXGpTjD3hhCeNUCEr9GvnAJplN3sUSelep8vURQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653580780;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=NQrxYoG3WSO3bXJoF/5Cl67gWNDaUrKIgX6/rNtJbkc=;
 b=BHXqtjDPl8kDTydFfZxHhhTy1ygk6at8AhjZzBM8hsj8aAMjPlTHXSimuBnpnQMU
 TjMR+rROWpQQlNFWbjvUPTDhRJNQLRVZUH/lWWP05827cVPPBMVKu+Yw0S0Id06bMxd
 3oWH71GGSlD/+jWWQkwXX0/q8qrS2iyntc1PWXnw=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018101185217-6c9acef6-430a-4945-a496-799acbaf50dc-000000@email.amazonses.com>
Date: Thu, 26 May 2022 15:59:40 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.26-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for a7362af
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
* git describe: a7362af
* test details: https://qa-reports.linaro.org/lkft/ltp/build/a7362af

## Test Regressions (compared to c5b8b34)
* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912

* qemu_x86_64, ltp-syscalls-tests
  - clock_adjtime01


## Metric Regressions (compared to c5b8b34)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to c5b8b34)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_arm64, ltp-fs-tests
  - read_all_proc

* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to c5b8b34)
No metric fixes found.

## Test result summary
total: 12634, pass: 10638, fail: 60, skip: 1936, xfail: 0

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
