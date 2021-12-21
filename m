Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD55C433FE
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:50:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457313C91FB
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 03:50:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263563C0BA7
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:50:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B1C3C2001CE
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640055044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dzf9NLbr0CdLdY5JD2+yri3UmvTtQeutMY3mfvqcqOQ=;
 b=BoQ6Zb9x30oVfzDeAVkX4dLAi4FYyyVM8wBPjfxcqHEFsbp3zho9Pu36IGZ2SIglamowB8
 RrlodyO+4azgA7ODBsdYbUHHQGss/NI7QP/V1T8Fz7/IX6/+6GvzEv5ua5F5+zrFmBsuPo
 Y/Jle94R2gngToKaLJHV3KxV6tttog8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-sstSKHsmNAyZ9TUgp1oE5A-1; Mon, 20 Dec 2021 21:50:39 -0500
X-MC-Unique: sstSKHsmNAyZ9TUgp1oE5A-1
Received: by mail-yb1-f200.google.com with SMTP id
 l145-20020a25cc97000000b005c5d04a1d52so23175878ybf.23
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 18:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OBJhwBzkVP1RY7eBZCVlKuAnrDfG0bWQQX1bvJgDZvg=;
 b=2EfG6yM6vHlRp9+yqV8A4mkXjQwH06Jb19OYfXn5rL7CA6Yf6fs8GU2KrDb3xQkVvw
 +Vbp2kZZNmzO4JVywg1empF2r+t+d5kXxuntG9A/GBAWNoxOHqd5fh/qZJdwe8gfe5y4
 xzNoNCttTEQQV5nr3lbJsTqwPG6Ggxk5G6i8X0BZOH53sGMXAG7YnBtM2xLww6TkQ0Gc
 ZiSlv8NZ5VjUl4+dBCdyWosYwPZDJRAVHJsdeldA38hfnvU9nIMpfFOqJoPAZsMCCqD1
 4FVoVfR05i9cKe3vhSGjiwWvN/Zt7TSrj06ujqdBQikpxX+v3+z2OIO9SbnBvgFyxAN6
 VPfA==
X-Gm-Message-State: AOAM532myA3sfXGSmLROThVfeuI1iRezejqy5sM+7UvT8WKRgbLb29Qw
 b7RDC88vkculDbBrqNAkDrkNqCG3wyJLPzDerSxSo7z26AmbV3amDhPK0np1KP6OJSaRePSGFqJ
 LO+/JnNT0p8PjSlTyZM3IJ7HkuAQ=
X-Received: by 2002:a25:b13:: with SMTP id 19mr1759966ybl.71.1640055039272;
 Mon, 20 Dec 2021 18:50:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxe0IqoQ2EsEU0662T7N8RE4J2vzYKVcjigQH92bKpcTm+0B6osj4DRnz12z/ylE92XG7gx8cnAXWk+PKxtsh4=
X-Received: by 2002:a25:b13:: with SMTP id 19mr1759944ybl.71.1640055039053;
 Mon, 20 Dec 2021 18:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
In-Reply-To: <YcDMnDRgsac/q8D9@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 10:50:26 +0800
Message-ID: <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Content-Type: multipart/mixed; boundary="===============1257245751=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1257245751==
Content-Type: multipart/alternative; boundary="00000000000003e99105d39f12a4"

--00000000000003e99105d39f12a4
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 21, 2021 at 2:34 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> >     v2 --> v3
> >       * rename to tst_disable_oom_protection
> >       * support set PID as 0 to protect current process
>
> > +static void set_oom_score_adj(pid_t pid, int value)
> > +{
> > +     int val;
> > +     char score_path[64];
> > +
> > +     if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> We need to check here also /proc/PID/oom_score_adj, i.e. score_path.
>

Good catch, I would add a 'W_OK' checking and skip the setting with
a reminder message if run without root.

how about this?

if (access(score_path, W_OK) == -1) {
        tst_res(TINFO, "Warning: %s cannot be accessed for writing,
                please check if test run with root user.",
                score_path);
        return
}


-- 
Regards,
Li Wang

--00000000000003e99105d39f12a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 21, 2021 at 2:34 AM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0v2 --&gt; v3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* rename to tst_disable_oom_protection<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* support set PID as 0 to protect current pr=
ocess<br>
<br>
&gt; +static void set_oom_score_adj(pid_t pid, int value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char score_path[64];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (access(&quot;/proc/self/oom_score_adj&quot;, =
F_OK) =3D=3D -1) {<br>
We need to check here also /proc/PID/oom_score_adj, i.e. score_path.<br></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Good catch, I would add a &#39;W_OK&#39; checking and skip the se=
tting with</div><div class=3D"gmail_default" style=3D"font-size:small">a re=
minder message if run without root.</div><br></div><div><div class=3D"gmail=
_default" style=3D"font-size:small">how about this?</div><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">if (access(score_path, W_OK)=
 =3D=3D -1) {</div>=09=09<span class=3D"gmail_default" style=3D"font-size:s=
mall">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>tst_res(TINFO, &quot;Warning: %s c=
annot be accessed for writing,<br>=09=09=09<span class=3D"gmail_default" st=
yle=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>please check if test run with root user.&quot;,<br>=09=09=09<=
span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>score_path);<br>=09=09<span clas=
s=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>return<br>=09}<br><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--00000000000003e99105d39f12a4--


--===============1257245751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1257245751==--

