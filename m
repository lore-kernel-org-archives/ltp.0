Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD68C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 09:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABF623CA51D
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 11:02:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2C453C0D24
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:02:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A10E22003AC
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 11:01:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649667718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Y+i7d+T3vgzP7KKrP+KBSxKEZUO1HS7PujTKRDh93I=;
 b=EQQhr43oqP/odo0iZjlUse90zTE21n1pu+jPWsDNivsSI5usW0NB0IQEAawwv1TzAXmF2X
 UT1qKUrqNnUgmVUhkxY3Q06Ct4wKB0oVVDDkeoFD7zbK/ZJx21dt99u3AX8FytYY18P8ov
 7Eykt6Rf/Cb0tLXD90oE4grx7R5LB0M=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-6FDB8xvsNoO6a2d_eeKEpg-1; Mon, 11 Apr 2022 05:01:56 -0400
X-MC-Unique: 6FDB8xvsNoO6a2d_eeKEpg-1
Received: by mail-yb1-f198.google.com with SMTP id
 o71-20020a25d74a000000b006410bd28f4eso5937633ybg.3
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 02:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Y+i7d+T3vgzP7KKrP+KBSxKEZUO1HS7PujTKRDh93I=;
 b=mX9rppkf94cOIhoHAj5diumrJzkCV95qftf+y2XhbUfxMy7agLQRetEHXaf9pO9BFF
 bfLX4QzpSWBOADyrEd4how6E9HmFgZLtILfqkBkMAvDbTILaY/CqM7E+3S4KvstA5k/h
 WyU4JiYLD6P7a5W4LFHv3iBkDc0UuGIwZPEXWLJ7TRmcoexgE9k7T7+i8HZCHsSv/AKf
 iB6lZrcgXLtmmEpBYU/UxtoY/MyxYLkOBOP1rG3/P98fVoHUCMlEeRoZLnuNCq+ilYlj
 uysju2kYt6Zvi1qmiyDGg/bOMqL23f4VqmZev2WhbXIY7qTsD9+f2G5nND7UFiUzbvCI
 dwGQ==
X-Gm-Message-State: AOAM530NaHMn3n0KXzk951aG70Se5ZnCcEQtpvy/9BGUZ2qHiIJEuJEr
 YaePvdfjOeOhcdqTWomChMOmWyRSLhqdbyXDuYji86TWkahmhwo1ezU0fQdDCs4WvHc1q0y1xOo
 iYUy2VtJAR7ZWCgGFCxMOzs2r7pw=
X-Received: by 2002:a25:b7c4:0:b0:633:602d:daa6 with SMTP id
 u4-20020a25b7c4000000b00633602ddaa6mr21192064ybj.273.1649667716059; 
 Mon, 11 Apr 2022 02:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0VTJM2oZQhELkC8DxRqSM2ymVaTXc4FcfbFINzrPjPA3WpP15Sy9SDrt445YktlrL1sgzU5gOVCxzIFoUqU4=
X-Received: by 2002:a25:b7c4:0:b0:633:602d:daa6 with SMTP id
 u4-20020a25b7c4000000b00633602ddaa6mr21192049ybj.273.1649667715712; Mon, 11
 Apr 2022 02:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220405170607.3596657-1-edliaw@google.com>
 <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
 <87sfqkggtq.fsf@suse.de>
In-Reply-To: <87sfqkggtq.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Apr 2022 17:01:41 +0800
Message-ID: <CAEemH2eh=AX6-DMW1UaVs+MGtqFXq8HoJD41D3paB93vQZ9ZUw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fzsync: break inf loop with flag vs
 pthread_cancel
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
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0256547963=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0256547963==
Content-Type: multipart/alternative; boundary="0000000000003160c105dc5d321e"

--0000000000003160c105dc5d321e
Content-Type: text/plain; charset="UTF-8"

Hi Richard, Edward,

On Mon, Apr 11, 2022 at 4:33 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:


> > Looking at tst_fzsync_run_a, if anything goes wrong in other places
> > (thread_b) and break with setting 'pair->exit' to 1 to end the looping.
> > It doesn't work for thread_a because tst_atomic_store(exit, &pair->exit)
> > will reset it back to 0 (int exit = 0).
>
> I don't think we have ever handled thread B breaking gracefully?
>

Right, that exist before Edward's patch :).



>
> If B breaks and it calls tst_fzsync_pair_cleanup then it will try to
> join to itself and we will probably get EDEADLK.
>

Exactly, maybe do something to make tst_fzsync_pair_cleanup
avoid joining to itself when the invoke come from B?



> > +                       tst_atomic_store(1, &pair->exit);
> > +                       usleep(100000);
>
> Why do we need usleep?
>

Seems not very needed.


-- 
Regards,
Li Wang

--0000000000003160c105dc5d321e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard, Edward,</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 11, 2022 at 4:33 PM Rich=
ard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.=
de</a>&gt; wrote:<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
&gt; Looking at tst_fzsync_run_a, if anything goes wrong in other places<br=
>
&gt; (thread_b) and break with setting &#39;pair-&gt;exit&#39; to 1 to end =
the looping. <br>
&gt; It doesn&#39;t work for thread_a because tst_atomic_store(exit, &amp;p=
air-&gt;exit)<br>
&gt; will reset it back to 0 (int exit =3D 0).<br>
<br>
I don&#39;t think we have ever handled thread B breaking gracefully?<br></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Right, that exist before Edward&#39;s patch :).<br></div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
If B breaks and it calls tst_fzsync_pair_cleanup then it will try to<br>
join to itself and we will probably get EDEADLK.<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">Exactly, m=
aybe do something to make tst_fzsync_pair_cleanup</div><div class=3D"gmail_=
default" style=3D"font-size:small">avoid joining to itself when the invoke =
come from B?</div><br></div><div>=C2=A0=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0tst_atomic_store(1, &amp;pair-&gt;exit);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0usleep(100000);<br>
<br>
Why do we need usleep?<br></blockquote><div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">Seems not very needed. </div></div><=
div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--0000000000003160c105dc5d321e--


--===============0256547963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0256547963==--

