Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FACCF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 09:46:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 048B83C4C09
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 11:46:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4103C00C7
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 11:46:22 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 20C371A01991
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 11:46:22 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-846bec788f0so1362270241.1
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727171180; x=1727775980; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VymbO4VKGrRhQ842pFUZ7n7JL91F7DEIZa8VhwbzAVc=;
 b=zb1CLNJl7lVtMHPlMr91VVSmZKzsYDcMHiV5MLtDQ1Dcx/Be2GQxPkwiH65lVAEIYA
 29kmHTslfs1vbEtEA0PHgqOqYlawChisx6P7KqSDG52fV03Gei4znqHXNR1/BJd2nfMs
 SmI4rLmrtRaN7xBc20UJxKGKqBzuwQVHmbgoOAwpzyR7mLjOR7HMc8Y3P51A1zvA3mkQ
 tGS0gW/kGiOvWTfl7Bne02Yk6JRwr67iAcTPsU/a2e7+RBTJ9WmSasRJ2jB+oWXZLtE3
 YbDBz21VOPqP3FywkxTE+rS+XtE40oQCttWnJWlwCki6x9tIFwoYmYOApnQgYZXIF0BS
 zInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727171180; x=1727775980;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VymbO4VKGrRhQ842pFUZ7n7JL91F7DEIZa8VhwbzAVc=;
 b=PBcMi3J/XyAAANhI3sCruTHXQPcvAzCPcn2SF5sGEPZNdGNV4gaDNhH7ncLNxt35XB
 J3UNpVuklzkC09UOEBojwXLQn8O8vF5zshKGMkBZAtU9CHzf4lWboybAwxU9TcNFmX+x
 ocwfZhttuoumc6Zhw/StnmOApKBmibk0G6mz3njMF0fPweB64RCoti+e10fN6k8XzSrT
 lnPYGV/6IFOIbqotYV7jWbQN5WOhqXC6JSzHK/AOEJig4u8QeeMM3+HivY5JahL9DZIb
 pLYYgw5KkyWw08s7uQaCBJaSAuFzS5ZKacXkSKvqnGDaNftJpACWOlkogNsQgy1Okavk
 T91Q==
X-Gm-Message-State: AOJu0Ywxy5aBZaizjltigYvgE54ntWp75kvQUh4iRwokbylPZyrZqLtx
 iC7FS/UwFpy8hbEPwKqr7Fyj3IVy31gkSMKny5cGChxStPDPK0kBil/uTn2Pqkq1cuCuAtsRG6M
 mt0t4IUA2eXApTxYrCONsorh6GknZMU5YATAcHbL2J1KXgfUi0uE=
X-Google-Smtp-Source: AGHT+IFW1lIEtdf54Ebt8HeFgkLUtAyOLGjTHkrA/Ct+9IgwP9rEU75K4d5gEKcpJrw2YljzTeCMRMcQ7LF26fCkpEw=
X-Received: by 2002:a05:6122:2914:b0:503:1bba:58df with SMTP id
 71dfb90a1353d-503e0422dbcmr8271763e0c.7.1727171180414; Tue, 24 Sep 2024
 02:46:20 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Sep 2024 15:16:09 +0530
Message-ID: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] af_alg01.c:36: TFAIL: instantiated nested hmac algorithm
 ('hmac(hmac(md5))')!
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The following LTP crypto tests failed on Linus mainline master branch.

LTP
  ltp-crypto:
    * af_alg03
    * af_alg01

First seen on e8fc317dfca9 (v6.11-2185-ge8fc317dfca9)
  Good: v6.11-rc7
  BAD:  e8fc317dfca9 (v6.11-2185-ge8fc317dfca9) and (v6.11)

Devices and qemu's:
  - dragonboard-410c
  - dragonboard-845c
  - e850-96
  - juno-r2
  - arm64
  - qemu-arm64
  - qemu-armv7
  - qemu-riscv64
  - qemu-x86_64
  - rk3399-rock-pi-4b
  - x15
  - x86_64

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
----------
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
tst_af_alg.c:46: TBROK: unexpected error binding AF_ALG socket to hash
algorithm 'hmac(hmac(md5))': EINVAL (22)

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf

HINT: You _MAY_ be vulnerable to CVE(s):

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806

...
tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
af_alg03.c:22: TFAIL: instantiated rfc7539 template with wrong digest size

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e57121d08c38


boot Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg03/log
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2

Test results history:
----------
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/
- https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/

metadata:
----
  git describe:  v6.11-2185-ge8fc317dfca9 .. v6.11-5002-g200289db261f
  git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git sha:  abf2050f51fdca0fd146388f83cddd95a57a008d  (v6.11)
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/
  toolchain: gcc-13

Steps to reproduce:
---------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/tux_plan

--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
