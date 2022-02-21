Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B424CC433EF
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 01:57:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3021B3CA15C
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 02:57:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E61373C7021
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 02:57:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D39D11401102
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 02:57:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645408656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQ5iKRR23zogi9KjhtCj8bGdtDcFZQ+qGbNOFCBq1Iw=;
 b=gjxD8kFeAswpyzWXuFBau2PBeoY+0FCjaRxUuQP8rzPKrqclkpYp/N19n2mg6ZZTcOJdIG
 X2keZTGqihJzdY6HGG5S00xXW+BfFMiL4P7lMtaROKloozU5VaV4Qy+VsJy37jYzyTxwY4
 x6YVStSXD29lXcrGEnNJ6UnCMBQAjDc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-phGV7QL5MsibU43K9tSqOQ-1; Sun, 20 Feb 2022 20:57:34 -0500
X-MC-Unique: phGV7QL5MsibU43K9tSqOQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 o5-20020a25d705000000b0062499d760easo1227157ybg.7
 for <ltp@lists.linux.it>; Sun, 20 Feb 2022 17:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=ZQ5iKRR23zogi9KjhtCj8bGdtDcFZQ+qGbNOFCBq1Iw=;
 b=3EpZgDetd7AJezvPzTp6LEzglMVV7UfKiEOG2c8TIuxVX/2rC/ZEMD4lrIIAiBLhsZ
 ObEk3qdjfHVmHwbP+i+uz+mFKejku1NT3LMBJekzt3yNTjoUrmFaUu4YvGYOQU9GVqRK
 k9JFwHd1MEdFkBucdwAoGixj+YT9kmvaVlrbBC1aAGwpJQDsOvgQHYJieQVjKMaQYcQL
 AQF3NXApjKEKAe4Wy6FrvVBWYuJiIpDLEyQOuccMTnAaWg1VdNOuE3/nHrQC2dgNvHS7
 xV7/3R1YGWsspWncKvPBdjR0X/2mHTM+OYOiCwnIno394rWS49j9JJPwK6DHoluf+DhL
 W8Fw==
X-Gm-Message-State: AOAM533WASvnzWSxsVH3i7Gn1ZvyPNzqfg0zTIUnskOMmhomNvk4TdjB
 uoZoxst755Ld7RW2Bz2w7i/r9q18DJWJ4wAx/WLNhMQRfqLgLCJTcJ/NXWI+OwBHkTqYSMcJ/ae
 uCLlQE3im73I6859XH1D0s7fU8jU=
X-Received: by 2002:a81:1416:0:b0:2d6:83d3:6e1a with SMTP id
 22-20020a811416000000b002d683d36e1amr17364879ywu.370.1645408653555; 
 Sun, 20 Feb 2022 17:57:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxki9jlY+HS0X/Yb82w0rBEN/lcRW8H6Im5VZV9chpB/H8AlxoLOShNtsHGQpGtLj2jTdf/J6oKIPqtR4IiUrE=
X-Received: by 2002:a81:1416:0:b0:2d6:83d3:6e1a with SMTP id
 22-20020a811416000000b002d683d36e1amr17364866ywu.370.1645408653093; Sun, 20
 Feb 2022 17:57:33 -0800 (PST)
MIME-Version: 1.0
References: <20220208132414.2852202-1-liwang@redhat.com>
 <20220209085213.2882229-1-liwang@redhat.com> <YgzJwTxk7Lnf7uG+@rei>
 <CAEemH2dd0Ctejvx2bZvHVWHd4Q=3y1sguoq=-CLCZvTYZafEeQ@mail.gmail.com>
 <Yg5nllcFYkaFlWR/@yuki>
In-Reply-To: <Yg5nllcFYkaFlWR/@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Feb 2022 09:57:18 +0800
Message-ID: <CAEemH2eCWiMDe5iQsw=ES2Z=hHZmtHtdgbDGmUpW0W1GexCsRA@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrusage03: mlock all address space for
 process calling consume_mb
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
Content-Type: multipart/mixed; boundary="===============1493653290=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1493653290==
Content-Type: multipart/alternative; boundary="0000000000004749f805d87d8efc"

--0000000000004749f805d87d8efc
Content-Type: text/plain; charset="UTF-8"

Pushed, thanks.

-- 
Regards,
Li Wang

--0000000000004749f805d87d8efc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Pushed, thanks.</div></div><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr"><br></div></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--0000000000004749f805d87d8efc--


--===============1493653290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1493653290==--

