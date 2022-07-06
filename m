Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2544CCA481
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 15:31:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41A903CA191
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 17:31:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 574183C97EF
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 17:31:36 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A41DC6012CB
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 17:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657121494;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=87terF/yjyDEWnECC0XsXhjYdVVcDvy7a0Tz5VvxqRk=;
 b=r0RFd3LbX+W5YB0u+eL9XUf2Di5mDnS8FXWvvKT6DbbaQtCHsZXTpD1AIw5/vWIp
 y6Q+g5EEH0h6oyUGDN6kEKIKatrOgBGFFnq3Lqdz7Mg4FKCunQWBcKSFMcviNoJdgkF
 znfMGNq6AxKaoPZQuCXkelHLE469woOANKU1Gbas=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657121494;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=87terF/yjyDEWnECC0XsXhjYdVVcDvy7a0Tz5VvxqRk=;
 b=Of/RcRglj8m5BhDrcw1qWOMfqxEzwtCEfOLvOrKSgwPoyjJE3e5pedCVrD3hSKn9
 aquB36JKokIbP0FovmoOlgq8lQ5+7J5WX3cUoQeXkxGDz4Sh+F5PJlxb7e9fTYeRMJV
 rRA9bsVOnuKEV+WXdZP+Dbjv2355QeXiu18CvnwA=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181d423546d-28c1e6cd-0792-4c8d-8a54-bee9d4ba0dee-000000@email.amazonses.com>
Date: Wed, 6 Jul 2022 15:31:34 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.06-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 7005396
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
* git describe: 7005396
* test details: https://qa-reports.linaro.org/lkft/ltp/build/7005396

## Test Regressions (compared to 1f2208c)
* qemu_arm, ltp-fs
  - iogen01

* qemu_x86_64, ltp-fs
  - read_all_proc


## Metric Regressions (compared to 1f2208c)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 1f2208c)
* qemu_arm64, ltp-cve
  - cve-2019-8912

* qemu_i386, ltp-cve
  - cve-2018-1000204


## Metric Fixes (compared to 1f2208c)
No metric fixes found.

## Test result summary
total: 12562, pass: 10577, fail: 62, skip: 1923, xfail: 0

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
