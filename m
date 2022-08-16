Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE0FC00140
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 02:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAF723C9725
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 04:16:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC1A43C95E2
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 04:16:16 +0200 (CEST)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 252F960086F
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 04:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660616174;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=Ta3trkonLlCOR0XxzPcUvAJkMAUDjWp0806duQo6q3Y=;
 b=p79P3gRU9UQLoOh9LtRqABoqCuxP/ogU48ZM7qFYS7FjYKDapF9kCA21i7NVns+3
 iMgwSzjQbxAQjDLgzv3+raRrmlHa0hxhFxYsEkY2jDG8bQNAzizVcCe0z9zODcEX9uR
 yUzcz7tZzoUHEfYQzVwgTcqPU10dqWJIOmI4fuOQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660616174;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=Ta3trkonLlCOR0XxzPcUvAJkMAUDjWp0806duQo6q3Y=;
 b=KbySbaLGoVB2LYEUWeL24chJTnV9TAXMzJE7b9emgi/zkV1wBqKGzhrT2YeBCD1/
 pelxWo3zyoexTO66MM0RhH6XMCsmlb+kcvdMfTHWDGFXTt4OoIzHYwcyIOQtJYloojp
 AbcXmBnFOkfwaf48D1T65uGQjYb4oShAAgY2kbd0=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000182a46feb1f-7d9e556e-481c-4ee6-bc3a-ea2ad75cbb6b-000000@email.amazonses.com>
Date: Tue, 16 Aug 2022 02:16:14 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.16-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for ab3b11b
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
* git describe: ab3b11b
* test details: https://qa-reports.linaro.org/lkft/ltp/build/ab3b11b

## Test Regressions (compared to bccfa73)
No test regressions found.

## Metric Regressions (compared to bccfa73)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to bccfa73)
No test fixes found.

## Metric Fixes (compared to bccfa73)
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
