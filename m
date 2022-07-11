Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E845CCA480
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 09:19:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DC143CA7C3
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 11:19:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 899AC3C9FD8
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 11:18:59 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DEF7E200388
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 11:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657531106;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=8MJMm0jakLEFydeBStnloTd2Nlmq+dYx0fSQox6yKb8=;
 b=nZnzVvQ54Eg9GWOZzmjc/xlJn1OaQTO6FLfl/ufNb5iS4FHoz2qMzN7EGR1FIjId
 rTh5fx6A6wz5evlZlktZRmkB1Jbs7U4tvxqw2f6S6HJNmqkrdn7xo7zGs5z574X8Xf0
 T0YadoluO9fg0oHsGl8y3DaXwLeRTIUufC6p9PPE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657531106;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=8MJMm0jakLEFydeBStnloTd2Nlmq+dYx0fSQox6yKb8=;
 b=ILQsf+CecmeNqNtjoipQezoBrqFk8eGHIy4eOueQ6rRY33vYhPQuySd8cy4u/1il
 Ez+HuDEqIXXC0AueMDE9YOUs3rBjEa3qmPb+TfnVs4UkMuzscB5zHAzFWa9F56XWZv5
 bjhSW2CBSHiGx/3kZn345x1TogngMhpprMInjE94=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181ec8d8348-ddab19e2-a363-4369-a16b-aebef9eff96b-000000@email.amazonses.com>
Date: Mon, 11 Jul 2022 09:18:26 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.11-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 79ba953
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
* kernel: 5.17.15
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: eed68052d2016d9f96d6656435099762608120e3
* git describe: 79ba953
* test details: https://qa-reports.linaro.org/lkft/ltp/build/79ba953

## Test Regressions (compared to 17d354e)
* qemu_arm, ltp-syscalls
  - accept02

* qemu_arm64, ltp-crypto
  - af_alg07

* qemu_arm64, ltp-fs
  - read_all_proc


## Metric Regressions (compared to 17d354e)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 17d354e)
* qemu_arm64, ltp-cve
  - cve-2019-8912


## Metric Fixes (compared to 17d354e)
No metric fixes found.

## Test result summary
total: 12637, pass: 10640, fail: 64, skip: 1933, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-syscalls
* ltp-tracing

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
