Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FF5ECAAD1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 05:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B5A83CA5E2
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 07:52:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CD563C25DD
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 07:52:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 68AF62009EC
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 07:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661838745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qdaFd6MWyEOjUa1xpVpV5SRQBOlzDWxQMMuTvFN6OQ=;
 b=TZtHXNIFSsUNQLUypwM3kSwWoqvAybSsCdUiqjC4yhWA7VJ0QGxd1G5k5nsigItmZJ3xNO
 M7cvADggkSEoOpwbogOzYDVoVAoeJUDwuJoMci2K+LycwXPQ5cXuXRcXRYHGSc8nzPzIY/
 U3na7GkqzdMjXUCFwIgOAYLA0Ut2i7U=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-85vGH2XdOcCCEp6TF3DN7A-1; Tue, 30 Aug 2022 01:52:23 -0400
X-MC-Unique: 85vGH2XdOcCCEp6TF3DN7A-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-335ff2ef600so161610507b3.18
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 22:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=6qdaFd6MWyEOjUa1xpVpV5SRQBOlzDWxQMMuTvFN6OQ=;
 b=XnZb/IiX/tsOeF8LoxrdS9szzFwpfA7KkJVC2Fu7rga8TR59+wChnns3ykHbrKdQBJ
 jR3VPb4+xHmoUDIfi1osrFhdwSvv0yYcyuNsgewGwrm/WxRqunwANaTYPei++25vMBKf
 O2WuvP+mKShRIWOuuloDAc4M/ElHybF2vLm/Ask0APOjOOAQEEfVJbWSZAHLhKhKlzuS
 bLJYGywsGfL5D5kELnpWlMH1h8tTH7yKrN8+9zWTxWH26IQwjI6WRPgF4yAmEvIdmQ/y
 IM689Abcx06HiLsBn7iQ1qoqFNIUM8z034/4afyHArhHAvH0g71NNADYQvsZDoX5qFfW
 dAGg==
X-Gm-Message-State: ACgBeo0lXHz3XbVodRjDjq7Fgr3wLEqHDG5f1C3c5DaukUgAVLBwWWit
 9n+W7T/7NswYuxlLb02gA5qOhhA3xo2PshXt/eAWEF/KEYjIqMrZBZ9CeXEQWitjl1gDNsrlEhk
 0QVD+hXMKu/8HI/A/iOVPF8lNGMA=
X-Received: by 2002:a0d:f783:0:b0:340:cd25:fc5d with SMTP id
 h125-20020a0df783000000b00340cd25fc5dmr10055561ywf.82.1661838743321; 
 Mon, 29 Aug 2022 22:52:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR41fhwjvQujPgN+KcV53ZqZdm5O13ZiIGTWpqToO09nOHJYluoQ8cBOXIB4dU5etMEH+sPFUCxssHTHoC8hNPo=
X-Received: by 2002:a0d:f783:0:b0:340:cd25:fc5d with SMTP id
 h125-20020a0df783000000b00340cd25fc5dmr10055547ywf.82.1661838743085; Mon, 29
 Aug 2022 22:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz> <YwyYUzvlxfIGpTwo@yuki>
 <YwyljsgYIK3AvUr+@pevik>
In-Reply-To: <YwyljsgYIK3AvUr+@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 13:52:12 +0800
Message-ID: <CAEemH2dbBZO91EEB-xheoToUPuz=SBDjp9dGzy1YuVL+qGgOMQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 0/6] Track minimal size per
 filesystem
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1684977669=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1684977669==
Content-Type: multipart/alternative; boundary="000000000000f4baf905e76efb5e"

--000000000000f4baf905e76efb5e
Content-Type: text/plain; charset="UTF-8"

Hi Petr, All,

On Mon, Aug 29, 2022 at 7:40 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Cyril,
>
> > Hi!
> > > This patchset require to be on the top of:
>
> > > [RFC,1/1] API: Allow to use xfs filesystems < 300 MB
> > > https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
> > >
> https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/
>
> > I'm not that sure if we want to run tests for xfs filesystem that is
> > smaller than minimal size used in production. I bet that we will cover
> > different codepaths that eventually end up being used in production
> > that way.
>
>         > > LTP community: do we want to depend on this behavior or we
> just increase from 256MB to 301 MB
>         > > (either for XFS or for all). It might not be a good idea to
> test size users are required
>         > > to use.
>
>         > It might *not*? <confused>
>         Again, I'm sorry, missing another not. I.e. I suppose normal users
> will not try
>         to go below 301MB, therefore LTP probably should not do it either.
> That's why
>         RFC.
>
> @Darrick, others (kernel/LTP maintainers, embedded folks) WDYT?
>
> I'm personally OK to use 300 MB (safer to use code paths which are used in
> production), it's just that for older kernels even with xfs-progs
> installed it's
> unnecessary boundary. We could base XFS size on runtime kernel, but unless
> it's
> 300 MB a real problem for anybody I would not address it. i.e. is there
> anybody
> using XFS on old kernels? (old LTS, whey sooner or later need to use these
> variables themselves).
>

Another compromised way I can think of is to let LTP choose
300MB for XFS by default, if the test bed can't provide that size,
simply go back to try 16MB.  Does this sound acceptable?

-- 
Regards,
Li Wang

--000000000000f4baf905e76efb5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr, All,</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 29, 2022 at 7:40 PM Petr Vorel=
 &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi C=
yril,<br>
<br>
&gt; Hi!<br>
&gt; &gt; This patchset require to be on the top of:<br>
<br>
&gt; &gt; [RFC,1/1] API: Allow to use xfs filesystems &lt; 300 MB<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/ltp/20220817204015.31420-1-pvo=
rel@suse.cz/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/=
ltp/20220817204015.31420-1-pvorel@suse.cz/</a><br>
&gt; &gt; <a href=3D"https://patchwork.ozlabs.org/project/ltp/patch/2022081=
7204015.31420-1-pvorel@suse.cz/" rel=3D"noreferrer" target=3D"_blank">https=
://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@sus=
e.cz/</a><br>
<br>
&gt; I&#39;m not that sure if we want to run tests for xfs filesystem that =
is<br>
&gt; smaller than minimal size used in production. I bet that we will cover=
<br>
&gt; different codepaths that eventually end up being used in production<br=
>
&gt; that way.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; LTP community: do we want to depend o=
n this behavior or we just increase from 256MB to 301 MB<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; (either for XFS or for all). It might=
 not be a good idea to test size users are required<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; to use.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; It might *not*? &lt;confused&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Again, I&#39;m sorry, missing another not. I.e.=
 I suppose normal users will not try<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 to go below 301MB, therefore LTP probably shoul=
d not do it either. That&#39;s why<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RFC.<br>
<br>
@Darrick, others (kernel/LTP maintainers, embedded folks) WDYT?<br>
<br>
I&#39;m personally OK to use 300 MB (safer to use code paths which are used=
 in<br>
production), it&#39;s just that for older kernels even with xfs-progs insta=
lled it&#39;s<br>
unnecessary boundary. We could base XFS size on runtime kernel, but unless =
it&#39;s<br>
300 MB a real problem for anybody I would not address it. i.e. is there any=
body<br>
using XFS on old kernels? (old LTS, whey sooner or later need to use these<=
br>
variables themselves).<br></blockquote><div><br></div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Another compromised way I can think of is=
 to let LTP choose</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">300MB for XFS by default, if the test bed can&#39;t provide that size,<=
/div><div class=3D"gmail_default" style=3D"font-size:small">simply go back =
to try 16MB.=C2=A0 Does this sound=C2=A0acceptable?</div><div><br></div></d=
iv>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000f4baf905e76efb5e--


--===============1684977669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1684977669==--

