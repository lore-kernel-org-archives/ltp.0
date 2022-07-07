Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A7C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 16:21:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF6973CA2C9
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 18:21:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 868323CA1A2
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 18:21:36 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA289601169
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 18:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657210894;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=WEtf51+uzeFk0ci5fKDb5VrDDJ21ac/whLd/BlHOZUI=;
 b=gGyAPT4gbdkpSllWK38gORu0M3E0hW1wOVbChv0420WlOMWp2if2odh0TnH7DzJs
 56HytNvAbCsqyX8gYmHHn/lAt3h9PdV0mD76wxKUW8zIHOEtH4Ob0boYkS+zo//h5xk
 2vQ4Y0nBSvAKH7nwfCL8jEh9STvF+XLqKfSfahBs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657210894;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=WEtf51+uzeFk0ci5fKDb5VrDDJ21ac/whLd/BlHOZUI=;
 b=YdOYgvdre0eLM+harzHmrNq6JbzazaGku7VeGjCZb3qIRt3+r1lvC13dtRExOvFN
 9WKG7TU1VV8iX26EH6sQpIrs0U64M510A2oBQqYkOCPeyOhy8iYTjTJPSCbSujsBZQ3
 3IdVNSbPcNvZgz1bCgqZI8B66HBs8ifjrho1WwtQ=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181d977759f-b767de06-0b0b-4cec-9ac7-152cac71f0a9-000000@email.amazonses.com>
Date: Thu, 7 Jul 2022 16:21:33 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.07-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 7b3c5d5
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
* git describe: 7b3c5d5
* test details: https://qa-reports.linaro.org/lkft/ltp/build/7b3c5d5

## Test Regressions (compared to 7005396)
No test regressions found.

## Metric Regressions (compared to 7005396)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7005396)
* qemu_arm, ltp-fs
  - iogen01

* qemu_arm64, ltp-crypto
  - af_alg07

* qemu_x86_64, ltp-fs
  - read_all_proc


## Metric Fixes (compared to 7005396)
No metric fixes found.

## Test result summary
total: 12127, pass: 10177, fail: 54, skip: 1896, xfail: 0

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
