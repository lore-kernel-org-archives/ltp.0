Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED908C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 23:26:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10DC33CA491
	for <ltp@archiver.kernel.org>; Wed,  6 Apr 2022 01:26:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE2063CA49C
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 01:26:00 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2B531A00448
 for <ltp@lists.linux.it>; Wed,  6 Apr 2022 01:25:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649201158;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=3HLSUBFrork6vBgjlGEZaE3inByXkIJgxWSnlFbhsjc=;
 b=Izo2G9Lx2R0ipUPe6JDVDE9ChNa55SRHL399LGL4qZFaV6UVZwpx+qMzKcVTMHu5
 dpjA3WNad15GkRQxdmW+rAVAOUNoQU0Hoj5lESr6NJo1oQBvGzpmN9Kdy3mdNHc5rFu
 8XaPN/K2d3RaOIMU/hvJ5A7j8dkDKkglI2/asNTY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649201158;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=3HLSUBFrork6vBgjlGEZaE3inByXkIJgxWSnlFbhsjc=;
 b=d1uopEj2Efet2E/GITrApwaW7TxrJYCqApE4xmBDzK9HE5rNVcI8+cXKuGK6SMAh
 5PciYgh2AoU7jzNDur6ZPRkbNxZbPtwhr4JE7PV0DNPHwiBLZ/kMjaa/7wPAC3z0OvC
 hDWdf/3McNofznvvGA/NGMlzqlTQxM7z5fYYodzQ=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017ffc0c97b2-995fd629-6aee-4681-b5f3-78941ac6d76f-000000@email.amazonses.com>
Date: Tue, 5 Apr 2022 23:25:58 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.05-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 91fd818
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
* git describe: 91fd818
* test details: https://qa-reports.linaro.org/lkft/ltp/build/91fd818

## Test Regressions (compared to 7c58f26)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_i386, ltp-commands-tests
  - mkfs01_ext4_sh

* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 7c58f26)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7c58f26)
* bcm2711-rpi-4-b, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Fixes (compared to 7c58f26)
No metric fixes found.

## Test result summary
total: 12023, pass: 10046, fail: 49, skip: 1928, xfail: 0

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
