Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7860BC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 12:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9EA3CA6A9
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 14:31:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FC683C192A
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 14:31:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 96DED1000413
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 14:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650457901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rGSuE0eCKLRFdr1Zi/PsQvWNBXffVZErUpnhUaY8rg=;
 b=gLbSIPFRh0Vbk48mqzeTZHLIwXC9De2DTFmQNMZTb1RzZ442tes8eJ4wMebhlwLJjZtOML
 +FW4w7f799k3tQAQF5Q+RImly80JtVAmEhumVl2ZYKgJVyLoNLOUk9kgSm032VydXAcWn3
 ljQ5kPlkAA7sk3/rL/Zlnyjn4soKkao=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-2sbBrwggNlyBOQj1TQz-VQ-1; Wed, 20 Apr 2022 08:31:39 -0400
X-MC-Unique: 2sbBrwggNlyBOQj1TQz-VQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 o188-20020a2541c5000000b0064334935847so1277406yba.16
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 05:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/rGSuE0eCKLRFdr1Zi/PsQvWNBXffVZErUpnhUaY8rg=;
 b=Lx8UxwXwjOPyvgXVyTAtTvxgQDLU0Oud2K2PT917ZtU8YCKBmwm/YWdHw76zXWfVQt
 lp6vZpGh2885Y1GZ76CwV43jiFL798HDoSs4BiJahkVo8lSfujhM8IIBe5XIgMjb54XJ
 CItbOWc4C7VgU0NHIJrIjco5+sKZ/oj3+qVmpv1gie/uLMmHWDlktJtJKfiSJMMxNlGv
 8lhtJRxVpj1DSpwNTjond3m+lMO32/begdCh2H0NwNiCBhpN/mdhlN4CP/QBhVJzwRjt
 sZI13aM6N0NFmVoXD7ifOevZJBOi+Ypf97pnAHWxyHkHh1g/ahzIwRNfFcyBZqpurkhF
 nVpw==
X-Gm-Message-State: AOAM532a5o4eeAr0VhuDN1I/s5fzbp4NPHj/JX2t129DkiKlMr8SgGF0
 wrah15EqwiPLDNX3QzMzwwpTmoSZNzPrZ5fLYSGAPLIMq8nZpvceEM8yWPMKjg12gvBuh7GK+Tg
 VbZv6dCheD6e1vpWpoBrFLXCCvYU=
X-Received: by 2002:a25:4114:0:b0:645:1c:5b58 with SMTP id
 o20-20020a254114000000b00645001c5b58mr13550800yba.233.1650457899141; 
 Wed, 20 Apr 2022 05:31:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT3WDd9uGzOm4cdX/U2mZy4Z/hAklIyZwRX2xLPNfYmYZMl/Z4Ktpwlaj7JU5IErhdXrwJo/Jnh5BUMgx6sGA=
X-Received: by 2002:a25:4114:0:b0:645:1c:5b58 with SMTP id
 o20-20020a254114000000b00645001c5b58mr13550774yba.233.1650457898870; 
 Wed, 20 Apr 2022 05:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220420114720.1463473-1-liwang@redhat.com>
 <Yl/3FchHScs8YS6c@yuki>
In-Reply-To: <Yl/3FchHScs8YS6c@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Apr 2022 20:31:23 +0800
Message-ID: <CAEemH2dTCBpynB3wj_8eTVvvJR_V4fGPZNvt_35noqdykKi52g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl09: wait for udevd complete the uevent
 handling
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
Content-Type: multipart/mixed; boundary="===============0228254487=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0228254487==
Content-Type: multipart/alternative; boundary="000000000000c7812905dd152c05"

--000000000000c7812905dd152c05
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:



>
> >  static void verify_ioctl(void)
> >  {
> > +     char cmd[BUFSIZ];
> > +
> > +     sprintf(cmd, "udevadm settle --exit-if-exists=%s", dev_path);
> > +
> >       const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
> >                                             "mklabel", "msdos", "mkpart",
> >                                             "primary", "ext4", "1M",
> "10M",
> > @@ -75,11 +79,13 @@ static void verify_ioctl(void)
> >
> >       loopinfo.lo_flags =  LO_FLAGS_PARTSCAN;
> >       SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &loopinfo);
> > +     tst_system(cmd);
> >       check_partition(1, true);
> >       check_partition(2, false);
> >
> >       change_partition(cmd_parted_new);
> >       TST_RETRY_FUNC(ioctl(dev_fd, BLKRRPART, 0), TST_RETVAL_EQ0);
> > +     tst_system(cmd);
> >       check_partition(1, true);
> >       check_partition(2, true);
>
> We allready use TST_RETRY_FN_EXP_BACKOFF() in there with 30 second
>

I have to say, for most systems 30 sec is long enough, but we definitely got
sporadically fails in larger-scale automation testing.


timeout isn't that enough? And if it isn't wouldn't simply increasing
> the timeout to a minute or two fix the issue?
>


That should be better, I just have a try on my reproducible system,
but it does not work with enlarged to 180 seconds.

ioctl09.c:52: TPASS: access /dev/loop0p1 succeeds
octl09.c:47: TFAIL: access /sys/block/loop0/loop0p2 fails
Test timeouted, sending SIGKILL!
tst_test.c:1509: TINFO: If you are running on slow machine, try exporting
LTP_TIMEOUT_MUL > 1
tst_test.c:1511: TBROK: Test killed! (timeout?)


Note, the `udevadm settle` uses 180s as default timeout as well,
but it can work, I will look into udevadm.c to see if that does
something additional besides the waiting.

If so, we might need to remove the TST_RETRY_FN_EXP_BACKOFF
from this test.

-- 
Regards,
Li Wang

--000000000000c7812905dd152c05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_=
quote"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"> <br>
&gt;=C2=A0 static void verify_ioctl(void)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char cmd[BUFSIZ];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sprintf(cmd, &quot;udevadm <span class=3D"gmail_d=
efault" style=3D"font-size:small"></span>settle --exit-if-exists=3D%s&quot;=
, dev_path);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *const cmd_parted_old[] =3D {&quo=
t;parted&quot;, &quot;-s&quot;, &quot;test.img&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;mklabel&quot;, &quot;msdos&quot;, &quot;mkpart&quot;=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;primary&quot;, &quot;ext4&quot;, &quot;1M&quot;, &qu=
ot;10M&quot;,<br>
&gt; @@ -75,11 +79,13 @@ static void verify_ioctl(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0loopinfo.lo_flags =3D=C2=A0 LO_FLAGS_PARTSCA=
N;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &amp;loo=
pinfo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tst_system(cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check_partition(1, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check_partition(2, false);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0change_partition(cmd_parted_new);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_RETRY_FUNC(ioctl(dev_fd, BLKRRPART, 0), =
TST_RETVAL_EQ0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tst_system(cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check_partition(1, true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check_partition(2, true);<br>
<br>
We allready use <span class=3D"gmail_default" style=3D"font-size:small"></s=
pan><span class=3D"gmail_default" style=3D"font-size:small"></span>TST_RETR=
Y_FN_EXP_BACKOFF() in there with 30 second<br></blockquote><div>=C2=A0</div=
><div><span class=3D"gmail_default" style=3D"font-size:small"></span>I have=
 to say<span class=3D"gmail_default" style=3D"font-size:small">,</span> for=
 most systems 30<span class=3D"gmail_default" style=3D"font-size:small"> se=
c</span>=C2=A0is long enough, but we <span class=3D"gmail_default" style=3D=
"font-size:small">definitely</span>=C2=A0got</div><div><span class=3D"gmail=
_default" style=3D"font-size:small">sporadically fails in larger-scale auto=
mation testing.</span></div><div><span class=3D"gmail_default" style=3D"fon=
t-size:small"></span>=C2=A0</div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
timeout isn&#39;t that enough? And if it isn&#39;t wouldn&#39;t simply incr=
easing<br>
the timeout to a minute or two fix the issue?<br></blockquote><div><br></di=
v><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">That should be better, I just have a try on my reproducible system,</div>=
</div><div class=3D"gmail_default" style=3D"font-size:small">but it does no=
t work=C2=A0with enlarged to 180 seconds.</div><div class=3D"gmail_default"=
 style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"=
font-size:small"><div class=3D"gmail_default">ioctl09.c:52: TPASS: access /=
dev/loop0p1 succeeds<br>octl09.c:47: TFAIL: access /sys/block/loop0/loop0p2=
 fails<br>Test timeouted, sending SIGKILL!<br>tst_test.c:1509: TINFO: If yo=
u are running on slow machine, try exporting LTP_TIMEOUT_MUL &gt; 1<br>tst_=
test.c:1511: TBROK: Test killed! (timeout?)<br></div><div class=3D"gmail_de=
fault"></div></div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">Note, the `<span clas=
s=3D"gmail_default"></span>udevadm=C2=A0<span class=3D"gmail_default"></spa=
n>settle` uses 180s as default timeout as well,</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">but it can=C2=A0work, I will=C2=A0look int=
o udevadm.c to see if that does</div><div class=3D"gmail_default" style=3D"=
font-size:small">something additional besides the waiting.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">If so, we might need to remove the=C2=A0=
<span class=3D"gmail_default"></span>TST_RETRY_FN_EXP_BACKOFF</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">from this test.</div></div><=
div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></d=
iv><div>Li Wang<br></div></div></div></div>

--000000000000c7812905dd152c05--


--===============0228254487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0228254487==--

