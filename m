Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E336C4332F
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:46:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 394DB3CA9C7
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:46:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76AE3CA897
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:46:15 +0200 (CEST)
Received: from a8-97.smtp-out.amazonses.com (a8-97.smtp-out.amazonses.com
 [54.240.8.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8536D100094B
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=sqsu7gnbk3ckn4qeg5tktvky4q6bd77q; d=linaro.org; t=1652366773;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
 bh=ad7znZ7XjNtYbpsxDeb9v+02iTJOvUyNd6LccScXgb4=;
 b=SAPrZCNNdAvcCksS6+Z76PG9weEwEX5/Ekqsyb8m5UeU9COj1SQzZGVxd+1P0no9
 leEUfkH2aKqwrfU0/U4D2KIpRma8me7EaGtm0NE87v87gwvmY4MT7wpLKRJTwOBN5h6
 GEw/o/UIKoDiAK/t1ECKeNrcTQnFFemopyc5kLwM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1652366773;
 h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
 bh=ad7znZ7XjNtYbpsxDeb9v+02iTJOvUyNd6LccScXgb4=;
 b=jvHQEmwkQhyJBnx2gG4y3EqYAsdXfO0NvC67i7JSDH+ayFggpeP2to2+Gjv+aI/z
 V1bv9aidOOyIbR494L9/NGVr/nvjZ+bmZRN23Cb6qw6RkaTvwpCkg/pZVl64Tbxww66
 mRSRr8gj0HgNfwCnCuTra5NU3MpnQ4uOkfBOsWm0=
From: lkft@linaro.org
To: ltp@lists.linux.it
MIME-Version: 1.0
Message-ID: <01000180b8bc0abd-c6087db0-a894-4f77-9af9-cce3ea577b0b-000000@email.amazonses.com>
Date: Thu, 12 May 2022 14:46:13 +0000
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
X-SES-Outgoing: 2022.05.12-54.240.8.97
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [REGRESSION] lkft ltp for 9042d74
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
* kernel: 5.17.5
* git: 
* git branch: linux-5.17.y
* git commit: 2731bd17017d4a0e2180a1917ab22d7820a07330
* git describe: 9042d74
* test details: https://qa-reports.linaro.org/lkft/ltp/build/9042d74

## Test Regressions (compared to ac7e6ae)
* bcm2711-rpi-4-b, ltp-controllers-tests
  - memcg_max_usage_in_bytes
  - memcg_usage_in_bytes

* bcm2711-rpi-4-b, ltp-crypto-tests
  - af_alg07

* bcm2711-rpi-4-b, ltp-syscalls-tests
  - fanotify16

* qemu_arm, ltp-controllers-tests
  - memcg_max_usage_in_bytes
  - memcg_usage_in_bytes

* qemu_arm64, ltp-controllers-tests
  - memcg_max_usage_in_bytes
  - memcg_subgroup_charge
  - memcg_usage_in_bytes

* qemu_i386, ltp-controllers-tests
  - memcg_max_usage_in_bytes
  - memcg_subgroup_charge
  - memcg_usage_in_bytes

* qemu_x86_64, ltp-controllers-tests
  - memcg_max_usage_in_bytes
  - memcg_usage_in_bytes


## Metric Regressions (compared to ac7e6ae)
No metric regressions found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to ac7e6ae)
* qemu_arm, ltp-syscalls-tests
  - accept02

* qemu_x86_64, ltp-fs-tests
  - read_all_proc


## Metric Fixes (compared to ac7e6ae)
No metric fixes found.

## Test result summary
total: 12006, pass: 10016, fail: 63, skip: 1927, xfail: 0

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
