Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5321CC43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 07:08:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75D123C9BA4
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 09:08:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 316053C1BEB
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 09:07:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B09BC1A0043E
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 09:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658387267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n8ZS9QOGyq1XReEQCDza3KDZs2CBXTeZFTeKEH1OIKY=;
 b=HDRaVEhjZL2tOfrbbmW7R4cTaPI7F7R4tvqkvwqt6vvghBvH6+PquVBwp12KeWlxBPcpF/
 6P6zZR4A/BrgO92Z+FrQcIdZ6pcfL+bsjrGHd2DW5V3zkMqR6jKqqmq2Pq5R9e1RRR505g
 hYfYCsN25HpgzVP22gibinOaL9eAK0A=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-u8GWF5X_M2SBG5PEfGybdw-1; Thu, 21 Jul 2022 03:07:44 -0400
X-MC-Unique: u8GWF5X_M2SBG5PEfGybdw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-31e62f7b377so7649777b3.17
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 00:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n8ZS9QOGyq1XReEQCDza3KDZs2CBXTeZFTeKEH1OIKY=;
 b=7M6VFl7qhd5ITaTldBeKkJZsu010dyEolW9L11VDG20EjA88g2OF3sVfuUeT+Xltx3
 Pn/kuelRyAmTtWiq6kaPkOheDAb6nGSdP1Azl8vEa511RoPN925osLaribaW55Oh5qt9
 tzgyK8Tcu29yvLpEifK3XWcYyTO/8c69iR6dkVzJnRdC9z11786JRF5YuMr5BJwD99Xw
 l9UKnaHplhguw7+YDnxRlW4qAyHTOZzHegi4GDqu4IrTp6oc0sCGf+NZH2iGtDh+3SkX
 YJceNKt7UccveWMu0E/uad5ZtytKoNcOk9wPqjFKWPO8GgcOAKoIkC7i8c1gJylpAFH4
 Z62A==
X-Gm-Message-State: AJIora/KE3wIebg8c+7zPRPel5kbuudEinFkOa7gIAhMv6qfks6xR/lS
 q3YRkXR0xabgHZ3ZCOhrTPvigqYUr+48mtsss8fBFPxQ5AQGhzHFDY/4km/x4+MO1PJnwMX98WI
 fEkYS75rgG0K6mtkAi18CYqq/1qA=
X-Received: by 2002:a25:34d2:0:b0:66f:fc01:5d7 with SMTP id
 b201-20020a2534d2000000b0066ffc0105d7mr26773106yba.412.1658387263956; 
 Thu, 21 Jul 2022 00:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sb8ZcRqcmTfZeQ4S+NVGD+uiIZv31/7dfD7lCjH47pp42lotG7gulcIfvI9scMPtOOXmjVRej+IRFRIXUQqqk=
X-Received: by 2002:a25:34d2:0:b0:66f:fc01:5d7 with SMTP id
 b201-20020a2534d2000000b0066ffc0105d7mr26773088yba.412.1658387263638; Thu, 21
 Jul 2022 00:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220720071743.28371-1-akumar@suse.de>
In-Reply-To: <20220720071743.28371-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Jul 2022 15:07:32 +0800
Message-ID: <CAEemH2dbXXHh-6PsMWtmo4gBmc5iWYAfbEe95U4_0jEK66b+Zg@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getitimer01.c: convert to new LTP API
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
Content-Type: multipart/mixed; boundary="===============1889576178=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1889576178==
Content-Type: multipart/alternative; boundary="000000000000bfe66705e44b5f48"

--000000000000bfe66705e44b5f48
Content-Type: text/plain; charset="UTF-8"

Hi Avinesh,

Avinesh Kumar <akumar@suse.de> wrote:


> +       for (i = 0; i < 3; i++) {
> +               TST_EXP_PASS(getitimer(itimer_name[i], &value));
> +               TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
> +               TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
>

This is just to verify getittimer() works well when there is none
of a specific interval timer being set.

Maybe we can add some more tests to check if it fully implements
the documented behavior? Or, at least confirming it gets expected
signals for different types of timers-specified is also necessary.

  ITIMER_REAL:         At each expiration, a SIGALRM signal is generated.
  ITIMER_VIRTUAL :  At each expiration, a SIGVTALRM signal is generated.
  ITIMER_PROF:        At each expiration, a SIGPROF signal is generated.

see: https://man7.org/linux/man-pages/man2/setitimer.2.html

-- 
Regards,
Li Wang

--000000000000bfe66705e44b5f48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Avinesh,</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Avinesh Kumar &lt;<a href=3D"mailto:akumar@suse.de">akumar@suse.de</a=
>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 3; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_PASS(getiti=
mer(itimer_name[i], &amp;value));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EQ_LI(value=
.it_value.tv_sec, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_EQ_LI(value=
.it_value.tv_usec, 0);<br></blockquote><div><br></div><div class=3D"gmail_d=
efault" style=3D"font-size:small">This is just to verify getittimer() works=
 well when there is none</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">of a specific interval timer being set.=C2=A0</div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">Maybe we can add some more tests to check if=
 it fully implements</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">the documented behavior? Or, at least confirming it gets expected</di=
v><div class=3D"gmail_default" style=3D"font-size:small">signals for differ=
ent types of timers-specified is also necessary.</div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><span class=3D"gmail_default" s=
tyle=3D"font-size:small">=C2=A0 </span>ITIMER_REAL<span class=3D"gmail_defa=
ult" style=3D"font-size:small">:</span> <span class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0</span><span class=3D"gmail=
_default" style=3D"font-size:small"></span>=C2=A0At each expiration, a SIGA=
LRM signal is generated.=C2=A0</div><div class=3D"gmail_quote"><span class=
=3D"gmail_default" style=3D"font-size:small">=C2=A0 </span>ITIMER_VIRTUAL<s=
pan class=3D"gmail_default" style=3D"font-size:small"> :</span> <span class=
=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0At each expiratio=
n, a SIGVTALRM signal is generated.=C2=A0</div><div class=3D"gmail_quote"><=
span class=3D"gmail_default" style=3D"font-size:small">=C2=A0 </span>ITIMER=
_PROF<span class=3D"gmail_default" style=3D"font-size:small">:</span> <span=
 class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 </s=
pan><span class=3D"gmail_default" style=3D"font-size:small">=C2=A0</span>At=
 each expiration, a SIGPROF signal is generated.</div><div class=3D"gmail_q=
uote"><br><div class=3D"gmail_default" style=3D"font-size:small">see:=C2=A0=
<a href=3D"https://man7.org/linux/man-pages/man2/setitimer.2.html">https://=
man7.org/linux/man-pages/man2/setitimer.2.html</a></div></div><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000bfe66705e44b5f48--


--===============1889576178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1889576178==--

