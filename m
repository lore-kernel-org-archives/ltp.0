Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0FEC433F5
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 19:27:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 629473CA5A5
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 21:27:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 062733C067A
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 21:26:51 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5FDC81A000A8
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 21:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1649791608;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=V/jJEeECg/xWPbrp8Nub/grE5sxWPzG5cBe3Z2Q48EM=;
 b=tU1YCqGgAAX76qZO5fxgLpaO1Bl2WuueTym2JiUS3R+bL88xRWTE3bYVe4uRAQac
 q+8spYY39n6iy5j+/JXRtCaeOPt9YEqOjPrJgeGKVfObcFVDPuBZGQmpXIj30TavXoU
 m5EcBlHXDugUHhBn5pwY4bLjzPs3mQ6sbjCBWjl4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1649791608;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=V/jJEeECg/xWPbrp8Nub/grE5sxWPzG5cBe3Z2Q48EM=;
 b=Wg0okUMNMeh/JfKjsQSPFK7onkwZNVdhJ+6wJDPIHjcF2UES/bNCJoRZvroVe5hX
 wAE3pBYS7jAwVdHNPa300qzL7rM3+gB2Bu4hHlkPr2uSe5anxOUBFRw4+fSjGQFp9n8
 doQkd4GeFvqXWnx67sZ05yh7112ht3WGMawD2SlE=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001801f3e24fc-f0b1ec7c-d73e-4e6b-9fb2-248880fed03c-000000@email.amazonses.com>
Date: Tue, 12 Apr 2022 19:26:48 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.04.12-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for e945767
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
* git describe: e945767
* test details: https://qa-reports.linaro.org/lkft/ltp/build/e945767

## Test Regressions (compared to 91fd818)
* bcm2711-rpi-4-b, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_arm64, ltp-controllers-tests
  - memcg_move_charge_at_immigrate
  - memcg_stat_rss

* qemu_arm64, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 91fd818)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 91fd818)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge

* qemu_i386, ltp-commands-tests
  - mkfs01_ext4_sh


## Metric Fixes (compared to 91fd818)
No metric fixes found.

## Test result summary
total: 12108, pass: 10130, fail: 50, skip: 1928, xfail: 0

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
