Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1CC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:54:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22B861100
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D22B861100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4DB33C8616
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:54:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B85243C7713
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:54:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 03E781A014A4
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632304447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yC2v+VsBqLuIhDCzc/3iN8BxG/KNRQsv1HY8c+TRAg=;
 b=c/GZ77Afygcck70SY39Zg9UKFH9pn9crD9yUEj9UwH2GXGk4lvQ7Xsukk0HBSKtyedienX
 4C/eWL84/bWzyQPxXaP8oaVvgWblnWiVGLU3v9vZArmL8Rve0HJoKiX0cjBFGMOJrR0NqJ
 ChlHJGeW7t91y4itNEd+ojK/rxoGQb0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-z9GrHqqpM6WHfhlGVxirZw-1; Wed, 22 Sep 2021 05:54:06 -0400
X-MC-Unique: z9GrHqqpM6WHfhlGVxirZw-1
Received: by mail-qv1-f72.google.com with SMTP id
 z6-20020a056214060600b0037a3f6bd9abso11079169qvw.3
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 02:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2yC2v+VsBqLuIhDCzc/3iN8BxG/KNRQsv1HY8c+TRAg=;
 b=Em3NtIc8pqsORPlBVYLVRGc2FRm6y0lgdflaIdIxjhRms5W+o30KGbVDIZuoABoWrM
 01Z3SbB2ELlJ/Wsd72DtLPsga9STmMybC2shwnfqDCqZaSNG48pC9T6sSgbUROXjFW6W
 NQMUGcwQ2ZcvriZxG/n0wBartNFkT45V9pGi49JTThqe4xUoprdPgcLO2mCD22aBVJVc
 kZlDFdRcJX4rtDgCuDhEahZUbSYAJcXgMfNK/1QtbuZQxoiya9chorL1bgbhro7RqJd/
 pSYf0PvHVsLsGjduCGpKFYjnEBZhmqFSsmP6WlMMsETrELFNXJfp5VHEoZ7vQYUxzbRG
 9Juw==
X-Gm-Message-State: AOAM530vgLhyKvuZriAvYcEoe+SUJ+MgbcLGR0y9WPirPrQl1n4B4Sqi
 aWbeSHfef4FRU7FanqI4jB96m+l6IbGDM0GmlEmifJW6pRm3X5jzhm5diMdbSqbbD+iK+1eW4QD
 cpVaR9d3GCgI1qsHPUiiDTsCh8SU=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr694962yba.316.1632304445628; 
 Wed, 22 Sep 2021 02:54:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0AjzoeXag0iMm6KZ/FOUg5RntbUyB5FGKc9OWB/qHXKcBSE3Jnu7d1jgcWNCrMgbywO/DxpUFjnC8EN+bCNU=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr694939yba.316.1632304445389; 
 Wed, 22 Sep 2021 02:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
In-Reply-To: <YUrnljqYd5Hx/fi+@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 17:53:53 +0800
Message-ID: <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1070142384=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1070142384==
Content-Type: multipart/alternative; boundary="000000000000a21a1105cc927e98"

--000000000000a21a1105cc927e98
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 22, 2021 at 4:21 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > This change appears seems to be causing fallocate05 test to reliably
> > > trigger OOM (out of memory) on my test machine, which has only 256MB
> > > RAM.
> > >
> >
> > Thanks for reporting the failure. We purposely increase the size of
> > fallocate
> > to reduce interference from metadata changing. But not clear how much
> > size should be a proper value for a small system.
> >
> > Can you try with decrease the number of FALLOCATE_BLOCKS?
> >
> > i.e.
> >
> > #define FALLOCATE_BLOCKS 64
> > #define DEALLOCATE_BLOCKS 16
> >
> > Or, what about other multiple sizes, test result?
>
> Looking at the test I do not think there is a reason to allocate more
> than a two or four blocks for the buffer. We just need to write() to the
> fallocated area in a loop one block at a time until it's full. I do not
> think that it's a good idea to pass ~100MB buffer to a single write()
> and expect it to succeed anyways.
>

Sounds practical.

Btw, If we don't create such a larger buffer area, then we have to
count the loop times must as equal to bufsize/blocksize. Otherwise,
we can't guarantee the test behavior is correct.

-- 
Regards,
Li Wang

--000000000000a21a1105cc927e98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 4:21 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; This change appears seems to be causing fallocate05 test to relia=
bly<br>
&gt; &gt; trigger OOM (out of memory) on my test machine, which has only 25=
6MB<br>
&gt; &gt; RAM.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Thanks for reporting the failure. We purposely increase the size of<br=
>
&gt; fallocate<br>
&gt; to reduce interference from metadata changing. But not clear how much<=
br>
&gt; size should be a proper value for a small system.<br>
&gt; <br>
&gt; Can you try with decrease the number of FALLOCATE_BLOCKS?<br>
&gt; <br>
&gt; i.e.<br>
&gt; <br>
&gt; #define FALLOCATE_BLOCKS 64<br>
&gt; #define DEALLOCATE_BLOCKS 16<br>
&gt; <br>
&gt; Or, what about other multiple sizes, test result?<br>
<br>
Looking at the test I do not think there is a reason to allocate more<br>
than a two or four blocks for the buffer. We just need to write() to the<br=
>
fallocated area in a loop one block at a time until it&#39;s full. I do not=
<br>
think that it&#39;s a good idea to pass ~100MB buffer to a single write()<b=
r>
and expect it to succeed anyways.<br></blockquote><div><br></div><div><div =
class=3D"gmail_default" style=3D"font-size:small">Sounds practical.</div><b=
r></div><div><div class=3D"gmail_default" style=3D"font-size:small">Btw, If=
 we don&#39;t create such a larger buffer area, then we have to</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">count the loop times must =
as equal to bufsize/blocksize. Otherwise,=C2=A0</div></div><div class=3D"gm=
ail_default" style=3D"font-size:small">we can&#39;t guarantee the test beha=
vior is correct.</div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000a21a1105cc927e98--


--===============1070142384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1070142384==--

