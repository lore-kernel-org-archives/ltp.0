Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8ADC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 10:25:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61E1C3CA745
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 12:25:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4C2A3CA677
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 12:25:06 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AE80560084C
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 12:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657535104;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=ymS78xEkvT41LphVWXlX9+H+7dVMjE/J8m+W0IxoAxk=;
 b=dx3C52K1AjzMsrHw+Lz6GCoiaZk9w5Tc0N3+Pml8J8yhuEbriNdOkLRZfU5mf66O
 ZGsKJHjvMLVgc9UpVDAeKXdN5P4cocbuvkhwAqR4CvA4MBwWe3H5sIgeD0Bg8MDitoY
 KE4DL2zM7nwrdINYJ+R4cIAlo6I/U7Jnbk24pwRA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657535104;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=ymS78xEkvT41LphVWXlX9+H+7dVMjE/J8m+W0IxoAxk=;
 b=Tx3+y/fL6xvBTsYh69r33tKLsM7Olq+CAJawTtwLnBaEiJrW2pyim5RfABfH+joi
 Mpd3dL0P+Ew9PTop/cpOB8Nvhr3OXvaULoElXLoczGtZ7JCX0D17pcBGAsmkv/Gex2u
 e5M7nV2mr98pig7UFA0a1zQoWSdG4nmitSOMoymw=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181ecca8379-2c499b32-2daa-4d18-b6b2-d8f28477d21d-000000@email.amazonses.com>
Date: Mon, 11 Jul 2022 10:25:03 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.11-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 9a6764e
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
* kernel: 5.17.15
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: eed68052d2016d9f96d6656435099762608120e3
* git describe: 9a6764e
* test details: https://qa-reports.linaro.org/lkft/ltp/build/9a6764e

## Test Regressions (compared to 17d354e)
* qemu_arm, ltp-syscalls
  - accept02


## Metric Regressions (compared to 17d354e)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 17d354e)
* qemu_arm64, ltp-cve
  - cve-2019-8912

* qemu_arm64, ltp-syscalls
  - accept02


## Metric Fixes (compared to 17d354e)
No metric fixes found.

## Test result summary
total: 12216, pass: 10283, fail: 54, skip: 1879, xfail: 0

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
