Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB671C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 09:46:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C96F43CB186
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:46:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A27E3CA95C
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:46:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A8E5620091F
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 11:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666259168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c45WMMy/lvV8+Oy4YYe8GgoR930purBG8O2Rb29eRLA=;
 b=MDvm4IdL/b9Q8YuxpWaTN7ao54o7Sq/lwfUitJ6hVELYzJRtsBR9hsoKGH7WFQ+2uAfkd1
 nCX5hcyavCwJRhW+gqB4ZIdXt0EcxaDC7GTJinKbflw4a1SBWwUY0c4kA8H8p2dQHW4ZXW
 NZEzPZpLD9HgQeKvuYlvmh9BlGLG60g=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-FgjM_bO1MwWfp83oRfNWhw-1; Thu, 20 Oct 2022 05:45:59 -0400
X-MC-Unique: FgjM_bO1MwWfp83oRfNWhw-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1331cbf6357so9571829fac.11
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 02:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c45WMMy/lvV8+Oy4YYe8GgoR930purBG8O2Rb29eRLA=;
 b=VRdXwCDCpnJapWaQVuYJcBcnh7v+Mz16F7ac81TFSm85dL6sLeFRi4+z8gI7INm3Dx
 06F8I9uwDSo6raDp8/LsOHo5MRk4V7CbgY7cA69Z5xXirkWTYAWKctLDXturPN0a5yNw
 6J6BEcCzEoR1oMPf0sb75FqkemYpvGSksKzRmWvtf8Kzn0BQcB43rxiVIGUyANXMpYp/
 nID9jIAdN0GjV2DQablc9/EfLKC2raoJ8mkkyB2vnQutX8G5zFOiZyNQpBdbD41O3J9W
 jQO6hQBhh40scekzaSp7k/QWQWXBej8gDDOKnBpH0ke1UkIPum2gzyoEc0h6mrWYqEQI
 gw4g==
X-Gm-Message-State: ACrzQf0MfYnTT3dj4mqpRvtwcPmtjRMil8r6nF+I0jiElh8ZxAq1ddG7
 4m3KCWAkeDcOPy5xh+YN+iq5vf2SVUTV37yjLuLQA3Z2N2OZJNp3SuoH7TzHXUAZCsbxPlB75wX
 928atwvhEad1qaNcsrs7kOZO9H68=
X-Received: by 2002:a05:6808:1704:b0:351:43bc:5e52 with SMTP id
 bc4-20020a056808170400b0035143bc5e52mr21472345oib.107.1666259156230; 
 Thu, 20 Oct 2022 02:45:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61TpjeRQR1oJSuLMCfvBjGoEsApRS/1tfdHjI6VYIVamxl0XXcsfjhzeTeZT5O3/SnRfwHmE8cwhFKujvOXpE=
X-Received: by 2002:a05:6808:1704:b0:351:43bc:5e52 with SMTP id
 bc4-20020a056808170400b0035143bc5e52mr21472335oib.107.1666259156047; Thu, 20
 Oct 2022 02:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221009065520.3236525-1-liwang@redhat.com>
 <20221009065520.3236525-2-liwang@redhat.com>
 <875ygex5ob.fsf@suse.de>
 <CAEemH2fq9qrr3vag3TOHNh_DE9u7s8TfEbr+ZwEPkj6jy1wZ2w@mail.gmail.com>
In-Reply-To: <CAEemH2fq9qrr3vag3TOHNh_DE9u7s8TfEbr+ZwEPkj6jy1wZ2w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 17:45:43 +0800
Message-ID: <CAEemH2e1wkUL_ntOE-7R0UpLDospNTFegEa1TJTC3Jem1v5ucw@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setitimer03: convert to new API
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
Content-Type: multipart/mixed; boundary="===============1837232463=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1837232463==
Content-Type: multipart/alternative; boundary="00000000000019af2005eb7431ec"

--00000000000019af2005eb7431ec
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 20, 2022 at 5:30 PM Li Wang <liwang@redhat.com> wrote:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>
>> > -static struct itimerval *value;
>> > +static struct itimerval *value, *ovalue;
>> > +
>> > +static struct tcase {
>> > +       int which;
>> > +       struct itimerval **val;
>> > +       struct itimerval **oval;
>> > +       int exp_errno;
>>
>> There is a whitespace error here (see checkpatch/make check)
>>
>
> yes, thanks.
>
>
>
>>
>> > +} tcases[] = {
>> > +       {ITIMER_REAL,    &value, &ovalue, EFAULT},
>> > +       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
>> > +       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
>> > +};
>>
>> Why do we need value and ovalue in the struct?
>>
>
> Becuase it does not allow parsing an invalid pointer address
> from a structure, we have to give a valid address which pointer
> to save an invalid address. Otherwise segement fault will
> be hit in execution.
>

On the other side, it also does not allow to initializer element
is not constant in structure. So the two-level pointer is only the
way I can make all things comprised here.

-- 
Regards,
Li Wang

--00000000000019af2005eb7431ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Oct 20, 2022 at 5:30 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small">Richard Palethorpe &lt;<a href=3D"mail=
to:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote=
:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; -static struct itimerval *value;<br>
&gt; +static struct itimerval *value, *ovalue;<br>
&gt; +<br>
&gt; +static struct tcase {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int which;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **oval;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int exp_errno;<br>
<br>
There is a whitespace error here (see checkpatch/make check)<br></blockquot=
e><div><br></div><div><div style=3D"font-size:small">yes, thanks.</div><br>=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +} tcases[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_REAL,=C2=A0 =C2=A0 &amp;value, &am=
p;ovalue, EFAULT},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_VIRTUAL, &amp;value, &amp;ovalue, =
EFAULT},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{-ITIMER_PROF,=C2=A0 =C2=A0&amp;value, &am=
p;ovalue, EINVAL},<br>
&gt; +};<br>
<br>
Why do we need value and ovalue in the struct?<br></blockquote><div><br></d=
iv><div><div style=3D"font-size:small">Becuase=C2=A0it does not allow parsi=
ng=C2=A0an invalid=C2=A0pointer address</div><div style=3D"font-size:small"=
>from a structure, we have to give a valid address which pointer</div><div =
style=3D"font-size:small">to save an invalid address. Otherwise segement fa=
ult will</div><div style=3D"font-size:small">be hit in execution.</div></di=
v></div></div></blockquote><div><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">On the other side, it also does not allow=C2=A0to ini=
tializer element</div><div class=3D"gmail_default" style=3D"font-size:small=
">is not constant in structure. So the two-level pointer is only the</div><=
div class=3D"gmail_default" style=3D"font-size:small">way I can make all th=
ings comprised here.</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--00000000000019af2005eb7431ec--


--===============1837232463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1837232463==--

