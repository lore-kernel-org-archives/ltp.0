Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2D4C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 22:52:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C0883CA5A7
	for <ltp@archiver.kernel.org>; Wed, 13 Apr 2022 00:52:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A49E53CA539
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 00:52:08 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8764600666
 for <ltp@lists.linux.it>; Wed, 13 Apr 2022 00:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649803925;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=t+NoyByHQJDIHstvJLtIFUug9N3ZFWrC6cLLmQnQX64=;
 b=rntxlTa6zw6XlKvzVzJFlSqGZ+mmQCh2InIKXHKAU4iA4iUQAE9usLXPhsCAwIzA
 aKiQ8rLuuNd7HVeF1lwcsdaxqCsPUCpgtZABbWkE8m4wSOWetsN+gosyO/JJ7UDfBpH
 KufRuZBFaqop6yBxdZSnNEumRy2AqxKvU7BsSPwQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649803925;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=t+NoyByHQJDIHstvJLtIFUug9N3ZFWrC6cLLmQnQX64=;
 b=Au6TDCd6boIugaQRgkSfxurjnEiAYy6GjFB8eEDZ9i5dXfl02uKtSk0/LvZWX/7x
 4jad/eqhNTok0yCrxUlegwadEYKdjS0a6wCONAqlYeey0tji0U+eZt0ie1s8PzwwOfo
 L9QuUwxTIR09hepDYTAe9VsPFrAixS2as9eAiVkU=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001801ffa1653-2a71ee61-5e2e-453f-a43f-87ff0bf0c9f2-000000@email.amazonses.com>
Date: Tue, 12 Apr 2022 22:52:05 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.12-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for ac7e6ae
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
* kernel: 5.16.19
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 73be23491df081be0311e65c7744c9f1ec6ad412
* git describe: ac7e6ae
* test details: https://qa-reports.linaro.org/lkft/ltp/build/ac7e6ae

## Test Regressions (compared to 91fd818)
* bcm2711-rpi-4-b, ltp-controllers-tests
  - memcg_subgroup_charge

* bcm2711-rpi-4-b, ltp-cve-tests
  - cve-2019-8912

* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912

* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 91fd818)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 91fd818)
* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-commands-tests
  - mkfs01_ext4_sh

* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Fixes (compared to 91fd818)
No metric fixes found.

## Test result summary
total: 12106, pass: 10118, fail: 54, skip: 1934, xfail: 0

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
