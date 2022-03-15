Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDA3C433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 09:40:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5547D3C93FB
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 10:40:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 416BF3C0711
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 17:36:48 +0100 (CET)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BD211A0014E
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 17:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1647362205;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=fU98loiI4hfQzPhdTyl8R3glmCUXt/X8Q29hN0tSTuE=;
 b=sVhBilI2OaeYJWud43cFYDtKJ0vQJCNlCa53cJhz6BDhfG7lGUTdJpwYH+PQUTbV
 1KVLdM35+Ulby5zyCc2X42WGKBosCeOxUCiDWc/now4b4Z90dXZrSNeD+ffNaHXa6uQ
 oetvD8jm4qyCNQ4x1nLzDctlYsdOkwVCeixOcDY8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1647362205;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=fU98loiI4hfQzPhdTyl8R3glmCUXt/X8Q29hN0tSTuE=;
 b=DsPD7x3+AFw9uZ/eHOeQA4By847yWWt47WFNsUJ6h0RXJO0KHkWYX+6uyJcC7aHi
 IN6dT8BGieL3DJlZc+ifDmn7qtZqQtfLcJlPbstvG1FRUNSmFQ2G5oSQIu0g4Xtd9OE
 sLHxDsrYZrvGSB0j7wxepjl9v7s5RhyxBv00G3f0=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017f8e7067ad-9d64aba2-f758-41a3-873b-984a5fdf87fe-000000@email.amazonses.com>
Date: Tue, 15 Mar 2022 16:36:45 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.15-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 17 Mar 2022 10:39:54 +0100
Subject: [LTP] [REGRESSION] lkft ltp for 8a07c39
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
* kernel: 5.16.14
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.16.y
* git commit: 3cfa7ce38ae6c2c8e57201e2978178c42051defb
* git describe: 8a07c39
* test details: https://qa-reports.linaro.org/lkft/ltp/build/8a07c39

## Test Regressions (compared to 3adffb3)
* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 3adffb3)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 3adffb3)
* qemu_arm, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Fixes (compared to 3adffb3)
No metric fixes found.

## Test result summary
total: 11354, pass: 9465, fail: 44, skip: 1845, xfail: 0

## Build Summary

## Test suites summary
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
