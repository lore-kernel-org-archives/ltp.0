Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089E2C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 23:26:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4523E3CA479
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 01:26:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65D5E3C1BBE
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 01:25:55 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 687C410006A5
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 01:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649201152;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=HgLmHgE0gZlqiagG4AMvVv8FYh958zi818+T1cK8Ltw=;
 b=ZpFZ7GRn83BajJnUGCYpxO4l9EO6C7jrnBNRbyI8AsWHn2+JBWYx6XqJJ5cu1boP
 z8NJ16MkZSKINWlR6wsM+PPE4k+3z5NcQ5zAOdErT/Ba2K8QzhMik57yoi34DRbmScn
 QTObgJSI6Zr5kPTvBvLVl1Ji0llXhAEvsDpKOqmY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649201152;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=HgLmHgE0gZlqiagG4AMvVv8FYh958zi818+T1cK8Ltw=;
 b=O5Y8Sn0SUhpNdliGVj1/aOwRlpjEtvoveFceh3kItfb6T/y1EytlUuSG8l1cw0rP
 10EryEbpHCFk/FRKR2foirUARMtRmoLfuFcuDCwWpenWQoY2fBT6KfTC4XQMabSvUVQ
 vH/rIcsCaxrQvrEljw1RVlsz40AVmqctKO7+zMJU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017ffc0c8201-0ac7c460-eb3c-4e41-92e1-9ca6abefc1e6-000000@email.amazonses.com>
Date: Tue, 5 Apr 2022 23:25:52 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.05-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for aef6138
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
* kernel: 5.16.18
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 9fec77b5f094c1bbd0432c3f98d20cca8fc07321
* git describe: aef6138
* test details: https://qa-reports.linaro.org/lkft/ltp/build/aef6138

## Test Regressions (compared to 7c58f26)
* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 7c58f26)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7c58f26)
* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Fixes (compared to 7c58f26)
No metric fixes found.

## Test result summary
total: 10560, pass: 8844, fail: 40, skip: 1676, xfail: 0

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
