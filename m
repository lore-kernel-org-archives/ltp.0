Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB10C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 09:06:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1739F3C95DD
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 11:06:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37A903C0895
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 11:06:03 +0200 (CEST)
Received: from a8-81.smtp-out.amazonses.com (a8-81.smtp-out.amazonses.com
 [54.240.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 330521A00A5A
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 11:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660208760;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=RRHaVtczRhyX6xIRmlQwSqIcIKskv5Z2+me2WJuNWBw=;
 b=lfp2EDKFn0ZFKsRRBedplwvFxMilK7SDER+9mNQ8/fuux7A7IN/FUL0nIAcXVEB6
 tgvGkknTzoLsB3eteBbeo1w6jeFTJCEMQJxB+Ps8e585uTrf9b0ElHjlHRyuuFqREQQ
 daCE3HR5IEIbwx3taqqdDlLQjm9txX3lDDhxnlvw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660208760;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=RRHaVtczRhyX6xIRmlQwSqIcIKskv5Z2+me2WJuNWBw=;
 b=ja87QKpK0CapYxQzaC/nWRvMP5UAP3Gn1sDdjwe+ECD4xlrRYSXgSlRrSJsle5Sh
 yBTTCxlA5z9IBdggUEYdyL56VnDvUBkHIy34XhvbfG+Wh+l90ii7TU09qBWarZcpAsT
 PpARts+h2xmMs9iAUPw4Vo7hwIoIhQtqa2uEhnPI=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <010001828c2746b9-432c4b0b-becf-4424-88a0-c14b25ec8f02-000000@email.amazonses.com>
Date: Thu, 11 Aug 2022 09:06:00 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.11-54.240.8.81
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 7a382a6
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
* git describe: 7a382a6
* test details: https://qa-reports.linaro.org/lkft/ltp/build/7a382a6

## Test Regressions (compared to 0f199f6)
No test regressions found.

## Metric Regressions (compared to 0f199f6)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 0f199f6)
No test fixes found.

## Metric Fixes (compared to 0f199f6)
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
