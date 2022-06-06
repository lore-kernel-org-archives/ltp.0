Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106AC43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 09:32:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99B403C8D3E
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 11:32:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35C1D3C0945
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 11:32:16 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 724C22002D2
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 11:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654507933;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=YFIgQL+ClAhMnsqwpMR1hIImpn8wmeTDpstJbteIV4M=;
 b=PsqFGfIwdo+ZxegnrezryBMhNhtRAULXGvZDTzMhJ3Ls85HAlWZ7oENLIFg6xP/c
 Rw+7niu2AQjNwg98p5yj+8xzc2gHqhEtH9xnK2W2WQNUNdfNe7KslYNgn0huY4p+AHx
 xLqqjOC/zhg6tQaWuWd2YwENWZXHbNF094anGXc4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654507933;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=YFIgQL+ClAhMnsqwpMR1hIImpn8wmeTDpstJbteIV4M=;
 b=hYqR0IByPv32xdvXOsvi0H/+n5qtgD2MSb+HY0QzVFIrocYfq1DYnhuDVWcxLumv
 9HAdd+T+6ddE5OSSokWulRLHb1RUTfydJe4wz2szyyEgZ5aDrzHGhstuLD8UvylPdey
 nILvkJZwtvSWFSEdtjsbN6/+DcucTLAUyWjcbwSY=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181385b900b-d37c7c27-d1b4-4ef6-baf5-4d70117b79e8-000000@email.amazonses.com>
Date: Mon, 6 Jun 2022 09:32:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.06-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 20220527-32-g9bc65ed
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
* kernel: 5.17.11
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: e960d734930b58bd6ce00c631ea117af0764473c
* git describe: 20220527-32-g9bc65ed
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-32-g9bc65ed

## Test Regressions (compared to 20220527-31-gaa0d8ff)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm, ltp-mm-tests
  - ksm03

* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 20220527-31-gaa0d8ff)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-31-gaa0d8ff)
No test fixes found.

## Metric Fixes (compared to 20220527-31-gaa0d8ff)
No metric fixes found.

## Test result summary
total: 12639, pass: 10640, fail: 61, skip: 1938, xfail: 0

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
