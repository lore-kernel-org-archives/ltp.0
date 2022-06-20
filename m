Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D270C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 15:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 683F83C9427
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 17:38:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBDD83C0611
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 17:38:00 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C28E16006C6
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 17:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1655739477;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=lxIBTpvrvymAoDVrCNHRJsmTJW+e/DT+QGEfnNJFfVE=;
 b=HTS8k5PS4lKrO7QmqlVvEMv7dUFlaNlIUBOvjwNtwm6fnR0jPZnl5tC7XZk5axWW
 SXfDDat5reXouzDk2DIFTrigecTZ96OT1rpBVkilH605N6bpfn1Y9C/xKTixotS/YyS
 OTulRW4kgzyOQoS62ekdXOYOzUN1/CYil9ik4f8o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1655739477;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=lxIBTpvrvymAoDVrCNHRJsmTJW+e/DT+QGEfnNJFfVE=;
 b=hyRcic8PkMuFH3spz7f8HYN0ooyN6tRQnrIW/XgI+ymclKPJ2FJyAUN8hZCtZlrX
 QltjczoRvff3APpDALlS1dMbO6NFSBL46tZzOLoOn/XansmCpmfhP/Yw+xyHE90YUT1
 vCwttR4MqlYjNH0boPb9i/lmt+VHXkiDuyQQ5hdk=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018181c36bde-030c448a-9756-4375-b979-c2cc93d3072d-000000@email.amazonses.com>
Date: Mon, 20 Jun 2022 15:37:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.20-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 53ae719
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
* git describe: 53ae719
* test details: https://qa-reports.linaro.org/lkft/ltp/build/53ae719

## Test Regressions (compared to 6763a36)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - syncfs01

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912

* qemu_arm64, ltp-fs-tests
  - fs_fill
  - read_all_proc


## Metric Regressions (compared to 6763a36)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 6763a36)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 6763a36)
No metric fixes found.

## Test result summary
total: 12311, pass: 10345, fail: 61, skip: 1905, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test
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
