Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D8EC433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 06:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C93A73CA645
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 08:17:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0669E3C12C4
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 08:16:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E23D2600436
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 08:16:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650349014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ud3+aNUQ1W978EvIZs6pxfMIMGXzIeaHhrzkgOZFKtk=;
 b=S1ssEq/i9MVhx3jIo5eiMX+6QGAF6lsrPCxYj5OmABehz+OsLp51jxMoAKyUWEREIkwC+I
 Ji787VKRFVT3fHQkkVu0VQtfSbpDUvP9YdGS1sx05GVrIr8LHQJzXihXwgg9IDVsg38dq8
 HuYQ+9SQoPE1mtAGFocQH/De+U1dz/4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-HdZIYpW9MsKXoxCRBpvGPA-1; Tue, 19 Apr 2022 02:16:52 -0400
X-MC-Unique: HdZIYpW9MsKXoxCRBpvGPA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2ec12272fb2so136903077b3.6
 for <ltp@lists.linux.it>; Mon, 18 Apr 2022 23:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ud3+aNUQ1W978EvIZs6pxfMIMGXzIeaHhrzkgOZFKtk=;
 b=3NddPRNmLcqK1JRo43tspI8daxBBmI1Rm5bIHl+DTKUIprGXyVu0fdP9dKyl9Ye21w
 CBY/ka8I6U9qsSPr3JBokHkVodq7uu+aZAU5PC9yFdpWYChh3NTLyfty8dNkkWfY0awn
 udPoCjVFvi7yNOfg2UPFraZiReJxcjjCEE06ncU2wFW0KRo5eUvT0J9I8k7a27n7Uqv3
 A59wwSFXtZODjuEIZ+vaFmaVJT/a7uiF2UBj0NwQCpRYV9VlVFIV7F5lsx/YXxujiZrg
 XOiL6QtuV/i1hxMmIEd4IOo51JAea7kIQoO9rtiC02NmKwTR5bDm2nL1zu1Z3gCvaec7
 KGfw==
X-Gm-Message-State: AOAM533j1bpny43YusXQc6DcSFpmOT0zXdP9Op+HRMFoGcesEy1wHDrT
 rd1qnVi8DfTcvWy1Kd+PiC4PINAcUgntTgmQyPiwkzQoaPhouVgbjYmVbiJA6Oe5zFv2dMuQaDu
 14vLxgAVAb0ai+UFHW+izeZgCfk8=
X-Received: by 2002:a25:d789:0:b0:642:8b3:a5b8 with SMTP id
 o131-20020a25d789000000b0064208b3a5b8mr13376978ybg.273.1650349012245; 
 Mon, 18 Apr 2022 23:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJya52NJleBRmC4LW06f/cHcuheQs9ZDqZmVGRp4RA/235RD7OvUYAARrgOk/nsfuj/Mb2kLapX1CuruEl57+x4=
X-Received: by 2002:a25:d789:0:b0:642:8b3:a5b8 with SMTP id
 o131-20020a25d789000000b0064208b3a5b8mr13376961ybg.273.1650349011922; Mon, 18
 Apr 2022 23:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220411094019.1143199-1-liwang@redhat.com>
 <Yl5GEIuThAtSgsDE@pevik>
In-Reply-To: <Yl5GEIuThAtSgsDE@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Apr 2022 14:16:33 +0800
Message-ID: <CAEemH2dfX6bb6MQRDw+Pdbizix0Ad0PVEj+3P0dxNy_uDSKk2g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fsync02: multiply the timediff if test in VM
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
Content-Type: multipart/mixed; boundary="===============1492533908=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1492533908==
Content-Type: multipart/alternative; boundary="0000000000009c860f05dcfbd2e1"

--0000000000009c860f05dcfbd2e1
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 19, 2022 at 1:18 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > Similar to 59e73f2 ("clock_gettime04: multiply the
> > timediff if test in VM"), extend tolerance for this test too.
>
> >   fsync02.c:93: TFAIL: fsync took too long: 167.000000 seconds;
> >                 max_block: 17768; data_blocks: 2287
>
> Make sense.
>
> Acked-by: Petr Vorel <pvorel@suse.cz>
>
> > +     if (tst_is_virt(VIRT_ANY)) {
> > +             tst_res(TINFO, "Running in a VM, multiply the time_limit
> by 2.");
> very nit: why dot at the end?
>

Pushed (without that dot), thanks for reviewing.


-- 
Regards,
Li Wang

--0000000000009c860f05dcfbd2e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Apr 19, 2022 at 1:18 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; Similar to 59e73f2 (&quot;clock_gettime04: multiply the<br>
&gt; timediff if test in VM&quot;), extend tolerance for this test too.<br>
<br>
&gt;=C2=A0 =C2=A0fsync02.c:93: TFAIL: fsync took too long: 167.000000 secon=
ds;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0max_block=
: 17768; data_blocks: 2287<br>
<br>
Make sense.<br>
<br>
Acked-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank=
">pvorel@suse.cz</a>&gt;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tst_is_virt(VIRT_ANY)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;=
Running in a VM, multiply the time_limit by 2.&quot;);<br>
very nit: why dot at the end?<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Pushed (without that dot), th=
anks for reviewing.</div></div></div><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,=
<br></div><div>Li Wang<br></div></div></div></div>

--0000000000009c860f05dcfbd2e1--


--===============1492533908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1492533908==--

