Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2F5C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 04:34:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21DA53C8183
	for <ltp@archiver.kernel.org>; Tue, 22 Mar 2022 05:34:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33B7E3C7ACE
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 05:33:51 +0100 (CET)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8486E2005D9
 for <ltp@lists.linux.it>; Tue, 22 Mar 2022 05:33:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1647923629;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=1HjDc3V1cBfZBulg9j+x71zZ9/a8O24QIPhcIo2Kqeg=;
 b=K8J3/tGGbDfrOMZ+nnJp130oEMIFqci3sa2oBsdWTeJPlskrBOi9xXcXdicobkWb
 s4kPDQxYawygrH+EHAeoyJmlJz4OHhJwOFkcD2E059ikoKeNLJmVEHr4ZYPse7m4pP2
 TSAH4ODJZUxn6fFDqEp6VQUeoHViulvkqBfoWbzE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1647923629;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=1HjDc3V1cBfZBulg9j+x71zZ9/a8O24QIPhcIo2Kqeg=;
 b=M8XDlKsZ8s+8ZMDvk5lwq9lPQZhtRW1waKnyERb0kBrk5yoMI5fsBna8bw2hh3Sx
 kn5H4ftxzq7ZSReizIb10nst4k6b3YnVZW8u7lO88UVPcfb4N9YKRqEC+PQaqNQT19a
 GehN9cHzlqTaRURalc5fxazUcppl2+ECulaEvaes=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fafe70a84-56246d3c-6c1e-4531-ae40-64623a18882c-000000@email.amazonses.com>
Date: Tue, 22 Mar 2022 04:33:48 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.22-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for a3fabc9
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
* kernel: 5.16.16
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 9aed648340400df7f403d41d8558244afd6d69d3
* git describe: a3fabc9
* test details: https://qa-reports.linaro.org/lkft/ltp/build/a3fabc9

## Test Regressions (compared to 26d117f)
* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-syscalls-tests
  - futex_cmp_requeue01

* qemu_x86_64, ltp-syscalls-tests
  - futex_cmp_requeue01


## Metric Regressions (compared to 26d117f)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 26d117f)
* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11


## Metric Fixes (compared to 26d117f)
No metric fixes found.

## Test result summary
total: 11983, pass: 10041, fail: 47, skip: 1895, xfail: 0

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
