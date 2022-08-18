Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23095C00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 09:59:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6690D3CA1E9
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 11:59:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A1B3C87EF
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:59:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 44EC41000601
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 11:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660816756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GuDCp/S+Xd+m/kGSYfynWG+uVGmM0um0b7MdcigIrm0=;
 b=QUfY3iGnu4cyDjR1qHiGTNf+/zCIkttJ7ffQnleBwD33ByA8e03FNR+Om1Yy7maAyMHYrr
 b1qM44u6AZfDvMUsilJs2NkfqRJQ8G8LcrbchMi3kx4AG36jBa2dzeEVUPC8rL/xYrkZew
 FLHsuqJ0bTbtN5WIuCg7ejbQGf5IIt4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-LpdLMr9CNOu-ddnUmB9jbg-1; Thu, 18 Aug 2022 05:59:15 -0400
X-MC-Unique: LpdLMr9CNOu-ddnUmB9jbg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-334228502a8so19080347b3.20
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 02:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=GuDCp/S+Xd+m/kGSYfynWG+uVGmM0um0b7MdcigIrm0=;
 b=jpEjZor4agLMKQCDBuoWRhPdefTidRLGpYYa9NH1Ug+KlL7OTarTY/c1FUuYANkB39
 xitjpN2gHX1T26zt3brH8zw+ZNkDMlEg4m6jwAnKVa4f2WqhyBRn2VHIYeXaJ+4IC8lp
 9LkzS1aMFf5pHU3aGT7NeyZRPOGSYwRROpJkm+ak5UfNbRssL/jGwzpNWbvXK0B0mXQK
 p4KgApAeDYMG7DIW1dTRk4oAAhZZss8XwDA9TQz7T1xamL9mkjHzpjlyeLf/6Ti7aXqh
 db4ZK60kCmDmQjThCn0JMMDddzrLdPOeMl+ZKO0AS/aT8AvGFdCK1KAkNNW5CwbZ1759
 vXYQ==
X-Gm-Message-State: ACgBeo3ovEycwxOgv9z1FraZgh1XK/ts4FZibpgYyr3Ds4flrOMLNKXa
 sRapNRk0Xa5tEH+XQMV2LFSCZaiznyt5NwHzC6NXVPx1PnfZBR4eu76GNxleGg7ikIO/wG0PMNl
 CYWhdVRPQQpvZg4Z31J2bhgcd9nE=
X-Received: by 2002:a25:a2c2:0:b0:683:daca:540d with SMTP id
 c2-20020a25a2c2000000b00683daca540dmr2061696ybn.301.1660816754783; 
 Thu, 18 Aug 2022 02:59:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4pASXpNcTedlBe/4NuVlo36V7p7QO+4dFJQ0Kmk7zv5oeZNuzQjqWLlcqY4Ojf+C8LthUm1OW/5Kn+pQ9Lp/Q=
X-Received: by 2002:a25:a2c2:0:b0:683:daca:540d with SMTP id
 c2-20020a25a2c2000000b00683daca540dmr2061680ybn.301.1660816754429; Thu, 18
 Aug 2022 02:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220818095030.1964355-1-liwang@redhat.com>
 <da253a0e-d082-9329-3392-aacee81e6c8d@fujitsu.com>
In-Reply-To: <da253a0e-d082-9329-3392-aacee81e6c8d@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Aug 2022 17:59:03 +0800
Message-ID: <CAEemH2cipQ-k1J7WEoNecqGJvDfXD2iz7zZOX+B9rv6oMkU5JQ@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: mask STATX_ATTR_COMPRESSED on tmpfs
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
Content-Type: multipart/mixed; boundary="===============0239867312=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0239867312==
Content-Type: multipart/alternative; boundary="000000000000af69e205e68108bf"

--000000000000af69e205e68108bf
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 18, 2022 at 5:55 PM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Li
>
> > Recently a new kernel commit (e408e695f) introduces the inode attributes
> > being supported in tmpfs, which is like other Linux file systems. But
> that
> > caused statx04 to throw an unsupported error in STATX_ATTR_COMPRESSED.
> >
> > This patch help masks it just like what we did for XFS.
>
> Looks good to me,
>

Thanks, I suddenly realized that we need to add the commit info into .tag
as well.

@@ -132,6 +139,7 @@ static struct tst_test test = {
                {"linux-git", "99652ea56a41"},
                {"linux-git", "04a87e347282"},
                {"linux-git", "5f955f26f3d4"},
+               {"linux-git", "e408e695f5f1"},
                {}
        },

-- 
Regards,
Li Wang

--000000000000af69e205e68108bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Aug 18, 2022 at 5:55 PM <a href=3D"mailto:x=
uyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a> &lt;<a href=3D"mail=
to:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Li<br>
<br>
&gt; Recently a new kernel commit (e408e695f) introduces the inode attribut=
es<br>
&gt; being supported in tmpfs, which is like other Linux file systems. But =
that<br>
&gt; caused statx04 to throw an unsupported error in STATX_ATTR_COMPRESSED.=
<br>
&gt; <br>
&gt; This patch help masks it just like what we did for XFS.<br>
<br>
Looks good to me,<br></blockquote><div><br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Thanks, I suddenly realized that we need to ad=
d the commit info into .tag as well.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div>@@ -132,6 +139,7 @@ static struct tst_test =
test =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quo=
t;linux-git&quot;, &quot;99652ea56a41&quot;},<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;linux-git&quot;, &quot;04a87e347282&=
quot;},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;l=
inux-git&quot;, &quot;5f955f26f3d4&quot;},<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 {&quot;linux-git&quot;, &quot;e408e695f5f1&quot;},<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 },<br><div class=3D"gmail_default" style=3D"font-size:sma=
ll"></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div><=
/div></div>

--000000000000af69e205e68108bf--


--===============0239867312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0239867312==--

