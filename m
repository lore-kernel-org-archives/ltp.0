Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4F1C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 15:30:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9177E3CAB0D
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 17:30:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BA723C0919
 for <ltp@lists.linux.it>; Fri, 20 May 2022 17:30:42 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2FC791401134
 for <ltp@lists.linux.it>; Fri, 20 May 2022 17:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653060640;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=njORB1FP/rjymU1swOarKOshFXb+uAkiIeu3dL190E8=;
 b=hBQVuvl7y6Qtb6kr1YpcbpLKjg0psSeWizbq4CGgHVIIQuPkV9dzW1hRdWwZQ17i
 TNCJMYDRq/MoJDZxjYmAim94TEJOx3BbdRd/fBMZmM1HDwloIMcHLPLbwilP+0UKI0t
 EurqvFYkBI1w3gfajkGO0Bu/UqUvU4ZIAiskynvk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653060640;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=njORB1FP/rjymU1swOarKOshFXb+uAkiIeu3dL190E8=;
 b=Zd+K8336EbJT1HlT2MY1cIyhIDvG8UrqvKIrMDnDtt4u57MxqNVE7XG5d41O3yHQ
 taK9PXwf7ZtaZzJ2Rc1WTBuukmV9J+D2WSXfFdGjA40K6i/JLEoZyh8IEnpA6NRcPEO
 0YpgGwz4pVKI80xIw/pLz1VrZyXUBHOUJiDelcgI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180e2179dc8-f4809151-7216-438f-bf05-c0eb9dacf780-000000@email.amazonses.com>
Date: Fri, 20 May 2022 15:30:40 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.20-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 6dd6876
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
* git describe: 6dd6876
* test details: https://qa-reports.linaro.org/lkft/ltp/build/6dd6876

## Test Regressions (compared to cd4dbf7)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11


## Metric Regressions (compared to cd4dbf7)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to cd4dbf7)
No test fixes found.

## Metric Fixes (compared to cd4dbf7)
No metric fixes found.

## Test result summary
total: 11722, pass: 9771, fail: 57, skip: 1894, xfail: 0

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
