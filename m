Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF2C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 03:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEBB03C98B0
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 04:22:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FD283C2824
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 04:21:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23C3E20099E
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 04:21:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644290510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rMaZM/aWqhcf1ozblFxh/7FscmW5VKUJg3mmorLwEys=;
 b=dxO/hVeMqwlZRmKxlp4Uy62O0Ql4Ipw7BdGTbZd4yDvFk7n/XQrOrRXmSOaGuBDk5l4WGr
 u8DWJBMOn/4eCdfzk93EHZR5Ub7CIrqtxYzV7X2ay8D/KbcalnFePnEcKrRZIh/d1Q/HY4
 +n+tJ4WKc+rDFig0ZfTAU9L3OXNuPhw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-MH_xDupiMZaSwtg_CPilvw-1; Mon, 07 Feb 2022 22:21:49 -0500
X-MC-Unique: MH_xDupiMZaSwtg_CPilvw-1
Received: by mail-yb1-f198.google.com with SMTP id
 s73-20020a25aa4f000000b0061d764d3c13so16772916ybi.1
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 19:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rMaZM/aWqhcf1ozblFxh/7FscmW5VKUJg3mmorLwEys=;
 b=hbTDM0eu2W/xqLnamuRjXDZ5szK0y/3uNVOgKuf9QBJ32bwrBzSPuX8fDffQ2b43zB
 HftSyWRfao0x6laGj0ZxnI1IGPY7rueO/jy2scVL4h9Y3RVi5xmzC6x59iblDZPjeCl7
 l33V/lIwi0f1wtm0rmT7YqU7k5lTpUKZHHBgeiOvhA3x1lBOzVnxh2sPNKWUa6SuEae9
 XwK3LH6zYrXs0Ruz8oQU3c2X44k4GeQMHpK5rofhexcdfISXCPsb5e8ZGeA/Y3wMvBzi
 o1Dg9nGVB/A487RCAcDZDIJQNnMVuCdrA+XbceHcuT4HLQw7YfYLLE+11u8Ni1f9MaSy
 AT/Q==
X-Gm-Message-State: AOAM531g+JRtZkUS7GmgrJ8Ih79s0AynlRfq98JALvyRsAetfI5QuQwq
 nXDDqi4VvSg7Bo6yO4fvs0P5XIozPQtztzMcvC88x2gd9trSbOZ40PSQzHKRAt5pVksle70F0ln
 pQ6Dw6b4tOsSEnyGMsaGBkanwbD8=
X-Received: by 2002:a81:e543:: with SMTP id c3mr3098378ywm.370.1644290508617; 
 Mon, 07 Feb 2022 19:21:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUpxnsp5fvAPGqbZMYxUinvMU5Ede+GtjraX7xbTX6iQd37noqnzIrSBPvOroYYJ+qbLBM+p9jWu75o3CMypQ=
X-Received: by 2002:a81:e543:: with SMTP id c3mr3098359ywm.370.1644290508260; 
 Mon, 07 Feb 2022 19:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20220207040447.2803113-1-liwang@redhat.com>
 <YgEcbmGjGEaPgzAo@yuki>
In-Reply-To: <YgEcbmGjGEaPgzAo@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 11:21:31 +0800
Message-ID: <CAEemH2fJbRVh=fdVrMfxctZQYMCwmU5Zeep3s-MsG1=RPhL3ug@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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
Content-Type: multipart/mixed; boundary="===============1144447932=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1144447932==
Content-Type: multipart/alternative; boundary="000000000000a71f7905d77937e6"

--000000000000a71f7905d77937e6
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> > Notes:
> >     Ps. I also think we might need .min_mem_[avai|total] field but
> >         not sure if it is really necessary to add that.
>
> Actually this would be very useful from the long term perspective. If we
> ever manage to run tests in parallel the scheduller should make sure
> that we do not hit OOM due to running more than one processe that
> consume significant amount of memory at the same time.
>

Well, sounds useful to avoid OOM in the parallel run.
Hence the .min_mem should gives the requirement of minimal
MemAvailable(but not MemTotal) size on test system.

I will view the whole test to add that when I get a chance.



> Looks good:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Pushed (with the typo fix).

-- 
Regards,
Li Wang

--000000000000a71f7905d77937e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Notes:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Ps. I also think we might need .min_mem_[avai|total=
] field but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not sure if it is really necessary to=
 add that.<br>
<br>
Actually this would be very useful from the long term perspective. If we<br=
>
ever manage to run tests in parallel the scheduller should make sure<br>
that we do not hit OOM due to running more than one processe that<br>
consume significant amount of memory at the same time.<br></blockquote><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Well=
, sounds useful to avoid=C2=A0OOM in the=C2=A0parallel run.</div><div class=
=3D"gmail_default" style=3D"font-size:small">Hence the .min_mem should give=
s the requirement of minimal</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">MemAvailable(but not MemTotal) size on test system.</div><div=
 class=3D"gmail_default" style=3D"font-size:small">=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-size:small">I will view the whole test to =
add that when I get a chance.</div><br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
Looks good:<br>
<br>
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;<br></blockquote></div><div class=3D"gmail_d=
efault" style=3D"font-size:small"></div><div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">Pushed (with the typo fix).</div></div><div><br></=
div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div=
>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000a71f7905d77937e6--


--===============1144447932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1144447932==--

