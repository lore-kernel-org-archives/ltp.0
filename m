Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269B7C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 02:57:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 064663CA34E
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 03:57:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C92EF3C9894
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 03:57:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A340F6010DA
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 03:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646362624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0X0wHm2DNk9xZrDWh9vSF+R99wtYy0wGcdTM/ZX3tfI=;
 b=V1VWSP9eJv4xcpv0sZv/cVM7Lxy48o9I9MlEDeX8tpKJXa0Vp/GjBRrBmNAYlXOoJpAIsg
 JO8SNtL2mVBzAzHnR3l0xfJRB91grmdL+otPnAWvVGAbOWPCu+AikqiO2wdWEUO74/EiAs
 7f7RJbQ+drY3EhIHjzfwn9RODZlwfe8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-7DUdFOM7OaSQmpg6PbqLPg-1; Thu, 03 Mar 2022 21:57:03 -0500
X-MC-Unique: 7DUdFOM7OaSQmpg6PbqLPg-1
Received: by mail-yb1-f200.google.com with SMTP id
 x11-20020a5b0f0b000000b0062277953037so6131873ybr.21
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 18:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0X0wHm2DNk9xZrDWh9vSF+R99wtYy0wGcdTM/ZX3tfI=;
 b=jO8NPmF5jH/8zKRALh2DcoBfFB0gTCN9Kwn9XmAh9KlCgtwQrxmyynrX1nf0DQm+8u
 Ga0oR/Cm3o+kioW5iwrHnTgu4+f9EswfHQLYU9qHxqfGx+BzYsJ/hPRiQ97WY16K3tE7
 ehw4l/Aq+fXLbropevE7rLjyGYQa2KXMwZBgSkNxerISCQZlbbkmSZU6qLBFngUQqmeK
 iTXqjQVrk8U1k2SYOsOS4kStnbf0bDW8tDJDHmcSgLF2N+maibQfDWA+TqlVzsl9OCSx
 nQuzZdZE2gSFjsvI1I5l4P6hk1X+COD2aQe4GgLU99zGx6IWauvECDqbB6UYHgvlHq+Z
 mEFQ==
X-Gm-Message-State: AOAM533buSPxKnVCelyEppgmU2wR7lNdmoofWUuBJVv0r5MNwfzAG2tK
 0JiFyitbtGhQLSvReJzVpi+FD5vnDagYuXKtv3llo3S+H5wATzkT1SLOgv2TPwtH6vkn/+8j55h
 MnaJj2bJWYLiapMvxIBCQQ5Wt66M=
X-Received: by 2002:a81:1ec7:0:b0:2db:c58e:cd89 with SMTP id
 e190-20020a811ec7000000b002dbc58ecd89mr19223264ywe.25.1646362622896; 
 Thu, 03 Mar 2022 18:57:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRVhIU72C37kjgvysrjQz4jm9fOn0M3Im21MnNlrso0aUGIfjhm5ZOb73Rys6qIjmRE2bxgzwUyE+t8AG2Vhw=
X-Received: by 2002:a81:1ec7:0:b0:2db:c58e:cd89 with SMTP id
 e190-20020a811ec7000000b002dbc58ecd89mr19223250ywe.25.1646362622613; Thu, 03
 Mar 2022 18:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-7-chrubis@suse.cz>
In-Reply-To: <20220303145032.21493-7-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Mar 2022 10:56:49 +0800
Message-ID: <CAEemH2f1AHuaNpqW=XhMZ2sL6e1=PFPWmY5ZNxve60HaUrB9dg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/7] libs: libltpnuma: Fix free memory estimate
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
Content-Type: multipart/mixed; boundary="===============1777070032=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1777070032==
Content-Type: multipart/alternative; boundary="0000000000004af74c05d95bab15"

--0000000000004af74c05d95bab15
Content-Type: text/plain; charset="UTF-8"

> -       if (mem_total - mem_used < (long)min_kb) {
> +       if (mem_total - mem_used + (9 * file_pages)/10 < (long)min_kb) {
>                 tst_res(TINFO,
>                         "Not enough free RAM on node %i, have %likB needs
> %zukB",
>                         node, mem_total - mem_used, min_kb);
>

We'd better count that part in the output message as well.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000004af74c05d95bab15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mem_total - mem_used &lt; (long)min_kb) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mem_total - mem_used + (9 * file_pages)/10 =
&lt; (long)min_kb) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Not enough free RAM on node %i, have %likB needs %zukB&quo=
t;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 node, mem_total - mem_used, min_kb);<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">We&#39;d be=
tter count that part in the output message as well.</div></div><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by:=
 Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@=
redhat.com</a>&gt;</div><br></div></div><div><br></div>-- <br><div dir=3D"l=
tr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></d=
iv></div>

--0000000000004af74c05d95bab15--


--===============1777070032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1777070032==--

