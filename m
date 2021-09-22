Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1258BC43219
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 10:34:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDE16124A
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 10:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FDE16124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D4F13CA150
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 12:34:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25F303C2659
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 12:34:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 15FD91401207
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 12:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632306875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/GmH9/aTUfHOXFZnZxwPZKs5aPgg4Q3Wc3g66PoONY8=;
 b=Eu9OoQ2vOlv9cMzC1YObj/IjhF701WQy+OnPNGp2XArVHthSltN6kmz2y6Avp54ygwJ/CM
 6KHglQz76EMzldBr50osaTauXeRVlAq21BxthJZjkBl11F+8llPNoDOCVWfqXML+P31iPX
 SgrWLi8rfm5a62BeQWSqv/P/lUrjUbw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-9RT2kSBDOWKxQdxSyBO0Vw-1; Wed, 22 Sep 2021 06:34:34 -0400
X-MC-Unique: 9RT2kSBDOWKxQdxSyBO0Vw-1
Received: by mail-qk1-f200.google.com with SMTP id
 j27-20020a05620a0a5b00b0042874883070so8576221qka.19
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 03:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/GmH9/aTUfHOXFZnZxwPZKs5aPgg4Q3Wc3g66PoONY8=;
 b=YzIRmapTpf8eLTB4XaXbBOKAwPCQMe5VElJcJ7gx/2YJq7uMHRx1xfHPYVK+qngP3p
 D1ZBLwTilM3L8JR4BALW1SVb0eNeXHdU0mzpfbc70Vu4VEt8m+X+8INetJBCeS6NO4ne
 xvvJacBSiz389HqlUkP/EqJsXOUHLIkqN8X9Zv5x7fjUClAyX1zkMJq4xf3MaGtJiepg
 PSBm8PfzgI9y3EBzphc2vovIC6G0Pc/l8V5a0J9DWeviQnS28F39/QnL7UMHwEpLp5ol
 jHE1kAxW/+h2FxSEi7HxLPPHvVVFX0zTXLi0TEPvqBsUhLVa5QrDKYc+B+6MZK76f0Ef
 PYuA==
X-Gm-Message-State: AOAM533OUEY9tgstz3gqZWfIgcW9PHtH3W/62xEYOm/GX1Xty19FI14D
 6zjQYgrPfsN7GAGdwelqbLJwoC51VQ5NfaG/AOco4D/TArXwZMjRRQMdDdw9W1n3cD6vK7UZKqz
 TU27AiNdiycLNA5LeSSmWNWxARoY=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr902245yba.316.1632306873965; 
 Wed, 22 Sep 2021 03:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7Vw2BaLGAL29jpEo8FTkWza30XEUdeqbaqBdp9ZJZv2HfhIU8qrJPI7bELxggLJNV1BpPdVjyKCDILVYIn0E=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr902217yba.316.1632306873705; 
 Wed, 22 Sep 2021 03:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
In-Reply-To: <YUr9676LXNi0xMs6@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 18:34:21 +0800
Message-ID: <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============1117094655=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1117094655==
Content-Type: multipart/alternative; boundary="0000000000005f4bd305cc930f02"

--0000000000005f4bd305cc930f02
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 22, 2021 at 5:56 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > Looking at the test I do not think there is a reason to allocate more
> > > than a two or four blocks for the buffer. We just need to write() to
> the
> > > fallocated area in a loop one block at a time until it's full. I do not
> > > think that it's a good idea to pass ~100MB buffer to a single write()
> > > and expect it to succeed anyways.
> > >
> >
> > Sounds practical.
> >
> > Btw, If we don't create such a larger buffer area, then we have to
> > count the loop times must as equal to bufsize/blocksize. Otherwise,
> > we can't guarantee the test behavior is correct.
>
> Strangely enough we allready do exactly that for the second part of the
> test.
>

That try one by one block after filling full of the FS because nobody knows
when fails.

But as you suggested we can do that as well for the previous allocation :).

So, will you create a patch, or I do that tomorrow?

-- 
Regards,
Li Wang

--0000000000005f4bd305cc930f02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 5:56 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; Looking at the test I do not think there is a reason to allocate =
more<br>
&gt; &gt; than a two or four blocks for the buffer. We just need to write()=
 to the<br>
&gt; &gt; fallocated area in a loop one block at a time until it&#39;s full=
. I do not<br>
&gt; &gt; think that it&#39;s a good idea to pass ~100MB buffer to a single=
 write()<br>
&gt; &gt; and expect it to succeed anyways.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sounds practical.<br>
&gt; <br>
&gt; Btw, If we don&#39;t create such a larger buffer area, then we have to=
<br>
&gt; count the loop times must as equal to bufsize/blocksize. Otherwise,<br=
>
&gt; we can&#39;t guarantee the test behavior is correct.<br>
<br>
Strangely enough we allready do exactly that for the second part of the tes=
t.<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">That try=C2=A0one by one block after filling full of the FS b=
ecause nobody knows when fails.=C2=A0</div><div class=3D"gmail_default" sty=
le=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font=
-size:small">But as you suggested we can do that as well for the previous a=
llocation :).</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">So, will yo=
u create a patch, or I do that tomorrow?</div></div><div><br></div>-- <br><=
div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br=
></div><div>Li Wang<br></div></div></div></div>

--0000000000005f4bd305cc930f02--


--===============1117094655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1117094655==--

