Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661DC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 11:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7176B3C882A
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 12:55:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08B893C87D3
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 12:55:34 +0100 (CET)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 20E0C680E59
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 12:55:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1647950131;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=zzVZb27KF5u3YBCGCWCw4+paelfqoVL/D9eLieSw7kk=;
 b=lcybYmKH3V6Dambp6Ugc/gIyHxIvNgugq0fpOPycSr5cRKA1rvVzN+yf5VRu+lQr
 gEynISRqVArAbfysc3256oZdaVshoXSJRohcwz7dN4Yu4P6whApHEc81szwQDQvF6JF
 i+0DB7qUSTpD+dCnNp86k4rVQoUm9oPw+qRCUXkk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1647950131;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=zzVZb27KF5u3YBCGCWCw4+paelfqoVL/D9eLieSw7kk=;
 b=l0Ak3YSmLSwXsY7xikbomojR3Ws+sGJQZkaWTKL8XOEPJGLqevZuny0vPq5oOhhZ
 BS9bufO1OQjV2+qWyavj7fTPJLLJ7kq6dNtf1nEpX3KLIAYNKba22IZhUhgDpjRJ3YS
 ZUnfT8Qw1BDZAKce31aildcbNtGXkyy7di/8ZJUA=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fb17b6ee9-0e87a99b-ddc2-49a2-87a2-2736b7cc207e-000000@email.amazonses.com>
Date: Tue, 22 Mar 2022 11:55:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.22-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for f68379f
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
* git describe: f68379f
* test details: https://qa-reports.linaro.org/lkft/ltp/build/f68379f

## Test Regressions (compared to a3fabc9)
* qemu_arm64, ltp-controllers-tests
  - memcg_move_charge_at_immigrate


## Metric Regressions (compared to a3fabc9)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to a3fabc9)
* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_arm64, ltp-syscalls-tests
  - accept02

* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-syscalls-tests
  - futex_cmp_requeue01

* qemu_x86_64, ltp-syscalls-tests
  - futex_cmp_requeue01


## Metric Fixes (compared to a3fabc9)
No metric fixes found.

## Test result summary
total: 11699, pass: 9778, fail: 41, skip: 1880, xfail: 0

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
