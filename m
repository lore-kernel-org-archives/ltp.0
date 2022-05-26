Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C59C433F5
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 02:19:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17CF83C071B
	for <ltp@archiver.kernel.org>; Thu, 26 May 2022 04:19:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DEF93C013B
 for <ltp@lists.linux.it>; Thu, 26 May 2022 04:19:42 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A9CE601258
 for <ltp@lists.linux.it>; Thu, 26 May 2022 04:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1653531580;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=z016N1i+BKPk682eIqcJD8Qtakbkb3EQbQ7w1awqn8s=;
 b=ggKiagkRxvLwxnSG/Vqjyk6ri+TFJtZvwa9wT9XIaGTWhooKcRQ6i/kRWGTOuq1I
 poeQPcYva6yKCkp1E/G43n8WRdrXshp84rbJrS9lZkwokBFCz43HTVJQIw4H/0KcXve
 cMrTXMprP082o3ryOUoNuqvNxfaim39d63SxSzRk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1653531580;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=z016N1i+BKPk682eIqcJD8Qtakbkb3EQbQ7w1awqn8s=;
 b=QsyGY9OSEUhEGiItL6fsLFAhIfbkBIWj7qSR4Nnx4uRp/x1QPgitQ6RfQ+Bkeruq
 /WKItXWXn4MXahDpHoC6qckQJmWyoUkjybqwl6WKdXSAj99GdMXJ6E7Bp9drCF4LnXz
 VrHl3r66d2ot1TnBf3zds4jh4EtT66Lo6CjjAurI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180fe2994f2-489cf7ac-f858-435b-a1dc-ee95c8cf08f8-000000@email.amazonses.com>
Date: Thu, 26 May 2022 02:19:39 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.26-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for c5b8b34
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
* kernel: 5.17.9
* git: 
* git branch: linux-5.17.y
* git commit: 5c2fc53857eb993952e932da8222b11b063c2581
* git describe: c5b8b34
* test details: https://qa-reports.linaro.org/lkft/ltp/build/c5b8b34

## Test Regressions (compared to bf96787)
* qemu_arm64, ltp-fs-tests
  - read_all_proc

* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to bf96787)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to bf96787)
* qemu_arm, ltp-crypto-tests
  - af_alg07

* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Fixes (compared to bf96787)
No metric fixes found.

## Test result summary
total: 12291, pass: 10337, fail: 55, skip: 1899, xfail: 0

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
