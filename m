Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B142BC433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 04:15:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D826F3CA2B5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 05:15:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E915E3CA2AE
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 05:15:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D336B2009C7
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 05:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646108112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uN6uut9JAQM0GW1B8xu1Mjb62iKZstdSoKhNDMzIiy8=;
 b=HR3mPj3iR8/1LDMV7dps7V6ydvCnx4Gpit/cntapxBUDX0+49Mzmpvf6bPkP3ysS+gorNt
 BokjAA7Co5pTi2xY8jmUNerywf5wPHlIgiHf2en6t6/FqHZwmCNiC6hQcqPFhDe7RrEkc9
 mtqg9I27CyzanRJgTiiuXbgIxR8jqYc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-WcvEQl2YM7yqc8qQxVan-Q-1; Mon, 28 Feb 2022 23:15:10 -0500
X-MC-Unique: WcvEQl2YM7yqc8qQxVan-Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2d6914a097cso117944487b3.10
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 20:15:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uN6uut9JAQM0GW1B8xu1Mjb62iKZstdSoKhNDMzIiy8=;
 b=lw9j29ly2uSpatKvpNUI85i0yfDqRuUOOqHa/uIpHr+L8rTS1IKrRlRmh4d0kEtF2v
 z9ft+ejpAPP2hHlgEERUkTnrMSfgsKlEgcXiIhfbVmn0hedsgKEOo8RaVTrJCncpdvnk
 ku3FXvUaa+BPReJcuuijOukB9lpcw226qDlXs6DPAIK911iv2rI1lHiIk45Grb3PUDLg
 p5jLiBuf5kywMQz4ldIwSYAYVr+xHNUmvBBfeB5s1uCkGCozqKGyhucJ2CfOagJEypBq
 mhdeiraFxwEZJ8EbXwxzmjoMKQm7Vj6/N+BG6zSaO2qVJn4pmViUkVqCO0Yve8P0eC6e
 3lBg==
X-Gm-Message-State: AOAM532vstQgtgICxKHJJ8SVylgfCuXV5fR4CDJfDOX6MxYTCRafiEtU
 J0zGFmh04d1fVxsheJLcOmqP2ONQ4NGaj1uaUnpNvlJTb3q2fAEtjL5X+RhZu7r0wgNqtrs2EQT
 T8ipq7kDkZTXkMJ7rR8S1kzA9sTA=
X-Received: by 2002:a25:76ca:0:b0:628:759f:7990 with SMTP id
 r193-20020a2576ca000000b00628759f7990mr1909421ybc.273.1646108110165; 
 Mon, 28 Feb 2022 20:15:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGGd2kOsGNFTUqzefbmYy4AvpdGlXAEwi5V2y/ZldmpEe5KWSkSuwsFDwT2EKjW5YN+gAebYYQPmhYYGO9JT4=
X-Received: by 2002:a25:76ca:0:b0:628:759f:7990 with SMTP id
 r193-20020a2576ca000000b00628759f7990mr1909407ybc.273.1646108109947; Mon, 28
 Feb 2022 20:15:09 -0800 (PST)
MIME-Version: 1.0
References: <20220222124547.14396-1-rpalethorpe@suse.com>
 <20220222124547.14396-3-rpalethorpe@suse.com>
 <20220222144511.GA12037@blackbody.suse.cz>
In-Reply-To: <20220222144511.GA12037@blackbody.suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Mar 2022 12:14:56 +0800
Message-ID: <CAEemH2csXLfe_3mXUprM6A8HpBwngJjxPz6uPEvk+5H_qQCQMg@mail.gmail.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] memcontrol04: Copy from kselftest
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0459986213=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0459986213==
Content-Type: multipart/alternative; boundary="00000000000027e7ae05d920697a"

--00000000000027e7ae05d920697a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2022 at 10:45 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:

> Hello.
>
> On Tue, Feb 22, 2022 at 12:45:47PM +0000, Richard Palethorpe <
> rpalethorpe@suse.com> wrote:
> > + * "First, this test creates the following hierarchy:
> > + * A       memory.low =3D 50M,  memory.max =3D 200M
> > + * A/B     memory.low =3D 50M,  memory.current =3D 50M
> > + * A/B/C   memory.low =3D 75M,  memory.current =3D 50M
> > + * A/B/D   memory.low =3D 25M,  memory.current =3D 50M
> > + * A/B/E   memory.low =3D 500M, memory.current =3D 0
> > + * A/B/F   memory.low =3D 0,    memory.current =3D 50M
> > + *
> > + * Usages are pagecache
> > + * Then it creates A/G and creates a significant
> > + * memory pressure in it.
> > + *
> > + * A/B    memory.current ~=3D 50M
> > + * A/B/C  memory.current ~=3D 33M
> > + * A/B/D  memory.current ~=3D 17M
> > + * A/B/E  memory.current ~=3D 0
>
> This nicely misses the expected consumption of the F cgroup (I see it's
>

+1



> missing in the original too). But one can expect from complementarity
> it's zero (if one accepts these values, which unfortunately is not true
> with hierarchical & scaled reclaim protection).
>
> > +             if (i < E || (i =3D=3D F && tst_cg_memory_recursiveprot()=
)) {
> > +                     TST_EXP_EXPR(low > 0,
> > +                                  "(%c low events=3D%ld) > 0", id, low=
);
> > +             } else {
> > +                     TST_EXP_EXPR(low =3D=3D 0,
> > +                                  "(%c low events=3D%ld) =3D=3D 0", id=
, low);
> > +             }
>
> Despite this makes the test behavior consistent, I think this is
> unexpected behavior with recursive_memoryprot. With the given
> configuration, there should never be residual protection that F assumes.
>
> Unless there is a good explanation [1], I'd consider non-zero
> memory.events:low in F the test failure here.
>

Hmm, the documentation does not give an explicit description for
recursive_memoryprot. If things like you said, it is more like a
CGroup bug in the kernel.

--=20
Regards,
Li Wang

--00000000000027e7ae05d920697a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 22, 2022 at 10:45 PM Michal Koutn=C3=BD=
 &lt;<a href=3D"mailto:mkoutny@suse.com">mkoutny@suse.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello.<br>
<br>
On Tue, Feb 22, 2022 at 12:45:47PM +0000, Richard Palethorpe &lt;<a href=3D=
"mailto:rpalethorpe@suse.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt=
; wrote:<br>
&gt; + * &quot;First, this test creates the following hierarchy:<br>
&gt; + * A=C2=A0 =C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.max =
=3D 200M<br>
&gt; + * A/B=C2=A0 =C2=A0 =C2=A0memory.low =3D 50M,=C2=A0 memory.current =
=3D 50M<br>
&gt; + * A/B/C=C2=A0 =C2=A0memory.low =3D 75M,=C2=A0 memory.current =3D 50M=
<br>
&gt; + * A/B/D=C2=A0 =C2=A0memory.low =3D 25M,=C2=A0 memory.current =3D 50M=
<br>
&gt; + * A/B/E=C2=A0 =C2=A0memory.low =3D 500M, memory.current =3D 0<br>
&gt; + * A/B/F=C2=A0 =C2=A0memory.low =3D 0,=C2=A0 =C2=A0 memory.current =
=3D 50M<br>
&gt; + *<br>
&gt; + * Usages are pagecache<br>
&gt; + * Then it creates A/G and creates a significant<br>
&gt; + * memory pressure in it.<br>
&gt; + *<br>
&gt; + * A/B=C2=A0 =C2=A0 memory.current ~=3D 50M<br>
&gt; + * A/B/C=C2=A0 memory.current ~=3D 33M<br>
&gt; + * A/B/D=C2=A0 memory.current ~=3D 17M<br>
&gt; + * A/B/E=C2=A0 memory.current ~=3D 0<br>
<br>
This nicely misses the expected consumption of the F cgroup (I see it&#39;s=
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">+1</div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
missing in the original too). But one can expect from complementarity<br>
it&#39;s zero (if one accepts these values, which unfortunately is not true=
<br>
with hierarchical &amp; scaled reclaim protection).<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &lt; E || (i =
=3D=3D F &amp;&amp; tst_cg_memory_recursiveprot())) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0TST_EXP_EXPR(low &gt; 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;(%c low events=3D%l=
d) &gt; 0&quot;, id, low);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0TST_EXP_EXPR(low =3D=3D 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;(%c low events=3D%l=
d) =3D=3D 0&quot;, id, low);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Despite this makes the test behavior consistent, I think this is<br>
unexpected behavior with recursive_memoryprot. With the given<br>
configuration, there should never be residual protection that F assumes.<br=
>
<br>
Unless there is a good explanation [1], I&#39;d consider non-zero<br>
memory.events:low in F the test failure here.<br></blockquote><div><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Hmm, the documenta=
tion does not give an explicit description for</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">recursive_memoryprot. If things like you sa=
id, it is more like a=C2=A0</div><div class=3D"gmail_default" style=3D"font=
-size:small">CGroup bug in the kernel.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div></div>-- <br><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></di=
v></div></div></div>

--00000000000027e7ae05d920697a--


--===============0459986213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0459986213==--

