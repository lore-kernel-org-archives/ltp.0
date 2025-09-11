Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB56CA1016
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 10:38:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4E3A3CD80B
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 12:38:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 740B43CAD56
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 12:38:38 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F0C810008F1
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 12:38:37 +0200 (CEST)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7722bcb989aso363495b3a.1
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757587116; x=1758191916; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hwCf+x6+iQDwlYTBOswpM6ZU+Uqffi/8oPlDvFPRj5I=;
 b=J1fpVHWlzOoOQFFXNgEs+npUrTMEdB+Nj20Qa5wANy/0caEWqoufNCVCGbxtMXrCXe
 6jxENWT/sd5wxzquZS/fUZlLTeCanRos9TpGEc4CXdAvAVt05Z64zWiq4guDtbwpNOgb
 AmudDKiPodAhTTLoJ5nGHoOwNJwQMgntf0Bg9H4NCwjUVc1dDwDcDZ1yqXQnmdDpDwKS
 iT+F8OTr3txFQJFXyrg/setQdHsKstpsbZ8GLOlqz9ey8s3rQaO/06cRKcoSMgNvNwtM
 zxd4XpB3cbHKDKYTiHPYMQ//tdjfwueMPicJnJw7YMEAt31zSHJQHy0kticgcQ2UNzl9
 GocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757587116; x=1758191916;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hwCf+x6+iQDwlYTBOswpM6ZU+Uqffi/8oPlDvFPRj5I=;
 b=TnMKDFPjrhIfR98ejBKpjDjFM3ivMf9wVZ5p2Y1Ii+9/BbMUOOTykELcfPRovvxaLC
 zFdeUR6ot3xsnqo4NNQ3ZabJjFfQwIr/9FLY9muW9NBwBWvoKfGAu5Ih+vFU0wp41KZl
 ga9rMnJU2RxpWz9mHAVQNJue4Dzr9XO94sSfvf3o7qSaLvtJX+MgNv1WrGvf4B9wUkCX
 Lrv1TKzqweGNHEnbvRN/gH+JOtksqa49CK9oADjsgkICE/TcXr5WEm+9dSohuJlvJx+T
 kG5VCPCytkGaERnN3hEG5aSzADwr1k05TzsAVdi+VN6mntUr/H4f+AD++2ZXl0GFfvsY
 I5JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1M2GQYJfEs8Ln8Y0uCJkJWgZnidmrSVW1ONNAbqhbX9s2J791ZwEXbM/qNZRUxRkbHVc=@lists.linux.it
X-Gm-Message-State: AOJu0Yzg3o/K/uhiE8CWALROe4+qMEpeVTO6DCHGOJQuypvkrJeWDlkV
 23XT/atBB4SO1oQMtnKRPoxapilZ+r142/IIOOscFzD04pvgX8WKY9HH9I9uWfHt/awzLa2vC9k
 aTHtzSgB3k/aWAIJC5zsD2yerwvo6XGqhY2vZlvhAUg==
X-Gm-Gg: ASbGncsQ3S0C3054b8mSDqLr9hPSZR6MOBxQ9CTyPEAqBZdWsSLkW6oRs1QlIGUpOsF
 sPNqq0CgtRwRq5aiWZVJ53IO+3bwcnybi96f5SsQuOgxSB0lsJBr+B16tZ6UZX4/kZmCVrlxq8p
 jyk8ogZ21qaJtAp1nHhOpptGJzdUgJirKaSK8AtzqiF30jOFgmKl4yypDqrn7vSycxcgax9OoSz
 wJ0YwDtizyQbWQ1a+pNZOaUv8nNVGkKtQCKdeF3ENZNQHcRJnT5nnQ4Oub0PbqHbt2Wf6KdVk5z
 YIUwmyM=
X-Google-Smtp-Source: AGHT+IFF9nLAlf5H5zTpQVUA1xDoSRqbppJFcEnC+SSt2NXKIJkElcllJglnQQoxzmnCvg9l74mXa81/q4BpW7N5QUs=
X-Received: by 2002:a05:6a20:1585:b0:24c:f8f:2b95 with SMTP id
 adf61e73a8af0-2534557a863mr28371984637.40.1757587115788; Thu, 11 Sep 2025
 03:38:35 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Sep 2025 16:08:24 +0530
X-Gm-Features: AS18NWDU1yGbFPHd1Xuf1CRGujHNL9_s9RGs2SutoTfTFAoxI3RGpotdfxd9IuI
Message-ID: <CA+G9fYsenOs88SO8ZRYnuDXU8tk=o-kS1Q=fvLbV3=6WKSJR2g@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] next-20250911 acct01.c 123 TFAIL acct(.) expected EISDIR
 EACCES (13)
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
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jani Nikula <jani.nikula@intel.com>,
 Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following LTP syscalls acct01 test failed on qemu-arm64, qemu-x86_64,
x86-64 and rock-pi-4b running the Linux next-20250911 tag kernel.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250911 acct01.c 123 TFAIL acct(.) expected
EISDIR EACCES (13)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Initial investigation pointing to this commit id, (Need to bisect)
$ git log --oneline next-20250910..next-20250911  -- kernel/acct.c
   ccc54b556054d kernel/acct.c: saner struct file treatment

## Test log
tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.17.0-rc5-next-20250911 #1 SMP
PREEMPT @1757575072 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1774: TINFO: Overall timeout per run is 0h 21m 36s
acct01.c:123: TFAIL: acct(.) expected EISDIR: EACCES (13)
acct01.c:123: TPASS: acct(/dev/null) : EACCES (13)
acct01.c:123: TPASS: acct(/tmp/does/not/exist) : ENOENT (2)
acct01.c:123: TPASS: acct(./tmpfile/) : ENOTDIR (20)
acct01.c:123: TPASS: acct(./tmpfile) : EPERM (1)
acct01.c:123: TPASS: acct(NULL) : EPERM (1)
acct01.c:123: TPASS: acct(test_file_eloop1) : ELOOP (40)
acct01.c:123: TPASS: acct(aaaa...) : ENAMETOOLONG (36)
acct01.c:123: TPASS: acct(ro_mntpoint/file) : EROFS (30)
acct01.c:123: TPASS: acct(Invalid address) : EFAULT (14)
Summary:
passed   9
failed   1

## Source
* Kernel version: 6.17.0-rc5
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc5-next-20250911
* Git commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
* Architectures:  qemu-arm64, qemu-x86_64, x86_64 and rock-pi-4b
* Toolchains: gcc-13
* Kconfigs: defconfig+lkftconfigs

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/29854528/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250911/ltp-syscalls/acct01/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32XlIYnaqlBd51NRfEjNdOSzoa9
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFRJ0UBKszjvazzyFA2gCmdT/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/32XlFRJ0UBKszjvazzyFA2gCmdT/config

--
Linaro LKFT

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
