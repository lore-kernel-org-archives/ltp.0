Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C274EC43334
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 09:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADF773C959C
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:08:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DC9A3C8CE5
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:08:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A4B31002870
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 11:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658221691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vXIEgnvxa800NciCyURRWMvn9prpzYd23xCT4lmbFG8=;
 b=WrQyBFoEySfzWbN1qI+gOlVjLKaFfgjTdmLpyjkEuYegPRlS7HeuiavYGf+5l7QQHJO+iZ
 jKvBgna3YUaJ6xr2qMCfkpMV3XLFFf+b+Xrl83jhlEhm7C6VFJInpOvRli1BZ4J/2rZThD
 lvDYee1ZCbRlQFj9aKhx51zLfz0mEIQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-km3f5PDYNBarhHHu5lhcWg-1; Tue, 19 Jul 2022 05:08:10 -0400
X-MC-Unique: km3f5PDYNBarhHHu5lhcWg-1
Received: by mail-lj1-f199.google.com with SMTP id
 v14-20020a2e9f4e000000b0025d5c8bf473so2452516ljk.6
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 02:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vXIEgnvxa800NciCyURRWMvn9prpzYd23xCT4lmbFG8=;
 b=iywt4XW7eL0o+0RBUO7WUNW8Bxngt8iyxFPrFOPV045JMdKjUezTnSiB5BbK6GhQoo
 Rz0++BBgsDy1PDd1OovI4mJ52yWRGWGvfPdoPiiuxVByS7bF61q8JkPbaXoDZIl7G1PN
 Fu9fzmthnIy+FefXQQNXsGryJCkChSbjj65P/Ruc74OiU3XrmJf4yz2v4KquaFFnDB1P
 uhtoewkcVhl63fc6Htl3jy3otd/YNpzfPXYOCcqptpuOQPdTGF3ExwGMunZSPUTx2G4x
 nyaTvyw4kT6tZb5Kcxk0WJ7bPAARW3LdluSxx6bWeuKrE0CBaGmVjAk1aS0zhwBX+SLK
 ijqA==
X-Gm-Message-State: AJIora/7LDSlAuKcFrz51O/zQwduR9kiQmfe9tnhJzuRUqLXYZpg0m8f
 aE6d7TbyCe+NPTuWUzNnlLsjqzbvizgleXxuhixQfNKeDXJeR4QKmWt3wwSorAK7nI1hK7Nbo9b
 qGD40wiqJhOQsYv5G6ia2OD4EPl4=
X-Received: by 2002:a2e:9bd6:0:b0:25d:8712:64f6 with SMTP id
 w22-20020a2e9bd6000000b0025d871264f6mr13953290ljj.337.1658221689028; 
 Tue, 19 Jul 2022 02:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vtCQD7lWcOhYe+EQCjo59zzVQ6wDb1OPUBppenZhTTEvbzhTq3ob5PwNBdVwBJdMj9d/oa35/aabfoflYALPM=
X-Received: by 2002:a2e:9bd6:0:b0:25d:8712:64f6 with SMTP id
 w22-20020a2e9bd6000000b0025d871264f6mr13953279ljj.337.1658221688532; Tue, 19
 Jul 2022 02:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
 <87fsj7onim.fsf@suse.de>
 <CAASaF6yQTmak7p5JZJFvBd-+qLsHNvimg7HvRQQQH9vjWGOMXg@mail.gmail.com>
 <87bktvokfl.fsf@suse.de>
In-Reply-To: <87bktvokfl.fsf@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jul 2022 11:07:51 +0200
Message-ID: <CAASaF6yxNF9fuOrjDcB4qngpgeBJ3LthdoW3HSzTdSCALGjnoQ@mail.gmail.com>
To: rpalethorpe@suse.de
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_find_backing_dev: fix logic in matching mount
 point
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jul 11, 2022 at 3:21 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> Jan Stancek <jstancek@redhat.com> writes:
>
> > On Mon, Jul 11, 2022 at 2:13 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >>
> >> Hello,
> >>
> >> Jan Stancek <jstancek@redhat.com> writes:
> >>
> >> > If backing dev is btrfs root device, then starting best_match_len
> >> > from 1 creates an issue, because root (/) is never matched.
> >> > Also we should check that entire mount point string is present in
> >> > path we are matching against.
> >> >
> >> > In case there's error also dump /proc/self/mountinfo before tst_brk.
> >> >
> >> > This fixes test with following partition layout (TMPDIR is on /):
> >> >   # cat /proc/self/mountinfo  | grep btrfs
> >> >   59 1 0:29 /root / rw,relatime shared:1 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=257,subvol=/root
> >> >   93 59 0:29 /home /home rw,relatime shared:47 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/home
> >> >
> >> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> >> > ---
> >> >  lib/tst_device.c | 17 ++++++++++++-----
> >> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> >> > index c34cbe6d1f56..414bf0eea816 100644
> >> > --- a/lib/tst_device.c
> >> > +++ b/lib/tst_device.c
> >> > @@ -506,12 +506,17 @@ unsigned long tst_dev_bytes_written(const char *dev)
> >> >       return dev_bytes_written;
> >> >  }
> >> >
> >> > -static int count_match_len(const char *first, const char *second)
> >> > +static int str_starts_with(const char *str, const char *prefix)
> >> >  {
> >> >       int len = 0;
> >> >
> >> > -     while (*first && *first++ == *second++)
> >> > +     while (*prefix) {
> >> > +             if (!*str)
> >> > +                     return 0;
> >> > +             if (*str++ != *prefix++)
> >> > +                     return 0;
> >> >               len++;
> >> > +     }
> >>
> >> I'm not sure this is better than the original. It's a seperate cleanup
> >> in any case.
> >
> > The difference is that partial matches now returns 0. Previously it did not,
> > it only counted number of matching characters. So for example ("/foobar" "/foo")
> > appeared as better match than ("/foobar", "/")
>
> Ah, sorry.
>
> >
> >>
> >> >
> >> >       return len;
> >> >  }
> >> > @@ -524,7 +529,7 @@ void tst_find_backing_dev(const char *path, char *dev)
> >> >       char *pre = NULL;
> >> >       char *next = NULL;
> >> >       unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> >> > -     unsigned int len, best_match_len = 1;
> >> > +     unsigned int len, best_match_len = 0;
> >> >       char mnt_point[PATH_MAX];
> >> >
> >> >       if (stat(path, &buf) < 0)
> >> > @@ -550,7 +555,7 @@ void tst_find_backing_dev(const char *path, char *dev)
> >> >                       break;
> >> >               }
> >> >
> >> > -             len = count_match_len(path, mnt_point);
> >> > +             len = str_starts_with(path, mnt_point);
> >> >               if (len > best_match_len) {
> >> >                       strcpy(dev, pre);
> >> >                       best_match_len = len;
> >> > @@ -559,8 +564,10 @@ void tst_find_backing_dev(const char *path, char *dev)
> >> >
> >> >       SAFE_FCLOSE(NULL, file);
> >> >
> >> > -     if (!*dev)
> >> > +     if (!*dev) {
> >> > +             tst_system("cat /proc/self/mountinfo");
> >> >               tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> >> > +     }
> >> >
> >> >       if (stat(dev, &buf) < 0)
> >> >               tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> >> > --
> >> > 2.27.0
> >>
> >> Makes sense. However I suspect this function can be replaced with the
> >> standard library method used in tst_stat_mount_dev. I didn't try this
> >> before because I'm not sure why it scans mountinfo instead of mounts.
> >
> > /proc/self/mounts doesn't contain major/minor numbers, which is primarily what
> > tst_find_backing_dev is using.
>
> Does anyone know a situation where checking the mount path doesn't work?

You could mount multiple times to same mount path, which would make it harder
to find the right one.

> It seems like we are just checking the device numbers first for
> historical reasons and not because it is necessary.

Device numbers seem slightly less ambiguous.

>
> I haven't seen any failure reports for io_control01 which only checks
> the path with tst_stat_mount_dev. However this test only runs if you
> have CG v2 enabled by default.
>
> >
> >>
> >>
> >> --
> >> Thank you,
> >> Richard.
> >>
>
>
> --
> Thank you,
> Richard.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
