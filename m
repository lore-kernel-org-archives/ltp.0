Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA2C433EF
	for <ltp@archiver.kernel.org>; Sat, 28 May 2022 07:50:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 318C13C1BAB
	for <ltp@archiver.kernel.org>; Sat, 28 May 2022 09:50:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFD4D3C0596
 for <ltp@lists.linux.it>; Sat, 28 May 2022 09:50:21 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 02E301A00643
 for <ltp@lists.linux.it>; Sat, 28 May 2022 09:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1653724219;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=Uyejrvo4cmd9OiJ2KXUU5H+aP8znTc727jZ3PmiLw20=;
 b=RVfm7UHen1mIbKKmXeDO39dqxGFn1Md/ZD/J9/+S45PAD5AWQYA8Rj6GLxFIfj7q
 pKK8psw+wMs4p/sTLOrE8ovafJH9+mXf6DSZPluupHpUOV3LtBlSHh8cXP/90BQq+/w
 ym+bvx4b2o/yFbyAL+hoxaiJSVTHq3sVQc3gPIFU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653724219;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=Uyejrvo4cmd9OiJ2KXUU5H+aP8znTc727jZ3PmiLw20=;
 b=ak30Ia7OcIvHOA+ziIQKiTtiJ5ZHUnBxEH2lYouxaOYeOedrHxj4TonKCcphQa74
 a/BLAh4V4fsuZVyHmc6cOAfLZu0os9TZrcOopzEPAzg/Yu6tW6hJdlPdnbHnCh8rhz5
 960qbdYQ0Aw66jsjsAV+mQ63vWzaTHQh4UKgQqdE=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018109a506d8-5936952d-a80f-46b5-b7d7-4c5239a45872-000000@email.amazonses.com>
Date: Sat, 28 May 2022 07:50:19 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.28-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-6-g26ab74b
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
* git describe: 20220527-6-g26ab74b
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-6-g26ab74b

## Test Regressions (compared to 20220527-3-g83978df)
* bcm2711-rpi-4-b, ltp-commands-tests
  - ar_sh

* qemu_x86_64, ltp-syscalls-tests
  - futex_waitv02


## Metric Regressions (compared to 20220527-3-g83978df)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-3-g83978df)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 20220527-3-g83978df)
No metric fixes found.

## Test result summary
total: 11165, pass: 9407, fail: 51, skip: 1707, xfail: 0

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
