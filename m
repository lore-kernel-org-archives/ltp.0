Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70855ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 16:58:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EB553CABF2
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 17:58:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5480C3CA9F0
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 17:58:20 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8C80B600671
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 17:58:19 +0100 (CET)
Received: by mail-il1-x132.google.com with SMTP id q18so6491807ils.12
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 09:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h85+z6gmk+bJnwdgDK+F1hghAg2PgdjR2eRcuA3j7sw=;
 b=ZK4aEe7ClNxtTwXg9EKDFSwcxcP0KFXmSS4ycvzYuezA0VhAmj57Y+h4GDOmB53hFx
 WEaYfFvkf22Z4cLes4vS8mlPmpwa4FA/BOH7xiIkqN3dg/Hd1um6Z0GPMmzK+XJq1ibO
 EQfhh3rznebw7cevkHa3Zk36CE8eB+jCslpQp2tzZt89a//o1oi+byCEcxBEraO7G07D
 koyrynTrM/Bavm+9j3ow/dzL7U7iFy5oNb07G1ep6gMfvm3IC5CClni8iGJ3cXcv/jEb
 uX39we68ipS0RhcyNKyezImuj9OHY+9GlRPNEvq5ZWZ6cMHEZa5M35tx2maLJUlegB0c
 ekiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h85+z6gmk+bJnwdgDK+F1hghAg2PgdjR2eRcuA3j7sw=;
 b=7g8B2j8BeLnNEkPt8JlCfoX9g1Tesn1Bl68QQUT49AztUzN+CduCGQpc/lthmaa0iP
 RwjQNCM5e0pODwjkLjbnB4czqM3h5KpuKWue2vt4EJFF5fgI/kueiUQnuHnA7qTI1JUv
 QMwgP0sYeE/z7Meh/On5YOT2XegyG/RVLlJsAqMVHHkAcRtbI8wfP/GBJnljgx0kf81a
 gdH/yatOOHfJ0GKNcB+frjp6RLXdSEggS56AZ+1lT92rmwyENCv3D6QtRwPK3CgwG+YZ
 2eqn307tm6wD0kii834hBg8M5zN8xQoYYCh5cHzSJL/Fksew2cyuK3wN9f4YheelVgvX
 LlaA==
X-Gm-Message-State: ACrzQf2dWo0FFrVWl4Yg4dIiWdSeU2FeactaKTBW7Re1B8D8k4Jzuwkz
 mbtl7PcHzrOIK3MtinTfWlYnQcLV3wF1dh8ThMA=
X-Google-Smtp-Source: AMsMyM7uH2TaFj40zPvj2NMl/IGbidrR1TriJo5SVzrIUIw7jk10b8ATymGMGHF8SXuKmg9ngldmuEzsTkjr1k5NYbc=
X-Received: by 2002:a05:6e02:14c4:b0:300:99b4:47f1 with SMTP id
 o4-20020a056e0214c400b0030099b447f1mr5782013ilk.8.1667235498082; Mon, 31 Oct
 2022 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221026140408.471609-1-alessandro.carminati@gmail.com>
 <20221026140408.471609-2-alessandro.carminati@gmail.com>
 <87fsf9sk2e.fsf@suse.de>
 <CAPp5cGQ++39EMSV3MrMTTKrTyn5WWRou=yP7f4jbBQ7p-F+cyA@mail.gmail.com>
 <87y1swb1bv.fsf@suse.de>
In-Reply-To: <87y1swb1bv.fsf@suse.de>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 31 Oct 2022 17:57:41 +0100
Message-ID: <CAPp5cGQFW5xBq+DPkFGQfHd1yzMHrzb5mLtZG-pdRe2Fwz49Ng@mail.gmail.com>
To: rpalethorpe@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Richard,

Il giorno lun 31 ott 2022 alle ore 13:54 Richard Palethorpe
<rpalethorpe@suse.de> ha scritto:
>
> Hello,
>
> Alessandro Carminati <alessandro.carminati@gmail.com> writes:
>
> > Hello Richard,
> >
> > Il giorno gio 27 ott 2022 alle ore 11:16 Richard Palethorpe <rpalethorpe@suse.de> ha scritto:
> >
> >  Hello,
> >
> >  Alessandro Carminati <alessandro.carminati@gmail.com> writes:
> >
> >  > In some minimal Linux the /dev/root can be missing. The consequence for this
> >  > is that mountinfo doesn't contain the correct information.
> >  >
> >  > The unevent file in sysfs is another method to retrieve device info given
> >  > a major/minor.
> >  >
> >  > btrfs subvolumes can be an exception to this rule, but they are not expected
> >  > to be used in the current usecase.
> >
> >  Unfortunately this is not true. If you mount /tmp on BTRFS (or set
> >  TMPDIR to some BTRFS mount), then we hit this issue.
> >
> > This is also true if you use the mountinfo strategy.
> > I ran a few tests on my test environment, and I could see that the ioctl_loop05
> > on btrfs filesystem doesn't work either with the mountinfo strategy.
>
> OK, so to summarise niether strategy works when the FS is BTRFS and init
> has not done something about /dev/root.
>
> I suppose part of the problem is BTRFS can span multiple devices
> (IIUC). So there is no definite single backing device.
>
> The command "btrfs devices stat <path>", uses the BTRFS_IOC_DEV_INFO
> ioctl to get backing device paths.

Yes, use the ioctl could be a solution for btrfs.
I ran a little test to understand what filesystem I can expect.
ioctl_loop05 is supported on a few filesystems, I tried listing them,
and on a few, I run the test:

| Filesystem    | tested | notes
+---------------+--------+----------------------------
|nfs            | no     | not tested, no idea.
|9p             | no     | not tested, no idea.
|ramfs          | no     | theoretically possible to have root on
ramfs, but I think it very unlikely
|btrfs          | yes    | both strategies have problems with it.
|xfs            | yes    | tested ok.
|ext2/ext3/ext4 | yes    | tested ok.
|minix          | yes    | max size is 64MB, possible but not
probable. Stat on mounted fs shows minor/major corresponding to
backend device.
|udf            | no     | optical media filesystem. Very unlikely to
have it as root filesystem. Stat on mounted fs shows minor/major
corresponding to backend device.
|sysv           | no     | not tested, no idea.
|ufs            | no     | not tested, no idea.
|f2fs           | yes    | tested ok.
|nilfs          | yes    | tested ok.
|exofs          | no     | it has been removed from kernel supported
FS since 5.1
|fuse           | no     | Unlikely.
|vfat           | no     | I'm not aware you can mount vfat as rootfs.
Since it lacks on a lot of features, it is unlikely having it as
rootfs.
|exfat          | no     | not tested, no idea.

It seems to me likely that btrfs is the only filesystem, among the
supported, that can present virtual devices with different
minor/major.
I'm not 100% sure, but I would bet on the fact that we can identify
these btrfs scenarios just by looking at the major number. If it is 0
we are dealing with it.
That been said, if major == 0 we can extract the backing device by
using the ioct, as you suggested:
        struct btrfs_ioctl_dev_info_args di_args = {0};
        ioctl(fd, BTRFS_IOC_DEV_INFO, &di_args)
and use di_args.path

Do you see any downside on such approach?

>
> >
> >  >
> >  > This solution requires sysfs to be mounted in /sys, but considering many
> >  > tests depends on the same, including the ioctl_loop05 that triggered this
> >  > patch, this requirement is not too restricted, and the old mountinfo can be
> >  > dropped altogether.
> >
> >  The mountinfo method is not such a maintenance issue that it needs to be
> >  removed IMO. Possibly it could be replaced by tst_stat_mount_dev
> >  instead, but we're cautious about touching this function.
> >
> > tst_find_backing_dev(), the function that is the target of this patch, seems to
> > be referenced in only a couple of points in all the LTP test suite.
> > One place is in the ioctl_loop05 test, the other reference I found is in the
> > lib/tst_device.c - tst_dev_block_size().  tst_dev_block_size() is a function
> > that seems not to be referenced by any test.
> >
> >
> >  To be clear, I'm not sure anyone compiles Linux without /sys then tries
> >  to run LTP on it. However the fact that it is possible to remove /sys is
> >  another signal (in addition to BTRFS) that the situation is complicated.
> >
> > Indeed, if we want to have a test that works in all the possible scenarios,
> > it needs additional work.
> > But IMHO, keeping the mountinfo strategy gives no advantage over not
> > having it.
> >
>
> Well it allows the test to work on BTRFS in most situations. Possibly if
> we find that the FS is BTRFS, the device is /dev/root and it doesn't
> exist. Then we should call tst_brk(TCONF...
>

I ran a multiple tests with btrfs, and the mountinfo strategy.
I didn't find a single scenario where it succeded.
In my situation I always had that the backend device presnted a
different couple minor/major with the one listed by mountinfo.
Could you suggest a btrfs scenario where the mountinfo strategy ends
with success?

> AFAICT what the test actually wants is the block device sector size
> (BLKSSZGET). Possibly this can be retrieved with the BTRFS_IOC_FS_INFO
> ioctl.
>
> The final option would be to try using some other BTRFS specific ioctl
> to get the backing device(s). If there is more than one then just return
> the first. That's probably not worth the effort for the current test,
> but I think it is quite likely this issue will arise again. io_control01
> has a similar requirement.
>
> --
> Thank you,
> Richard.

Cheers
Alessandro Carminati

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
