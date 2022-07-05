Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C336C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 15:28:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1DC03CA0FA
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 17:28:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D39133C96E0
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 17:28:37 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F09C71400C48
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 17:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657034915;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=z9iquxSvWO5vgZn9b4WZ6NtErkh2rOGPxf/aMk2wkBE=;
 b=sZoot2ab1WYFwKC58wueJlaiInVrgUZwZmZpuLYkJ6kgTn7/0J8/6iEkaxl4/zhz
 2MC7UOP8ex5sF9TGCXBtBbTMi0M0Dw6MRwFoeDygYocRWz1BUYNOXa7sm8uSDGtUQYp
 i3B6nool7ve81a2bpO9l0fcp4lQduwUb1HX7hVCA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657034915;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=z9iquxSvWO5vgZn9b4WZ6NtErkh2rOGPxf/aMk2wkBE=;
 b=OtEVnhYTR2SBQH4oGLp0WACjGpAmJh3GTgU3SG8Svp47RYMZ4X2/C2SdyUHIcyl4
 LFNqw1PaPrJahDxew+GyQKUTQyWXsWzGU4iWjma//krCVDcLs56wUX9pJSRgtxfuLK/
 AKIuGDGmUT5apRWb3tHdXRJ0brZliLzREm+KfsD4=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181cefa3e2d-c7fa332f-2d9e-405b-981c-6a9f6445d789-000000@email.amazonses.com>
Date: Tue, 5 Jul 2022 15:28:35 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.05-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 1f2208c
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
* git describe: 1f2208c
* test details: https://qa-reports.linaro.org/lkft/ltp/build/1f2208c

## Test Regressions (compared to 9fb2800)
No test regressions found.

## Metric Regressions (compared to 9fb2800)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 9fb2800)
No test fixes found.

## Metric Fixes (compared to 9fb2800)
No metric fixes found.

## Test result summary
total: 12654, pass: 10651, fail: 64, skip: 1939, xfail: 0

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
