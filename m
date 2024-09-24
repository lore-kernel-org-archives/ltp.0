Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A9ECF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 11:23:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E8543C4C9A
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 13:23:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AFEE3C4BE6
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 13:23:34 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F41BF600C94
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 13:23:32 +0200 (CEST)
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-502af8a83daso1674364e0c.1
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 04:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727177011; x=1727781811; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KjdEl0kfRqlw8okFJhhXvORQBqugd848yp2a6Kz7jtI=;
 b=QTjj/cQv5i93ja4+x2PCENuqEYjQJ6EycyaxJUk5vni+HaNjnoY4lS9E6hGjzvBvxt
 g2yLRWVnw+IDJXUNhnW9+kxh80QjPYwx5nMECy4OL4y/5KSBTThHcdMWzGVNBBgMQg8i
 Nf1aByRxVi02yc5iUivddThkEvxvKwc08nEYR2YrIzBk+DhrQufrdzrVmapHZ1dKbdVT
 1WTJDGFghum8BooJ2PReFHUOdRNS8Ej3eU9CAt1504jDV49u3D6CFxy+TkgEMDz4Kpf3
 0Lpn/SoZQ2LFK4OK4CPxtZb4Phs9i85dC5wB761yMh11SacLJudeJ2BFatAKyMzrraAK
 o2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727177011; x=1727781811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KjdEl0kfRqlw8okFJhhXvORQBqugd848yp2a6Kz7jtI=;
 b=gszEV+G3nG1J5OXr6dD2uAeiASdYSA2vGGf7Ot1rmtEL9d04nFWjenn5KAMBTkwRZo
 vUOSSLhDkC78wDUxYcA0xZHhLexGPnS83IeNGctPaQDK+xF5NupQY8u1riwcgbKXO/K4
 wSBTIGTDtYtW2jnFOwu3R5lRQfT7JBauZzz9Yv4V4/T5y5pvODaOsNF845EIGzlZAP0Y
 cEDxyrVot22hqpC4Fzc+k8Du/ldM3bqADMI+jk2Vj6VH/B5VKBDF57VuAWK07HCufOPy
 H2E74KUuqhAurpmUcg7kQpesoPdLFY2B9ILW+EddgJkf6CQQ0gOSoyX877ZX+qg2ot54
 Ssng==
X-Gm-Message-State: AOJu0YzMimU+AIFjvdpq4i4xxwY64ymT9OQIIa0XLsFqIFxKYMsgagG1
 uOkYGKmdR1BxNUbSdRbtTIi24aXbjVbdsAf4ItvIdO/4DwYMbaMBDtL/m3eyO69L4ImUMJlw12d
 kvIdo+kXsWaizHYwWRcFDri0KNkbYlNZWyi3p/2Z958nv3Zy8X3w=
X-Google-Smtp-Source: AGHT+IEI7XjbuorHGWTR1E3X/+r/7ORf73vJlzjELjbAYRDPDVaPLPO0nhzOjurzdZrh5ZpFYfyg/8r0kv6TUteT69Y=
X-Received: by 2002:a05:6122:2213:b0:503:d875:6a26 with SMTP id
 71dfb90a1353d-503e0400c97mr9329354e0c.5.1727177011299; Tue, 24 Sep 2024
 04:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
In-Reply-To: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Sep 2024 16:53:18 +0530
Message-ID: <CA+G9fYsHQ_q9e5GYVpdMmaRrgR1zvoyFH0wP0RzbqUFBTuNq9Q@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 lkft-triage@lists.linaro.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] af_alg01.c:36: TFAIL: instantiated nested hmac algorithm
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

On Tue, 24 Sept 2024 at 15:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following LTP crypto tests failed on Linus mainline master branch.
>
> LTP
>   ltp-crypto:
>     * af_alg03
>     * af_alg01
>
> First seen on e8fc317dfca9 (v6.11-2185-ge8fc317dfca9)
>   Good: v6.11-rc7
>   BAD:  e8fc317dfca9 (v6.11-2185-ge8fc317dfca9) and (v6.11)

Also seen on Linux next from next-20240909 tag.

Good:  next-20240906
Bad:   next-20240909

>
> Devices and qemu's:
>   - dragonboard-410c
>   - dragonboard-845c
>   - e850-96
>   - juno-r2
>   - arm64
>   - qemu-arm64
>   - qemu-armv7
>   - qemu-riscv64
>   - qemu-x86_64
>   - rk3399-rock-pi-4b
>   - x15
>   - x86_64
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Warning log:
> ----------
> tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
> tst_af_alg.c:46: TBROK: unexpected error binding AF_ALG socket to hash
> algorithm 'hmac(hmac(md5))': EINVAL (22)
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf
>
> HINT: You _MAY_ be vulnerable to CVE(s):
>
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3ff8045bbf
>
> HINT: You _MAY_ be vulnerable to CVE(s):
>
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-17806
>
> ...
> tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> af_alg03.c:22: TFAIL: instantiated rfc7539 template with wrong digest size
>
> HINT: You _MAY_ be missing kernel fixes:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e57121d08c38
>
>
> boot Log links,
> --------
>  - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg03/log
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2
>
> Test results history:
> ----------
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/
> - https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.11-8836-gf8eb5bd9a818/testrun/25191971/suite/ltp-crypto/test/af_alg01/history/
>
> metadata:
> ----
>   git describe:  v6.11-2185-ge8fc317dfca9 .. v6.11-5002-g200289db261f
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git sha:  abf2050f51fdca0fd146388f83cddd95a57a008d  (v6.11)
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m980TaGzPk0qjtFUPnMNoDj7Sw/
>   toolchain: gcc-13
>
> Steps to reproduce:
> ---------
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/reproducer
> - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2m983y1hatxwkXBtrAYvCPw6pK2/tux_plan
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
