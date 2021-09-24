Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDBDC433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 03:15:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B186961164
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 03:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B186961164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A10B53CB2B1
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 05:15:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BCD23C1C6E
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 05:15:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 88CF71001422
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 05:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632453319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMNZofJA0AN9ogUDhH3LcUz5b5fiXOeABF2bWTq+txE=;
 b=WveHkZltEMxmnI/9zeDRijfK7aVvIAEvCmd/DRc0bUIxcRmZ8/mruebyKWLKH0kIzjs0eD
 en5Uo0H9FsSzEOCWccZPWWtTX034uuezj56iYz5Jn5BnECM0FLehbdJMaJMQMIbCZ8Gi7m
 h3rUcjh5JmR8UtPzYFLQEWU0pE3fVMQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-HPCN0JkpNCyCX1kJ_iyzyw-1; Thu, 23 Sep 2021 23:15:18 -0400
X-MC-Unique: HPCN0JkpNCyCX1kJ_iyzyw-1
Received: by mail-yb1-f197.google.com with SMTP id
 s5-20020a056902120500b005b603c714b0so1724611ybu.9
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 20:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NMNZofJA0AN9ogUDhH3LcUz5b5fiXOeABF2bWTq+txE=;
 b=TSSeAI4iR6oQ0kCb2sykrcxWzHxvYEa4HO02N43lRLnDgvVLFf7/PwqvSznh2Z6MHX
 eAQ8F3epWoZAs5w5X0Gk3PwemLm9pxMNVUndKEd+bI0hj09/jISM6eiY4up8uckCrUh/
 1rQmEcDwaWHxu0b3oyZHhfPAqJ3hR8NJFyIXwotZAUF8Hkm88RcDT8Ldt5E/VOwwV1fF
 YlzK2IcffsYC12jEfVZ+HXoXufvlD14yR/N3qOeSMCGvBkdXwVhTOIxvmvf8UHccHO02
 di52Cf2Q/xYmURFIQ3gjRYSfRDOc8w67GO/92pwtxL/hR9t1PeipFxUgxbvdKRPbTLRk
 qBSw==
X-Gm-Message-State: AOAM5313rvUBdKeP/AcfebVrpNcJFivxCQEpiO0/Y8pD6SP1ygqNZKTE
 DjJjvD4nQaRrnQDqmdrxlm0CphF69U/JXH8znQmJ5c+nd6OpCKerA68gGdBhmCbow0yiJFDi3XC
 9MgRv+QFN9/rp48zw3Go/aaxloS4=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr9889801yba.316.1632453315221; 
 Thu, 23 Sep 2021 20:15:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbUR3qkwSGWNz8g2Qbsx9J8ryr8QIhXLEgFl5IFKyrhCQhdSxHi5KrMXCqpDrZmlWsILf3EMWBVkrpSDZ1YcI=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr9889787yba.316.1632453315031; 
 Thu, 23 Sep 2021 20:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <8b4c1fad2914aee00c8a160d1f9e482574b8e5ae.1632242721.git.jstancek@redhat.com>
 <3190c9a0b45411eb9d6024267c264825c9faa32e.1632386756.git.jstancek@redhat.com>
 <YUxD0Ah1IrSq4Flk@yuki>
In-Reply-To: <YUxD0Ah1IrSq4Flk@yuki>
From: Li Wang <liwan@redhat.com>
Date: Fri, 24 Sep 2021 11:15:03 +0800
Message-ID: <CAEemH2cNJx4b1utpoC+5E-cbxHQP6owF5tAhFQsvLPVdCKx08w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] hugeshmat04: try to find unmapped range for
 test
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
Content-Type: multipart/mixed; boundary="===============0873153284=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0873153284==
Content-Type: multipart/alternative; boundary="000000000000f490cd05ccb527b0"

--000000000000f490cd05ccb527b0
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 23, 2021 at 5:07 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Great work.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


I'm going to start a round of test for the latest branch before the release.
So this patch merged. Thanks!

-- 
Regards,
Li Wang

--000000000000f490cd05ccb527b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 23, 2021 at 5:07 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
Great work.<br>
<br>
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;</blockquote><div><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">I&#39;m going to start a round of te=
st for the latest branch before the=C2=A0release.</div><div class=3D"gmail_=
default" style=3D"font-size:small">So this patch merged. Thanks!</div></div=
><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr">Regards,<br>Li Wang<br></div></div></div></d=
iv></div>

--000000000000f490cd05ccb527b0--


--===============0873153284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0873153284==--

