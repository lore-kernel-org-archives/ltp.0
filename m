Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C258FC433F5
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 09:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F27A3CA28A
	for <ltp@archiver.kernel.org>; Fri,  1 Apr 2022 11:43:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF4D33CA182
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 11:43:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE7261400DB4
 for <ltp@lists.linux.it>; Fri,  1 Apr 2022 11:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648806179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2gZGQyOCYPPxKaMFIKpImrdiCvN/5+geIkiMFXnh8A=;
 b=BvY6/o7WNo3wHM7vo+9KwzcS1hGraGALF3WTCCF1Y+v6DkO12rHtkgqbe3gwVfKNQtz+Pp
 AhoYF92aRuzVmjdDacJKwbJd8Dv6R8j2j/t3vUaO6MDyaKrkJw+c/vaZqIkJ9r05WrODZd
 aberpldi1HJURN9cwDXix+kCAzJ/NWU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-YWDluI2CNOC-siYBEdbiNA-1; Fri, 01 Apr 2022 05:42:55 -0400
X-MC-Unique: YWDluI2CNOC-siYBEdbiNA-1
Received: by mail-yb1-f199.google.com with SMTP id
 b11-20020a5b008b000000b00624ea481d55so1781138ybp.19
 for <ltp@lists.linux.it>; Fri, 01 Apr 2022 02:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X2gZGQyOCYPPxKaMFIKpImrdiCvN/5+geIkiMFXnh8A=;
 b=w5KPpp6MS4k7ESOKa0CDAIty5ira5+Je7rKP62qLw4935bJti/YDTuDHejCJg3kF/0
 MQ5u5tNkspSu6GmGTwQ1tMbRhZuvMmmZgsB20KyPlw83Rrk6AiDG0XcQRw5m8dAUn42c
 KgjMinsOGHiEWIfqnCBR+sC8DVAQTqaBU1G/AMzW1aIdW0KDXO0Cp4BCE8eii4mD9Y3U
 WCBXgM2GmIfQPBeZ+Ad6DWHYUtCWqxR7X8oDzgWo1CpqwRtpcfoLWXcEYyXYIIF10Ze2
 GxaLuIMqWhifFUdyrlOGKxPpnzqJIb0h/NKANh1pJ6qeSCKrlrFlc8TqgEvVB7Fc8Ld/
 XnEg==
X-Gm-Message-State: AOAM533WgTBYGYFlA5VJoWDJYxFZkoFZWmNyjoRxYpMcc7g/jZEEfoa+
 KABhBQhlaskI4Ce6D1aOkHi39dFbfTL+Tjo7PbZvLy4Bc50zOGn/G6A80TRL3g16z+pIFxJUdhl
 GKTaG5YNV5eTIVritOjwdKvS0dfI=
X-Received: by 2002:a25:780a:0:b0:633:ccea:3430 with SMTP id
 t10-20020a25780a000000b00633ccea3430mr7569883ybc.26.1648806174966; 
 Fri, 01 Apr 2022 02:42:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd5wWFVZXxrdqZCrB7JfXnRanT3JGoixS8/8HZsVTiMm7yqlH2PJL/uDxeCQAJJWsKbdpZ8sccIeOK0VtyHTo=
X-Received: by 2002:a25:780a:0:b0:633:ccea:3430 with SMTP id
 t10-20020a25780a000000b00633ccea3430mr7569875ybc.26.1648806174788; Fri, 01
 Apr 2022 02:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220401084124.801586-1-liwang@redhat.com>
 <YkbC4Fs2EO25qCVO@pevik>
In-Reply-To: <YkbC4Fs2EO25qCVO@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Apr 2022 17:42:40 +0800
Message-ID: <CAEemH2fi0QmxDuzrS=joHe7s7QvU7NjyPxFb70avmPj5D3-2yQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: resolve some no match arguments problem
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
Content-Type: multipart/mixed; boundary="===============2034177010=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2034177010==
Content-Type: multipart/alternative; boundary="0000000000005a292405db949a29"

--0000000000005a292405db949a29
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 1, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> Acked-by: Petr Vorel <pvorel@suse.cz>
> Thanks!
>
> I suppose this fix is for local run of this script on RHEL VM, right?
>

That's right. Pushed.

> Or is there some failure in CI I overlooked?
>

> No failures from CI, it is just to make the installation easier everywhere
:).


-- 
Regards,
Li Wang

--0000000000005a292405db949a29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Apr 1, 2022 at 5:16 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
Acked-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank=
">pvorel@suse.cz</a>&gt;<br>
Thanks!<br>
<br>
I suppose this fix is for local run of this script on RHEL VM, right?<br></=
blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">That&#39;s right. Pushed.</div><div class=3D"gmail_default" style=3D"=
font-size:small"></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Or is there some failure in CI I overlooked?<br></blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br>
</blockquote></div><div class=3D"gmail_default" style=3D"font-size:small"><=
/div><div class=3D"gmail_default" style=3D"font-size:small">No failures fro=
m CI, it is just to make the installation easier everywhere :). </div><br c=
lear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></di=
v></div>

--0000000000005a292405db949a29--


--===============2034177010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2034177010==--

