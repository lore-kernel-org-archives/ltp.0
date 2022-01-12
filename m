Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E75C433F5
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 11:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FA4C3C948B
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 12:46:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C32D3C4EC5
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 12:45:50 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7DC9D1400069
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 12:45:49 +0100 (CET)
Received: by mail-yb1-xb30.google.com with SMTP id p5so5452507ybd.13
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=1oAWQHZqJjxGspd66xUUwdpCocjq4RF4bRYfPMa0RgM=;
 b=LCxuNDTBSrsTxNHCIoEpEJhzykzI1PqU0Qu7+y1h/2eirkEaNcUWcRKGGAWaV79ru6
 Xv6at+0+iUtpOEe63PUlXlbArXuMTPWdZ+/I9QGm1/Tn/3qseWRDveOL4FnagSPN1A/T
 WQA5lRrrNPqlTtbO2930mHMbqr0IbKawgZZJX2ACEHAPmOPO0eKb5zSkXu2527bDe22H
 qZSNnQTvKG1BZvNckxJgIPiclQ2QGrvZHaHYpAF4Yj1u61rLGVSA/EQd1E9Vbu/Wv0mM
 76FeBD8ggDrgJZACy1k8ttE1LmolWjhAvrPauqbZAqe0sJtrtel+dc7OKUTio8KPUJJT
 BrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=1oAWQHZqJjxGspd66xUUwdpCocjq4RF4bRYfPMa0RgM=;
 b=ipuY/SrX9HMMB7N32IivkWEXzt04H7D/nqM5OTrB46pyU3bsbX0iSnRdJrNSf8mXM5
 Rn+jePN99aINsHul8f0TrgCP1PfZTCD9Fl5z81CjtG7gpBDRmqZOSaJiyTa6Mw2po7BX
 e/S/eX8X3Aa2NtIMMJSsodM0CLSahW47kL2Vtpj1pMqEpDbA9dSEl2DMVWjuzKnHAkyU
 2rjZw6XYxrwhNeI1j+eUECjnrmCYwxHxhZScrKzSJh7optxGfhAZGuBlhRwRRtN+9ENA
 lq0wIU8VoHeAoWTOPehks6u737rmoEcUgBvPG8RC9yjBE+WdTpBIFtClgnfvWZTm+27t
 N0/A==
X-Gm-Message-State: AOAM530PNdgFMpK0V9jIcW7VdmaiHN2LB8X2dJQXntm1t8rxUseqLUSo
 +OV5eniQxAv0kTJCX1DS7kumuFEgsONWMskzMW4N5A==
X-Google-Smtp-Source: ABdhPJy833HxrFP8l/AcVNmiqInufp1tn6sOo1ri3JhrVF4Lbfk3FqLKPmb8gT8eZ0+nFbb7F4rgAXM2QRTArxbTsF4=
X-Received: by 2002:a5b:d09:: with SMTP id y9mr7287068ybp.146.1641987948106;
 Wed, 12 Jan 2022 03:45:48 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Jan 2022 17:15:37 +0530
Message-ID: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, 
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 lkft-triage@lists.linaro.org, 
 LTP List <ltp@lists.linux.it>, linux-fsdevel@vger.kernel.org, 
 regressions@lists.linux.dev
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [next]: LTP: getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER)
 failed: ENOSPC (28)
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
Cc: Arnd Bergmann <arnd@arndb.de>, Alexey Gladkov <legion@kernel.org>,
 Sven Schnelle <svens@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
on x86_64, i386, arm and arm64 the following tests failed.

tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
getxattr05.c:87: TPASS: Got same data when acquiring the value of
system.posix_acl_access twice
getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:391: TBROK: Invalid child (13545) exit value 1

fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:391: TBROK: Invalid child (14739) exit value 1

sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)

setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)

strace output:
--------------
[pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
[pid   481] clone(child_stack=NULL,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0x7f3af0fa7a10) = 483
strace: Process 483 attached
[pid   481] wait4(-1,  <unfinished ...>
[pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)

metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: 57c149e506d5bec1b845ad1a8a631063fcac1f6e
  git describe: next-20220110
  arch: x86
  toolchain: gcc-11

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

GOOD: next-20220107
 BAD:    next-20220110

Test logs:
https://lkft.validation.linaro.org/scheduler/job/4301888#L1474
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220110/testrun/7253656/suite/ltp-syscalls-tests/test/getxattr05/log

compare test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220112/testrun/7277164/suite/ltp-syscalls-tests/test/getxattr05/history/

kernel-config:
https://builds.tuxbuild.com/23V6AwGvHW7H3kr6WxZZwueajVS/config

We are investigating this regression.

Steps to reproduce:
   # cd /opt/ltp
   # ./runltp -s getxattr05

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
