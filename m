Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60496C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 11:18:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A11B63C959A
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 13:18:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F09AB3C2D44
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 13:18:21 +0200 (CEST)
Received: from a8-35.smtp-out.amazonses.com (a8-35.smtp-out.amazonses.com
 [54.240.8.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E08BB1400061
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 13:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1660130299;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=TOqSPrtka9WTEs/UkbqnAH7+V2BSNCuL6Nrzt/ShRR4=;
 b=mgF+L9bNsWaF02p0IpOoIqqIv5YT+9cUVCBgXXiafcBYpSyvwX3OY37w2SU5qh9m
 7sLiqLyIqQACSAYa8IsWiLeexeGKLp3IRZIoG/1Ktp+nmxNqmV6vUIfcqoMfWXFK/Kf
 JSuRwLykBZzFYBsQYNaz9ZTYN2RfzWsQVy7qi6Q4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1660130299;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=TOqSPrtka9WTEs/UkbqnAH7+V2BSNCuL6Nrzt/ShRR4=;
 b=ZLWTxnvczimAlIAkVYNf1fjUPttuhrjlD9RhJw7nF42WIltzUserz5Se2uoDVIyf
 1l8yoxjbTOSwqp3odG4CL+BLWx0/DTQBUUU4ScWaruYk7S1dfQS6MEQreYJhyQASttj
 SW6R3UIVDncXzXZHmqApS07tlUTL6yijSNLTG1ZA=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000182877a0e1a-8baafbb1-34fc-4e33-957d-e7a0e355f7d5-000000@email.amazonses.com>
Date: Wed, 10 Aug 2022 11:18:19 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.08.10-54.240.8.35
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] lkft ltp for 0f199f6
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
* git describe: 0f199f6
* test details: https://qa-reports.linaro.org/lkft/ltp/build/0f199f6

## Test Regressions (compared to 3459e94)
No test regressions found.

## Metric Regressions (compared to 3459e94)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 3459e94)
No test fixes found.

## Metric Fixes (compared to 3459e94)
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
