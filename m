Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A14ECAAD3
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 10:56:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 146853CACCC
	for <ltp@archiver.kernel.org>; Sat, 17 Sep 2022 12:56:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFBA3CAC18
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 12:55:50 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2EC966006CA
 for <ltp@lists.linux.it>; Sat, 17 Sep 2022 12:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663412148;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=lK1CEBtyG1v/6SaPHaanGQGc0vlk+5EMfvTgboYS+zw=;
 b=rZd6yn8JIvr8GJ9G3uD1DR5bMRw4vSha32LWCmFowiEsDVVpZCv3OEONXmsuA/30
 ZU6fbrbDdjNf9rqa+/gOWmcQsU3gLPo3X5Vnps3bhDkxu8DCPCtAhGCPFsJM0Oct0X7
 jco9kY6kyhZu73tajxrVKMc8xKqVf4s74/T0TDgk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663412148;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=lK1CEBtyG1v/6SaPHaanGQGc0vlk+5EMfvTgboYS+zw=;
 b=IrilnKvpljLN7VV9S/H9FtLEerD+FvLpEm8gXPfEBxG69WUPsxAa6/ro+71J8UQi
 4VWvGsVWHBhLgIPn01aceMjDZJ5vaDelbiQWJoNTv7vWXyemuOKZPGJvLVmWuMbikyl
 ZMX07bRVAN/yMYS0/NnZDXqaKLkVPrhzbfNSt+eU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001834b1718b9-7977dbb4-7b09-4911-97ba-b0b60633c9d5-000000@email.amazonses.com>
Date: Sat, 17 Sep 2022 10:55:48 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.17-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 3a04863
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
* git describe: 3a04863
* test details: https://qa-reports.linaro.org/lkft/ltp/build/3a04863

## Test Regressions (compared to 98140f3)
* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11

* qemu_arm, ltp-syscalls
  - epoll_pwait01

* qemu_i386, ltp-cve
  - cve-2018-1000204


## Metric Regressions (compared to 98140f3)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 98140f3)
No test fixes found.

## Metric Fixes (compared to 98140f3)
No metric fixes found.

## Test result summary
total: 12629, pass: 10737, fail: 164, skip: 1728, xfail: 0

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
