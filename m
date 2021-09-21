Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5B7C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 03:46:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF3E610A1
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 03:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CF3E610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20C7A3C8F81
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 05:46:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59D8F3C8760
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 05:46:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D10F600804
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 05:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632195973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZvLNNHx8SzaJWU6p6ClsujeUvt7w5Ko1Vm9mWoKptY=;
 b=iyVa4oriLLtPmu2E3CF9pUcVIlkNHBCd/YfDolc09K2zdkkDvHOt5wss1i0H+EefMQmlBG
 h/c5vYnSsOaKdpfMi71zc/4QXNzfSoL1gZeRhbdqvtuAf7ftE9ynoQKcOkThMwK5U7XiOe
 gRWJy10oX258HhGJ9BJfsh4msv0JnKM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-f7w3eTKRMG-M0dkUhxfSlQ-1; Mon, 20 Sep 2021 23:46:10 -0400
X-MC-Unique: f7w3eTKRMG-M0dkUhxfSlQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 p23-20020a05620a22f700b003d5ac11ac5cso161467683qki.15
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 20:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yZvLNNHx8SzaJWU6p6ClsujeUvt7w5Ko1Vm9mWoKptY=;
 b=2xlwbp7s067P96ISSLJZFOm9yGKWe1P5EAUlJHMhwGptstXid2TQsT6u58U8e5v5o1
 gCgPCh6YBkHXU4QCGYhvfSg+tROtngbAsRLUa1ka3lv/XvwOKrra+eortNUf+bcgTJgH
 o1Bh2oSM3sdBJUXMktoVLz2dwLgmivN+DCdYheznhiYROj4+PvF6bTrlvTMQwd5KqgWp
 jp8xM02/nbuRaSeZJM+NoJHoevjLs//3kHPDllpGFut8rJrgAfTWJoT9dSpLN2LHZ/VL
 /OhX31j4Yr178D6e31ASXUhVBuvqT+xRcV7VeguCmGlDo+ZfkUuTPzwKXsCPrqJ1u+Kb
 dmPg==
X-Gm-Message-State: AOAM532Vb7qDmVItIc6QbNUN0PxETl8wr75FgjZJ/9V6KqarvX/L2jjS
 oB9RVQf66GEzedy1WRQsPXCWCO6UD2Rw6RE+RasnZixHuWnqsRyIGNrnL3gGBDpOHdVzfLHyxhL
 LQ5665JMvKfgyLX13SxE5mdhK2/U=
X-Received: by 2002:a25:2455:: with SMTP id k82mr7495871ybk.186.1632195969815; 
 Mon, 20 Sep 2021 20:46:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT0DVfYzwgR6xJX+Iu50D4JpTunQsZhispr7Rqq6KVBkdXsYag9Hujb7Bidfk9wIyTgVARjJv/xT6yKV4ydUA=
X-Received: by 2002:a25:2455:: with SMTP id k82mr7495861ybk.186.1632195969643; 
 Mon, 20 Sep 2021 20:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210917141719.5739-1-chrubis@suse.cz>
 <01fb50a1-8edb-77ac-fba4-b70965022b3f@jv-coder.de>
 <YUg6BM39OKgI5Ovl@yuki>
In-Reply-To: <YUg6BM39OKgI5Ovl@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Sep 2021 11:45:57 +0800
Message-ID: <CAEemH2dNhWjzjGok9Q2HbDaszd=YrtZpXvNv8WVAbn-kcW60JQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] lib: shell: Fix timeout process races
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
Content-Type: multipart/mixed; boundary="===============1906302693=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1906302693==
Content-Type: multipart/alternative; boundary="000000000000f98ec405cc793cb5"

--000000000000f98ec405cc793cb5
Content-Type: text/plain; charset="UTF-8"

Hi Joerg,

On Mon, Sep 20, 2021 at 3:36 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > There were actually several races in the shell library timeout
> handling.
> > >
> > > This commit fixes hopefully all of them by:
> > >
> > > * Reimplementing the backgroud timer in C
> > I did that once, but at that point it was kinda rejected ;)
>

Sorry, I was suggesting to solve the problem only in Shell ATM,
and it proved that it's not easy to cover all.


> > See https://lists.linux.it/pipermail/ltp/2021-May/022445.html
> > and https://lists.linux.it/pipermail/ltp/2021-May/022453.html
>
> I guess we found out the hard way that it's impossible to write raceless
> timeouts in shell.


+1 Indeed.

-- 
Regards,
Li Wang

--000000000000f98ec405cc793cb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Joerg,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Sep 20, 2021 at 3:36 PM Cyril Hrubis =
&lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; There were actually several races in the shell library timeout ha=
ndling.<br>
&gt; &gt;<br>
&gt; &gt; This commit fixes hopefully all of them by:<br>
&gt; &gt;<br>
&gt; &gt; * Reimplementing the backgroud timer in C<br>
&gt; I did that once, but at that point it was kinda rejected ;)<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Sorry, I was suggesting to solve the problem only in Shell ATM,</div>=
<div class=3D"gmail_default" style=3D"font-size:small">and it proved that i=
t&#39;s not easy to cover all.</div></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; See <a href=3D"https://lists.linux.it/pipermail/ltp/2021-May/022445.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://lists.linux.it/pipermail/l=
tp/2021-May/022445.html</a><br>
&gt; and <a href=3D"https://lists.linux.it/pipermail/ltp/2021-May/022453.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://lists.linux.it/pipermail/l=
tp/2021-May/022453.html</a><br>
<br>
I guess we found out the hard way that it&#39;s impossible to write raceles=
s<br>
timeouts in shell.</blockquote><div><br></div><div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">+1 Indeed.</div></div></div><div><br></div>-=
- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Rega=
rds,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000f98ec405cc793cb5--


--===============1906302693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1906302693==--

