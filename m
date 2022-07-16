Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6BAC433EF
	for <ltp@archiver.kernel.org>; Sat, 16 Jul 2022 16:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3F533CA2E4
	for <ltp@archiver.kernel.org>; Sat, 16 Jul 2022 18:02:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E36D3CA378
 for <ltp@lists.linux.it>; Sat, 16 Jul 2022 18:02:11 +0200 (CEST)
Received: from a8-29.smtp-out.amazonses.com (a8-29.smtp-out.amazonses.com
 [54.240.8.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BDEA16002B0
 for <ltp@lists.linux.it>; Sat, 16 Jul 2022 18:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1657987329;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=ArtLFjay28qt9isnmGRIs/guQae13BhzVijdCgtE7wg=;
 b=X0ErZ2rFuDC+ftenf0/fr0+XZXkyIdR4cnEfjgDn39MGX3AMPhsVqPNOCzMBhRcn
 i2f/NqVyJOVWOsZ8r9dVLl/OM3fvHbAS5QsnM3mHV7Ud4zxV7PziSnXsCFJGKy6aZFN
 fVr3eT2llNDhSORPW9vpLhEtUTkDpWmsnd40rejU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1657987329;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=ArtLFjay28qt9isnmGRIs/guQae13BhzVijdCgtE7wg=;
 b=a4j3WCnlCZs9ac183estBbIvhU55rEbIb31h4ADCKkuLWGzUdvif8VFlCvLD4jEB
 CLXY8dEGueqoqaDtD7BH+WDI9ZNPVu6CQ+Y9ZiQloWP8a34oFf5OUJ53ofucTYee8W4
 NpQDCNmfj++ag4bfMALn9Oz+gBK3+CNps5fXM9yQ=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018207beec05-4603c96b-092b-4bff-bdf6-f8743a11b8f6-000000@email.amazonses.com>
Date: Sat, 16 Jul 2022 16:02:09 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.07.16-54.240.8.29
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for bda92ad
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
* kernel: ['5.18.10', '5.18.12']
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.18.y
* git commit: ['bc560cecaa8b2517932808fa939e36371ffa036e', 'c2e9702659dfc309dfda6116da48f200fe425aab']
* git describe: bda92ad
* test details: https://qa-reports.linaro.org/lkft/ltp/build/bda92ad

## Test Regressions (compared to 3866cf0)
No test regressions found.

## Metric Regressions (compared to 3866cf0)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 3866cf0)
No test fixes found.

## Metric Fixes (compared to 3866cf0)
No metric fixes found.

## Test result summary
total: 2240, pass: 2240, fail: 0, skip: 0, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
