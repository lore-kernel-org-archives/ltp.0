Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE0FC19F2A
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 16:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 118A23C0B82
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 18:24:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5006E3C1364
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 18:23:52 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 24E8E1400960
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 18:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1659630229;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=H64/S1684ySp/ihOa9/sOMoN9+3wjlcrApB0haI3Vuw=;
 b=t5CeoJtRso0TVeSQMimxFXVhpubAs1fHGN/CRDVBCkIhlLPnbhRk2yaljmyhYwPC
 PtH43U4AMF1nfHepXuxJu4wrPFBcvjaxn7AzBDd9WuHTaNu4H0ZPBUDHFD5Zu3/KxRE
 GKyRm/5NY207526s/Cic1/jUCsby65Lifoq17Czo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1659630229;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=H64/S1684ySp/ihOa9/sOMoN9+3wjlcrApB0haI3Vuw=;
 b=JUPqELmsGUI6i91/IntzUneRaqoJJ8DmxZPZg/XJIfa6T0vn7qyF180BkTLgDyzz
 ggW8v6/LAZ7s6UJcW14zad1nJn5OqgvCCQPEp2g9RPHrJWLbwC8nNcnxF8rlvzLnAPx
 vUtCXhg4T7DvQRRHRWY7PpsSTQR5HxWtr+KhwnU4=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018269ab952e-3c8f8a8b-c982-4956-8ff1-60d9a8293e67-000000@email.amazonses.com>
Date: Thu, 4 Aug 2022 16:23:48 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.04-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for d4f0d8e
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
* git describe: d4f0d8e
* test details: https://qa-reports.linaro.org/lkft/ltp/build/d4f0d8e

## Test Regressions (compared to d18e2bf)
No test regressions found.

## Metric Regressions (compared to d18e2bf)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to d18e2bf)
No test fixes found.

## Metric Fixes (compared to d18e2bf)
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
