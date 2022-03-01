Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99832C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 09:01:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED12E3CA2F5
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 10:01:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 144F33CA2B9
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:01:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1FC5020109C
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 10:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646125298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qtjfWOiM0/sVivP6eb7HKe3uTn2CHri3DB5KFaaKdAc=;
 b=fCWSBrYvUAnrRGnv8Zwg5keaoD806l9kWu/7orTeJD/NjVALjokTlSH21MJT7PWad2W1OT
 XQbzbd1te8lLKtVOH3gZkWZLtYDPD/DNb2aReUDPGABC2IhUUn1uYQlH7vgyMT16qXojKn
 /lEEFU1k4hYL/3gzz2/N7Hn0ao7el10=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-tAIjiyiBOkqaC7A6yM8ijQ-1; Tue, 01 Mar 2022 04:01:37 -0500
X-MC-Unique: tAIjiyiBOkqaC7A6yM8ijQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 x11-20020a5b0f0b000000b0062277953037so9664737ybr.21
 for <ltp@lists.linux.it>; Tue, 01 Mar 2022 01:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qtjfWOiM0/sVivP6eb7HKe3uTn2CHri3DB5KFaaKdAc=;
 b=laZb0aYd6ejHGgmcKkP98xJZezVZTN21ZfhUxgnWc1lcXOvTXXl7jc/4QYmDcjR0KU
 Xl/s3Zm+Bju+49Wpi3Azq8+z2U6zk0TF/uPypJdG+gTCL5xxfLrac1wzC/H03tqxhxMu
 /CUNovAlr406juT9YsTSZOnkZmh0DF8tPghPlY5Ysc27EyWlKAdJWKO1l1VrrCx+qfrF
 OnXfjL6nwbOhR32CHKUaLAWHC3puizPUORNlzByD7XoNGDZrBn829qgV6QFt0o103VkI
 O1XfXZmoS/bAEySRaIkoYmuD7JcBTxuBGOzDdbBe9bcAviMMaxyLUtAtTs1q2dDGfcMb
 9Jyg==
X-Gm-Message-State: AOAM532Wcb+053xaYMA8gjoysnEol7iQDNxa1wjXegEEffxZYGHOKtB/
 xrJ92Dug8I47Kr0nYSGZ33MKjvgDxL5fFEUGEZjofWhIfXVnENxgD+oVaSSP9bimyMnp8nm633e
 cm9HKlAJUvTa52NhA9BCyE2dYe9g=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr22575369ybp.506.1646125296805; 
 Tue, 01 Mar 2022 01:01:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwvlpC8M46F2OL61yNkBdP1tlh6HJlu6DKG/pNLljVUL4aYR04fhaOssTp+bn5g2fKNsUR300788tbFd91yCk=
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr22575356ybp.506.1646125296639; Tue, 01
 Mar 2022 01:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20220228094659.21959-1-chrubis@suse.cz>
In-Reply-To: <20220228094659.21959-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Mar 2022 17:01:22 +0800
Message-ID: <CAEemH2c-ZKrKVTqt-tSFvt36r5-P7c_9qTv7Q55QOhBC=TzWhw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] ksm06 fixes
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
Content-Type: multipart/mixed; boundary="===============1798676684=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1798676684==
Content-Type: multipart/alternative; boundary="0000000000008ff55f05d9246989"

--0000000000008ff55f05d9246989
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:

Two minor fixes for the ksm06 test.
>
> Also it looks like the test_ksm_merge_across_nodes() is only called from
> the ksm06 test so it does not make that much sense for the code to be in
> the mem.c library. I guess that we should move it to the test source so
> that it's not hidden in the library as well.
>

Absolutely yes, that will make mem library a bit shorten to read, we can do
that in a separate patch.
(sorry for overlooking this patch cover letter)

-- 
Regards,
Li Wang

--0000000000008ff55f05d9246989
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Two minor fixes for the ksm06 test.<br>
<br>
Also it looks like the test_ksm_merge_across_nodes() is only called from<br=
>
the ksm06 test so it does not make that much sense for the code to be in<br=
>
the mem.c library. I guess that we should move it to the test source so<br>
that it&#39;s not hidden in the library as well.<br></blockquote><div><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">Absolutely=C2=
=A0yes, that will make mem library a bit shorten to read, we can do that in=
 a separate patch.=C2=A0</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">(sorry for overlooking this patch cover letter)</div></div><div><=
br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"=
><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000008ff55f05d9246989--


--===============1798676684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1798676684==--

