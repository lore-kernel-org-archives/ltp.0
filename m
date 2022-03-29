Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB0AC433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 17:20:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740EE3C9F01
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 19:20:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C926F3C31F2
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 19:19:50 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC6FB2001AC
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 19:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648574387;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=UkYN35gCI6BD/oZHo/U7HIntTFLjUDDFS2n35ScPI7I=;
 b=ZXruTH88zb813Ql+dwvoCEEan1KQpN/9idOviQyO2xXOyQjR2rLdMwd+lBGG9aFE
 WBP5YVXy8oPN67BJwxNuSHk4aJ3CyxtoNijPpqQfMSkf+AluxpZMYf7+gJzWqm2JX3k
 L8UsYxI2/1QInjbwOaAXRMAOc5/KRMTVh3fSGE3M=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648574387;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=UkYN35gCI6BD/oZHo/U7HIntTFLjUDDFS2n35ScPI7I=;
 b=Vy0DmlOcBEfb9FTiJNnSK8mFaRO1DNXP2Hx+ZVmKrVR7XzNo/mIePEWOiH39Vlvx
 +8O26wE7KzYLRWA6uQU3v8zLi7itNigggvUiSymopzJ1OR/HHoYxe70M7aCM/i+oszX
 hyADkVK0kj1jN3kj/2OhuWAPkz41GkUJmYoVkX7M=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fd6b0d4d2-c61c3c00-c920-4ee3-9cba-cd8bd992a643-000000@email.amazonses.com>
Date: Tue, 29 Mar 2022 17:19:47 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.29-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for a1c46c7
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
* git describe: a1c46c7
* test details: https://qa-reports.linaro.org/lkft/ltp/build/a1c46c7

## Test Regressions (compared to 9eb00f3)
No test regressions found.

## Metric Regressions (compared to 9eb00f3)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 9eb00f3)
* qemu_x86_64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 9eb00f3)
No metric fixes found.

## Test result summary
total: 12109, pass: 10129, fail: 49, skip: 1931, xfail: 0

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
