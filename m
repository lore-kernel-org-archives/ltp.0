Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF564C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 06:35:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233F761178
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 06:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 233F761178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5423C7825
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 08:35:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A2013C2ADA
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 08:34:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7164600F06
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 08:34:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632292494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6J7slUyD9fPETmKPLZmE6r0bVOMYNvu30bv+ofZWrA=;
 b=TsL4m3W/GOQUhteHj9J5AiDv1jkdkTfnVNelyDFnhxvdvZoeoKJWhlEqv0cQn2VeuCBSAN
 EqFZ3dlH8sN/6b4viAUp6C8mf5c4PVbcmALaxWujMchjty83nkWhD1PvR/sznWMuMhOTWi
 Vc2rK2XG6Hb0KRDNWNqxZHd9mHbBR5Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-opuoRvbfMYOAAo5SF41-Fw-1; Wed, 22 Sep 2021 02:34:52 -0400
X-MC-Unique: opuoRvbfMYOAAo5SF41-Fw-1
Received: by mail-qt1-f199.google.com with SMTP id
 w10-20020ac87e8a000000b002a68361412bso7008553qtj.7
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 23:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u6J7slUyD9fPETmKPLZmE6r0bVOMYNvu30bv+ofZWrA=;
 b=cEgJ19TZ8p8Rr8qJoBZ2AXUrPxM1eZwhI9u5wo6qVkpazFFwBWqKq0Aa1IzoY/NeBx
 WAIoergaFO1Z/gFnhIFNa/bvVh5v0L/cklUlZrw+3wRVFFQ3az1aCRos/flVkitJKhwc
 f0jO93++Uya+1+Zf2v5566lYUUAvmognGg1gIcxqF8u87esevToC0zg25MefQrh/oSA5
 BxATRjJsKImXiLPW686w48h9MRSv/tOnUOB8TzN9UUtaavMFYbIHbF6MVGq5/IFIdGfF
 4R9qW8d4OGvEmJ5Un9wFgN1jMevTy08aWFUN4ygyodHb3I2U6flZ1IincbxJRTpRwqrG
 As2A==
X-Gm-Message-State: AOAM531zMXgsjBXIV6/1qy2jL0T/gHhTdQ32+GwdkdRozDMUJx82uy4y
 RX1PNxpSQgzTbTd6g5fl4riyTPXZz/4FoiQkLcsel6jWM9RLBIqBQWuVprJjjNKNJNK5gWp4ur9
 k0sknFBcvUCuiMXn1dXO9VaySvfA=
X-Received: by 2002:a25:938e:: with SMTP id a14mr41961694ybm.144.1632292492191; 
 Tue, 21 Sep 2021 23:34:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAEy0rLU5MuYymlmEC5PAV+/0RuaWNeOC4ZsJTjqIjbGTx57pVrx0y5gv/cuvfV2EyZ9B1TUCuidWvDwlugNo=
X-Received: by 2002:a25:938e:: with SMTP id a14mr41961676ybm.144.1632292491918; 
 Tue, 21 Sep 2021 23:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
In-Reply-To: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
From: Li Wang <liwan@redhat.com>
Date: Wed, 22 Sep 2021 14:34:39 +0800
Message-ID: <CAEemH2dQ7NyWSoSwEcyeug6phJKja5=affWzWxt0fQLvHrtODw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmat04: don't attach at specific address
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
Content-Type: multipart/mixed; boundary="===============0050103567=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0050103567==
Content-Type: multipart/alternative; boundary="000000000000269b6205cc8fb64a"

--000000000000269b6205cc8fb64a
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 22, 2021 at 12:46 AM Jan Stancek <jstancek@redhat.com> wrote:

> The test intermittently fails on ppc64le, when heap
> happens to overlap with segment that the test is trying
> to attach at 1GB boundary.
>
> Let the kernel find suitable address.
>

I'm not sure why the original way uses fixed address, but
it should be fine to cancel that limitation.

Reviewed-by: Li Wang <liwang@redhat.com>

Or, maybe we can consider doing range_is_mapped check
before using it.

-- 
Regards,
Li Wang

--000000000000269b6205cc8fb64a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 12:46 AM Jan Stancek &lt;<a=
 href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">The test intermitte=
ntly fails on ppc64le, when heap<br>
happens to overlap with segment that the test is trying<br>
to attach at 1GB boundary.<br>
<br>
Let the kernel find suitable address.<br></blockquote><div><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">I&#39;m not sure why =
the original way uses fixed address, but</div><div class=3D"gmail_default" =
style=3D"font-size:small">it should be fine to cancel that limitation.</div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a h=
ref=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">Or, maybe we can consider doing range=
_is_mapped check</div><div class=3D"gmail_default" style=3D"font-size:small=
">before using it.</div></div></div><div><br></div>-- <br><div dir=3D"ltr" =
class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Regards,<b=
r>Li Wang<br></div></div></div></div></div>

--000000000000269b6205cc8fb64a--


--===============0050103567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0050103567==--

