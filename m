Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54950C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:24:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 750F63CAAF2
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 13:24:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19A0B3CA948
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:24:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 839872003A0
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653045871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=slTjTxyXw+iBLoAQ60BoQmYaABNSRWuP2s++Kljp0uU=;
 b=LSyfJrkVBbjAEhLhojk5Agh/fjg9wuELhVuRkfKieklzHPZoY9U5PvQw7hjopKuqjlrQJe
 6swVgVva2nystElX1SbuyA8k1SemghgYUBJd/C7RilwKoLgICSQE8+4Jrfp7btcPJzcjh5
 rkPxZwXdNxI1C/iLi9KM6AcsK1KoGd8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-vSi05rAyPimFPvVqP5KvcQ-1; Fri, 20 May 2022 07:24:30 -0400
X-MC-Unique: vSi05rAyPimFPvVqP5KvcQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2fb7cb07885so69080617b3.23
 for <ltp@lists.linux.it>; Fri, 20 May 2022 04:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=slTjTxyXw+iBLoAQ60BoQmYaABNSRWuP2s++Kljp0uU=;
 b=PZCGjHCGpMPNJ4oY6t150qtlslPMpnmn7w/ADsfLDTpT8t0olaguL1evGGfPm0t1n2
 LQMb7TFv7IRC9MtaJ8ZeRrzuDBJvQ9ocSWhhlz1RfRl0fi2N7oXF4tp2721LF3nl6Esk
 bYTT1j0tyNrzyzlo/8leJfW1DMFBMlR6Dcd5P+I3IC5wWyczLWfpALU/w4N41P0egMdc
 fhtaMXh4XksrgaKDwzeDGWiCQrJrS/2XNrsGF319rR/KU4G21wDTvtVqKMvidm6vIYSU
 GSUUb2FoPoQdyz8H5p1BLwh79qR2OA3f76y/7AIWNH00WF9BabBZ7X8s+/uevwPRmU1t
 3N4A==
X-Gm-Message-State: AOAM5309oofpOboNAiZzwmlcc/RHZIfXUaccUEg+2sfpQeHpvJTUbxmH
 CpbKGvq7xnqGIu0S/fEsASTdyUQfqz3rySh9Ak356uONelw2CnFYHyTZMfLfb6tvOoAhEAR/LOq
 u6uNqV6+qrV10Z3jey1Gr2jmiiPY=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr9261880ywc.208.1653045869995; 
 Fri, 20 May 2022 04:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKVkkYipIMiFxRkv/D+tk6eLzycBuWhnI3inl/ZG96NtH4Mn1UegNej1lE5ePxR60FAPLaD12Ch1KPuiFNXMw=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr9261862ywc.208.1653045869767; Fri, 20
 May 2022 04:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220520083627.2499121-1-liwang@redhat.com>
 <20220520083627.2499121-3-liwang@redhat.com> <Yod19WafdD4AIdrg@yuki>
In-Reply-To: <Yod19WafdD4AIdrg@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 May 2022 19:24:18 +0800
Message-ID: <CAEemH2dx9vc9btte-i-ObgLp64De6xGeGVG7oxAL_qDWv1wacA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mmap3: reset runtime to 10s
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
Content-Type: multipart/mixed; boundary="===============1966335977=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1966335977==
Content-Type: multipart/alternative; boundary="000000000000dd8c2c05df6fbb4a"

--000000000000dd8c2c05df6fbb4a
Content-Type: text/plain; charset="UTF-8"

On Fri, May 20, 2022 at 7:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > As we have removed the "-x" support from this test, there is no way to
> > reduce running time by multiply small float number.
>
> Actually the -x has been replaced by -I so we may as well change the
> runtest file to pass -I instead.
>

Good to know, thanks!

>
> On the other hand I guess that the original runtime was way too long for
> a default value.
>
> > Let's set 10 seconds for the max_runtime (approximately equal to -x
> 0.002).
>
> If we are touching the code we may as well pick slightly longer
> interval, what about a minute so that we have chance to do some testing
> even on slower targets?
>

Make sense!

Feel free to add your amend when patchset merging,
I'd not send V2 to bring additional review work.

-- 
Regards,
Li Wang

--000000000000dd8c2c05df6fbb4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, May 20, 2022 at 7:03 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; As we have removed the &quot;-x&quot; support from this test, there is=
 no way to<br>
&gt; reduce running time by multiply small float number.<br>
<br>
Actually the -x has been replaced by -I so we may as well change the<br>
runtest file to pass -I instead.<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Good to know, thanks!</div><di=
v class=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
On the other hand I guess that the original runtime was way too long for<br=
>
a default value.<br>
<br>
&gt; Let&#39;s set 10 seconds for the max_runtime (approximately equal to -=
x 0.002).<br>
<br>
If we are touching the code we may as well pick slightly longer<br>
interval, what about a minute so that we have chance to do some testing<br>
even on slower targets?<br></blockquote><div><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Make sense!=C2=A0</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">Feel free to add your amend when patchset mergi=
ng,</div><div class=3D"gmail_default" style=3D"font-size:small">I&#39;d not=
 send V2 to bring additional review work.</div></div><div><br></div>-- <br>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<b=
r></div><div>Li Wang<br></div></div></div></div>

--000000000000dd8c2c05df6fbb4a--


--===============1966335977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1966335977==--

