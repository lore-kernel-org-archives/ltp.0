Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED53C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 21:38:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E6BB3C91E2
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 22:38:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EA163C882C
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 22:38:28 +0100 (CET)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B4A046009D9
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 22:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1647985106;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=6OO7OBlbOXPzkexJEJ4Kua+GNPWPVICii8ogML/zMyY=;
 b=muugliXIusHxX80K5d6hcLdUWzlwySSm1pqvWS0DYJBz8bG4nHcyP07Zkn+qhQS6
 v3UEglHDjScZT1xcQYbM2bj1DylZdeKpmRwrD3gW53ROsGECYFC3Y3Y3RISbbtW9Bwr
 xozMmxcjKrV3UGrLeiNvnI9ekNQBzWMHgaSc3z6w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1647985106;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=6OO7OBlbOXPzkexJEJ4Kua+GNPWPVICii8ogML/zMyY=;
 b=N3se2+I01hWLNgvoLBAcRHuENvQY/WBkrqBF6LaIfnudBSafOH/lZHg3KGtuANIb
 CDUpt62wb4coKkTEgUb2nwPI8q/jBqkYarE4Y6RJxbc7ZHEhGhAShP0rqT6n3SgegeW
 xgOEgHy1pAW7V+UUtWc7wspYJd77ivnrGoi0N1i4=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fb3911be3-4b9c9c6d-d3ba-4d24-a635-c47069963d41-000000@email.amazonses.com>
Date: Tue, 22 Mar 2022 21:38:25 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.22-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 98b016c
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
* kernel: 5.16.16
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 9aed648340400df7f403d41d8558244afd6d69d3
* git describe: 98b016c
* test details: https://qa-reports.linaro.org/lkft/ltp/build/98b016c

## Test Regressions (compared to e246b2e)
* bcm2711-rpi-4-b, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to e246b2e)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to e246b2e)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Fixes (compared to e246b2e)
No metric fixes found.

## Test result summary
total: 12100, pass: 10133, fail: 47, skip: 1920, xfail: 0

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
