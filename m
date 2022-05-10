Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C25CC433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 13:16:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC563CA966
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 15:16:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D512A3C1BCA
 for <ltp@lists.linux.it>; Tue, 10 May 2022 15:16:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FFDE2001CD
 for <ltp@lists.linux.it>; Tue, 10 May 2022 15:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652188564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hzsjg5Oeqs1GS2bLgvXMNXnENlOg80uvMgABH8ZcJ1A=;
 b=T2M4q9PiPVJJG27iJAb8CNMEyiTk4f4WCPkH4USLFq44vj9mFyZCTAP2ug8IXWIXUcLSq9
 vgN+14MCbhGCIFENc/mD+C0uer9FkQINHyrYTSqQYthak/i+Dhvg1VuFHgnBmqQ8ZH4/zi
 5LALCIX3OtdEhbrxZBCGBCKxvw0sUPQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-kapd-TgKONKehcga8X2Erw-1; Tue, 10 May 2022 09:16:03 -0400
X-MC-Unique: kapd-TgKONKehcga8X2Erw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2f4dee8688cso145553177b3.16
 for <ltp@lists.linux.it>; Tue, 10 May 2022 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hzsjg5Oeqs1GS2bLgvXMNXnENlOg80uvMgABH8ZcJ1A=;
 b=rBQ5LiNkjV+bFh0t46eo6YR+8hmiKSPkFP4lO9sdG5NYxUfw4pFGyD2yjKfxDGnsMX
 gUCyj1R1G7uZEaamYwknMEM//9A2gg5lFAFmGVimWuT32ZokpdtTQLbu6OAZx5w+oI9J
 Vj9hRqHYn25yZT9K2W/bCSxHEyt9aMizOqEd/0oo4UyQNepDYk0D3AOYybnHUjl7nhui
 F/MzGxp2xiz3Sr7veyYAO2ya2xyKV9mbrZudzqtt4UJu8YeGSq9ueDiJCn1vGFZKmSZA
 615jbm/e5LLcQ0fqztJhWSM8/J2LICBIebr5J+oCBcSnshGJVeOrOFDYZx4iwfwgju2M
 Y8Jw==
X-Gm-Message-State: AOAM531R7fQGWQ7uHf+uqy82I9BL9XAh37yBBm1Kai1aA/T4BM+HwxhX
 EmXrDnOEG14VjLxQ/nN/Cpr076oECNYKNIFZuePx03JV5kdt+Z9Tkj955KAD7b5iLzp0KKK379M
 z2xkJ5zsXWT+hR921D40H0DgVDyY=
X-Received: by 2002:a25:dc8d:0:b0:648:6d03:28a4 with SMTP id
 y135-20020a25dc8d000000b006486d0328a4mr18435552ybe.211.1652188562510; 
 Tue, 10 May 2022 06:16:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkV49u9TRu5qrvEoF6SYeb8cFuhK2Di+q/Krbgi+RoGlvT9N1XOs1c1T/p69KLFa1pNzCSi5SERiY9xKzUX7c=
X-Received: by 2002:a25:dc8d:0:b0:648:6d03:28a4 with SMTP id
 y135-20020a25dc8d000000b006486d0328a4mr18435536ybe.211.1652188562347; Tue, 10
 May 2022 06:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-2-chrubis@suse.cz>
 <87a6bwe7ps.fsf@suse.de> <YnOdXct59/QFXd1Z@yuki> <87fslocm83.fsf@suse.de>
In-Reply-To: <87fslocm83.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 May 2022 21:15:51 +0800
Message-ID: <CAEemH2feHOWW_vb89Z6bbsZEgnzxu7Wje3XKvST-zyBCHYFXbw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 01/30] Introduce a concept
 of max runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1802645528=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1802645528==
Content-Type: multipart/alternative; boundary="0000000000005c6fde05dea82054"

--0000000000005c6fde05dea82054
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> >> > +  int max_iteration_runtime;
> >>
> >> It's not immediately clear if iteration refers to the inner test loop
> >> (e.g. Fuzzy Sync) or the outer loop performed by adding '-i N'. Perhaps
> >> it would be better to call it max_runtime and document that it is scaled
> >> by '-i N'?
> >
> > It's not only the -i N paramater, it's carthesian product of:
> >
> >       -i parameter x all_filesystems x test_variants
> >
> > And every single instance of that product is limited by the runtime
> > value, which is the reason I want to have iteration explicitly in the
> > name. Maybe we should call it instance instead or whatever else that may
> > be more fitting.
>
> I suppose it is the innermost runtime, so I would vote for inner_runtime
> or just runtime. However whatever it is called it will require
>

I do really have the same feelings here. I'm even afraid 'iteration' will
confused people who are not familiar with ltp-library.

From my comprehension, max_iteration_runtime takes effect on every
onefold test iteration, or maybe just directly rename to 'max_test_runtime'
(or max_runtime) with explanation in code comments.



> explanation. What is considered to be an iteration, instance, inner, test
> etc. is arbitrary.
>

Yes, includes "onefold" which hovers in my mind.


-- 
Regards,
Li Wang

--0000000000005c6fde05dea82054
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:</div></div><div class=3D"gmail_quote"><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt; &gt; +=C2=A0 int max_iteration_runtime;<br>
&gt;&gt; <br>
&gt;&gt; It&#39;s not immediately clear if iteration refers to the inner te=
st loop<br>
&gt;&gt; (e.g. Fuzzy Sync) or the outer loop performed by adding &#39;-i N&=
#39;. Perhaps<br>
&gt;&gt; it would be better to call it max_runtime and document that it is =
scaled<br>
&gt;&gt; by &#39;-i N&#39;?<br>
&gt;<br>
&gt; It&#39;s not only the -i N paramater, it&#39;s carthesian product of:<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-i parameter x all_filesystems x test_varian=
ts<br>
&gt;<br>
&gt; And every single instance of that product is limited by the runtime<br=
>
&gt; value, which is the reason I want to have iteration explicitly in the<=
br>
&gt; name. Maybe we should call it instance instead or whatever else that m=
ay<br>
&gt; be more fitting.<br>
<br>
I suppose it is the innermost runtime, so I would vote for inner_runtime<br=
>
or just runtime. However whatever it is called it will require<br></blockqu=
ote><div>=C2=A0</div><div><span class=3D"gmail_default" style=3D"font-size:=
small"></span>I do really have the same feelings here. I&#39;m even afraid =
&#39;iteration&#39; will</div><div class=3D"gmail_default">confused people =
who are not familiar with ltp-library.</div><div class=3D"gmail_default"><b=
r></div><div class=3D"gmail_default">From my comprehension, max_iteration_r=
untime takes effect on every</div><div class=3D"gmail_default">onefold test=
 iteration, or maybe just directly rename to &#39;max_test_runtime&#39;</di=
v><div class=3D"gmail_default">(or max_runtime) with explanation in code co=
mments.</div><div><span class=3D"gmail_default" style=3D"font-size:small"><=
br></span></div><div><span class=3D"gmail_default" style=3D"font-size:small=
"></span>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
explanation. What is considered to be an iteration, instance, inner, test<b=
r>
etc. is arbitrary.<br></blockquote><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-size:small">Yes, includes &quot;onefold&quot; which =
hovers in my mind.</div><br></div></div><div><br></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--0000000000005c6fde05dea82054--


--===============1802645528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1802645528==--

