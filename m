Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E1FC00140
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 02:11:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FE7F3C9788
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 04:11:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70F223C1FED
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 04:10:50 +0200 (CEST)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 411EE1A00108
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 04:10:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660615847;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=sTZaAZ2EC7slSd7a6CSYfOQM/I/SpZ6ywNpSbpRFyHc=;
 b=WyZxmPtEOpSj7sPnVoIsX4irr/EGe2Vp488pxLe5QEcAGpfULMxniG0AA/trJImt
 5W8U0IAMwFyK6S8QFZJiNEk5IBxjUvNpJmH8XsnECni93wK4E/p4F5Q65ZwoRgjArDj
 BEvbi+Ai6e+PSNXIu2IpIhQZ5oa1PCwTI1Z/tryE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660615847;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=sTZaAZ2EC7slSd7a6CSYfOQM/I/SpZ6ywNpSbpRFyHc=;
 b=Ne+VxCys5STaj4on3GFYBn2nyP8rZf3KgP11XwUbJNLTnYW3gGGTnbHteKZf+xHV
 slKHBl//04UVPnftoBFx3fiV3vmCbAHxOavZSEeLn/yQwdZOUq3+/v8vx6rutJIKi89
 0+ekD9cYLlvGOLGqqCieDmcXCK219vRfbvqyo3i8=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000182a46aedbe-2c6be8df-1376-4214-a8b7-1d5b9696dc8c-000000@email.amazonses.com>
Date: Tue, 16 Aug 2022 02:10:47 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.16-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 3fcb854
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
* git describe: 3fcb854
* test details: https://qa-reports.linaro.org/lkft/ltp/build/3fcb854

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
