Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC69C43334
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 11:59:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852FC3C8808
	for <ltp@archiver.kernel.org>; Fri,  3 Jun 2022 13:59:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AF7C3C2FA4
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 13:59:37 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 42B741000D1E
 for <ltp@lists.linux.it>; Fri,  3 Jun 2022 13:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1654257574;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=KEve4iBgNKpOJI63PvVOaueWBIk4ONOdE52QKUSqgA8=;
 b=s7JJtA/NNDqBBv4RAa4mghBjmlJpp5TZ9EnMtUVM8v24Ug7LWX1FJE3cFOEznhec
 uQZeTR5F3FoVZDhOPc3MCwbXEvwD0ni0tOZyOpEZKhI4c+z61IXRPexob4erxFY9TNL
 gCa9DbeFz9rlWPXTIJ87DbEzRgP+tXIfL6gwlxso=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1654257574;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=KEve4iBgNKpOJI63PvVOaueWBIk4ONOdE52QKUSqgA8=;
 b=GbV1qcMEl1uGrlcqU6UAGwhESV0ceLgxUDF6uOthXV6MpNQGjQo7g67svfZMbmHr
 H/6Llz+gl8dZrKp2qXt2VfTmjzs2CNMhju9qx4wDof1VopMGeCKW3ugcvhVS3UjYUaM
 2ouKj19o/7AmfwvGPpQ2z96DfOvIuwkKW7xbNSh8=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000181296f628c-b76a6b57-3d15-42d2-89f7-f84dde12539c-000000@email.amazonses.com>
Date: Fri, 3 Jun 2022 11:59:34 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.03-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 20220527-31-gaa0d8ff
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
* git describe: 20220527-31-gaa0d8ff
* test details: https://qa-reports.linaro.org/lkft/ltp/build/20220527-31-gaa0d8ff

## Test Regressions (compared to 20220527-25-g1ef4772)
No test regressions found.

## Metric Regressions (compared to 20220527-25-g1ef4772)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 20220527-25-g1ef4772)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* bcm2711-rpi-4-b, ltp-syscalls-tests
  - inotify11

* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_arm64, ltp-cve-tests
  - cve-2019-8912

* qemu_arm64, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 20220527-25-g1ef4772)
No metric fixes found.

## Test result summary
total: 12639, pass: 10640, fail: 58, skip: 1941, xfail: 0

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
