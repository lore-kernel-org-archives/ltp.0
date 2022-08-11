Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9405CC19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 09:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B8373C9600
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:30:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85FC93C021B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 11:30:08 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2248A1400BF4
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 11:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660210205;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=/8Qv8rw3w8Z+XleGfUbFgy6PRqi9RXTVBLR/eY2qyNA=;
 b=kyGyy4s7liOjEpsP+yv6ebPhnv5gRruOgicOW4WcJUpR7aJGSzTmhbtx731b0y6C
 wnvIKtZbm1ooHHjZ8pxcXIz74G3L8Fu/weScyTHw8kIOd5RFPQuE3jXwKbIK2/U9grA
 sr3nYWorDn6ar5qJeHpJjRSLgbUFkePw4mKnuyqs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660210205;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=/8Qv8rw3w8Z+XleGfUbFgy6PRqi9RXTVBLR/eY2qyNA=;
 b=WPSuu9ZIbOEzb+S07iVSw+/FdHxhct/UTVkBT844Re5PffjN9Ir6FBBvMmhS8Fru
 tMxNVvHTlkYr1ljl1taY+8TCYzGSTjLHdg4fKPrSoA5h/D0GvyEaEO/sXwdLGbBS65h
 4NSSrAUAeMlZPyebqQlqlXaXC6SID7V721v5YzFI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001828c3d52ff-780b532d-9c20-4db8-b3bb-76456571bc11-000000@email.amazonses.com>
Date: Thu, 11 Aug 2022 09:30:05 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.11-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 72efdad
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
* git describe: 72efdad
* test details: https://qa-reports.linaro.org/lkft/ltp/build/72efdad

## Test Regressions (compared to 7a382a6)
No test regressions found.

## Metric Regressions (compared to 7a382a6)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 7a382a6)
No test fixes found.

## Metric Fixes (compared to 7a382a6)
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
