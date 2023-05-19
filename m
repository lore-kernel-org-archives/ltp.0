Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53820C77B75
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 09:17:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74A5C3CD410
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 11:17:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18B953CB25D
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:17:32 +0200 (CEST)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A36F41000D1C
 for <ltp@lists.linux.it>; Fri, 19 May 2023 11:17:31 +0200 (CEST)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-437d6a60763so448383137.0
 for <ltp@lists.linux.it>; Fri, 19 May 2023 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684487850; x=1687079850;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EyqtzOzYWX6JRvNob/w8wtaOTH2ZW4ullCjMcrbQt84=;
 b=zRvxgZdjVaC0wM7XeeOgxt3NbiwlmT38GWMl7PWKSG8f8T5z0tfKB4I+487Wu2J2QX
 wCM9NlgvLUbNa/Gd+DZ+JADCVilNLsLZXRrZ01Zmo8fVvYyPoFgJI9NNcoRg/1ulgBe2
 el4DzrArMkz3HcYzEt1DnIKv9tacor94bK/6YevcX1tZEFtrxMX7f5zX17tKFl5VCUZK
 XwdemgLE2M6x+jilv0YwN4RGquzszXM/9zgk/zUJwUBY8BchRJgdV5aBqcLUJdDKY05X
 zLx7Ey/H6lhBRjv2lHjBMxt96U2DwuWhZAgQFgnnJR2N7dw2gyeAX87nch5wOOTmhoiI
 +k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684487850; x=1687079850;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EyqtzOzYWX6JRvNob/w8wtaOTH2ZW4ullCjMcrbQt84=;
 b=PtymJg/7rYJW+4B2r0PlrLQaCGPfOGs0v9c2gXpnPGor82NlEbr/3gWoqt+/5TuRoa
 7n3S9fMhVCFm4Bly3NeN7GG70JZnzstspRBQgv7/9Yw74U/MRNvSxZKslshA2OVBekgC
 i5Dbg4L2RyCSUg+dgK3mODJgSlYFSHcM9Bj7U3UpbRg9WeRgrIBdTpAS354Oe4XPkjvX
 7X9hkmW8RL9IFg2EKqFbKdRLRnwjqKXVfNqUhjliwL44zEkp04GM3dcLSScgR3fpeTwC
 CRJWAkxBNZNLBUDUsOOoZCHolq1dyspxgwHZfhITxkUvnGNpYQvAuCR6vxEjiqRt7xOn
 s8MA==
X-Gm-Message-State: AC+VfDwOvymmP3zACa3/rnWOJxjs3+MmWCjjCEldEdG70JrntEsgpXjJ
 UwjDrfqWjL2zUhww5nmcJTokR3Bhe6roe1Cn6qApjw==
X-Google-Smtp-Source: ACHHUZ7qIUMxdpZJ/pPArQrhJcxkdOvkT3Ni6MqkUJEeHYxiqb4zb7qGxo21gCQCJ9cJcpOHDYckJB+fo+0hATp9r2c=
X-Received: by 2002:a05:6102:1521:b0:42e:5b08:ec71 with SMTP id
 f33-20020a056102152100b0042e5b08ec71mr900473vsv.11.1684487850295; Fri, 19 May
 2023 02:17:30 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 May 2023 14:47:19 +0530
Message-ID: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP: shmget02 fails on compat mode - 64-bit kernel and 32-bit
 userspace
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
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP running on compat mode where the tests run on
64-bit kernel and 32-bit userspace are noticed on a list of failures.

What would be the best way to handle this rare combination of failures ?

* arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
    - shmget02

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
<4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
enough memory for the allocation
shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
EINVAL: ENOMEM (12)
shmget02.c:95: TPASS: shmget(1627422610, 4096, 1024) : EINVAL (22)
shmget02.c:107: TPASS: shmget(1627422610, 2048, 256) : EACCES (13)
shmget02.c:107: TPASS: shmget(1644199826, 2048, 2560) : EPERM (1)
shmget02.c:95: TPASS: shmget(1644199826, 2048, 2560) : ENOMEM (12)

logs:
-----
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16880333/suite/ltp-syscalls/test/shmget02/log
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-rc1-71-g105131df9c3b/testrun/16880333/suite/ltp-syscalls/test/shmget02/history/


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
