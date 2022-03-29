Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87734C433EF
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 10:31:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BFDE3C9C20
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 12:31:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C02843C98CE
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 12:31:06 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFBC9100034D
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 12:31:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1648549864;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=hLI9Sifo1nQdhqmt+V57aBhIpiuG+a86p/BnmFBOg3I=;
 b=LOjKN9ERQMUtez40WU1iDx06mhxTZYhwDhcvFZqrh8v6lhWM8QRuSEQIy4ETX7TQ
 JDeRQVMg++x3Pv+Z0TiP1EY6rMkcNhBblQgxIS5a7guwG/WlTSYskdfIZxkMZ8pHWOv
 tAV0EqA45xdGzhwdQ/LkaUWZ/gCLHROOvsHMLRxk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1648549864;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=hLI9Sifo1nQdhqmt+V57aBhIpiuG+a86p/BnmFBOg3I=;
 b=S47sIRpc7CYBPEUU2lRAfJCAYOWctfXZmhUcU2usgKHjLz48QAws+xXVTyjxD89H
 NE8ir3N1GN54gozklr01q/N2sj7heO2TKNrmSu9SbYAbWHCz5B10SG5hIDrxSOSUWo6
 pdwgyLiyoN9J/1aXVJXdbDGZ5yRJjC4zn/6kenUI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017fd53aa0eb-279d2bec-9b1a-4df8-bfff-73128e2e706f-000000@email.amazonses.com>
Date: Tue, 29 Mar 2022 10:31:03 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.29-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 7b16c02
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
* git describe: 7b16c02
* test details: https://qa-reports.linaro.org/lkft/ltp/build/7b16c02

## Test Regressions (compared to 6f697fd)
* qemu_arm, ltp-syscalls-tests
  - accept02
  - futex_waitv03

* qemu_i386, ltp-fs-tests
  - read_all_proc

* qemu_x86_64, ltp-syscalls-tests
  - futex_cmp_requeue01


## Metric Regressions (compared to 6f697fd)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 6f697fd)
* bcm2711-rpi-4-b, ltp-fs-tests
  - read_all_proc

* qemu_arm64, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Fixes (compared to 6f697fd)
No metric fixes found.

## Test result summary
total: 11767, pass: 9825, fail: 46, skip: 1896, xfail: 0

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
