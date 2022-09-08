Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2909C38145
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 00:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B15CB3CA97E
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 02:19:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5F2A3CA6B3
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 02:19:16 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BD3831A00905
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 02:19:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1662596354;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=WeBUbKIN4O0iQvCJCyc3v5oSzYgL5RIf3eg/veYKw4U=;
 b=cmeopAfTr+h7DqaDROcqxIMvWsSObcyJQk/oKM/4e66SUuQMqbJP2TpBhB8WFn36
 HnONYycdoLrzm321fxvb1HC8W5uEsWhsXOqkLwte2DXPZhJrMISLF7+ZbuxvKPR+ONX
 Q+4P/hx31Lv+mKjkV9SLCz/51eYZNMPPeL+AaoyY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1662596354;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=WeBUbKIN4O0iQvCJCyc3v5oSzYgL5RIf3eg/veYKw4U=;
 b=hLrBi9RXum+klUhY+PAxvZof2yuJgRorXy2pETZDgb9wVtii587fR8U+j2ul0iZP
 basmGJTJ3ONVD9fFckAKS1AkwcGecBiV0U2ClyxUoWauI0dW8+Qx3RH22Gy6hpJW+tc
 GNbyIvW/z6mdFu8q5Ras9a/+mbe4c15JrJu3BJe4=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001831a770f2e-3a363ae9-fd4d-4ced-8094-335133a3c09a-000000@email.amazonses.com>
Date: Thu, 8 Sep 2022 00:19:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.08-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for fef92f1
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
* kernel: 5.18.19
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.18.y
* git commit: 22a992953741ad79c07890d3f4104585e52ef26b
* git describe: fef92f1
* test details: https://qa-reports.linaro.org/lkft/ltp/build/fef92f1

## Test Regressions (compared to 14e3179)
* bcm2711-rpi-4-b, ltp-mm
  - mm01

* qemu_arm, ltp-crypto
  - af_alg07

* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Regressions (compared to 14e3179)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 14e3179)
* qemu_arm, ltp-syscalls
  - epoll_pwait01

* qemu_arm64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to 14e3179)
No metric fixes found.

## Test result summary
total: 12286, pass: 10433, fail: 159, skip: 1694, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-syscalls
* ltp-tracing

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
