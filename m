Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B14C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 02:20:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2700F3C9DAD
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 03:20:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6B9B3C8FB5
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 03:20:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CACAF6008BD
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 03:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644459615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cgwOerIBeWIG667UR0nYXJQGKv3pcIIK9bP2SRbdA/Q=;
 b=J8tXC8YiL8igCm0sRiWECYIq2zGQf6CYfvHWIe5jGu8PIl4UhNfE+S8kAMvaPwe6D1gC/v
 dWU49+DTiN8v63Tql9hco+OArhRUtbAKC0Ji0fpJZ9+PSI0mrnHV9gtV8L2/Y6t1ThnYFl
 X9QqrpWDLDpcnxHuWFnKNKYHFjmqGpQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-Saf6gkT_Pked7TMsAqcyQg-1; Wed, 09 Feb 2022 21:20:13 -0500
X-MC-Unique: Saf6gkT_Pked7TMsAqcyQg-1
Received: by mail-yb1-f199.google.com with SMTP id
 g205-20020a2552d6000000b0061e1843b8edso7913410ybb.18
 for <ltp@lists.linux.it>; Wed, 09 Feb 2022 18:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cgwOerIBeWIG667UR0nYXJQGKv3pcIIK9bP2SRbdA/Q=;
 b=OmYzV/gdvWvOZXpqclQ1GETUjerCO3ZuP3R7PgraTziw3NSbL5Mr4kx52K882OIop/
 lCm+54ox3LQ3ihb2cMUxyRAH13vHlzo7GHhQwni7spHO+NS3Lflvp+Y8AL38foELqECU
 qwC9/KiqbPjYtRUd+Iih/VvJn016jkd73pZxTdhpbarAzeU9IKNStZh7lDlrdVR7eElk
 TouGSCuUL8v19sNbxyvsMnewJPAenxpJBrwxH9cHjjHfmUqeXnbHVSuLlrnM77X396Qm
 XPF3IK2opdvcfvDIXrz1ETdrUl79CD2+oHY7nLa0TRizv6Rmi+QrHY8jXLEBij7bck6F
 1UkQ==
X-Gm-Message-State: AOAM532LXm3ASvTNUzzlsFwRjqKCgt3CI5b0lZNHF/VVnrxwJb2y/ola
 Ci1GVwehqsaRbpg85qzf2AIjx+driz1pZ4sW59YhJBec1Mnk+qkVsy7WxOquiEjbM+RPNZZ9a2t
 rQCPL53BFGEROLS1uaK0Fex4XLxE=
X-Received: by 2002:a25:45:: with SMTP id 66mr5163845yba.102.1644459613257;
 Wed, 09 Feb 2022 18:20:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyY3fvx2l5Qjj7UlYGGYdICUPUg30W3rSXqBZQ2g/X6SQ+rglWFc7DOcqUOutExR80oQT9mDZkhaViNGIXB36Y=
X-Received: by 2002:a25:45:: with SMTP id 66mr5163834yba.102.1644459613007;
 Wed, 09 Feb 2022 18:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
 <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
 <620095ED.1040808@fujitsu.com>
 <CAEemH2cs3-rBd+XTkh1A0ZtQxU-1WVx_pQtYGMyZX0zG48csew@mail.gmail.com>
 <YgO5XLFXQS+wxu4l@pevik>
In-Reply-To: <YgO5XLFXQS+wxu4l@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Feb 2022 10:19:58 +0800
Message-ID: <CAEemH2cHe-Mc9g=ScTH5F0c5_WmrvsvHSObsDVy0aa-ayz76zA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0484534361=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0484534361==
Content-Type: multipart/alternative; boundary="00000000000014c5f105d7a09710"

--00000000000014c5f105d7a09710
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 9, 2022 at 8:53 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Xu,
>
> > > In fact, we don't have mandatory rules that TAPSS or TFAIL only can
> > > occur one time. a example ie memcontrol02.c
>
> > Right, that is my hesitant part for counting that.
> > Seems many tests abuse the TPASS|TFAIL for defining test fail bound.
>
> OK, while it'd be useful for some tests, it'd be confusing due this for
> other.
> I guess printing (tst_test->tcnt * test_variants) number can be confusing
> either.
>

Agree, so we might need more time coming up with a better solution.
Or, we go another way to limit the abuse in TPASS|TFAIL in the test.

But both sound not easy at this moment.

-- 
Regards,
Li Wang

--00000000000014c5f105d7a09710
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Feb 9, 2022 at 8:53 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Li, Xu,<br>
<br>
&gt; &gt; In fact, we don&#39;t have mandatory rules that TAPSS or TFAIL on=
ly can<br>
&gt; &gt; occur one time. a example ie memcontrol02.c<br>
<br>
&gt; Right, that is my hesitant part for counting that.<br>
&gt; Seems many tests abuse the TPASS|TFAIL for defining test fail bound.<b=
r>
<br>
OK, while it&#39;d be useful for some tests, it&#39;d be confusing due this=
 for other.<br>
I guess printing (tst_test-&gt;tcnt * test_variants) number can be confusin=
g<br>
either.<br></blockquote><div><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">Agree, so we might need more time coming up with a bet=
ter solution.</div><div class=3D"gmail_default" style=3D"font-size:small">O=
r, we go another way to limit the abuse in TPASS|TFAIL in the=C2=A0test.</d=
iv><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">But both=C2=A0sound not eas=
y at this moment.</div></div><div><br></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<b=
r></div></div></div></div>

--00000000000014c5f105d7a09710--


--===============0484534361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0484534361==--

