Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7982BC4332F
	for <ltp@archiver.kernel.org>; Sat,  5 Nov 2022 02:32:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12D543CAE66
	for <ltp@archiver.kernel.org>; Sat,  5 Nov 2022 03:32:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B7F63C7FCC
 for <ltp@lists.linux.it>; Sat,  5 Nov 2022 03:32:32 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EAA2E14002C4
 for <ltp@lists.linux.it>; Sat,  5 Nov 2022 03:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667615550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vlDg0NrnpHET992qr6rXR0OHdgH5Z506g/doKh5/+uk=;
 b=NMo/ww4tfP3Ze+BFI5GTtF96aumNXh+rz2vyc3cbJ1TNnu6Khp8OCfl6W0SXSdITnTp6Oa
 s/PC/pMX98lYiyWho7gVGT/FT5RHnpRCQdw5+95TDh7/WXMb8cGJrhafAcqT6HuPbnKTHK
 +Ot9hEnVbIJQR1lRPzsv51KhyxHHrSs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-sH4QRI6uMh-sN44hVQ7KGQ-1; Fri, 04 Nov 2022 22:32:28 -0400
X-MC-Unique: sH4QRI6uMh-sN44hVQ7KGQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-13b7af40a31so3341348fac.1
 for <ltp@lists.linux.it>; Fri, 04 Nov 2022 19:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vlDg0NrnpHET992qr6rXR0OHdgH5Z506g/doKh5/+uk=;
 b=xGhS4y2SCsEht/e1Wt1oYiMDCbuBWVX5harVmyDA2t6Q0TfjFArK34WloJO1VHIJZU
 admv/oxbyYgPsoYa8GjhJRYS7TrjXGcWdVimau/k4neDmZdSx8nmTyjRakqSffnOODic
 h7WCAhJLLcbROlrPDhHkIa0zAX/Zoq9QLQHoJyUCJ11RlIGkihXSc4yso0qavl7EAZ/A
 0wKJVzGVSLkMn6TKCEmU28YwJoOsms+46Q5aESRUrx4NAvyhqKof3uIneZfBVymQ5lRP
 m7nW1OHmDlhvlKkGvHlPnMYvGgjnUqXroxJ0L9UCABT5fLt4NW4qhtLPTQoD6ko7eTjM
 Tc0g==
X-Gm-Message-State: ACrzQf2yahU3+MdH1FTM8fk6laO9xwRUWimRUBWVSCu/jWimt/zh6G6G
 kDgrBhJetC4EyfzbKN4NGuq8P69pLj2+bfA4/EE9apwtijvWWhT1GbOKRPVnf0cAHV8X8mMbUpJ
 a0F0Da56fOppaCnvEy7uq3uyaAzU=
X-Received: by 2002:a05:6808:14c9:b0:35a:7106:e036 with SMTP id
 f9-20020a05680814c900b0035a7106e036mr209765oiw.107.1667615548033; 
 Fri, 04 Nov 2022 19:32:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7YXfGtYwoiJ0OAU8xNy9xp3ZmmTiWOQJbBArqUSZEF9okDp1vrU32QY3TPZwG3Qamq+nZ/ny6B1EDtPGYDfVg=
X-Received: by 2002:a05:6808:14c9:b0:35a:7106:e036 with SMTP id
 f9-20020a05680814c900b0035a7106e036mr209756oiw.107.1667615547780; Fri, 04 Nov
 2022 19:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
 <Y2UeAGj58zSd47Rt@yuki> <b0091247-3c27-49f5-351a-6ba06e0cfc24@suse.cz>
In-Reply-To: <b0091247-3c27-49f5-351a-6ba06e0cfc24@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 5 Nov 2022 10:32:14 +0800
Message-ID: <CAEemH2cFPw+Y=gBaYOKqLFyfwdYo6Oz_vcrappPempQKknrpHg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly handle user time in setitimer01
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
Content-Type: multipart/mixed; boundary="===============1192357393=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1192357393==
Content-Type: multipart/alternative; boundary="0000000000005901f305ecb00098"

--0000000000005901f305ecb00098
Content-Type: text/plain; charset="UTF-8"

Martin Doucha <mdoucha@suse.cz> wrote:

On 04. 11. 22 15:13, Cyril Hrubis wrote:

> As ITIMER_VIRTUAL and ITIMER_PROF counts CPU time the precision would be
> > the same as the COARSE clocks which depends on jiffies and on the
> > compile time option CONFIG_HZ. That is because in the scheduller the CPU
> > time is quantized into chunks based on CONFIG_HZ.
> >
> > And the ITIMER_REAL runs on hrtimers which would be the same precision
> > as CLOCK_REALTIME or CLOCK_MONOTONIC.
>

This description of the rationale is what I was trying to confirm.
Thanks for sharing.



>
> The kernel mangles the new timer values for ITIMER_PROF and
> ITIMER_VIRTUAL. It'll always add one extra jiffy to the actual timer
> value you've passed. For ITIMER_REAL, the timer value gets set as is.
>


Right, but I don't think it could be said as "mangles" cause that is
on purpose, in case people give a very tiny 'tv_usec' to setiitimer(),
so plus one jiffy to guarantee at least the timer takes effect.



>
>  From set_cpu_itimer() in kernel/time/itimer.c:
>
> if (oval || nval) {
>         if (nval > 0)
>                 nval += TICK_NSEC;
>         set_process_cpu_timer(tsk, clock_id, &nval, &oval);
> }
>
> nval = new timer value passed to setitimer() converted to nanoseconds
> TICK_NSEC = 1 jiffy in nanoseconds
>
> --
> Martin Doucha   mdoucha@suse.cz
> QA Engineer for Software Maintenance
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000005901f305ecb00098
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz">mdoucha@=
suse.cz</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 04. 11. 22 15:13, Cyril Hrubis wrote:=C2=
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; As ITIMER_VIRTUAL and ITIMER_PROF counts CPU time the precision would =
be<br>
&gt; the same as the COARSE clocks which depends on jiffies and on the<br>
&gt; compile time option CONFIG_HZ. That is because in the scheduller the C=
PU<br>
&gt; time is quantized into chunks based on CONFIG_HZ.<br>
&gt; <br>
&gt; And the ITIMER_REAL runs on hrtimers which would be the same precision=
<br>
&gt; as CLOCK_REALTIME or CLOCK_MONOTONIC.<br></blockquote><div><br></div><=
div><div class=3D"gmail_default" style=3D"font-size:small">This description=
 of the rationale=C2=A0is what I was trying to confirm.</div><div class=3D"=
gmail_default" style=3D"font-size:small">Thanks for sharing.</div><br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The kernel mangles the new timer values for ITIMER_PROF and <br>
ITIMER_VIRTUAL. It&#39;ll always add one extra jiffy to the actual timer <b=
r>
value you&#39;ve passed. For ITIMER_REAL, the timer value gets set as is.<b=
r></blockquote><div><br></div><div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Right, but I don&#39;t think it could be said=
 as &quot;mangles&quot; cause that is</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">on purpose, in case people give a very tiny &#39;tv_=
usec&#39; to=C2=A0setiitimer(),</div><div class=3D"gmail_default" style=3D"=
font-size:small">so plus one jiffy to guarantee at least the timer takes ef=
fect.</div></div><div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
=C2=A0From set_cpu_itimer() in kernel/time/itimer.c:<br>
<br>
if (oval || nval) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nval &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nval +=3D TICK_NSEC=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_process_cpu_timer(tsk, clock_id, &amp;nval,=
 &amp;oval);<br>
}<br>
<br>
nval =3D new timer value passed to setitimer() converted to nanoseconds<br>
TICK_NSEC =3D 1 jiffy in nanoseconds<br>
<br>
-- <br>
Martin Doucha=C2=A0 =C2=A0<a href=3D"mailto:mdoucha@suse.cz" target=3D"_bla=
nk">mdoucha@suse.cz</a><br>
QA Engineer for Software Maintenance<br>
SUSE LINUX, s.r.o.<br>
CORSO IIa<br>
Krizikova 148/34<br>
186 00 Prague 8<br>
Czech Republic<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000005901f305ecb00098--


--===============1192357393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1192357393==--

