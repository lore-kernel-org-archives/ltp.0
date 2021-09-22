Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77965C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:40:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC33A61050
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC33A61050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 421463C87A2
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:40:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCE343C6A0B
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:39:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 540196008F2
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632303592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfLhJ/tHnjFXakL4beDO9zawARQW13+NxR/gMamSiwM=;
 b=Kn7yeqQAgHgdhtn2KTLCOzx8crcdyLs4qMmQYb/GAnJHHKdymw7+pzvxrTU7r6AkSmRl/+
 YDVUMJNHq1wL+LJuZ3nzSrSskejqU9un2f378XC1o5b7N8tdNMRM+8i5t4i7urax1pFOd6
 6mLnOsHQGM9YMIzW5pDKU30V7hedsJY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Yt5a-OYAPIylJXdpnlcVuA-1; Wed, 22 Sep 2021 05:39:51 -0400
X-MC-Unique: Yt5a-OYAPIylJXdpnlcVuA-1
Received: by mail-qk1-f198.google.com with SMTP id
 bj32-20020a05620a192000b00433162e24d3so8536712qkb.8
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 02:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RfLhJ/tHnjFXakL4beDO9zawARQW13+NxR/gMamSiwM=;
 b=LAUQoSytTFvKTMmaxvemWt2pxyYwx5VH2/L+SnX8ftCB5Qlo9shYLWmouqSL3Jytpt
 XQbkWNwtN7Q6Jl6Up23eqokhuIZv16CjAZre+2WTDwvuWSLgL3dUku/wmnay91xzwXPd
 XDhJv3alKPHsxXp/AJ958Z4TYJAg/JQGO//ffy6jQ/AMrYYFvpkoWgUR9rQtknnF3Hti
 pSNyGgTix18/7I2c+B9uuu6yn86+k5bI4rbY4b8SFWpayK+leM4kjhSiWi3atwAvykWR
 ZaVAe8XmSajA+DDy6RsoErwxirNR1RzTB2MQid9y79OZH2+pZxSbsTvYNinXxpefGfs5
 QwuQ==
X-Gm-Message-State: AOAM533akk4MEt+yOjhEEoEhaTsvzhh4tFWUNNS//pXLNRYD/uqzr9KL
 ZXaRBc9Z7d5K3rTxxjAqUD2lbT4wHVBtZkqgpYRHDpjLx/g7jomPw34pXQx2IMDAJz6po32E4Mc
 cJUv7unIlBp5boGgIRLiy8RLBGtc=
X-Received: by 2002:a05:6902:705:: with SMTP id
 k5mr44030428ybt.490.1632303590917; 
 Wed, 22 Sep 2021 02:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytCHFZHcinJ/YGl0xYmIpSojXdybb/2/LoBYECNFyAmZAurrTi1pvNG35++gBjaKFqbvg3K9dHskGbMZJuEc8=
X-Received: by 2002:a05:6902:705:: with SMTP id
 k5mr44030413ybt.490.1632303590704; 
 Wed, 22 Sep 2021 02:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210920122146.31576-1-chrubis@suse.cz>
 <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
 <YUnCYvtAZkO/LZIP@yuki>
 <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
 <YUrxJfAOO3+B8//7@yuki>
 <CAEemH2d=+h1k62SnVY8Rh=c0UGGEvvTQieW3YgUq8j2Mg6UW=g@mail.gmail.com>
 <YUr1ga3JSak7Gfry@yuki>
 <CAEemH2etot5qBfTWkk3JqRZ1ywTo75M7Vu-ZhXvnQgVqcZovBw@mail.gmail.com>
 <YUr4C3VOYI4qtS/F@yuki>
In-Reply-To: <YUr4C3VOYI4qtS/F@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 17:39:38 +0800
Message-ID: <CAEemH2eU-oDy6z_FmDQW2KjoGj25vOHxFeeXyOST0+ZwibZD6Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Content-Type: multipart/mixed; boundary="===============1886489723=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1886489723==
Content-Type: multipart/alternative; boundary="000000000000b09fc505cc924bd7"

--000000000000b09fc505cc924bd7
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 22, 2021 at 5:31 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > Agreed, that sounds like a great method.
> > >
> > > Should I send v3 or can I commit v2 with this change?
> > >
> >
> > V3 please, I will help test it all.
>
> Ok, will send ASAP.
>
Thanks.


>
> > I just think of setsid(), is that works and better than setpgid(0, 0)?
>
> For moving the process out of the process group setpgid() is enough, we
> use it in the lib/tst_test.c for the fork_testrun() in order to track
> all children of the test process as well.
>
> I do not think that we need a new session here, that would probably have
> strange side effects, for instance it would isolate the tst_timeout_kill
> process from the terminal the tests were started in.
>

Ok, thanks! Let's go with the safe method setpgid(0, 0).

-- 
Regards,
Li Wang

--000000000000b09fc505cc924bd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 5:31 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; &gt; Agreed, that sounds like a great method.<br>
&gt; &gt;<br>
&gt; &gt; Should I send v3 or can I commit v2 with this change?<br>
&gt; &gt;<br>
&gt; <br>
&gt; V3 please, I will help test it all.<br>
<br>
Ok, will send ASAP.<br></blockquote><div><span class=3D"gmail_default" styl=
e=3D"font-size:small">Thanks.</span></div><div><span class=3D"gmail_default=
" style=3D"font-size:small"></span>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
&gt; I just think of setsid(), is that works and better than setpgid(0, 0)?=
<br>
<br>
For moving the process out of the process group setpgid() is enough, we<br>
use it in the lib/tst_test.c for the fork_testrun() in order to track<br>
all children of the test process as well.<br>
<br>
I do not think that we need a new session here, that would probably have<br=
>
strange side effects, for instance it would isolate the tst_timeout_kill<br=
>
process from the terminal the tests were started in.<br></blockquote><div><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">Ok, thanks!=
 Let&#39;s go with the safe method setpgid(0, 0).</div></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b09fc505cc924bd7--


--===============1886489723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1886489723==--

