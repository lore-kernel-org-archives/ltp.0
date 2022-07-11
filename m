Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD6CC43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 13:05:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 250C13CA6BB
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 15:05:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA30D3CA34D
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 15:05:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E46EF60076C
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 15:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657544701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pGAKg4Tw/IuQOSFV4afuYhKig65I5WPDnEV68Dg4cM=;
 b=DOY0sfI5Jc3vVdlwKeseXne2NN2+6ieQL1nDTl8r5dtFQZqV4/D6zXHKZPN//Ya/jnOHqk
 zAIA7uT2n7RiN2htqLEPpnH/1x+jP4Ixckf46i71AyF74VsvGD+akSb2V0xJTVlOr1niFr
 D7q/VdC78Uq3heWAFzXCfwMU6uEO6xg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-9MohWiHyN8qAcqoJBxt0Qw-1; Mon, 11 Jul 2022 09:05:00 -0400
X-MC-Unique: 9MohWiHyN8qAcqoJBxt0Qw-1
Received: by mail-lj1-f197.google.com with SMTP id
 r7-20020a2eb607000000b0025d547f19c4so882150ljn.11
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 06:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+pGAKg4Tw/IuQOSFV4afuYhKig65I5WPDnEV68Dg4cM=;
 b=k4XRGzCQZ3WW4m7sgRSxuftCF303REX/nCGr+QIajKNM41Ti6N8EQWWJQK/AkvbgIW
 c2fo4S2UjHYKpXc1BOzs/+3ssrhwLeZuk8g313Z5wRBJzxzoNvOo3f2vstzgh4bD7fSh
 RHSaiMpgo9lnuPofTzutFdzuG581XH1hQiyma7uwfZJ4+0rQEogrsuFB96ZrNTpKvxHm
 8B01yEJ90BRA9MeuzyfjrCW9IVYKbUfsucKurZjeGgJjqE09T7zV7DEi/sMvcWRAakWN
 cW1oxufKcvk9dvuvrw2B8Rw8LrifJtynEmLHqMMe8M3f7CJ1IKCYP/4cDO6GeRFiC6TK
 K/nA==
X-Gm-Message-State: AJIora9CNobZDHkkQ/65vdwNCzuopD85oesiASqbMVBoOJR3OROAUfNd
 i6G7TrNMJI1K6nGk4p4+4uLCT3xaEJbKUP+9o3cis6X4NOZr2xjuoYf78nsnMbsPK1Y3NoKX6uX
 TDN7JTV6o2pIwvepLkTg8DINTU1I=
X-Received: by 2002:a05:6512:3f27:b0:47f:a079:eeec with SMTP id
 y39-20020a0565123f2700b0047fa079eeecmr11281118lfa.46.1657544698575; 
 Mon, 11 Jul 2022 06:04:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8XN4g7B0d7Oo96RlgwdPvVg+vrMe5AC1xy+6ecbDROnR0RizEkDe/tVsGVI1XCNJ6ixVBx9ks1zs8sRjdcmo=
X-Received: by 2002:a05:6512:3f27:b0:47f:a079:eeec with SMTP id
 y39-20020a0565123f2700b0047fa079eeecmr11281096lfa.46.1657544698325; Mon, 11
 Jul 2022 06:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
 <87fsj7onim.fsf@suse.de>
In-Reply-To: <87fsj7onim.fsf@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2022 15:04:41 +0200
Message-ID: <CAASaF6yQTmak7p5JZJFvBd-+qLsHNvimg7HvRQQQH9vjWGOMXg@mail.gmail.com>
To: rpalethorpe@suse.de
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On Mon, Jul 11, 2022 at 2:13 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> Hello,
>
> Jan Stancek <jstancek@redhat.com> writes:
>
> > If backing dev is btrfs root device, then starting best_match_len
> > from 1 creates an issue, because root (/) is never matched.
> > Also we should check that entire mount point string is present in
> > path we are matching against.
> >
> > In case there's error also dump /proc/self/mountinfo before tst_brk.
> >
> > This fixes test with following partition layout (TMPDIR is on /):
> >   # cat /proc/self/mountinfo  | grep btrfs
> >   59 1 0:29 /root / rw,relatime shared:1 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=257,subvol=/root
> >   93 59 0:29 /home /home rw,relatime shared:47 - btrfs /dev/dasda2 rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/home
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  lib/tst_device.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index c34cbe6d1f56..414bf0eea816 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -506,12 +506,17 @@ unsigned long tst_dev_bytes_written(const char *dev)
> >       return dev_bytes_written;
> >  }
> >
> > -static int count_match_len(const char *first, const char *second)
> > +static int str_starts_with(const char *str, const char *prefix)
> >  {
> >       int len = 0;
> >
> > -     while (*first && *first++ == *second++)
> > +     while (*prefix) {
> > +             if (!*str)
> > +                     return 0;
> > +             if (*str++ != *prefix++)
> > +                     return 0;
> >               len++;
> > +     }
>
> I'm not sure this is better than the original. It's a seperate cleanup
> in any case.

The difference is that partial matches now returns 0. Previously it did not,
it only counted number of matching characters. So for example ("/foobar" "/foo")
appeared as better match than ("/foobar", "/")

>
> >
> >       return len;
> >  }
> > @@ -524,7 +529,7 @@ void tst_find_backing_dev(const char *path, char *dev)
> >       char *pre = NULL;
> >       char *next = NULL;
> >       unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> > -     unsigned int len, best_match_len = 1;
> > +     unsigned int len, best_match_len = 0;
> >       char mnt_point[PATH_MAX];
> >
> >       if (stat(path, &buf) < 0)
> > @@ -550,7 +555,7 @@ void tst_find_backing_dev(const char *path, char *dev)
> >                       break;
> >               }
> >
> > -             len = count_match_len(path, mnt_point);
> > +             len = str_starts_with(path, mnt_point);
> >               if (len > best_match_len) {
> >                       strcpy(dev, pre);
> >                       best_match_len = len;
> > @@ -559,8 +564,10 @@ void tst_find_backing_dev(const char *path, char *dev)
> >
> >       SAFE_FCLOSE(NULL, file);
> >
> > -     if (!*dev)
> > +     if (!*dev) {
> > +             tst_system("cat /proc/self/mountinfo");
> >               tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> > +     }
> >
> >       if (stat(dev, &buf) < 0)
> >               tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> > --
> > 2.27.0
>
> Makes sense. However I suspect this function can be replaced with the
> standard library method used in tst_stat_mount_dev. I didn't try this
> before because I'm not sure why it scans mountinfo instead of mounts.

/proc/self/mounts doesn't contain major/minor numbers, which is primarily what
tst_find_backing_dev is using.

>
>
> --
> Thank you,
> Richard.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
