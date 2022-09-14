Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC40ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99EE3CABFC
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:31:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68A933CAAD0
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:30:59 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 72E821A0021E
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663155056;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=VmFIhcCBq+o5VNjqRdARHQ/N/UXurSel8YKTRn4cXEE=;
 b=FkwBGuf6+SP/QJyxh8EGnY3m1De50xokbx8Ez2Up0/MFh/ziL1UnpHmbahWJqeNw
 geKP4yk9jjuOK7IcyNfajg5FVgXbgcyKMKQZTk02O/hwqz0cv/qbY0NQU0oxOGNdbGA
 KpjFr4az097INdg+DOcFAzfPDVkUlX2MOa6W7/3I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663155056;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=VmFIhcCBq+o5VNjqRdARHQ/N/UXurSel8YKTRn4cXEE=;
 b=FTp2mkGUG1H9C25XUbJPUltVM2VA47cVgMhJnwF+Q3TvzoPnxnoFtEJG8LY4zBrB
 YhHYMojOlMDBNxxQEfZwBO9yEMQCMQG3XdR/oHVc4eWWwvxM948VWDSlIoaGDL+kNnX
 gXNSaq7yMIP7jB/d5wS09XTOC/HWtbFBeE36w01U=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001833bc43066-a4966c03-28d5-4c2f-a5a5-74dd2195f287-000000@email.amazonses.com>
Date: Wed, 14 Sep 2022 11:30:56 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.14-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 2a7734f
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
* git describe: 2a7734f
* test details: https://qa-reports.linaro.org/lkft/ltp/build/2a7734f

## Test Regressions (compared to fe31bfc)
* qemu_i386, ltp-controllers
  - cpuacct_100_100

* qemu_i386, ltp-cve
  - cve-2018-1000204


## Metric Regressions (compared to fe31bfc)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fe31bfc)
* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11

* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to fe31bfc)
No metric fixes found.

## Test result summary
total: 12287, pass: 10436, fail: 157, skip: 1694, xfail: 0

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
