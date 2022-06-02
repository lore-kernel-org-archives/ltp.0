Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA783C43334
	for <ltp@archiver.kernel.org>; Thu,  2 Jun 2022 23:51:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14B5E3C7F60
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 01:51:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B8BD3C31FC
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 01:51:36 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6061A1400330
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 01:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654213893;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=RQEpH58I/0Kfw8n+f7F4ZP1iKshRgq2xWFbj9ERM/Do=;
 b=f5Lc4eT4wFS14YHJbJav+Uin8j1MUq27rLeeT3ksaJJQMZcCyOH/HKwPI283go8c
 F0clLEl7Lt1kcnL+G9zNZ9JnSlWzWf4V66VJMY6xodJQVwaNBzM2IviEzGIn5fOVKUC
 jneeUDD9dDA1G3iWl4/nma8zDSHMMohSI6e5Up5E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654213893;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=RQEpH58I/0Kfw8n+f7F4ZP1iKshRgq2xWFbj9ERM/Do=;
 b=fMNbaPyqWHlKgzE7CX8AD8nR4OcXzPPoE9qqyLFpOzv8lOXTPbsA3KNouo6U2Swd
 ub+4a1/c24QIN/21e/si3PtaHDxPx5mQRGG3XWmx9j7mTrUtg9m6YcRmDjfM8LgiCbu
 7XpaWHIo+/OWGfut4MfYaztPUqosxskfxy9VFQBM=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018126d4de22-5ebcbf7b-3564-4c81-8c9b-4209eb857754-000000@email.amazonses.com>
Date: Thu, 2 Jun 2022 23:51:33 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.02-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-25-g1ef4772
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
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: e960d734930b58bd6ce00c631ea117af0764473c
* git describe: 20220527-25-g1ef4772
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-25-g1ef4772

## Test Regressions (compared to 20220527-18-gf9715d7)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Regressions (compared to 20220527-18-gf9715d7)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-18-gf9715d7)
* qemu_arm64, ltp-crypto-tests
  - af_alg07

* qemu_x86_64, ltp-controllers-tests
  - memcg_stat_rss


## Metric Fixes (compared to 20220527-18-gf9715d7)
No metric fixes found.

## Test result summary
total: 12296, pass: 10333, fail: 58, skip: 1905, xfail: 0

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
