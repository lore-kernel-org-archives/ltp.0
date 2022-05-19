Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E05C433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 13:28:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 482C33CAB10
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 15:28:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514F83CA62E
 for <ltp@lists.linux.it>; Thu, 19 May 2022 15:28:23 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 077E91401191
 for <ltp@lists.linux.it>; Thu, 19 May 2022 15:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652966901;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=NljZKvNxXwwFAAqkcp53P7C25vOXhBrymN0V0+1OTi4=;
 b=L4H3ytJaiGsqWNCz7dORm/5y3EL2mvTNyD5dBmjj5DBvl1lHiOKPlXqxI0d3EjeI
 AwXTdkCzys7NqKG2dpW6MxxPWF2tPnlDXSv4Uqepguyw7F1Xagi8N5YKwll9q0AuZ+U
 zJzoEIVr6BiaJUkEGkMXFOxodCypZK+TUd0EMMy8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652966901;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=NljZKvNxXwwFAAqkcp53P7C25vOXhBrymN0V0+1OTi4=;
 b=PAc0q1bEIYS2XaopuFNNcWkiAl82ZMN4S3b8VERkB6VrupQ5V4A5zpUAlWW4MQqk
 BnpLpL9i4zVHe/zDxI0F69y1sTcagAOv2U1tQ4LTiOTGnBT1LrCx8TtPnuD1xZMC8+W
 LHeF0aTytXDUB2xwYsDRjVkEbbhHFrphZ8j0pLDU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180dc81456a-205d3246-7890-4844-aa91-587b43145d70-000000@email.amazonses.com>
Date: Thu, 19 May 2022 13:28:21 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.19-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 517540b
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
* kernel: 5.17.9
* git: 
* git branch: linux-5.17.y
* git commit: 5c2fc53857eb993952e932da8222b11b063c2581
* git describe: 517540b
* test details: https://qa-reports.linaro.org/lkft/ltp/build/517540b

## Test Regressions (compared to be1888a)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Regressions (compared to be1888a)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to be1888a)
* qemu_arm64, ltp-fs-tests
  - read_all_proc

* qemu_x86_64, ltp-controllers-tests
  - memcg_stat_rss

* qemu_x86_64, ltp-syscalls-tests
  - futex_waitv02
  - futex_waitv03


## Metric Fixes (compared to be1888a)
No metric fixes found.

## Test result summary
total: 12001, pass: 10030, fail: 62, skip: 1909, xfail: 0

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
