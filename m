Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63C5C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 09:46:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 617253C93C9
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 10:46:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA6B93C91FC
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 10:46:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3C0EF60081E
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 10:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647423994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEl5l0JUwHLLoTM9VFymzHaBsMF09Ru4UQwWInNIf4M=;
 b=esew7K+5qVQO9gtmvEUCwRisymBcVkboWpxfH9vJJ/eEJSnGkpgFoi43dAYPCAIUSmZlIj
 cocYjoMGtU75RF0w8C/Ppi0kMhJFhdNhkr9RqDUUYIugqeY0Umi7kD1zb23dh9QTQMtaLb
 2fsRGrQJsNlokHngq54+yyxBXwZdDjQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-vysrAh8YOxu0qvjYfTSI2A-1; Wed, 16 Mar 2022 05:46:33 -0400
X-MC-Unique: vysrAh8YOxu0qvjYfTSI2A-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2d726bd83a2so14299497b3.20
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 02:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEl5l0JUwHLLoTM9VFymzHaBsMF09Ru4UQwWInNIf4M=;
 b=4TxGCleTzPYkpVj4BFcYFyL4kpNuCZOqimDclb1+N/wkMKzzj5HlwLWZdsZOKcnF+c
 dG2r3iT5ZHX9OjYnZlG0lkm4Xzb0jjp3IueTeb739j7XSmhEapngPlpE0MphkvkYKoT1
 +PxlukxCVGg96dJXZJyI1ePWjk70fEMTdkjcTyu4YzJyxLAjJK4Sd7RdLI38i5nZ3RB4
 OJEQY43qGWIM+qEDdsEPa7Xmj285Q0Z4fiwGfVtn4eYUJUky7xKTkOI7Hi9WtRK2J7W5
 O0bk2juo2Wdhjyp5SWPbUVtiyNdKYpg7XYCilNvAqBKY+/p7kcTnifMP/MJIuJWtIy3j
 oAEQ==
X-Gm-Message-State: AOAM533s5wybRtfhyXZ0gR0rliEZuMd61KE+qw8Hiv0ys/8RqRhxobIp
 EkTcrLxibESlhKSbI5l6fgHiqzpFABxpX9HoW3rMu2+EVS/SKXVzsu89ibwsuReN6UvvJS1IM+F
 QNwGgk6iZ93GIAvt9NdZA/fwZrAE=
X-Received: by 2002:a25:4fc4:0:b0:633:25c8:7d9 with SMTP id
 d187-20020a254fc4000000b0063325c807d9mr16079529ybb.506.1647423992531; 
 Wed, 16 Mar 2022 02:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN6XE1brzaneRUlH8P5rgskkuQTqwZPrqfGlrXCuwdOxk68CrsZ/dXziAUQj2llF7UQp8U7uS6eFIMKnKCEPU=
X-Received: by 2002:a25:4fc4:0:b0:633:25c8:7d9 with SMTP id
 d187-20020a254fc4000000b0063325c807d9mr16079521ybb.506.1647423992368; Wed, 16
 Mar 2022 02:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <ef5d94799195f00c6ab1fffe612e62bf1ee530a7.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <87wnh6m2fp.fsf@suse.de> <87ilsqm1kg.fsf@suse.de>
In-Reply-To: <87ilsqm1kg.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Mar 2022 17:46:20 +0800
Message-ID: <CAEemH2fZN6k1hY1BE1dDWtQRi_8w2vBQH9c4EGxz-bRdaYNrFA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/16] controllers: Expand cgroup_lib shell
 library
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: multipart/mixed; boundary="===============0990385562=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0990385562==
Content-Type: multipart/alternative; boundary="000000000000dc23cc05da52c91a"

--000000000000dc23cc05da52c91a
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:



> >> +
> >> +    _cgroup_state=$(tst_cgctl require "$ctrl" $$)
> >> +
> >> +    [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No
> >state was set after call. Controller '$ctrl' maybe does not exist?"
>
> Perhaps we can just check the return status of tst_cgctl and exit the
> script if it is >0?
>

That should be work, but we need to check the _cgrou_state
at other places because many shell APIs require getting Cgroup
info, I guess this does not make things more easily if check the
return value only one time.


-- 
Regards,
Li Wang

--000000000000dc23cc05da52c91a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de"=
>rpalethorpe@suse.de</a>&gt; wrote:<br></div></div><div class=3D"gmail_quot=
e"><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 _cgroup_state=3D$(tst_cgctl require &quot;$ctrl&quo=
t; $$)<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 [ &quot;$_cgroup_state&quot; =3D &quot;&quot; ] &am=
p;&amp; tst_brk TBROK &quot;cgroup_require: No<br>
&gt;state was set after call. Controller &#39;$ctrl&#39; maybe does not exi=
st?&quot;<br>
<br>
Perhaps we can just check the return status of tst_cgctl and exit the<br>
script if it is &gt;0?<br></blockquote><div><br></div><div class=3D"gmail_d=
efault" style=3D"font-size:small">That should be work, but we need to check=
 the _cgrou_state</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">at other places because many shell APIs require getting Cgroup</div><div=
 class=3D"gmail_default" style=3D"font-size:small">info, I guess this does =
not make things more easily=C2=A0if check the</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">return value only one time.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000dc23cc05da52c91a--


--===============0990385562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0990385562==--

