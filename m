Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBECC43334
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 01:24:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B857D3C9442
	for <ltp@archiver.kernel.org>; Wed, 22 Jun 2022 03:24:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998093C61E5
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 03:24:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0FBC600918
 for <ltp@lists.linux.it>; Wed, 22 Jun 2022 03:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655861069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Utb3aFzW3/B8X/p+W7wmHU9Ul3y4YR/a9oU/T6Opv0A=;
 b=Tlxhfz2ZjWAPnyw4R3kaAbw3lAfZeVvyMXFeEhXbyeyvwv9lPE3ck+jJBwUBFbs4z4GmvZ
 lBlAl2g9mnAG2JKPRhNEuSppLsNdVKg7jOMrqODlaJ3ZidxjdWlB8kY+hIfzp/mh+cBI7/
 D/BO7Jd/yIYzPi6WCFVUSvEbxhPiBb8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-KqIEtyxoNs-an_Pu6_NUsg-1; Tue, 21 Jun 2022 21:24:27 -0400
X-MC-Unique: KqIEtyxoNs-an_Pu6_NUsg-1
Received: by mail-yb1-f199.google.com with SMTP id
 l6-20020a25bf86000000b00668c915a3f2so10149734ybk.4
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 18:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Utb3aFzW3/B8X/p+W7wmHU9Ul3y4YR/a9oU/T6Opv0A=;
 b=D3+Msq2K4j7tQ+S+QGGYg2LbZDbDe5XyLQbMKcWTdLDnYrR5qbEIcE9WnvsZhqDSyh
 IVGYJbk/a+RRSOF4jDpBGR4cbY86HX/eh71ssG0P8W04mYsYYZ97eg2xAxsNNddcBnYz
 utTqY+rUBVWcJzkRI6aDPnjG7bgl93Pk58i0VXWIeMfzJ2PQKGjIpP+b05gFYyUODF9r
 dYwwG3nWzCwQt664jEn1OW3/Gd11C9BImVo9GgryHF4OkWMQvXB9gyDwTihmue1F+kco
 UBw84i6bwWuac2KD6ZCvYbUGBw8B6NUtDqIQeZK7kMerpwlNO/uoOk4gdMH1axAsf2FB
 wOeg==
X-Gm-Message-State: AJIora8RtSDe53lSvNVxxTl2MBhk1mC+I3K40itKs3xjS21nMX0ZaoO6
 0lUXOD1Y/QkL3Y9wmDCDbVUDAfgBUZTDSdxATH56DTnrALEv/O7M/N9AGjeRUCSOeg45gqoNAeM
 kWeLKWgb0ofm1118UAsHXoAKULwU=
X-Received: by 2002:a25:b44b:0:b0:669:10c4:ccde with SMTP id
 c11-20020a25b44b000000b0066910c4ccdemr1160564ybg.412.1655861067151; 
 Tue, 21 Jun 2022 18:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ti7Rii/VX4IpMhbiOkwfWdB+OchJLDmYAuZe20/SG09KLnuclPwTEDndTmh6tICdnjTXwqr6rPAaotvdnBvJ4=
X-Received: by 2002:a25:b44b:0:b0:669:10c4:ccde with SMTP id
 c11-20020a25b44b000000b0066910c4ccdemr1160546ybg.412.1655861066820; Tue, 21
 Jun 2022 18:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220621034729.551200-1-liwang@redhat.com>
 <875yku5sjy.fsf@suse.de>
In-Reply-To: <875yku5sjy.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Jun 2022 09:24:15 +0800
Message-ID: <CAEemH2cwpeufbE4P5f6E-G+18ny0upcEqg+NDqebqAMUphxvbQ@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] madvise06: shrink to 3 MADV_WILLNEED pages to
 stabilize the test
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
Cc: Paul Bunyan <pbunyan@redhat.com>, Rafael Aquini <aquini@redhat.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0409142661=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0409142661==
Content-Type: multipart/alternative; boundary="000000000000af8d2f05e1ff3206"

--000000000000af8d2f05e1ff3206
Content-Type: text/plain; charset="UTF-8"

Richard Palethorpe <rpalethorpe@suse.de> wrote:

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Patch applied, thanks!

-- 
Regards,
Li Wang

--000000000000af8d2f05e1ff3206
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@su=
se.de">rpalethorpe@suse.de</a>&gt; wrote:</div><div dir=3D"ltr" class=3D"gm=
ail_attr"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Reviewed-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com"=
 target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br></blockquote><div><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">Patch applied, t=
hanks!</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--000000000000af8d2f05e1ff3206--


--===============0409142661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0409142661==--

