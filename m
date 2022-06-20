Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8734C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 08:29:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD45F3C9203
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 10:28:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14FDB3C8F89
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 10:28:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1CD10200751
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 10:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655713724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LzzheY76eBuXdemd53cJ/EboPgerb2G2SF3hzrnrctQ=;
 b=QTYKHBq54F+vZ4cYaXXWeYtBShHsIZoUAtkQuufA63H0/FXeLPMQ4M5++l2CJ4dtACAu4o
 8J5mYd0OM1gc4D9ihDf1h5QExu9vXrzJvDd6f6ESgPYRWkK6XnfL+GLEMMCGhsGQTWjT0q
 4aE+C9yuNettoTeWgOhEucq63DdWUwY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-woM_K23CPNSc3dl6LYPayg-1; Mon, 20 Jun 2022 04:28:41 -0400
X-MC-Unique: woM_K23CPNSc3dl6LYPayg-1
Received: by mail-yb1-f197.google.com with SMTP id
 n124-20020a25d682000000b00668ca3ee0edso5502826ybg.21
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LzzheY76eBuXdemd53cJ/EboPgerb2G2SF3hzrnrctQ=;
 b=FzyV7Fwz8AV0Qtdx6p0K3zOsC6yTqbZcczgCsbGrJbyBzRvMb/hfD7vspD/QOb2NE7
 WGMwTUnqo7rUIiI4Ogr4u9JiNYLBCFSdTruXpXEAJStAussLEGrS+rDl6l3ncTnvM2X0
 0Sl2014xnGqPPZdZWTk8W6UXKK7c0gP7kcZU3ptshURBWrpPypfFowpbZv+ZoYE/3FYm
 N5fUIKo7hrq5PZ0Mh2kxinT28AyqNyAG1aZt4tbFap7UGQhijVuvTv9vaEbl4jSUkwx4
 r8mEQYk5Lg9tLWxDjbkDfw/Q2r2unfBZLxgOhXHE2CmtVxdK13XJUnHcz9WLA0ig2S9v
 GO/A==
X-Gm-Message-State: AJIora/GVtaFtr6yHmqvjLkhZd1NvljKe9wDlDpDwWKKJxDJOchxVkIx
 OCLAIS2JQ3UduDiv9IcE/l5yFZQPEQiP9oCPUdjLrjZeiqgE74gXw5MYH8rlB70oRHdS/83Dg4G
 AnOiXnyb37+FbcbQ2+KeUHMe/UU4=
X-Received: by 2002:a81:a242:0:b0:317:5a3b:3fc8 with SMTP id
 z2-20020a81a242000000b003175a3b3fc8mr25750021ywg.424.1655713720859; 
 Mon, 20 Jun 2022 01:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uoDgGe7aPyd2HEwQVh60lW2jFCGfbiT86+RJFwv/SykRZSfsPnq8B1QBrto8xsxTBB8e0Q5RbzT3mVjJ2Lbas=
X-Received: by 2002:a81:a242:0:b0:317:5a3b:3fc8 with SMTP id
 z2-20020a81a242000000b003175a3b3fc8mr25750008ywg.424.1655713720695; Mon, 20
 Jun 2022 01:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220615090648.405100-1-liwang@redhat.com>
 <875yl1jbkq.fsf@suse.de>
 <CAEemH2egR16PDbTASg9pJxBdY3w8B_=XEf+Du9hbLaqR0X3Wsw@mail.gmail.com>
 <87a6a769kt.fsf@suse.de>
In-Reply-To: <87a6a769kt.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jun 2022 16:28:29 +0800
Message-ID: <CAEemH2d39rr4skmrTiMhSO1LVHKfn9mTmV1-KX0E6CaL6PbCPA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] madvise06: shrink to 1 MADV_WILLNEED page to
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
Content-Type: multipart/mixed; boundary="===============0353453204=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0353453204==
Content-Type: multipart/alternative; boundary="0000000000002c11b605e1dce469"

--0000000000002c11b605e1dce469
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

Richard Palethorpe <rpalethorpe@suse.de> wrote:


> >  Adding the loop makes sense to me. However I don't understand why you
> >  have also switched from PASS_THRESHOLD to only a single page?
> >
> > In the test, we use two checks combined to confirm the bug reproduces:
> >
> >   1. swap cached increasing less than PASS_THRESHOLD_KB
> >   2. page_fault number large than expected
> >
> > The 2. case is more easily get failed on kind of platforms and hard
> > to count an average value for tolerating. So maybe we just reduce
> > the page to one that would not affect the final result. Because we
> > rely on both checks happening simultaneously then assume a bug.
> >
> >
> >
> >  I guess calling MADV_WILLNEED on a single page is the least realistic
> >  scenario.
> >
> > Okay, perhaps it's a step backward:).
> >
> > I was just thinking it is a regression test and if 1 page works to
> reproduce
> > that (but more chunks of memory easily cause false positive), why not.
>
> That makes sense, but this test has also found other bugs. I'm not sure
> if they are reproducible with only one page.
>

Indeed.



>
> >
> >
> >
> >  If there is an issue with PASS_THRESHOLD perhaps we could scale it based
> >  on page size?
> >
> > This sounds acceptable too.
> >
> > How many pages do you think are proper, 100 or more?
> > and, loosen the faulted-out numbers to 1/10 pages?
>
> I suppose that 100 pages would be too much memory on some systems. I
> guess at least 2 or 3 pages are needed so there is some
> traversal. Beyond that I don't know what would make a difference.
>
> If there are only max 3 pages and we have a loop, I would not expect any
> to be faulted. Although maybe we could allow 1/3 because MADV_WILLNEED
> is only an advisory and a lot of time has been spent discussing this
> test already.
>

It sounds reasonable. Thanks!

I would have a try and go touch 3 pages (with expect 0 page fault) if that
does work.

-- 
Regards,
Li Wang

--0000000000002c11b605e1dce469
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Richard Palethorpe &lt;<a href=3D"mailto:rpa=
lethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrote:<br></div><div>=C2=A0<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 Adding the loop makes sense to me. However I don&#39;t understan=
d why you<br>
&gt;=C2=A0 have also switched from PASS_THRESHOLD to only a single page?<br=
>
&gt;<br>
&gt; In the test, we use two checks combined to confirm the bug reproduces:=
<br>
&gt;<br>
&gt;=C2=A0 =C2=A01. swap cached increasing less than PASS_THRESHOLD_KB<br>
&gt;=C2=A0 =C2=A02. page_fault number large than expected<br>
&gt;<br>
&gt; The 2. case is more easily get failed on kind of platforms and hard<br=
>
&gt; to count an average value for tolerating. So maybe we just reduce<br>
&gt; the page to one that would not affect the final result. Because we<br>
&gt; rely on both checks happening simultaneously then assume a bug.<br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 I guess calling MADV_WILLNEED on a single page is the least real=
istic<br>
&gt;=C2=A0 scenario.<br>
&gt;<br>
&gt; Okay, perhaps it&#39;s a step backward:).<br>
&gt;<br>
&gt; I was just thinking it is a regression test and if 1 page works to rep=
roduce<br>
&gt; that (but more chunks of memory easily cause false positive), why not.=
<br>
<br>
That makes sense, but this test has also found other bugs. I&#39;m not sure=
<br>
if they are reproducible with only one page.<br></blockquote><div><br></div=
><div><div class=3D"gmail_default" style=3D"font-size:small">Indeed.</div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 If there is an issue with PASS_THRESHOLD perhaps we could scale =
it based<br>
&gt;=C2=A0 on page size?<br>
&gt;<br>
&gt; This sounds acceptable too.<br>
&gt;<br>
&gt; How many pages do you think are proper, 100 or more?<br>
&gt; and, loosen the faulted-out numbers to 1/10 pages?<br>
<br>
I suppose that 100 pages would be too much memory on some systems. I<br>
guess at least 2 or 3 pages are needed so there is some<br>
traversal. Beyond that I don&#39;t know what would make a difference.<br>
<br>
If there are only max 3 pages and we have a loop, I would not expect any<br=
>
to be faulted. Although maybe we could allow 1/3 because MADV_WILLNEED<br>
is only an advisory and a lot of time has been spent discussing this<br>
test already.<br></blockquote><div><br></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">It sounds reasonable. Thanks!</div><div class=3D"g=
mail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">I would have a try and go touch 3 pages=C2=A0=
(with expect 0 page fault) if that does work.</div></div><div><br></div>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regard=
s,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000002c11b605e1dce469--


--===============0353453204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0353453204==--

