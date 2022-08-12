Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48900C00140
	for <ltp@archiver.kernel.org>; Fri, 12 Aug 2022 15:18:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9723D3C95CA
	for <ltp@archiver.kernel.org>; Fri, 12 Aug 2022 17:18:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF30A3C02C2
 for <ltp@lists.linux.it>; Fri, 12 Aug 2022 17:17:59 +0200 (CEST)
Received: from a8-73.smtp-out.amazonses.com (a8-73.smtp-out.amazonses.com
 [54.240.8.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D2C5D1400F9C
 for <ltp@lists.linux.it>; Fri, 12 Aug 2022 17:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660317477;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=2hxX56S+e9cpS/qPFn7+rtttMTV267WK+hJo7sSKd6o=;
 b=LMrBHEkGAPukPw1kemvt7ji7sooSlXSl8fNYfGfxR6o/xdPi8uJTIodkTz+Zk7nX
 ZCIbbr6EFh445axLQQJu75GA2ZwtOcjQGp1DLt874qTOxNdj6DtUpzd0/duEN5c7KMo
 5IGAUJ7V3jvYJ5buNB/ZAKbVlh2HtjJq/AGmTVHo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660317477;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=2hxX56S+e9cpS/qPFn7+rtttMTV267WK+hJo7sSKd6o=;
 b=iu9JRf5JcImgWAerZNwQdYBozp+j0ryOCKTUSrhZ6uPTHS1+iFRTXU40UG5tfPGL
 /X0cyrok8EdD1uQH97Q6xQQO8tPrgJCKoe1/ihR7ceMNncWBPShh0/1t9iWRAJa9W/C
 mrxQLe1ccmv92VAPRVT/srXVo+d04Qx4C/gBQX2Y=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018292a228df-1eef519f-036c-4286-a0f2-ee8cfbd4e895-000000@email.amazonses.com>
Date: Fri, 12 Aug 2022 15:17:57 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.12-54.240.8.73
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for bccfa73
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
* git describe: bccfa73
* test details: https://qa-reports.linaro.org/lkft/ltp/build/bccfa73

## Test Regressions (compared to f42f6f3)
No test regressions found.

## Metric Regressions (compared to f42f6f3)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to f42f6f3)
No test fixes found.

## Metric Fixes (compared to f42f6f3)
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
