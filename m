Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0710C433FE
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 07:20:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C21003CC509
	for <ltp@archiver.kernel.org>; Wed, 30 Nov 2022 08:20:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33AA83C9008
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 08:20:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 379E11400BD8
 for <ltp@lists.linux.it>; Wed, 30 Nov 2022 08:20:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669792823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmFxCB/uSgsrdXmeMQwQVfAmFtxXSNP0x1+7Azew3WM=;
 b=EEFk3CeR/jciBhCfbg3qAEXMD62cSZRPn48g+ZTBm9+RG689GWHyEeWuJfnZ+YJ2gvbdot
 DLe15CEfw8121/5+Nzc7P0QKxfzJTpfgjnDtmfqKdKdgJp0ERsPKbQxvKE1qNpO011BPdR
 XK0pUSgmCT2WQYdmzj2AoGLr/et09bE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-5jZrokAJPhO4irL4qykeIw-1; Wed, 30 Nov 2022 02:20:21 -0500
X-MC-Unique: 5jZrokAJPhO4irL4qykeIw-1
Received: by mail-wm1-f69.google.com with SMTP id
 az40-20020a05600c602800b003cfa26c40easo544421wmb.1
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 23:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmFxCB/uSgsrdXmeMQwQVfAmFtxXSNP0x1+7Azew3WM=;
 b=35ryZKDkE2YFrerhMjPbQBxn4TdnAvgMikxjOj/EHS0dHDU5SSRu+dqyyEPl2WE6SF
 dnYVQVC6xt5hRLkb3nip+IHfDNSaLaCf447nEbAczK0zjDF4fM4q0D6Rs2vCWdjhHiSq
 etScqqE3K8vGGlxvSmbCWUaqF2KLF6+3ITCN5ZAm4CiQAAOwdQcs0xYWYwiKT1vBKxzj
 VWOdfdyYWbktGg5sEgHVOSLUSVGA6NS/bYD0v04jDRRgl7Vm3OqxYpvTdWoR6L7iUPSX
 qObXlCTQQbZ74hXmzHc111mc9Iqqwp5tnT2qYkU2137o3JqgJLc2HxRryxkuIOQg3r7x
 LDcQ==
X-Gm-Message-State: ANoB5pmXlPtCRWP5HO4HTekd6UwtEomD+jokHidNGKgk2dI1nm9vGO2S
 9JcBOKjfzcqItmZL3egbleRCLvGzkiulY+dZK8FCw5i8U+FFqoekhwlvxDJ84QvUl80W7oz25va
 D7JtwVUAcorFPuLS5nbcyfUEh54g=
X-Received: by 2002:a05:600c:1604:b0:3cf:7fb1:e217 with SMTP id
 m4-20020a05600c160400b003cf7fb1e217mr43915056wmn.92.1669792820256; 
 Tue, 29 Nov 2022 23:20:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf48PzdyH5fIYmKDkp8ie1LWrVlHaVCr3yHzc3PZtQl95DJAoYnFgP38VUIjLCqWG0udDyv91p8gXEjGAG4Py80=
X-Received: by 2002:a05:600c:1604:b0:3cf:7fb1:e217 with SMTP id
 m4-20020a05600c160400b003cf7fb1e217mr43915047wmn.92.1669792820057; Tue, 29
 Nov 2022 23:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20221124114204.990-1-akumar@suse.de>
 <CAEemH2eVctJWX8AehwFDa0aorAyM_c+yabnB8zbwDoTUaVQLyg@mail.gmail.com>
 <87r0xmt3ts.fsf@suse.de>
In-Reply-To: <87r0xmt3ts.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 30 Nov 2022 15:20:08 +0800
Message-ID: <CAEemH2dErC+9-UawDMdYq=rCnHOE7ciU7dZ4Ma0A542wdrg+eA@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statvfs01: Convert to new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0703612622=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0703612622==
Content-Type: multipart/alternative; boundary="000000000000e379ad05eeaaef67"

--000000000000e379ad05eeaaef67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 7:09 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > On Thu, Nov 24, 2022 at 7:42 PM Avinesh Kumar <akumar@suse.de> wrote:
> >
> >  Also I've removed the TINFO statements, I'm not sure if only
> >  printing the data in logs is helpful in anyway.
> >
> > Removing the printing is OK, but I am just wondering that
> > can we find a way to check if the returned value in 'buf' is
> > indeed correct?
> >
> > As you can see the =E2=80=98struct statvfs=E2=80=98 includes many fs ke=
y
> > values that we need to trust when using them.
> >
> > struct statvfs {
> >         unsigned long  f_bsize;    /* Filesystem block size */
> >         unsigned long  f_frsize;   /* Fragment size */
> >         fsblkcnt_t     f_blocks;   /* Size of fs in f_frsize units */
> >         fsblkcnt_t     f_bfree;    /* Number of free blocks */
> >         fsblkcnt_t     f_bavail;   /* Number of free blocks for
> >                                              unprivileged users */
> >         fsfilcnt_t     f_files;    /* Number of inodes */
> >         fsfilcnt_t     f_ffree;    /* Number of free inodes */
> >         fsfilcnt_t     f_favail;   /* Number of free inodes for
> >                                              unprivileged users */
> >         unsigned long  f_fsid;     /* Filesystem ID */
> >         unsigned long  f_flag;     /* Mount flags */
> >         unsigned long  f_namemax;  /* Maximum filename length */
> >  };
>
> I suppose previously printing the values at least accessed the memory.
>

Sounds reasonable.



> Actually validating the values could be a separate patch though.
>

+1 Absolutely.



>
> We (probably) know that maximum filename should be less than 255 chars
> (for e.g.), but I think there is a good chance that trying to validate
> this will result in false positives and stuff we might want to revert.
>

Maybe we can create a concrete size of the device and mount
it with a designated FS (e.g. ext4), then extracting the known FS
data into `struct statvfs` and validating them.

Does this make sense?


--=20
Regards,
Li Wang

--000000000000e379ad05eeaaef67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 29, 2022 at 7:09 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@su=
se.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Hello,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Nov 24, 2022 at 7:42 PM Avinesh Kumar &lt;<a href=3D"mailto:ak=
umar@suse.de" target=3D"_blank">akumar@suse.de</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Also I&#39;ve removed the TINFO statements, I&#39;m not sure if =
only<br>
&gt;=C2=A0 printing the data in logs is helpful in anyway.<br>
&gt;<br>
&gt; Removing the printing is OK, but I am just wondering that<br>
&gt; can we find a way to check if the returned value in &#39;buf&#39; is<b=
r>
&gt; indeed correct?<br>
&gt;<br>
&gt; As you can see the =E2=80=98struct statvfs=E2=80=98 includes many fs k=
ey<br>
&gt; values that we need to trust when using them.<br>
&gt;<br>
&gt; struct statvfs {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 f_bsize;=C2=A0 =
=C2=A0 /* Filesystem block size */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 f_frsize;=C2=A0 =
=C2=A0/* Fragment size */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsblkcnt_t=C2=A0 =C2=A0 =C2=A0f_block=
s;=C2=A0 =C2=A0/* Size of fs in f_frsize units */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsblkcnt_t=C2=A0 =C2=A0 =C2=A0f_bfree=
;=C2=A0 =C2=A0 /* Number of free blocks */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsblkcnt_t=C2=A0 =C2=A0 =C2=A0f_bavai=
l;=C2=A0 =C2=A0/* Number of free blocks for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unprivileged users */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsfilcnt_t=C2=A0 =C2=A0 =C2=A0f_files=
;=C2=A0 =C2=A0 /* Number of inodes */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsfilcnt_t=C2=A0 =C2=A0 =C2=A0f_ffree=
;=C2=A0 =C2=A0 /* Number of free inodes */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsfilcnt_t=C2=A0 =C2=A0 =C2=A0f_favai=
l;=C2=A0 =C2=A0/* Number of free inodes for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unprivileged users */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 f_fsid;=C2=A0 =C2=
=A0 =C2=A0/* Filesystem ID */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 f_flag;=C2=A0 =C2=
=A0 =C2=A0/* Mount flags */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long=C2=A0 f_namemax;=C2=A0 =
/* Maximum filename length */<br>
&gt;=C2=A0 };<br>
<br>
I suppose previously printing the values at least accessed the memory.<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">Sounds reasonable.</div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
Actually validating the values could be a separate patch though.<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">+1 Absolutely.</div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
We (probably) know that maximum filename should be less than 255 chars<br>
(for e.g.), but I think there is a good chance that trying to validate<br>
this will result in false positives and stuff we might want to revert.<br><=
/blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:=
small">Maybe we can create a concrete=C2=A0size of the device and mount</di=
v><div class=3D"gmail_default" style=3D"font-size:small">it with a designat=
ed FS (e.g. ext4), then extracting the known FS</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">data into `struct statvfs` and validating =
them.</div></div><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Does this make sense?</div><br></div><div><br></div>-- <br=
><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br><=
/div></div></div></div>

--000000000000e379ad05eeaaef67--


--===============0703612622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0703612622==--

