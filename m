Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BAFC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:23:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74A360F6E
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B74A360F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E959C3CA1FF
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:23:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E92543C73FA
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:23:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4BF2B200DCC
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632302578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PM3nHYAxpF5T1pa4qTd80yhhbu7FQRmTD078Bx4/kOw=;
 b=N+Ndk1UNRw2JaZGrDfaSUK5j/rK+pXvbGbI+mIOf89f9PJwHxWnCOJ0aHuDreoF//H9xLJ
 pJaiakmpaoOzQUhUKmNGlariBWK2WG+EVPI1LhS9NIK/oGEKQnzJRQwHTyvDe8F0HcOYZf
 eA9x9+RG5uwmLp5jlh72mnPZiCTpxXo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-8RJmYnLlMayU3k6FqrYZYQ-1; Wed, 22 Sep 2021 05:22:56 -0400
X-MC-Unique: 8RJmYnLlMayU3k6FqrYZYQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 ib9-20020a0562141c8900b003671c3a1243so9352699qvb.21
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 02:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PM3nHYAxpF5T1pa4qTd80yhhbu7FQRmTD078Bx4/kOw=;
 b=ZKvuxBVIu5r16DQmkTzCbpOd0b9xxgXlNsod2VfVEjfGdToXIYnwt2pNlO+vKoXgUT
 OwerT+TwIypC8ZLI4Ev1tysfjBnfSzkqM7VW7zP27uYQ0zFg8NgP8euwn/2UJqnt3E0Y
 rE983H0lAY2Gu7JdZJi2DwNwJJ+0SOO/xGcRSd2umgU+dwlUKDehHfzEqxMdYRLXImAv
 w+HppDhk9J57G6Jz4xJMnyITK2kmPqqLtrzQ7PldMFP1LD/qNW5k3qLLJbZINnvFEZrr
 XmBZybaN+f0QgGZTUL1yhFUX/gj6jT2abq+ywY2tTQvtu9UzzfqV1U32y1V7MQt/Dnmo
 p81Q==
X-Gm-Message-State: AOAM532vtkeq4mkSWG+UTT2FCVXgVZhhV9+SOm8b+UKGwywEsRp0oyhC
 lQRJ4g0iNpheSvJhtST33TgZB0exyYxux6wXbutrTjMcFJjd2H5nnzPMpdWTfXVXOsHdSUTnUxP
 vBJtrLh2tuibrm9X55gSTt9HKY78=
X-Received: by 2002:a25:e4c7:: with SMTP id
 b190mr41844601ybh.302.1632302576206; 
 Wed, 22 Sep 2021 02:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqV0QmQHCq2uy5RdxtDF+IHKXNki0NeDXzB955uPnVRJRDEp2WmnNKuwKVjWhtEA3zQTH8bpN0ypVa21FQX3M=
X-Received: by 2002:a25:e4c7:: with SMTP id
 b190mr41844585ybh.302.1632302576009; 
 Wed, 22 Sep 2021 02:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210920122146.31576-1-chrubis@suse.cz>
 <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
 <YUnCYvtAZkO/LZIP@yuki>
 <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
 <YUrxJfAOO3+B8//7@yuki>
 <CAEemH2d=+h1k62SnVY8Rh=c0UGGEvvTQieW3YgUq8j2Mg6UW=g@mail.gmail.com>
 <YUr1ga3JSak7Gfry@yuki>
In-Reply-To: <YUr1ga3JSak7Gfry@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 17:22:43 +0800
Message-ID: <CAEemH2etot5qBfTWkk3JqRZ1ywTo75M7Vu-ZhXvnQgVqcZovBw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Content-Type: multipart/mixed; boundary="===============0023764035=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0023764035==
Content-Type: multipart/alternative; boundary="000000000000359ca305cc920f85"

--000000000000359ca305cc920f85
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 22, 2021 at 5:20 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Agreed, that sounds like a great method.
>
> Should I send v3 or can I commit v2 with this change?
>

V3 please, I will help test it all.

I just think of setsid(), is that works and better than setpgid(0, 0)?

-- 
Regards,
Li Wang

--000000000000359ca305cc920f85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 22, 2021 at 5:20 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Agreed, that sounds like a great method.<br>
<br>
Should I send v3 or can I commit v2 with this change?<br></blockquote><div>=
<br></div><div class=3D"gmail_default" style=3D"font-size:small">V3 please,=
 I will help test it all.</div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div>I just think of setsid(), is that <span class=3D"gmail=
_default" style=3D"font-size:small">works and </span>better than setpgid(0,=
 0)?</div><div class=3D"gmail_quote"><br><div class=3D"gmail_default" style=
=3D"font-size:small"></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--000000000000359ca305cc920f85--


--===============0023764035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0023764035==--

