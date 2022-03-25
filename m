Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08822C433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 12:42:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89DBD3C91B1
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 13:42:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB55B3C189A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:42:42 +0100 (CET)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3A75600F0B
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 13:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648212160;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=qLHwT0s19KD6V56+JoAHig5DZ8MBpj+uwiBw2POFyz8=;
 b=b5FjUL1RIr4+/aFtjS53qZOxnyp1oM6cOABD3Q/E2hik+XgY0JYEDhu6CRIEf5IZ
 FV7UWqTF26Q88n0kwmV0wriILzVZnuwf1NVQ/4PtpjfvpokS6X1zVGAkoKClM+AgG3T
 kRZ+DhQXofhaiD5KKAzxPMBJEOKccUio5xzf+jT4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648212160;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=qLHwT0s19KD6V56+JoAHig5DZ8MBpj+uwiBw2POFyz8=;
 b=ZvIZ00tMz/3Th14YPheoKaDfD0zla/tUDtnl2uYwvo9lue6Gvoz0Gpr0m4UNTawi
 0oLJW2xNilOSP566Spi70VCGzCICawTvcYCV206iaooEEhaL8BOydsyaNg5FPvZBjd7
 53UzimOFa2EHU4eirqdX9y8CWImA/sEzLeGFniY4=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fc119ad86-b4f1b8c2-8fc2-40c5-9fe3-d07757ec320f-000000@email.amazonses.com>
Date: Fri, 25 Mar 2022 12:42:40 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.25-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 77373fc
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
* kernel: 5.16.17
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: b90df4ec299a1dbb7f7164b0db27406643329597
* git describe: 77373fc
* test details: https://qa-reports.linaro.org/lkft/ltp/build/77373fc

## Test Regressions (compared to 342e7a0)
* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 342e7a0)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 342e7a0)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 342e7a0)
No metric fixes found.

## Test result summary
total: 11759, pass: 9820, fail: 45, skip: 1894, xfail: 0

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
