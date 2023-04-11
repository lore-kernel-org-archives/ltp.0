Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BDC77B6F
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 17:37:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A7293CC8EB
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 19:37:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88C623CA92F
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 19:37:17 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 91959600298
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 19:37:16 +0200 (CEST)
Received: by mail-vs1-xe31.google.com with SMTP id dg15so34464669vsb.13
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681234635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhDQvgwbEigeXXlhjN0Q22Hgc1o3hW4XorfhYiSjVOw=;
 b=wM0eU9iLTKS2qIwAZM91w9fyzPeNpHKK5in6tKFab7b8hwc1DfX2rk1esKdYhShKWr
 z6++KMS11Y3BY7X8+mYRdqbevzVHWtjam5+uWqDFEjhBXbE6pe1FXVQ0GVdPwIdoanuV
 uNT6git+LHi4jWXGsIpCXmY3sazX0UNtZAVVP2x83QHV9m4Kt3xN7AfNgBKnLyKqB7jo
 gwiiANyEFIKbSGVZCxUbvo/uQsuy42VBndU4t1lUMAJDf8qdl5SaLqaTGjRvroD5nu2l
 TWDWbGVc4OO3GEa4nAIrUAUqzGX/e/5BtYYPkx/xe4iWG+OGQRSaa8PeZHsCxkSx4DxG
 tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681234635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhDQvgwbEigeXXlhjN0Q22Hgc1o3hW4XorfhYiSjVOw=;
 b=IkokKvDI8xb7Ghf866FrDuVUU74zB6LXgg9bL9MIxjxdyWIdy/59HOBOBZA3p3jIkJ
 N1Ew1+8CgeZ3CWqA0MfhMa5pjal7PUXFIKUtRG6iHOksFlqx75ejrEfpVMh+w3jaqugx
 4yDeIVM7FTFJdE+Mo13OhPA7XONpRk3ddbPPyrHugS++b8PX72lIHD2Umy3nJiQOytcT
 nDVIV7htrvP2W/rFio+7Fwt0bnACedOEc8MF40mnBGDa2MiK0v8S1nxy0wzeGVNmAos0
 2IzPs0+0m43SSdKRe+28WQpGuF57vOM9uPMf1u8dWgJssJxBPZT+p8kIsFvK7JCfFKyp
 2f2w==
X-Gm-Message-State: AAQBX9egIb8fKMxVU2HRFpszMiBShBPAFWQXOY67H5VDUZ2MRGq6AxYb
 8I1RruyTmjoQHswWyb54e9q8vV+6uxSdZ0bUDZ3Uhw==
X-Google-Smtp-Source: AKy350YpuoPk7W++ajGy+qfyAsaan1Z7UNoHbZNPGVodEYE9qqPd4lFm1tkfjtHuOoVmq8hz4BUp9kM3Y3qx/OT3ZLk=
X-Received: by 2002:a67:d293:0:b0:416:2ad3:35ba with SMTP id
 z19-20020a67d293000000b004162ad335bamr8779166vsi.1.1681234634941; Tue, 11 Apr
 2023 10:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
In-Reply-To: <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Apr 2023 23:07:02 +0530
Message-ID: <CA+G9fYtvp+iu-hA0YnMuT9gVET+4VFuz7faGTUWfmY_=dPtzZg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 11 Apr 2023 at 22:15, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:
> >
> > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > Following LTP syscalls failed on the i386 and arm environments with
> > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > Embedded kirkstone.

<Trim>
> > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> > released in 20220930. There is already newer release 20230127.
> > Generally it's safer to test mainline kernel with LTP master,
> > but this fix has already been in the latest LTP release 20230127.
> > And this error has been later fixed with
> > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")
>
> Thanks for insite about the failed test investigations.
>
> >
> > @Naresh which LTP do you use for testing? It must be some older LTP :(.
>
> Our build system started running LTP version 20230127.
> I will keep you posted with the latest findings.

Few quick updates,
Do you see these failures on compat mode ?

Following regressions noticed with LTP version 20230127 on Linux next.

Regressions found on juno-r2-compat:
Regressions found on qemu_arm64-compat:

  ltp-syscalls/fcntl34
  ltp-syscalls/fcntl36
  ltp-syscalls/fcntl34_64
  ltp-syscalls/fcntl36_64

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl34.c:87: TINFO: write to a file inside threads with OFD locks
fcntl34.c:33: TINFO: spawning '18' threads
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl34.c:63: TBROK: fcntl(4, F_OFD_SETLKW, { 1, 0, 0, 1, 0 }): EINVAL (22)

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl34.c:87: TINFO: write to a file inside threads with OFD locks
fcntl34.c:33: TINFO: spawning '18' threads
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl34.c:63: TBROK: fcntl(4, F_OFD_SETLKW, { 1, 0, 0, 1, 0 }): EINVAL (22)

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl36.c:288: TINFO: OFD read lock vs OFD write lock
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl36.c:166: TBROK: fcntl(3, F_OFD_SETLKW, { 0, 0, 0, 4096, 0 }): EINVAL (22)

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl36.c:288: TINFO: OFD read lock vs OFD write lock
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl36.c:166: TBROK: fcntl(3, F_OFD_SETLKW, { 0, 0, 0, 4096, 0 }): EINVAL (22)

Test details links,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230411/testrun/16168516/suite/ltp-syscalls/test/fcntl36/history/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230411/testrun/16168516/suite/ltp-syscalls/test/fcntl34/history/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230411/testrun/16168516/suite/ltp-syscalls/test/fcntl36/log

Steps to reproduce:

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.41.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-arm64   \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2OGsEcyUv1ZWPkcY6bowUEt67EK/Image.gz
  \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2OGsEcyUv1ZWPkcY6bowUEt67EK/modules.tar.xz
  \
 --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2OFRZRfcnhLXEnzmi2qNYuD7o3k/images/am57xx-evm/lkft-tux-image-am57xx-evm-20230410193023.rootfs.ext4.gz
  \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters SHARD_NUMBER=10   \
 --parameters SHARD_INDEX=2   \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests ltp-syscalls   \
 --timeouts boot=30 ltp-syscalls=50


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
