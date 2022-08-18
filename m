Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBFBC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 05:09:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 898A53CA1D5
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 07:09:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 806113C6552
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 07:08:49 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEE5860048C
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 07:08:48 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id t21so278094uaq.3
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 22:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=3xGN6r96/Y1UiUO4lWP9TbgY3FFPBwWFs/DdheQ83B4=;
 b=CgMr98VAZsU7hxtZk5LBP2+2Rf29PoSETGDz9UKYWBu2wH79OqJafocKAbXj748Y/n
 BGpNlFmebHQ0035+iiP4KlLND6sfPvgq6JsXurhS/KeBP/TZ/rZTC+f+IuyaS5amthxY
 tDp31N9uZwqOdIx9UqJ3NCGKOJTgZHcZ6kr3AgeyQ0wyHJkBycs8Rn6hw0cJPEIfmobl
 8KeAzleYGxgAKo7fPbZrcqjKMhZu0DpRFMiJEpt7yeL15oRyckXDSfutP2yAWmeGLeSu
 xpieiNrvu+XQYum2XMa4pkpUfPGiXqrh22SE4YpZTZR5SCrnGlQmGbDp5qfErbf/CBYa
 GTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=3xGN6r96/Y1UiUO4lWP9TbgY3FFPBwWFs/DdheQ83B4=;
 b=fbjks9A8W+Mau63dcLW3bO6a2sl54yrZOcEQErsYjmNFr8cX1odSRGDI4qjH4Ej4s7
 MknsRaChHEE4XNQHo1iqNVbEpImyUzlRk+0qJNQ604OHN+v1QbZ3ZTNTVG4H3htmWTZy
 4GDe4bgFNRkxeBwH0EvmruIzudbv2kgzjq9AM2tQa2gLQ1Oslwef919qSYJyX08nMkvE
 QpDVUH51JEfDUDGsSPzt4KS6MWqSXedm3K1WP7Rt42F0tJmZDq68huc4nt/ym4/6K0d2
 FP6LwKCFZDefTbsYFNth6xc/9gbGJgw99F8mn7Zn2BLiTqvSC6YOCnPrb6hfHLjuHRNz
 KgqQ==
X-Gm-Message-State: ACgBeo1fLVRCsjvsoNJC6Mc1KbJWw2ggYJf7u53CTM9W122G3EWBkoBj
 piK2T274aK+q/6O86p1yTGo+kPbGI7ojrlo8Lns=
X-Google-Smtp-Source: AA6agR4aKYzgl1P30CWDx74JjkZx5OUiQp0wIs5OKU/ZlavM4hOD9hvTPStKy8BA+4yuUClhaoFQfQGADZ0ijRQSK5M=
X-Received: by 2002:a9f:2067:0:b0:387:984d:4a8e with SMTP id
 94-20020a9f2067000000b00387984d4a8emr473558uam.60.1660799327324; Wed, 17 Aug
 2022 22:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220817204015.31420-1-pvorel@suse.cz> <Yv2A9Ggkv/NBrTd4@magnolia>
In-Reply-To: <Yv2A9Ggkv/NBrTd4@magnolia>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Aug 2022 08:08:35 +0300
Message-ID: <CAOQ4uxjMEHYQwO25dhs5WtzbOkJcee0HofQDTT3cD-qXJn7xQw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] API: Allow to use xfs filesystems < 300 MB
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
Cc: automated-testing@yoctoproject.org, Eric Sandeen <sandeen@sandeen.net>,
 linux-xfs <linux-xfs@vger.kernel.org>, Joerg Vehlow <joerg.vehlow@aox-tech.de>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 18, 2022 at 2:59 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Aug 17, 2022 at 10:40:15PM +0200, Petr Vorel wrote:
> > mkfs.xfs since v5.19.0-rc1 [1] refuses to create filesystems < 300 MB.
> > Reuse workaround intended for fstests: set 3 environment variables:
> > export TEST_DIR=1 TEST_DEV=1 QA_CHECK_FS=1
> >
> > Workaround added to both C API (for .needs_device) and shell API (for
> > TST_NEEDS_DEVICE=1).
> >
> > Fix includes any use of filesystem (C API: .all_filesystems,
> > .format_device, shell API: TST_MOUNT_DEVICE=1, TST_FORMAT_DEVICE=1).
> >
> > Fixes various C and shell API failures, e.g.:
> >
> > ./mkfs01.sh -f xfs
> > mkfs01 1 TINFO: timeout per run is 0h 5m 0s
> > tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
> > mkfs01 1 TFAIL: 'mkfs -t xfs  -f /dev/loop0 ' failed.
> > Filesystem must be larger than 300MB.
> >
> > ./creat09
> > ...
> > tst_test.c:1599: TINFO: Testing on xfs
> > tst_test.c:1064: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> > Filesystem must be larger than 300MB.
> >
> > Link: https://lore.kernel.org/all/164738662491.3191861.15611882856331908607.stgit@magnolia/
> >
> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Dave, please next time remember there are other testsuites testing XFS,
>
> Dave?? <cough>
>

TBH, it is not about remembering, it is about running integration tests
that catch these test bugs.

Obviously, xfsprogs maintainer (Eric) is running fstests before an
xfsprogs release, but I cannot blame Eric for not running the entire
LTS test suite for xfsprogs release...

I suppose that the bots running LTP on rc kernels might want
to consider also running LTP with rc xfsprogs/e2fsprogs/...
otherwise, those bugs would be caught when *progs hits a distro
that is used to run LTP.

> > not just fstests :). How long do you plan to keep this workaround?
>
> Forever.  In the ideal world we'll some day get around to restructuring
> all the xfstests that do tricky things with sub-500M filesystems, but
> that's the unfortunate part of removing support for small disks.
>

If it's forever, then it should probably have been a command line option.
IIUC, the motivation was to discourage users from formatting too small
filesystems, but if users have a way to do it, they will find it anyway.

Petr,

Notice that the fstests hack was needed for fstests that require MAX fs size,
while the existing LTP lib and tests only have MIN dev size requirement.

> Most of the fstests don't care about the fs size and so they'll run with
> the configured storage (some tens or millions of gigabytes) so we're
> mostly using the same fs sizes that users are expected to have.
>
> > LTP community: do we want to depend on this behavior or we just increase from 256MB to 301 MB
> > (either for XFS or for all). It might not be a good idea to test size users are required
> > to use.
>

For most LTS tests, all you need to do is increase the default (DEV_MIN_SIZE)
from 300MB to 301MB so that's not worth doing any workarounds.

For the 3 memcontrol tests that require dev_min_size = 256 and run on
all_filesystems, it does not look like changing min size is needed at all.

For squashfs01 the xfs limitation is irrelevant, but generally,
If the test min requirement (1MB) is smaller than the lib default,
DEV_MIN_SIZE still meets the test requirement, so why bother
going below the lib default DEV_MIN_SIZE?

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
