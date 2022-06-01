Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9333BC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 09:56:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B32533C6574
	for <ltp@archiver.kernel.org>; Wed,  1 Jun 2022 11:56:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC2843C61C0
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 11:56:27 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EA29200A15
 for <ltp@lists.linux.it>; Wed,  1 Jun 2022 11:56:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654077385;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=xSm/cptFePqJIX9Q7GLUHP8NvGNRmfggVzIyYuBi9WI=;
 b=MgaFjKV7vs0ThHjCbWweI6K2vWUwEYCgD1ol0YpQ1SCV1at+Wa2MOJOYs2KqQC5f
 F+nmjR5XbSLNmSvCxIidnYeSAPnpXqYr8kaIWTz0D0irHjnR5gW14D8NOdT0lmwHEa/
 Me1IV5V5CfgBgcdbvTtahO2lpMOVLKWPbKArRuxo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654077385;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=xSm/cptFePqJIX9Q7GLUHP8NvGNRmfggVzIyYuBi9WI=;
 b=gF6xEZY5ANhOPGsAaC9mlsSHkwdOKd/7kLydn/LrHaCNH5EwOt58lm3OPsCoATy0
 WnjqppEKS2nj7cmGMzNRueaGmzWbDUL729jzTPrnyluhOgOphLpjOuHE232xse6Oa2d
 z2Kh3Ei+Qv58UTbp3FWyKNxAvU4trsd5pzrf4mpQ=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001811eb1e9fd-b4a9a6f9-af33-47e0-b22a-60cb1b2cf5cb-000000@email.amazonses.com>
Date: Wed, 1 Jun 2022 09:56:25 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.01-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-13-ga2d0e01
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
* git describe: 20220527-13-ga2d0e01
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-13-ga2d0e01

## Test Regressions (compared to 20220527-10-g8ffc871)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm64, ltp-crypto-tests
  - af_alg07

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912


## Metric Regressions (compared to 20220527-10-g8ffc871)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-10-g8ffc871)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 20220527-10-g8ffc871)
No metric fixes found.

## Test result summary
total: 12553, pass: 10552, fail: 61, skip: 1940, xfail: 0

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
