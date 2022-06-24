Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF14C43334
	for <ltp@archiver.kernel.org>; Fri, 24 Jun 2022 07:34:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B08523C95C4
	for <ltp@archiver.kernel.org>; Fri, 24 Jun 2022 09:34:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C8E93C8D96
 for <ltp@lists.linux.it>; Fri, 24 Jun 2022 09:34:34 +0200 (CEST)
Received: from a48-37.smtp-out.amazonses.com (a48-37.smtp-out.amazonses.com
 [54.240.48.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E63DA1000417
 for <ltp@lists.linux.it>; Fri, 24 Jun 2022 09:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=r5f3hr7pzmhv6xwu5spgpns3mj2fddpz; d=linaro.org; t=1656056072;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=1c5a8a3wSNBawW7vplivn+zPiAAJzNMJ6dsJB2mSrVk=;
 b=tFKxK3LD5GQ1EEpUuM8KiFYta+SeuP5zhAl7yYqF6tCzQIGPc6OU/KmL49ZmoMjE
 2fsc2VBf+UW2YLbeDW8ZFdn7RJ4g1x0rF6qbk6asxukuhbYC2zlAMMxm0ySd8u5NN3g
 289OfB7IQa95G4Qpbt3t/MTjudlz8vQvU9LMSP1U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1656056072;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=1c5a8a3wSNBawW7vplivn+zPiAAJzNMJ6dsJB2mSrVk=;
 b=kTPCRYmpFFo14cJwWlilZWwMpsxw4XI4vpT98DbZn6sVtv8W4X6GnnlRA55t7nKW
 jR28qKKAPfuaig0Wp98tsYm3CEb0Yhd40HxhS75/qN260yxs2J7ueO2/Oq3fxdAIPCA
 6L546q7MbZ5dNrF+3D17ZHtmgnIol02P+6K1i7Xk=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <0100018194a24594-d53bfb5c-7623-4132-b883-ab0f1795818f-000000@email.amazonses.com>
Date: Fri, 24 Jun 2022 07:34:31 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.06.24-54.240.48.37
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 9fb2800
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
* kernel: 5.17.15
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.17.y
* git commit: eed68052d2016d9f96d6656435099762608120e3
* git describe: 9fb2800
* test details: https://qa-reports.linaro.org/lkft/ltp/build/9fb2800

## Test Regressions (compared to 00e769e)
* qemu_i386, ltp-fs-tests
  - read_all_proc


## Metric Regressions (compared to 00e769e)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to 00e769e)
* qemu_arm64, ltp-crypto-tests
  - af_alg07

* qemu_arm64, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to 00e769e)
No metric fixes found.

## Test result summary
total: 12311, pass: 10348, fail: 58, skip: 1905, xfail: 0

## Build Summary

## Test suites summary
* log-parser-boot
* log-parser-test
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
