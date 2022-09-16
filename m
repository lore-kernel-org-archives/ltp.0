Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1304BECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 11:25:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD9253CAC6F
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 13:25:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 248CE3CAC39
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 13:24:50 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAB4F20119E
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 13:24:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663327488;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=Hk+KR2SK0Yl8/dFrNO5Dpn4sDHWtIQ+vMKhic5lTrjo=;
 b=JfsqWgpBr4lSqwjg6yeKTum4e6lMwUlutwF3pTx74/UJ1TMzLGVh4djrOvq6KamU
 OjbpUEp1h8ETtmznuDCi35zoySyvvWDNC4+mBtoeTm1XMut15kCq0o+NHXSM/P0SKUc
 Dayx+7dhucGqKVOAisWkDWiq6O+JvK6R+X3V5ajE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663327488;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=Hk+KR2SK0Yl8/dFrNO5Dpn4sDHWtIQ+vMKhic5lTrjo=;
 b=jenz2U+z2Ulhkh18mLrT0wlzVbGbQ58ASZwq3Ni9ql5bR4gZhIRDz81qotTKMDJ4
 PCC6hJw2Ul+qLeMVfI8CwNvgGM7EEGZPwiEh8c43yKGEx/3bHkoWgCYJHqGVDFdOYdG
 0xUMafTuzaKXzvxqfWmWwMGU2/qc9r4mr0+BtwzI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000183460b4944-c8ebffe6-ed71-4c71-963c-aa5a3929d00e-000000@email.amazonses.com>
Date: Fri, 16 Sep 2022 11:24:48 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.16-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 98140f3
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
* git describe: 98140f3
* test details: https://qa-reports.linaro.org/lkft/ltp/build/98140f3

## Test Regressions (compared to fea3c47)
No test regressions found.

## Metric Regressions (compared to fea3c47)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to fea3c47)
* qemu_i386, ltp-controllers
  - cpuacct_100_100

* qemu_x86_64, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to fea3c47)
No metric fixes found.

## Test result summary
total: 12630, pass: 10740, fail: 160, skip: 1730, xfail: 0

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
