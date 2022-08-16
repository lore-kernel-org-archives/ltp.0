Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C77AC25B0E
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 13:21:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33A603C9882
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 15:21:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 113AB3C97E3
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 15:21:00 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E74371A008A5
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 15:20:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660656058;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=UBeR1X5B478sktBGF9q2w7QtgCUn6cfNVa5qhCaQAG8=;
 b=MqH+bwACnOc09mIfN7BIYw4cj/HXVZPKbZtk0BetMR3U+QF38lOY+v2i2eWe0WsJ
 eRdWNGxdHM11ahbaNNeEyxwYooxycv9Cl/J3D72a5gydiw3av+87zr6jFcgXSfpUpcH
 1Q27llKYSBc6JtgxcjFvSfjcrWhTPUTnkgJn/LFA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660656058;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=UBeR1X5B478sktBGF9q2w7QtgCUn6cfNVa5qhCaQAG8=;
 b=bE5vmxEzFZGW9IbncsPC+2TVJ67fpy3U2P0IvFZDLXvzw2fDX5TcxJP5QAEsa0Ht
 QvRwsKWs4PhIh1kSVCA5j5BY1+1wGq4gOu7PMYtHyvcLaKCgXx0Yl+y5KYU9F1owVZE
 7EDcNSrgRbJj6WwKerrNrKVurGmk47o6Wm8oVe38=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000182a6d07d74-a08f8608-37ba-4c7e-ba51-b9537ae19e76-000000@email.amazonses.com>
Date: Tue, 16 Aug 2022 13:20:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.16-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 51574c3
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
* git describe: 51574c3
* test details: https://qa-reports.linaro.org/lkft/ltp/build/51574c3

## Test Regressions (compared to 94e0b45)
No test regressions found.

## Metric Regressions (compared to 94e0b45)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 94e0b45)
No test fixes found.

## Metric Fixes (compared to 94e0b45)
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
