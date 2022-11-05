Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFE8C4332F
	for <ltp@archiver.kernel.org>; Sat,  5 Nov 2022 02:38:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 130A93CAE83
	for <ltp@archiver.kernel.org>; Sat,  5 Nov 2022 03:38:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 043FA3C7FCC
 for <ltp@lists.linux.it>; Sat,  5 Nov 2022 03:38:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5A701400335
 for <ltp@lists.linux.it>; Sat,  5 Nov 2022 03:38:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667615902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1A+vp0/PuOlI6OY6DxOrZcJSdHarRwoKeIns3u7bAM=;
 b=fokjnKnG0ranbs9MKosRNJief6GpyeNd6Qm8HghbCzRl5ePyGbcHdr43oDoqmHCqmchBgw
 zZqPwGJfwdZZQ5mbbrS/OTqZVLtz9ex9CMc9zhhygtATsFyeqb5xU+xEGgxz/F7WD3nm+O
 i0/UGJwVs9SvdpJb3LkRNan1epmF+WI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158--ht-MVcqPxqzl03JMvNv6w-1; Fri, 04 Nov 2022 22:38:20 -0400
X-MC-Unique: -ht-MVcqPxqzl03JMvNv6w-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13b273d54dbso3381563fac.10
 for <ltp@lists.linux.it>; Fri, 04 Nov 2022 19:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1A+vp0/PuOlI6OY6DxOrZcJSdHarRwoKeIns3u7bAM=;
 b=UIa/ABqez7fix27ZlcvltLQ52Runh+kE20bJaoNdGZcMmThBIVvYHlKn/vHphU1t59
 ge/XHP4rtSf3CNWXOZPmYGGsW7yYK4+RYVk+UW0moGroFfqJD+hAXQ3vuJdbDiSxtl9g
 6Il6N0fz3A8fzohbirE7YVIitxWgq/5EIAlzZ9C3n4pm18HcJzA3v1ZrzZhXQbyaoaGF
 oEBIUT/d1PlDJUyywINhxZWdnGtgs/KN52EYFmUSE+EOSrytEMTqyUm7UIQS1AsgVC9P
 Tzd+S/pu3BRYOnEK2N/0zr32uCOh3YxU3fKBS/mjZd1nQS2Ee6NpypdpBtWpf2/gCRnN
 RCRA==
X-Gm-Message-State: ACrzQf2XzoFrG9uNEC9d+D8gRbnO4oNGKYGAFPu+Duib7PB6AHK+K5ML
 JYu2gIBusiRStf20qDeizyKtRo3eE80/jRojRRYwZ782GEsQQz9Q/RzKpmogtCqkgEpeNgHiIEH
 3VpnQcKpVp0m/M+GCYlkRsRNMMLI=
X-Received: by 2002:a05:6870:40cc:b0:13c:d606:27e8 with SMTP id
 l12-20020a05687040cc00b0013cd60627e8mr20842264oal.107.1667615899849; 
 Fri, 04 Nov 2022 19:38:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM52qe3DSU3LjXB2Pl1bqQGZVlq/AKgUVUMyT3YfhCGqNPABZrC8IQJQR9s/Fzh83G5RbBu+xMFdjjP8rzv1T7Q=
X-Received: by 2002:a05:6870:40cc:b0:13c:d606:27e8 with SMTP id
 l12-20020a05687040cc00b0013cd60627e8mr20842255oal.107.1667615899581; Fri, 04
 Nov 2022 19:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221104092411.5446-1-andrea.cervesato@suse.com>
 <c9a2c8ce-9dfb-a001-fa93-10a669c0e228@suse.cz>
 <6597b3e7-2f24-6d6d-e0f9-976251518e21@suse.com>
 <051a74e3-0a6a-5fe3-3e10-24430c8e5a96@suse.cz>
In-Reply-To: <051a74e3-0a6a-5fe3-3e10-24430c8e5a96@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 5 Nov 2022 10:38:07 +0800
Message-ID: <CAEemH2fTFBiuejwvpxPEDQK_tfzJh3-pouHo0QLnjb8JjAmQug@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0453357965=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0453357965==
Content-Type: multipart/alternative; boundary="0000000000005121cf05ecb015e3"

--0000000000005121cf05ecb015e3
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 4, 2022 at 11:44 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 04. 11. 22 15:20, Andrea Cervesato wrote:
> > Hi!
> >
> > On 11/4/22 13:46, Martin Doucha wrote:
> >> This approach looks like it'll lead to some bad edge cases when
> >> 0 < time_step < 1000. It'd be better to keep the original time_step
> >> detection and initialize "error" variable like this (and also rename
> >> it to "margin"):
> >>
> >> int jiffy;
> >>
> >> verify_setitimer()
> >> {
> >>     ...
> >>     margin = (tc->which == ITIMER_REAL) ? 0 : jiffy;
> > Here we can't take in consideration CLOCK_MONOTONIC_COARSE resolution by
> > default, because on ITIMER_REAL we are having a clock resolution given
> > by CLOCK_MONOTONIC. And unfortunately we are not sure it's under the
> > millisecond resolution all the times, which means margin > 0. For this
> > reason, in the patch we are fetching clock resolution in a different
> > way, according with the counter timer. We can fetch different
> > resolutions from setup tho and using inside the test code.
>
> There is nothing preventing you from using CLOCK_MONOTONIC_COARSE
> resolution as time_step even for ITIMER_REAL. The only constraints are
> that the timer value must be:
> 1) higher than CLOCK_MONOTONIC resolution (preferably a multiple of it)



> 2) large enough so that you can call setitimer() again before the timer
> expires

Just finding a proper size should be fine, because next I plan to
split ovalue check from the signal test. That means we can give both
SEC and USEC for setitimer() verification.

Also, the interval timer should be tested as well, it will be rebased
(on this problem fixing) in a separate patch.


-- 
Regards,
Li Wang

--0000000000005121cf05ecb015e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Nov 4, 2022 at 11:44 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 04. 11. 22 15:20, Andre=
a Cervesato wrote:<br>
&gt; Hi!<br>
&gt; <br>
&gt; On 11/4/22 13:46, Martin Doucha wrote:<br>
&gt;&gt; This approach looks like it&#39;ll lead to some bad edge cases whe=
n<br>
&gt;&gt; 0 &lt; time_step &lt; 1000. It&#39;d be better to keep the origina=
l time_step <br>
&gt;&gt; detection and initialize &quot;error&quot; variable like this (and=
 also rename <br>
&gt;&gt; it to &quot;margin&quot;):<br>
&gt;&gt;<br>
&gt;&gt; int jiffy;<br>
&gt;&gt;<br>
&gt;&gt; verify_setitimer()<br>
&gt;&gt; {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0...<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0margin =3D (tc-&gt;which =3D=3D ITIMER_REA=
L) ? 0 : jiffy;<br>
&gt; Here we can&#39;t take in consideration CLOCK_MONOTONIC_COARSE resolut=
ion by <br>
&gt; default, because on ITIMER_REAL we are having a clock resolution given=
 <br>
&gt; by CLOCK_MONOTONIC. And unfortunately we are not sure it&#39;s under t=
he <br>
&gt; millisecond resolution all the times, which means margin &gt; 0. For t=
his <br>
&gt; reason, in the patch we are fetching clock resolution in a different <=
br>
&gt; way, according with the counter timer. We can fetch different <br>
&gt; resolutions from setup tho and using inside the test code.<br>
<br>
There is nothing preventing you from using CLOCK_MONOTONIC_COARSE <br>
resolution as time_step even for ITIMER_REAL. The only constraints are <br>
that the timer value must be:<br>
1) higher than CLOCK_MONOTONIC resolution (preferably a multiple of it)</bl=
ockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
2) large enough so that you can call setitimer() again before the timer <br=
>
expires</blockquote></div><div class=3D"gmail_default" style=3D"font-size:s=
mall"></div><div><div class=3D"gmail_default" style=3D"font-size:small">Jus=
t finding a proper size should be fine, because next I plan to</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">split ovalue=C2=A0check fro=
m the signal test. That means we can give both</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">SEC and USEC for setitimer() verification.<=
/div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div =
class=3D"gmail_default" style=3D"font-size:small">Also, the interval timer =
should be tested as well, it will be rebased</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">(on this problem fixing) in a separate patch.=
</div></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--0000000000005121cf05ecb015e3--


--===============0453357965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0453357965==--

