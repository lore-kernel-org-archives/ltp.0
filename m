Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E27C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 05:17:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF843CDE39
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 06:17:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD8483CC55B
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 06:17:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3B6C1600B42
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 06:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669871817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ginOCDxWl5uClazDcDeScUr8FH3DEbsT0bohZg7n/04=;
 b=TBkZdtLWDxi1jGQ/6CfTF+y20t+lmBBbhhxRqxZnKt1blRJBVKaIGlVXD35nawf1WHYrio
 yH6rV62hVAS2p19Bfx6ZyxqNjgMmeEcowOnmavRItJLKraQKl7P5NXBjDvCuiKakhEdNLq
 2IVeFKI4XDx3P+/hqB5Prz7B4TwFoGo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-osYJ6g3WMta9KGflamu9gQ-1; Thu, 01 Dec 2022 00:16:55 -0500
X-MC-Unique: osYJ6g3WMta9KGflamu9gQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 m34-20020a05600c3b2200b003cf549cb32bso2016342wms.1
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 21:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ginOCDxWl5uClazDcDeScUr8FH3DEbsT0bohZg7n/04=;
 b=0vxQ8IQSMWbVbDDXAD7Of81Bxdn0o12ZEDLC2J0LFnFKg5lqfNZG8S1aDe9svLJlqH
 Fw5uT3WtiRh8Hona/g6BGVhc8q+vlz6jrg+yItLao/Yixf0IHtgvgWjk+n9JS2IJbFCn
 pTYeop7P/kFNg8SXX7HEtmMhzvxTcNfhaZLTbLX6nRkjho70k2w2nxno58r3hbXyKBST
 M/DO2jWm9kzl2HEyYooMyG6TpSmxS9FFoMeLXp0Rj24oBfRjlCKG8fbSekgoUabztl7M
 R0sAEIXKslVv04/WYf/E70Pj2p7EWXR8Cot5P1yN2mIDLBSnUKdAR0tYlxu/D8bz3y1k
 ggxw==
X-Gm-Message-State: ANoB5plrDumULL3goDwf5yryqrEb1zdXgFqZrdMBJpDpQ6bmpXYpV0g4
 qgN7zpoApFJk3rfX1u75GrPrKA/uWRafAQJXui6A3hKeV3ZwrRAYkZjdRkd22FtXNXo2xoIw1yo
 JkkuQB5abAjoTDub2kQRObg8o+eM=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr33718421wro.129.1669871814122; 
 Wed, 30 Nov 2022 21:16:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4JDu87pJFdw77VU3Qcs2TUXrXb/O+ngReXHsTdOyfQ0H/BMvoxlcJEkMzoFvUrpVydo1N6kfHIFEX88DCDgiQ=
X-Received: by 2002:adf:f011:0:b0:241:c78c:3671 with SMTP id
 j17-20020adff011000000b00241c78c3671mr33718412wro.129.1669871813866; Wed, 30
 Nov 2022 21:16:53 -0800 (PST)
MIME-Version: 1.0
References: <87r0xmt3ts.fsf@suse.de> <20221130070500.28664-1-akumar@suse.de>
 <Y4cZxK/SqTtpQb07@pevik> <Y4cnbaAtMAtw3IWC@pevik>
In-Reply-To: <Y4cnbaAtMAtw3IWC@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 1 Dec 2022 13:16:42 +0800
Message-ID: <CAEemH2dO+QXEteiEOqA5o_Axxxe9c4mdPrMB34Pj1FMPyDf9EQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statvfs01: Convert to new LTP API
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: multipart/mixed; boundary="===============1379969091=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1379969091==
Content-Type: multipart/alternative; boundary="000000000000494dc905eebd548d"

--000000000000494dc905eebd548d
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 30, 2022 at 5:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> ...
> > > +static struct tst_test test = {
> > > +   .test_all = run,
> > > +   .setup = setup,
> > > +   .needs_root = 1,
> > > +   .mount_device = 1,
> > > +   .mntpoint = MNT_POINT,
> > > +   .all_filesystems = 1,
> > > +   .skip_filesystems = (const char *const[]) {
> > > +           "vfat",
> > > +           "exfat",
> > I was looking what's wrong with vfat and exfat.
> > statvfs.f_namemax returns 1530, which is obviously too long, thus
> valid_fname
> > obviously returns ENAMETOOLONG (36). Tested on
> 6.1.0-rc6-1.g4c01546-default.
> > I wonder why, isn't that a bug?
>
> To reply myself, both glibc and musl defines:
> statvfs->f_namemax = statfs->f_namelen;
>
> TL;DR: 6 * 255 = 1530 due names being in UTF-8:
>
> Therefore looking into kernel sources for statfs->f_namelen:
>
> include/linux/nls.h
> #define NLS_MAX_CHARSET_SIZE 6 /* for UTF-8 */
>
> === exfat ===
> exfat/exfat_raw.h
> #define EXFAT_MAX_FILE_LEN 255
>
> exfat/super.c
> static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
> {
>         ...
>     /* Unicode utf16 255 characters */
>     buf->f_namelen = EXFAT_MAX_FILE_LEN * NLS_MAX_CHARSET_SIZE;
>
> === vfat ===
> include/uapi/linux/msdos_fs.h
> #define FAT_LFN_LEN 255     /* maximum long name length */
>
> fat/inode.c
> static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
> {
>         ...
>     buf->f_namelen =
>         (sbi->options.isvfat ? FAT_LFN_LEN : 12) * NLS_MAX_CHARSET_SIZE;
>
> => i.e. for vfat without long filename support it'd be 72.
>
> How about
> 1) don't skip exfat and vfat but just skip creating file with valid name?
> or
>

Sure, I think this method is better.


>
> 2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate
> length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?
>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000494dc905eebd548d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Nov 30, 2022 at 5:50 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
...<br>
&gt; &gt; +static struct tst_test test =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0.test_all =3D run,<br>
&gt; &gt; +=C2=A0 =C2=A0.setup =3D setup,<br>
&gt; &gt; +=C2=A0 =C2=A0.needs_root =3D 1,<br>
&gt; &gt; +=C2=A0 =C2=A0.mount_device =3D 1,<br>
&gt; &gt; +=C2=A0 =C2=A0.mntpoint =3D MNT_POINT,<br>
&gt; &gt; +=C2=A0 =C2=A0.all_filesystems =3D 1,<br>
&gt; &gt; +=C2=A0 =C2=A0.skip_filesystems =3D (const char *const[]) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vfat&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;exfat&quot;,<br>
&gt; I was looking what&#39;s wrong with vfat and exfat.<br>
&gt; statvfs.f_namemax returns 1530, which is obviously too long, thus vali=
d_fname<br>
&gt; obviously returns ENAMETOOLONG (36). Tested on 6.1.0-rc6-1.g4c01546-de=
fault.<br>
&gt; I wonder why, isn&#39;t that a bug?<br>
<br>
To reply myself, both glibc and musl defines:<br>
statvfs-&gt;f_namemax =3D statfs-&gt;f_namelen;<br>
<br>
TL;DR: 6 * 255 =3D 1530 due names being in UTF-8:<br>
<br>
Therefore looking into kernel sources for statfs-&gt;f_namelen:<br>
<br>
include/linux/nls.h<br>
#define NLS_MAX_CHARSET_SIZE 6 /* for UTF-8 */<br>
<br>
=3D=3D=3D exfat =3D=3D=3D<br>
exfat/exfat_raw.h<br>
#define EXFAT_MAX_FILE_LEN 255<br>
<br>
exfat/super.c<br>
static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 /* Unicode utf16 255 characters */<br>
=C2=A0 =C2=A0 buf-&gt;f_namelen =3D EXFAT_MAX_FILE_LEN * NLS_MAX_CHARSET_SI=
ZE;<br>
<br>
=3D=3D=3D vfat =3D=3D=3D<br>
include/uapi/linux/msdos_fs.h<br>
#define FAT_LFN_LEN 255=C2=A0 =C2=A0 =C2=A0/* maximum long name length */<b=
r>
<br>
fat/inode.c<br>
static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 buf-&gt;f_namelen =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (sbi-&gt;options.isvfat ? FAT_LFN_LEN : 12) * N=
LS_MAX_CHARSET_SIZE;<br>
<br>
=3D&gt; i.e. for vfat without long filename support it&#39;d be 72.<br>
<br>
How about<br>
1) don&#39;t skip exfat and vfat but just skip creating file with valid nam=
e? or<br></blockquote><div><br></div><div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Sure, I think this method is better.</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate<br>
length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?<br>
<br>
Kind regards,<br>
Petr<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000494dc905eebd548d--


--===============1379969091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1379969091==--

