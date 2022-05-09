Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F91C433EF
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 07:25:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 803C93CA928
	for <ltp@archiver.kernel.org>; Mon,  9 May 2022 09:25:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A01D3CA907
 for <ltp@lists.linux.it>; Mon,  9 May 2022 09:25:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E8DC600687
 for <ltp@lists.linux.it>; Mon,  9 May 2022 09:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652081139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N32yrbHfzqomW/l1i7fxeZz3F7H64T4AJUq/Au4AVfo=;
 b=UuttjG6jGeGi5+h16M+3s/Y9PjW49US4a9T52jh2kT/ipAujSToJxVgsjzbfp72Hm90Be4
 zw7VSMNeG+T2mUnKir2gXZSUCiTVn+DKYF3m9dwcy06BHaV9y5metKzaf7zVcXIARKLd1x
 5x6UurM6MOC7/ohGuPX+VPftHhAvhrE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-9BYLiTzRMkiXaNkuHmDGjQ-1; Mon, 09 May 2022 03:25:38 -0400
X-MC-Unique: 9BYLiTzRMkiXaNkuHmDGjQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2f7c011e3e9so114556527b3.23
 for <ltp@lists.linux.it>; Mon, 09 May 2022 00:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N32yrbHfzqomW/l1i7fxeZz3F7H64T4AJUq/Au4AVfo=;
 b=gosKVqPpF+vdv96y0hAPDbTSp5Ur0hm5fJGx/EPGSKmoqazuSYuxxIeJwhkR/kaNqu
 TINZBV8MI2z8YOSPCsxoJN1j/dDAkbQebKYXWz4JsaS/VwrwDKQ2/i32VfYZTr2iqV3G
 scruExSWdxj7axoLmpqc7HmqKTBFT7eRdGYr+P7Xcv7+IMHhSW6O8kXoq9qE3MKxayGw
 0buIQZGj5C4iCAoDDYFf5Eg1q6iRLcpVLceBhRPZnWrlaMrOe4ES7fMuvZHUxInAgPfC
 1NF2MgcwIoCAx2eIaavRgTaX8ncy8XY37WWLFTU6w5xBesYPTw+xJd1YXxpK5ghghH6j
 dc0A==
X-Gm-Message-State: AOAM5307LnODqzRQbXcFqg6MKPjaqAu/tWns4vWlxO+tNtBT0MFdRc36
 KzvdS423nXLezyehEc6dQ9I1r5LAc/RmsGllgcZyWxRUbuMS7uFvCNxH5ObPfQl+0n0u1j4MwcE
 Exib7Rg3M2ArqvJOY8c67YUOHdYs=
X-Received: by 2002:a5b:8cb:0:b0:645:d65f:dcdd with SMTP id
 w11-20020a5b08cb000000b00645d65fdcddmr11443030ybq.233.1652081138026; 
 Mon, 09 May 2022 00:25:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzue64ElhJQYFwfJhTiKfkFY1izevOsRbaypo5KAuDxA9J3yWOPj74jqwB9inprjjWT4KgFe67FtIuNz0LzSUk=
X-Received: by 2002:a5b:8cb:0:b0:645:d65f:dcdd with SMTP id
 w11-20020a5b08cb000000b00645d65fdcddmr11443017ybq.233.1652081137774; Mon, 09
 May 2022 00:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <46c22201fe644cd7e96d24ef9110e2c643c8ec33.1651828441.git.jstancek@redhat.com>
 <YnUAR0pJx2dKIFvJ@pevik>
In-Reply-To: <YnUAR0pJx2dKIFvJ@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 9 May 2022 15:25:27 +0800
Message-ID: <CAEemH2eH1uF4J6vzsixnTutXby=YnvgfcTFmwxXQqeJVttS24A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/recvmsg01: wait for server to finish
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
Content-Type: multipart/mixed; boundary="===============0652089603=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0652089603==
Content-Type: multipart/alternative; boundary="0000000000005b87a805de8f1d25"

--0000000000005b87a805de8f1d25
Content-Type: text/plain; charset="UTF-8"

On Fri, May 6, 2022 at 7:02 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Jan,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>


Patch applied, thanks for the fix/review.


-- 
Regards,
Li Wang

--0000000000005b87a805de8f1d25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, May 6, 2022 at 7:02 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Jan,<br>
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<span class=3D"gmail_default" style=3D"font-size=
:small"></span></blockquote><div>=C2=A0</div><div><span class=3D"gmail_defa=
ult">Patch applied, thanks for the fix/review.</span>=C2=A0</div></div><br =
clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></d=
iv></div>

--0000000000005b87a805de8f1d25--


--===============0652089603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0652089603==--

