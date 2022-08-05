Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49D1C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 13:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0CB03C9486
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 15:51:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33ADF3C25D7
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 15:50:55 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B75A460095E
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 15:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1659707452;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=pulERVDr9SSQ3lOY1SMTD6D3dia2vKw2XS1ZgWYfE4s=;
 b=C6xfCvDLEtKeBYXmA5uKcQ7xUMsDSNDRimn3wLdglYtiomviiWYfDMbmmKH1FP41
 G5GaO8Hsv14GlU7f9vZ29UatYZn8cMY7YUkHmfnQeGROmREC5ev+wXLRwnueSk0MjcA
 2ESKQN4VOPTEOj2VYG7AZVsEvOVlEeCXOToU6O4E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1659707452;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=pulERVDr9SSQ3lOY1SMTD6D3dia2vKw2XS1ZgWYfE4s=;
 b=T6TGjLI3FRsk16zN02p2aosUoBSyGOPTSvzJCNj1ZZzpDamlxWeQqrmogZq5D5Qr
 P2Gn76Nd/XeatUl48ZR9TFws7l+t08LVvb38JLSh+XtFS/Gb5zhilmfdTXmKlFx/nrX
 YtiwG/7QQZbPN+NwcLPdLkayOJnSAPPc5YSSAX1k=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001826e45e9b3-a1c18a9f-d890-458a-9828-e34d08d25f6d-000000@email.amazonses.com>
Date: Fri, 5 Aug 2022 13:50:52 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.05-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 7e71b2c
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
* git describe: 7e71b2c
* test details: https://qa-reports.linaro.org/lkft/ltp/build/7e71b2c

## Test Regressions (compared to b857f87)
No test regressions found.

## Metric Regressions (compared to b857f87)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to b857f87)
No test fixes found.

## Metric Fixes (compared to b857f87)
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
