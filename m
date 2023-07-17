Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C93BEB64DC
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 05:06:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32AE03CDDC4
	for <ltp@archiver.kernel.org>; Mon, 17 Jul 2023 07:06:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 526503C99AE
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 07:06:19 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E2ACF14002BB
 for <ltp@lists.linux.it>; Mon, 17 Jul 2023 07:06:18 +0200 (CEST)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4816db26ff1so875638e0c.2
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 22:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689570377; x=1692162377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xR7Jh7BXNDpu6+2aiq3ZuVrs5oBNof862oaaEGT22kE=;
 b=K/GmCjSqOYm0KWCBJgUAzYKSJMgtUbsQgdm3le7BCDDPkafCvqTGFvy/h05nnECb3A
 SXiLbd98PE5p0DHBkyrJHpnDi4u8V/Ls+0mW2DiZhRHrvaogGxeZH67R9I+WAMJaY50P
 8pej23rGRTwODqWQEVMMd1SMgtf10FCgibO2twTrOfGxcA/8g0nHbKKUFsBcTh+V0Iua
 kC+e+RKVSmL1ADafHew0B8wA2cozddQug8Fh9JDB0Bgqwh2ShRBoMalH9pf9DIAzi8r+
 31R2cmR6rsERPaezQDdv3EKRM4/jjsqC84/StexZJTLhJli4BYahal7F2Yfdu16GcEyH
 7zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689570377; x=1692162377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xR7Jh7BXNDpu6+2aiq3ZuVrs5oBNof862oaaEGT22kE=;
 b=H9dZCdDcRIQrr2vs+B6bKleNpsi1tAgpW3qo+b0BljLj7fWxrShUlg5VLvz2N1f7O2
 nIS//zWbQW2jtZa6kgFa2GRVp3Nl2pd/ve9c1AWaBWMbA77jAHjfiAJ4qwYy69PrR7/d
 wj8tq9MiW5w3xWjEZN4azndbTzyE5l8Wr91U/IBE90rciWe0mEhVTTg94sTRE0cH1jGC
 +ZRoEo7CKbKhkHLCNE/9KS9wcRABFEg6BIWHdT/FQK55aKWjBQLF3P4/5+eTEw1ONpiG
 2TqzZDN0uvYXvpaHN8/0ipi5hzs48cX15J1RFtgI68FVkkwgZNqvMRq4gh/1RIfz3FIX
 lycQ==
X-Gm-Message-State: ABy/qLaU1lyQwdXZyEri0PVFaWVkxm2L13iNXLILQ7BuCtvIYO5HOvnn
 kRSeUgNFuPGxbRKaMXsoVqSFXRp+y5sCieMKOCRSLg==
X-Google-Smtp-Source: APBJJlFtxcetEBCc4TSfgqF8xL/QIBSc2Drf5I8jWvVjy2toUPb9CBtwXYjXn2M9Pxxq/5xt2wL5YpHpWjFpfJPf2Vg=
X-Received: by 2002:a67:fd7b:0:b0:444:17aa:df60 with SMTP id
 h27-20020a67fd7b000000b0044417aadf60mr5035406vsa.13.1689570377332; Sun, 16
 Jul 2023 22:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
 <20230717043111.GA3842864@mit.edu>
In-Reply-To: <20230717043111.GA3842864@mit.edu>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 17 Jul 2023 10:36:06 +0530
Message-ID: <CA+G9fYukSUuNV5usVC1Zmq7uqxu5w2g8dTHgV9WUAA=nGBk20w@mail.gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: kernel BUG at fs/ext4/mballoc.c:4369!
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
Cc: Arnd Bergmann <arnd@arndb.de>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 17 Jul 2023 at 10:01, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Jul 16, 2023 at 11:32:51AM +0530, Naresh Kamboju wrote:
> > Following kernel BUG noticed while testing LTP fs testing on x86_64
> > arch x86_64 on the Linux next-20230716 built with clang toolchain.
>
> Hmm, I'm not seeing the next-20230716 tag at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>
> or
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/
>
> I see a tag for next-20230717 and for next-20230714, but not
> next-20230716.  Was this a typo?  Does it reproduce on the
> next-20230717 tree?

Sorry it is a Typo,
Here is the kernel version, 6.5.0-rc1-next-20230714

>
> Also, since I don't use LTP, can you give me a trimmed-down
> reproducer, to save me some time?

Boot images for x86_64,
I have defconfig + test KConfigs.

   kernel:
      url:
        https://storage.tuxsuite.com/public/linaro/lkft/builds/2SY3QjxEGsLoae4uGpfjPnZqwKC/bzImage
    modules:
      url:
        https://storage.tuxsuite.com/public/linaro/lkft/builds/2SY3QjxEGsLoae4uGpfjPnZqwKC/modules.tar.xz
    nfsrootfs:
      url:
        https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2SPaZ6KtLE32NNDGqKrHtwJJz1g/images/intel-corei7-64/lkft-console-image-intel-corei7-64-20230711051126.rootfs.tar.xz


Build and install LTP:

# git clone https://github.com/linux-test-project/ltp.git
# cd ltp
# make autotools
# ./configure
# make
# make install

Connect external newly formatted SSD drive via USB and mount.
This drive will be used by LTP at run time to create temporary test files.


Run LTP

  cd /opt/ltp/
  ./runltp -f fs - d /mount/SSD-external-storage-drive


ref:
 - https://github.com/linux-test-project/ltp

- Naresh

>
> Thanks!!
>
>                                         - Ted

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
