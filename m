Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411EFC433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 16:20:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2026A3C98AB
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 17:20:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EBD43C016A
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 17:19:52 +0100 (CET)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 793362009E1
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 17:19:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648138789;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=VahcgazUkA0qK+gpTNSeZfuireXkKsG8TRq3z+6NjFo=;
 b=loHFkeQ75Vpuj2NINjvDlSTYQ7/HDQGIw4U2GnSuZOxj+K8vGnWT1UChpULivyBR
 EGR63cIhcfNpCX0yIGdfnm8abR1qs9gUkSybWjLj+TpwvvqOBoX2EG/44yfzLV70hZI
 i5e5k7lWktmovUic3btSmIC+MuNI2fWNHGyDaD4Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648138789;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=VahcgazUkA0qK+gpTNSeZfuireXkKsG8TRq3z+6NjFo=;
 b=Zrtwffb+0YTPx3QW4tVeX7XkXcoTN6PRlgM6pgXQZ6NzNAt7ijpPbLXVsFq/YWn5
 Jdya0YQxo1xpVFGWJpeJlcq/moJOlGXADjl0o0o+EBCGriwfk78SK0GFjg2nh/yRjin
 IrucKLGQg71P6tS90OeRMAazlsk6GYsxMFbvlitU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fbcba2284-aa00081f-897a-45a8-9a16-52a1785761e2-000000@email.amazonses.com>
Date: Thu, 24 Mar 2022 16:19:49 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.24-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 342e7a0
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
* git describe: 342e7a0
* test details: https://qa-reports.linaro.org/lkft/ltp/build/342e7a0

## Test Regressions (compared to 7ff14b9)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 7ff14b9)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7ff14b9)
* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-syscalls-tests
  - futex_cmp_requeue01


## Metric Fixes (compared to 7ff14b9)
No metric fixes found.

## Test result summary
total: 10157, pass: 8480, fail: 42, skip: 1635, xfail: 0

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
