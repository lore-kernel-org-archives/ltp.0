Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CDBC43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 16:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A4023C9456
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 18:53:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 019D33C9456
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 18:53:47 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F3CCD200077
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 18:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1655225625;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=OWU5kIpzMBBH6MdNYULx7CAcp6wR6cFtikoj+/+Rzro=;
 b=Dfp/aVC32u5DnfpY6Xts/yOjWk9qV8ypfwEyEa0O8eZYNnYdOb/w8+n5Uuw4h3gm
 zC0Gio9u/Izx4yFM4Gin9VxfP8FC4/bWAthIKxB0r7gStW0jOjyuTXETu4KjgxLNEPU
 eslaHtd/MwcdiHIwORgMPDufWOaXzmSlOwkaCt5k=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1655225625;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=OWU5kIpzMBBH6MdNYULx7CAcp6wR6cFtikoj+/+Rzro=;
 b=NNA3NoG0K/3waUDVhqIFHdJFznLH9EhnWyOx5hiA3++Jkv6KxydxjSSrjZZjIZez
 SGU4gZlKVS1SpjxuxzCxFSzyt3ZiDLwTT5xztjkYMslflgHK1sYqoeVw02xbHQSYzfa
 M5RoTUsIq+2/ZNLZIWcBqC4Edi/0IkLc/8/HKpCo=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001816322aaf2-c4916c57-6f92-4e19-9cc0-6cabd55166ae-000000@email.amazonses.com>
Date: Tue, 14 Jun 2022 16:53:45 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.14-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-48-g47ebb84
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
* kernel: 5.17.13
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: 8eb69e8f0d4544de764ab03c5b292ead949d9ac1
* git describe: 20220527-48-g47ebb84
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-48-g47ebb84

## Test Regressions (compared to 20220527-47-gf1b05b2)
* bcm2711-rpi-4-b, ltp-crypto-tests
  - af_alg07

* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 20220527-47-gf1b05b2)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-47-gf1b05b2)
* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 20220527-47-gf1b05b2)
No metric fixes found.

## Test result summary
total: 12654, pass: 10644, fail: 69, skip: 1941, xfail: 0

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
