Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F4AC433F5
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 09:27:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89B803C9CCC
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 11:27:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E19D33C089F
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 11:27:12 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1E5C1200918
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 11:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648632430;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=C8mrt/bAMp9AJ32sciwON5fczqBvX1RNMdAK71+4HTc=;
 b=jNYnBMocnqRj4MlWoC3N8iOle9pEc+kGv+oGB35QYgCnyyxHyAb1rPgafkHeWkEL
 xne2FkmpbIiNV8SIusbfpbMIRB+bZdEeN4VhpBh7VMFiIIy8Hz07fifHeauo4pAErBr
 UXfeuU9WMqsEmZDwKUGhQkLOyRU806BleuhhISic=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648632430;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=C8mrt/bAMp9AJ32sciwON5fczqBvX1RNMdAK71+4HTc=;
 b=loE56P06v3418nXY6Jgh8XcNbHekwfY774GnhcTqtjO8zV90eK2orLGIcr5ak+07
 OYZKghm606kP+lQvtPMFrWXEphw4X5tg+77l4vTyM5lpIPBt5jkD3ebsmdMAfukHr1I
 uWQipBLxad4dACaXf0w+hp0rUvdCnkNGDyjEbA6M=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fda267f49-4d67d301-18d9-454a-8223-d96625e558f7-000000@email.amazonses.com>
Date: Wed, 30 Mar 2022 09:27:10 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.30-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 1979a25
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
* kernel: 5.16.18
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 9fec77b5f094c1bbd0432c3f98d20cca8fc07321
* git describe: 1979a25
* test details: https://qa-reports.linaro.org/lkft/ltp/build/1979a25

## Test Regressions (compared to a1c46c7)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Regressions (compared to a1c46c7)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to a1c46c7)
* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Fixes (compared to a1c46c7)
No metric fixes found.

## Test result summary
total: 12109, pass: 10129, fail: 49, skip: 1931, xfail: 0

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
