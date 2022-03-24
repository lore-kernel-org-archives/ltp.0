Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936ACC433EF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 04:27:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D44C3C97B4
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 05:27:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A50DF3C8989
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 05:26:50 +0100 (CET)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71132600425
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 05:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648096007;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=MIi3Ef0s+J6fYBiugpbquzNRmj9rYuv8rFDoI98e6TE=;
 b=pdD1XVD8REi5C36J8RpA4bbKo5B8ce9yZaPjiOxZ/itpzIdN+PdL/XYDKs9BnvPB
 B7BIHizBg25Pg0U9ZT1FD85m9Ov2LeJsavKnMlveGwtbLRdA0KrmClMBsyJGdCihtS7
 0jrKvVeHQpGPyZd3vxWTIXlWnBKkuvkuxwECLNX8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648096007;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=MIi3Ef0s+J6fYBiugpbquzNRmj9rYuv8rFDoI98e6TE=;
 b=gaIZBRCWag2Kt5BZuucCSWESfFAeyIiivVLeaikW7ejy1pX6Qx2KKTktRBf0x6SI
 7ZMQlxHYZ6jkIxcBDG6pwq/nYKnB9DMIFpuUiF92tgI+gya764CFceULiJNM5nwgDXy
 fL+A1sJAWNhZOBLAEqB2YSUXZ6z8z9fWz53JW+9Q=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fba2d55ff-9e2fa951-f1f7-499f-a8e7-ad5cd9e1d285-000000@email.amazonses.com>
Date: Thu, 24 Mar 2022 04:26:47 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.24-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 7240b4f
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
* kernel: 5.16.17
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: b90df4ec299a1dbb7f7164b0db27406643329597
* git describe: 7240b4f
* test details: https://qa-reports.linaro.org/lkft/ltp/build/7240b4f

## Test Regressions (compared to 7ff52f0)
* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 7ff52f0)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7ff52f0)
* qemu_arm, ltp-controllers-tests
  - memcg_limit_in_bytes

* qemu_i386, ltp-syscalls-tests
  - futex_wait_bitset01


## Metric Fixes (compared to 7ff52f0)
No metric fixes found.

## Test result summary
total: 10637, pass: 8897, fail: 40, skip: 1700, xfail: 0

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
