Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2497C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 11:47:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 753883C91DA
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 12:47:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A066F3C1FF3
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 12:46:59 +0100 (CET)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CC29A1A0121C
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 12:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648208817;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=bMiVJvkXr57RQG4GG7980FPd2UJSC3mcmgwB3AYRz/o=;
 b=lre/0GDs+TYSi8ye+r+AsbErftLfwrI4YQKMHcql28Rt+Mxk6Myiule2K4U/9vIz
 umgS5JoERwCBkk4/bGMng8mjL5sIsEz+V+m5kNVgHH5Qjs53HRN6ZyZ/Mc6TZ3dUETD
 cJl4rxJJEI7T80u8I4vF8lHlpJs3r3HL3sCvC4mY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648208817;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=bMiVJvkXr57RQG4GG7980FPd2UJSC3mcmgwB3AYRz/o=;
 b=Bt/D+axfkKoZzN+hkijZ/SLqn16YB9wCVmaNCORRj8ppPYXTkBcmd7QzgEdVNVLI
 Grpeh4NbKgWiI2mBrp7J/WULXmGJhvCXGepZXRjRUmtr4Gq9BaJpA2Q77k5GtRN7CB3
 VLNdLTpM1/HSYIVVtQzhqJUrinpoEXMskrBo6pys=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fc0e6abb1-9b88eb4b-82fb-4d14-982a-26d2f6334a9c-000000@email.amazonses.com>
Date: Fri, 25 Mar 2022 11:46:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.25-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 00f1e12
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
* git describe: 00f1e12
* test details: https://qa-reports.linaro.org/lkft/ltp/build/00f1e12

## Test Regressions (compared to 342e7a0)
* qemu_arm, ltp-syscalls-tests
  - clock_gettime04

* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 342e7a0)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 342e7a0)
* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 342e7a0)
No metric fixes found.

## Test result summary
total: 11767, pass: 9825, fail: 47, skip: 1895, xfail: 0

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
