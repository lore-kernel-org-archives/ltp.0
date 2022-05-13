Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09070C433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 16:37:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D59C93CAA22
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 18:37:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C4D93CA9AE
 for <ltp@lists.linux.it>; Fri, 13 May 2022 18:37:17 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 930851A01200
 for <ltp@lists.linux.it>; Fri, 13 May 2022 18:37:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652459834;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=OJ8StvOJ4EG+K4I5b0PkZdvphC3yy5TA6FUVzuN6miY=;
 b=ZxiM6t0u4smbcqJNij1CbXvaS2PmVDs9F8zBNjRJa2aVRMSr5GTLY1nfL+KtvLHr
 jrciijkztw/gntJgH906Ds4zxFEza6h9ivcGzSnghWm3CJFw4sPcb7iXogkHhToP14f
 b2jts0yYgf3h9FQPzopcwKVRafxh209IQp50HEoA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652459834;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=OJ8StvOJ4EG+K4I5b0PkZdvphC3yy5TA6FUVzuN6miY=;
 b=G1Z9QGNVyfqXIpbEt6JeWm/ztY+SdU7jH61Iripw+zHMT2CgZqZzgjfONpQ9gLin
 AwjutMv1Aj3q9XMp7oaDao2EixtTH9iSrNo2DD00lkhuKVri4MI663Dsqpkzx1wN4OY
 NejAzWRMPANSwwFPm+npfZ2MYaNZmsfFESy/tuiI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180be480c29-5302c213-7c97-4ee3-8203-419424eafde2-000000@email.amazonses.com>
Date: Fri, 13 May 2022 16:37:14 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.13-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for fc37232
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
* kernel: 5.17.7
* git: 
* git branch: linux-5.17.y
* git commit: 7651bb70fe5d2bc9b1b45890d990cb670b23a51c
* git describe: fc37232
* test details: https://qa-reports.linaro.org/lkft/ltp/build/fc37232

## Test Regressions (compared to 17e9ae6)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11


## Metric Regressions (compared to 17e9ae6)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 17e9ae6)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - waitid10

* qemu_arm64, ltp-syscalls-tests
  - waitid10

* qemu_x86_64, ltp-syscalls-tests
  - futex_cmp_requeue01


## Metric Fixes (compared to 17e9ae6)
No metric fixes found.

## Test result summary
total: 11958, pass: 9958, fail: 64, skip: 1936, xfail: 0

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
