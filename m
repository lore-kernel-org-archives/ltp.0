Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1BAECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 23:24:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA8323CAC38
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 01:24:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FEB43CABBF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 01:24:37 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB49310009FD
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 01:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663197874;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=CN2dv1iQ1ZDH2ndnVkQEXNH18jb0p5nLEwVbbYYKJxs=;
 b=RBPEmVa5A8npxSdL7S8bFpYgLUbK+1d0l12WNpnp0jTPEEDbrf+miWrMPlxKbUNv
 cBKwe2M9KWdcC8zWV8xlYylHi24nJmW7u6mVjYudhexaazN38L0OOCW3Yf2tQzw1lJ+
 7OLUcmPlqp6aoITZiqYFjE6/fknPni0bqYPDFdXM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663197874;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=CN2dv1iQ1ZDH2ndnVkQEXNH18jb0p5nLEwVbbYYKJxs=;
 b=EVP/oeeaXF+S3k0ChWRv+YFZgz74Mjq/HODuv5lBJNjItVqMFaScBFlmaTY/9GM8
 vl6BH42JrpJTc6nkqnQcflcPMuQiiNnP5Iunn13Llhms1N1moDvx8Y+nL39p7LP3EsE
 qLV0tea2pugXLQ5OG0u1yUXYj7jR9AocJqeO3Xy0=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001833e518708-e2d5247c-df02-42f0-8705-ae89cdd28467-000000@email.amazonses.com>
Date: Wed, 14 Sep 2022 23:24:33 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.14-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for c987801
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
* git describe: c987801
* test details: https://qa-reports.linaro.org/lkft/ltp/build/c987801

## Test Regressions (compared to ac926e2)
* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11

* qemu_arm, ltp-mm
  - ksm03

* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Regressions (compared to ac926e2)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to ac926e2)
* qemu_arm, ltp-cve
  - cve-2017-15951

* qemu_arm64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to ac926e2)
No metric fixes found.

## Test result summary
total: 12630, pass: 10736, fail: 164, skip: 1730, xfail: 0

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
