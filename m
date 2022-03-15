Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1DEC433FE
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 09:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B8C73C9425
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 10:40:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C6373C1879
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 19:20:19 +0100 (CET)
Received: from a48-34.smtp-out.amazonses.com (a48-34.smtp-out.amazonses.com
 [54.240.48.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 049DE1400537
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 19:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1647368417;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=2SLuLbNjXzD0ikq3HT3ULjeZ8u7EbmWlz6+HupOc62w=;
 b=Gdth7WBJ/z6m15bOMVO5OANU4jfduYcG1ngaUSV8ykDOTFsC35XhxPsF9loBUODZ
 qci5POhfGffDdrN+WE20y7JYKRhYE9RE2pLvFKBro/pZSzcwsU8gnzqERBPc6RmeiM5
 VehZ8qoLx5N8t/lRwBwDKj+KXfyZ1+zHemew6Ejg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1647368417;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=2SLuLbNjXzD0ikq3HT3ULjeZ8u7EbmWlz6+HupOc62w=;
 b=ITtctp4dgxOFYHrQ6YS7pqXF550RIF0zImjkuPK2b30wo5dpGGle99QEjoPZgWMp
 /Ya/ZGeiZwYNElTDzqOIlRP6qZ8mv1Ix3qC+8vBkTmyQfPfQRWdC3BBfa4Zi/+0Dlds
 3oqST+2K7mLVQ2W570h0knqICiN5EXPnJFGMDIpw=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100017f8ecf2ec3-0d700477-83bb-474b-beab-47c30febc225-000000@email.amazonses.com>
Date: Tue, 15 Mar 2022 18:20:17 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.03.15-54.240.48.34
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 17 Mar 2022 10:39:54 +0100
Subject: [LTP] [REGRESSION] lkft ltp for 57d05ce
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
* git describe: 57d05ce
* test details: https://qa-reports.linaro.org/lkft/ltp/build/57d05ce

## Test Regressions (compared to 3adffb3)
* qemu_arm64, ltp-controllers-tests
  - memcg_move_charge_at_immigrate
  - memcg_stat_rss
  - memcg_subgroup_charge

* qemu_i386, ltp-controllers-tests
  - memcg_subgroup_charge


## Metric Regressions (compared to 3adffb3)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 3adffb3)
* qemu_arm, ltp-syscalls-tests
  - accept02


## Metric Fixes (compared to 3adffb3)
No metric fixes found.

## Test result summary
total: 10637, pass: 8922, fail: 44, skip: 1671, xfail: 0

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
