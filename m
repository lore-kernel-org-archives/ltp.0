Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585B5CCA473
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 15:33:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7C73C7378
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 17:33:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24CA43C3302
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 17:33:25 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A22EF600879
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 17:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654097603;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=gxEThOCqz7ZGXyBonp2EvQRkEjGXFbnGU6wESbz15ZU=;
 b=xIH5B5iQ/0xgRCDepR/1708yK0J0jYWhCoLnP5FeUTq0ZAbdOrBKdcIxvofMaswd
 fs2KJnmRER4GqyZIlYX5cHBXWlXA52B1JB6BeltpK3HSNK81RNV+HRqoExOKt3Wt5iU
 zh03xrPVKK9BntxELTYKs7gkLvGMgUr1vH8vmhgg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654097603;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=gxEThOCqz7ZGXyBonp2EvQRkEjGXFbnGU6wESbz15ZU=;
 b=TRZs3uaXnYvUGC0usQZzzFASZsbYoJ1Wr9nt1DFNN6KbDUgXppsnwz/yuKmSpvsY
 +blozpELg+A54Zo3ON33MVwLQQY2KY53cgtIr9sVM6ypJjLTmaFCG13/vuv/NPAdoyb
 4JjaJ+3GK4rJNC8qGtMaoUgVEJ3UscXpJG21PjVI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001811fe66990-78ced771-11d2-488e-b09f-3d0ff2a8e35e-000000@email.amazonses.com>
Date: Wed, 1 Jun 2022 15:33:23 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.01-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-14-gd2a5676
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
* git describe: 20220527-14-gd2a5676
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-14-gd2a5676

## Test Regressions (compared to 20220527-13-ga2d0e01)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Regressions (compared to 20220527-13-ga2d0e01)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-13-ga2d0e01)
* qemu_arm64, ltp-crypto-tests
  - af_alg07

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912


## Metric Fixes (compared to 20220527-13-ga2d0e01)
No metric fixes found.

## Test result summary
total: 12639, pass: 10639, fail: 60, skip: 1940, xfail: 0

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
