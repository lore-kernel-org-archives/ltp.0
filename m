Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC2BC00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 10:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82A363C9478
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 12:18:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B50F93C062C
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 12:18:42 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A05F81400452
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 12:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1659694720;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=pc/Fc9XeqgmmPuFWdv9MgvMkhcZdIZ6kEAvmWehhk84=;
 b=douRR+tgzIQOdQxWhGxSiCK6HL5vX6ieJbGbU2exxq0V6jK8g3Ui4s2VadkEFyc7
 DUHem1dTOr0HXl4e1jdvGWWM5fBlpxc/ax6LaiMei7KU8IlQL5rNc4JLiduBezsTPOi
 PeDRIs5LEnxfPxEy8lUtN3DckXFL4J6tJe7jnBgM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1659694720;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=pc/Fc9XeqgmmPuFWdv9MgvMkhcZdIZ6kEAvmWehhk84=;
 b=FA5UzvnFEGSAB7BIb/yWAGaB+bG/XVRnKtD1CEZHABuOAKJrCvfBfIBUOSipPyhI
 G6XzZJWjUMAjZTOQ32UCJzwdKrrOIqA7lKtSC6Q/g5UUNlPwqpGAfvTnNoT7MMt5FsQ
 XQuiGVr1T6ok1js1G2Oi7AWttPqCwd7PBzWSlTRo=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001826d83a393-16a42a0a-9703-4ea8-8278-e08934ea3a8c-000000@email.amazonses.com>
Date: Fri, 5 Aug 2022 10:18:39 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.05-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for b857f87
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
* kernel: 5.18.16
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.18.y
* git commit: 8843bf1f0737ecea456d2bbd19d4263d49f2d110
* git describe: b857f87
* test details: https://qa-reports.linaro.org/lkft/ltp/build/b857f87

## Test Regressions (compared to d4f0d8e)
No test regressions found.

## Metric Regressions (compared to d4f0d8e)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to d4f0d8e)
No test fixes found.

## Metric Fixes (compared to d4f0d8e)
No metric fixes found.

## Test result summary
total: 1120, pass: 1120, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
