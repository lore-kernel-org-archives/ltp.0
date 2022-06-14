Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB8AC433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 13:31:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B3233C94F6
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 15:31:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08B5E3C8D40
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:31:16 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D7C72003B8
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 15:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1655213473;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=nWNE5HPmI3F5H0My73lbes8At4ZYKf5/Xdkyk+LiJT8=;
 b=kR2opJW9hhyknnlDlQ05aCC+JekjzdJfVoxG0dPNf1avngxxXqwqIlpGzspqvVb7
 9ZgM7VSMMwI0ObuWZY8+fVhMOI7zYFwUe8vKEdBDrAOhXG4yIMWVO5VyyHOISFwypeU
 EaJsNQ6uox39dqjcPGz3D3tN6ofNDLuxzolUa4Xo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1655213473;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=nWNE5HPmI3F5H0My73lbes8At4ZYKf5/Xdkyk+LiJT8=;
 b=I21xH+7fVbugj24ZhJKGft7xqgn91vQNmxo3JJ8dRo0lwgveRoRNHsmfR5Cm64pX
 mRw7J9IT7I+AB3LEUxqpv5DBi/KZL/OY4kV9BNnaRZaKUbmb359yMI+c6hawKsGXjeg
 kMV2zOmoEd8TSjurTzgTQ9Smtqzm57sHF3LpQ5Hk=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018162693dbd-bf014820-d352-4a41-91cb-cefe20d0b240-000000@email.amazonses.com>
Date: Tue, 14 Jun 2022 13:31:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.14-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-45-g1873da9
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
* git describe: 20220527-45-g1873da9
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-45-g1873da9

## Test Regressions (compared to 20220527-44-g3b783e4)
* qemu_arm64, ltp-controllers-tests
  - memcg_stat_rss


## Metric Regressions (compared to 20220527-44-g3b783e4)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-44-g3b783e4)
No test fixes found.

## Metric Fixes (compared to 20220527-44-g3b783e4)
No metric fixes found.

## Test result summary
total: 12528, pass: 10519, fail: 68, skip: 1941, xfail: 0

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
