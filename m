Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A2BC43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 09:17:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3AEB3CC49B
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:17:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFC753CA9B6
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:17:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1A5B2013C9
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 10:17:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669886244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zpfDgndwIqNNDuu4YqmsIGNRVOQNfDP5zCOyYVa0mu8=;
 b=b5340+hXKDBxMvPhADTDzrQKEbqgt5u4BxHqWjRc+Q7xgs17XoKTfAWCxPme11+wPzQ5Xv
 oTN78nvS0tpXTO20PYlARbvj1IklRU36znHAaAX0uwceiOlYLevXFgqulPsSsdmVn4Wum/
 8IvWjQ/8SVf3Bndinsy21HVzZnvuCgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-426-PzRrg_haOsGwkGDnEGAN0g-1; Thu, 01 Dec 2022 04:17:22 -0500
X-MC-Unique: PzRrg_haOsGwkGDnEGAN0g-1
Received: by mail-wr1-f69.google.com with SMTP id
 g14-20020adfa48e000000b00241f94bcd54so217557wrb.23
 for <ltp@lists.linux.it>; Thu, 01 Dec 2022 01:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpfDgndwIqNNDuu4YqmsIGNRVOQNfDP5zCOyYVa0mu8=;
 b=1F3b4aFNP8LlGNxg/6v8zbFfgcOKxQQNDgp9kXtBMEvhHhLxbc/KvuBWEUTJDaoaKC
 gfhdnWyAWlnKXPxKn17Unkk7fkMPQAgQcRFqV1s97a1+SqyfxkYsHPnnsAPZaiPwi60V
 ugxhzZd9wUe/+AoCZGiyoNHGFLAIAX4vfzZtUGuTvv+o4Hzn5d2w/c/r0oRqFdFw2c7Z
 BAVAECeUISZswoJkGZb1d/AImaSrsM+2pCfc4n8wE/19L+4ej5YGyH+9mPCtfOZNMzw0
 uErn3oTa1mN3QpJ8KY2yuIvDVy59llbYUBoquyOkxyIP6S9F+/ZnmWqlSYEn5fmbku8T
 rUmQ==
X-Gm-Message-State: ANoB5pkphhDskR6sa4LrufSWcgfjI2K3YZOP2nPNKfwQwFLJK5/PLdUX
 qjlyQLzzTbXKzD8IunWBkTio6FM/sMDaspMO7D0EMIP7GKtuZ0KS9mYEQoj8Abz4JEA5oWoOmV3
 lBau//P8uQO2H3bZHtusc0EeqEDg=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr41012697wrn.316.1669886240425; 
 Thu, 01 Dec 2022 01:17:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Cf6qlyYl5khII8zu/9jLlmlmEM15thCfSJaBmcU4sxanFccleLfeRd/rbXbVkMjfJRt/MP2y3fPzTD9A5HrU=
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id
 k9-20020adfe8c9000000b0022e33dc3bf1mr41012686wrn.316.1669886240201; Thu, 01
 Dec 2022 01:17:20 -0800 (PST)
MIME-Version: 1.0
References: <87r0xmt3ts.fsf@suse.de> <Y4cZxK/SqTtpQb07@pevik>
 <Y4cnbaAtMAtw3IWC@pevik> <1774275.JVTEKzzMJm@localhost>
In-Reply-To: <1774275.JVTEKzzMJm@localhost>
From: Li Wang <liwan@redhat.com>
Date: Thu, 1 Dec 2022 17:17:08 +0800
Message-ID: <CAEemH2eDBmac9hSZ+n_hQhLjaHOtxqSAj+QfJ_Sc_+4jd4hDww@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1466321833=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1466321833==
Content-Type: multipart/alternative; boundary="00000000000029c4f705eec0b0bb"

--00000000000029c4f705eec0b0bb
Content-Type: text/plain; charset="UTF-8"

Avinesh Kumar <akumar@suse.de> wrote:

> How about
> > 1) don't skip exfat and vfat but just skip creating file with valid
> name? or
> >
> > 2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate
> > length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?
>


> Thank you for the review and research on vfat, exfat scenarios.
> I have adopted the option 1 for now and sent a v3 of this patch.
>

I thought option_1 meant to skip creating a valide-file when
detecting on "vfat,exfat" FS, but not skip for others.

Or probably I misunderstood Petr's words.

Anyway, don't hurry to send V3 until we get an agreement :).

--- a/testcases/kernel/syscalls/statvfs/statvfs01.c
+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c
@@ -30,7 +30,10 @@ static void run(void)
        memset(valid_fname, 'a', buf.f_namemax - 1);
        memset(invalid_fname, 'b', buf.f_namemax + 1);

-       TST_EXP_FD(creat(valid_fname, 0444));
+       long fs_type = tst_fs_type(TEST_PATH);
+       if  (fs_type != TST_VFAT_MAGIC && fs_type != TST_EXFAT_MAGIC)
+               TST_EXP_FD(creat(valid_fname, 0444));
+
        TST_EXP_FAIL(creat(invalid_fname, 0444), ENAMETOOLONG);
 }

@@ -46,9 +49,4 @@ static struct tst_test test = {
        .mount_device = 1,
        .mntpoint = MNT_POINT,
        .all_filesystems = 1,
-       .skip_filesystems = (const char *const[]) {
-               "vfat",
-               "exfat",
-               NULL
-       }
 };


-- 
Regards,
Li Wang

--00000000000029c4f705eec0b0bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Avinesh Kumar &lt;<a href=3D"mailto:akumar@suse.de">akumar@su=
se.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; How about<br>
&gt; 1) don&#39;t skip exfat and vfat but just skip creating file with vali=
d name? or<br>
&gt; <br>
&gt; 2) Add #define NLS_MAX_CHARSET_SIZE 6 and for vfat and exfat calculate=
<br>
&gt; length as: buf.f_namemax / NLS_MAX_CHARSET_SIZE - 1 ?<br></blockquote>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thank you for the review and research on vfat, exfat scenarios.<br>
I have adopted the option 1 for now and sent a v3 of this patch.<br></block=
quote><div><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>I thought option_1 meant to skip creating a=C2=A0valide-file when</div><di=
v class=3D"gmail_default" style=3D"font-size:small">detecting on &quot;vfat=
,exfat&quot; FS, but not skip for others.</div><div class=3D"gmail_default"=
 style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"=
font-size:small">Or probably I misunderstood Petr&#39;s words.</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">Anyway, don&#39;t hurry to send V3 un=
til we get an agreement :).</div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div>--- a/testcases/kernel/syscalls/statvfs/statvfs01.c<=
br>+++ b/testcases/kernel/syscalls/statvfs/statvfs01.c<br>@@ -30,7 +30,10 @=
@ static void run(void)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(valid_fname, =
&#39;a&#39;, buf.f_namemax - 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(inva=
lid_fname, &#39;b&#39;, buf.f_namemax + 1);<br>=C2=A0<br>- =C2=A0 =C2=A0 =
=C2=A0 TST_EXP_FD(creat(valid_fname, 0444));<br>+ =C2=A0 =C2=A0 =C2=A0 long=
 fs_type =3D tst_fs_type(TEST_PATH);<br>+ =C2=A0 =C2=A0 =C2=A0 if =C2=A0(fs=
_type !=3D TST_VFAT_MAGIC &amp;&amp; fs_type !=3D TST_EXFAT_MAGIC)<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_FD(creat(valid_fname,=
 0444));<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_FAIL(creat(invalid_fna=
me, 0444), ENAMETOOLONG);<br>=C2=A0}<br>=C2=A0<br>@@ -46,9 +49,4 @@ static =
struct tst_test test =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mount_device =3D=
 1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mntpoint =3D MNT_POINT,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 .all_filesystems =3D 1,<br>- =C2=A0 =C2=A0 =C2=A0 .skip_f=
ilesystems =3D (const char *const[]) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;vfat&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;exfat&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 NULL<br>- =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0};<br><div class=3D=
"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small"></div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">R=
egards,<br>Li Wang<br></div></div></div></div></div>

--00000000000029c4f705eec0b0bb--


--===============1466321833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1466321833==--

