Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95526C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 22:05:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E9C73C91E8
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 00:05:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EBBF3C9098
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 00:05:33 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B1CF600730
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 00:05:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654812331;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=LFqH0r6/e+tf+v/ysN0nCQROu7nFDXy7p7X/OTzX9yA=;
 b=TakSFdjbDdvj67kbO6Htcw0iPmDFkKc4s7Hk6XG/dYvGfn0BaczFrFWsAEvGm/wt
 aEQBI4mFvvY8Ic9ntlXFFrBWsTq6z39/ed3diQ/z6ubQ2CHd+KlFqHfy3+hUsiNa/lA
 a78R9SBoZgh3U9QEH3fg/WvH4CXUo6VXK9sR7cig=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654812331;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=LFqH0r6/e+tf+v/ysN0nCQROu7nFDXy7p7X/OTzX9yA=;
 b=adnPiPbDJR2EEYoc+oRR5AYeMgUP/HRwR2SC2Raa41LQld0ZxzAVtKN96uLmyYUC
 Tmf0ilpysB0ZVVZYGFi86nCT+58krxS+PlbHQBGuAARos6Z3/rj9nYnRrIFDVVhqk5K
 n5SRuNnRg8LXS8FY1UpX9uQY5CWy0bBuCTXacABs=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001814a804ad1-a771aecd-2427-4bd1-ac8b-6cc1f14e5b9d-000000@email.amazonses.com>
Date: Thu, 9 Jun 2022 22:05:30 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.09-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-38-ge3289ef
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
* git describe: 20220527-38-ge3289ef
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-38-ge3289ef

## Test Regressions (compared to 20220527-34-gc5a5f50)
* bcm2711-rpi-4-b, ltp-crypto-tests
  - af_alg07

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912


## Metric Regressions (compared to 20220527-34-gc5a5f50)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-34-gc5a5f50)
No test fixes found.

## Metric Fixes (compared to 20220527-34-gc5a5f50)
No metric fixes found.

## Test result summary
total: 12296, pass: 10335, fail: 56, skip: 1905, xfail: 0

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
