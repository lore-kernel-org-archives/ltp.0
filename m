Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8B8C43219
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 10:01:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57F803CD14A
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 11:01:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81AC73CD10F
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:01:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6466D600353
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:01:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668506474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KyhGBQqQZgWoHwW3Fi31lL9N3OLxOuLq6bClMRCO7zg=;
 b=B8f7iZ9LS/ui6PMFhJIr7KBu+ylgihfqpT4ewVnumpWR0agLvMA5SBX/TFMe9lLdWPqHPV
 ZoNUvSWnil3rm5Rhj3il0OfN507lbpAU+JNpAt2WBqCVJ6HEOGFrf7MU9NfKbqbI/fV9GF
 s1UffIauKFNj4YtefEeTF0EvtSTS5js=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-wCJdCnSuPtOTMcPnYPBshQ-1; Tue, 15 Nov 2022 05:01:12 -0500
X-MC-Unique: wCJdCnSuPtOTMcPnYPBshQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 h188-20020a1c21c5000000b003cfe4cc64eeso38978wmh.6
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 02:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KyhGBQqQZgWoHwW3Fi31lL9N3OLxOuLq6bClMRCO7zg=;
 b=nMrdx7PaVKEQSXHdPBsZp+tsTKLAogKb3jMotzUduPqjOyuU3UfnRvOqrikEqTQCar
 etnzMhW4rlDq9R64bFQ/8hNhaCynkLn8bhklyv6Vo2aTapzrGu5qumzGJ6oEz0w+uWUP
 hSsP75A14XkGLpORFLzJlriX9sHiFAdfISozKXyoyvylwPaSeWj4FtjUBMN1iWyfcUjB
 tM99EYlKyTrBiGdWhuWSQwORo1dkkSUYwsbhzyZbzR5lU9OWoQjSvxR51QWI3Qn6BYQA
 fPwK6CGrevH0erVjusrEKrn3KBy9IjYYlE4pfucgrKCd/Gz9P/jLF1H0eSlPbnuqgyjC
 Ws+A==
X-Gm-Message-State: ANoB5pmFL47Kxv6yyn+A3BNdxsECIMRh1pgs9qfA/03wY004YPGkhXZ1
 bkQQtGt3D7YMWzr3aRlhMx3oLIPHpuaJdBBej++B9KVZmnk1no97avmn/2p8cRUmbrTJ5nyJyLJ
 SNdBYI+e2XJyW6DQJXMWuWR/ajx4=
X-Received: by 2002:adf:f54e:0:b0:236:877b:9cf6 with SMTP id
 j14-20020adff54e000000b00236877b9cf6mr9884155wrp.528.1668506471664; 
 Tue, 15 Nov 2022 02:01:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf59rfFBMd1Lq6qr8g3/8gBWUTFrfIzZ6w3zxRjnQmre5TIYyIsooud3gZPjhyzdS0leoKnD7isRsD3bdpDLBTw=
X-Received: by 2002:adf:f54e:0:b0:236:877b:9cf6 with SMTP id
 j14-20020adff54e000000b00236877b9cf6mr9884146wrp.528.1668506471423; Tue, 15
 Nov 2022 02:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
 <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
 <87h6z0sh8o.fsf@suse.de>
In-Reply-To: <87h6z0sh8o.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Nov 2022 18:00:59 +0800
Message-ID: <CAEemH2c-90baLEbom4yF8oVjh9n7O4uKkXS5SBmx2rSBRsZBBQ@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1652530086=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1652530086==
Content-Type: multipart/alternative; boundary="0000000000008901d705ed7f6f28"

--0000000000008901d705ed7f6f28
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> >
> >  Practically speaking we have to assume a large amount of time has passed
> >  when using ITIMER_REAL. It has to be *much* larger than a VM is likely
> >  to be paused for and then successfully resumed. Or the amount of time a
> >  clock may be corrected by (for e.g. with NTP).
> >
> > Hmm, not sure if I understand correctly above, will that
> > timer value be out of the range but reasonable?
> >
> > Or is there any additional situation we should cover?
>
> Sorry that is confusing.
>
> The question is what happens if the clock jumps backwards?
>
> I don't see anything which says it_value.tv_sec can't go out of
> range. OTOH I would expect it to compensate for large jumps in time.
>
> If the test randomly fails because it_value.tv_sec > time_sec then what
> action will we take?
>

How about increasing the time_sec on virtual machine?

Seems no perfect way to completely resolve but only reducing
the odds of happening.

Or do you have another better suggestion?

--- a/testcases/kernel/syscalls/setitimer/setitimer01.c
+++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
@@ -142,6 +142,11 @@ static void setup(void)

        time_sec  = 9 + time_step / 1000;
        time_usec = 3 * time_step;
+
+       if (tst_is_virt(VIRT_ANY)) {
+               tst_res(TINFO, "Running in a VM, multiply the time_sec by
10.");
+               time_sec *= 10;
+       }
 }


-- 
Regards,
Li Wang

--0000000000008901d705ed7f6f28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quot=
e"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 <br>
&gt;=C2=A0 Practically speaking we have to assume a large amount of time ha=
s passed<br>
&gt;=C2=A0 when using ITIMER_REAL. It has to be *much* larger than a VM is =
likely<br>
&gt;=C2=A0 to be paused for and then successfully resumed. Or the amount of=
 time a<br>
&gt;=C2=A0 clock may be corrected by (for e.g. with NTP).<br>
&gt;<br>
&gt; Hmm, not sure if I understand correctly above, will that<br>
&gt; timer value be out of the range but reasonable?<br>
&gt;<br>
&gt; Or is there any additional situation we should cover?<br>
<br>
Sorry that is confusing.<br>
<br>
The question is what happens if the clock jumps backwards?<br>
<br>
I don&#39;t see anything which says it_value.tv_sec can&#39;t go out of<br>
range. OTOH I would expect it to compensate for large jumps in time.<br>
<br>
If the test randomly fails because it_value.tv_sec &gt; time_sec then what<=
br>
action will we take?<br></blockquote><div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-size:small">How about increasing the time_sec on v=
irtual machine?</div><div class=3D"gmail_default" style=3D"font-size:small"=
><br></div><div class=3D"gmail_default" style=3D"font-size:small">Seems no =
perfect way to completely resolve but only reducing</div><div class=3D"gmai=
l_default" style=3D"font-size:small">the odds of happening.=C2=A0</div><div=
 class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">Or do you have another better sugg=
estion?</div><div class=3D"gmail_default" style=3D"font-size:small"><br></d=
iv>--- a/testcases/kernel/syscalls/setitimer/setitimer01.c<br>+++ b/testcas=
es/kernel/syscalls/setitimer/setitimer01.c<br>@@ -142,6 +142,11 @@ static v=
oid setup(void)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_sec =C2=A0=3D=
 9 + time_step / 1000;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_usec =3D 3 * tim=
e_step;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (tst_is_virt(VIRT_ANY)) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;Runni=
ng in a VM, multiply the time_sec by 10.&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_sec *=3D 10;<br>+ =C2=A0 =C2=A0 =C2=A0 }<b=
r>=C2=A0}<br><div class=3D"gmail_default" style=3D"font-size:small"></div><=
br></div><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div>=
</div></div>

--0000000000008901d705ed7f6f28--


--===============1652530086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1652530086==--

