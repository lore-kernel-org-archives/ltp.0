Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE9FC54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 12:21:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 911843CAAF5
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 14:21:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CE583CAA8E
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 14:21:20 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83F1C1000A39
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 14:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1663071677;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=TcR7krZuXB8Yg/kKGV0y3+OcOCHkcEmbbxY3lpOp5h4=;
 b=s/IPvsPvKD6tDzLSDRgmwFRaLiIqTECpFMhrJxM70sq618UZ+CAznBY3Mo2T4NJ3
 6YwQTQa1SpsWUQR64a0nV5kOSETbKOLfgI8iqtU2qSTcZ2NlZdT6YEX9IAkxHXDscz/
 Gg4eWE+5QCthhqkuLHL3g5E/AwfB7egs7JjY+imE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1663071677;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=TcR7krZuXB8Yg/kKGV0y3+OcOCHkcEmbbxY3lpOp5h4=;
 b=XSc2Fmai4so/4d0fC6UI41GuY4cfYq4F4L7Iuw5q86JvizsdLEtJ1PfEVcX5CYEY
 /DMCmjE5v3cGPCKis6+8PrWdQr5qWxXmPJzYkVuKoiKfsjmDiUQqnESTgQ0+fFoxam0
 S4Nw9ioZ2Y9KlpAJCJQaP/2Tk1OdeWPSjckpBfHg=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018336cbeb96-29b3aa34-112d-4a0f-9cbf-d04da1f8fd0e-000000@email.amazonses.com>
Date: Tue, 13 Sep 2022 12:21:17 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.09.13-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for fe31bfc
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
* git describe: fe31bfc
* test details: https://qa-reports.linaro.org/lkft/ltp/build/fe31bfc

## Test Regressions (compared to 4d23b30)
* bcm2711-rpi-4-b, ltp-syscalls
  - inotify11


## Metric Regressions (compared to 4d23b30)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 4d23b30)
* qemu_arm, ltp-mm
  - ksm03

* qemu_arm, ltp-syscalls
  - epoll_pwait01

* qemu_i386, ltp-controllers
  - cpuacct_100_100


## Metric Fixes (compared to 4d23b30)
No metric fixes found.

## Test result summary
total: 12630, pass: 10738, fail: 162, skip: 1730, xfail: 0

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
