Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B0C433F5
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 03:59:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47E3D3CA4E0
	for <ltp@archiver.kernel.org>; Fri,  8 Apr 2022 05:58:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08FB83C9A7E
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 05:58:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A04B76009AE
 for <ltp@lists.linux.it>; Fri,  8 Apr 2022 05:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649390325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6LUQG+fUx9QGqA/izdOt3MMiMkAu+9yC7+ALm/aGgRY=;
 b=OCgN3HdnQl4lBRRiyhB492VG7qN5BgFdfSPIo/nZ99hR+TLID96mF6CCX2z/SXtJajJVYv
 /wxohAG68qYCnEbFlSQgLi9FOcGibuxUnRmsvspYk5Wu7XKG597iE0Hjb5d+Y9WNg+y0HR
 ZnJiGBmDpMLVnzAUvlPvBJpOxm3dbxs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-mr8oZcHePeSkz5LeXjH5AA-1; Thu, 07 Apr 2022 23:58:44 -0400
X-MC-Unique: mr8oZcHePeSkz5LeXjH5AA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2e61c5a0eb7so65097007b3.22
 for <ltp@lists.linux.it>; Thu, 07 Apr 2022 20:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6LUQG+fUx9QGqA/izdOt3MMiMkAu+9yC7+ALm/aGgRY=;
 b=TGJXAUPJSpUkDaxnc6ZxnXw5GF1Nr1N7642tfPFnQUHl/7ZZjebsFkin44DmEGq82B
 pk9hjBkXSkFqSmuMstMcX5dh5VVPFeRDUejtV72fV+qeM5H+3HKG9DKPwQSe2uIx1rST
 ZJ1wP2DZwQ5/EW7Fk87jXRSMChQLGwGrRgr/pDf66+jnE6mUQwTj38N8bHHiJqR/LO/a
 BAm518+9Of7FwKxwkV9Vp3XrZzqR7h8M5W+JjGRFTtmMXndP6NPI8V1CT3OGYYAL5nU4
 sLhcztO29vfnlaGcJaLjp+4xB1PgJvjeH6tSWTK9LeM8xJ9R1i/dZhrEwQiv7fIl95d9
 Zbtg==
X-Gm-Message-State: AOAM5313oSZs4UV68XpzDpnahqJGfW2h0+KS9F+JjoZ+6gCosmr3cMVz
 1qwxVcMLm66iQsMgw4tRbwnIKuIB9N1u4HxbSIfMMqmaMgllkjMMlwMbDRe31pp2pz74Idwm9+b
 8k70vhkgeN9WttdUZC1S8O9RLPMA=
X-Received: by 2002:a25:780a:0:b0:633:ccea:3430 with SMTP id
 t10-20020a25780a000000b00633ccea3430mr12489353ybc.26.1649390323557; 
 Thu, 07 Apr 2022 20:58:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygwX/FtIs5ycpjzL9AJLMwG+0TeSpN0K/8U8tIpdzOUVuiaisqyJ7eL2YWNhZq4D6foK1yt/pPLxs0ZXtZOlw=
X-Received: by 2002:a25:780a:0:b0:633:ccea:3430 with SMTP id
 t10-20020a25780a000000b00633ccea3430mr12489340ybc.26.1649390323277; Thu, 07
 Apr 2022 20:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220328114921.182315-1-zhaogongyi@huawei.com>
 <YkxNEjvaLAsWZSaq@pevik>
In-Reply-To: <YkxNEjvaLAsWZSaq@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 8 Apr 2022 11:58:31 +0800
Message-ID: <CAEemH2e4WMF98j7auOJZd8+YhKk69bZ63+sLURFLNpq6qUeCRA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] io_submit01/io_submit02: Bugfix for running with
 the option "-i"
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0859506552=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0859506552==
Content-Type: multipart/alternative; boundary="00000000000050c04205dc1c9c61"

--00000000000050c04205dc1c9c61
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 5, 2022 at 10:08 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> > For io_submit01, add io_destroy before test return, or the test
> > would fail and report EAGAIN.
> > For io_submit02, move the io_destroy to the suitable location, or
> > the test would fail and report EAGAIN.
>
> $ ./io_submit01 -i150
> ...
> io_submit01.c:122: TPASS: io_submit() with NULL iocb pointers failed with
> EFAULT
> io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> expected EBADF(-9)
> io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> expected EBADF(-9)
> io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> expected EBADF(-9)
> io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK),
> expected SUCCESS(1)
>
> $ ./io_submit02 -i150
> ...
> io_submit02.c:76: TPASS: io_submit() returns 0 if nr is zero
> io_submit02.c:78: TFAIL: io_submit() returns -1, expected 1
>
> @Cyril, Li, Martin, Viresh: while this fix is valid using memset() (which
> is required)
> slows down testing a lot. Any idea whether this can be avoid to keep the
> speed?
>

It would not be a serious problem if only execute the test once,
I'm wondering if it really necessary to rerun many times(i.e. 150)?

BTW, the patch generally looks good to me.

-- 
Regards,
Li Wang

--00000000000050c04205dc1c9c61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Apr 5, 2022 at 10:08 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
&gt; For io_submit01, add io_destroy before test return, or the test<br>
&gt; would fail and report EAGAIN.<br>
&gt; For io_submit02, move the io_destroy to the suitable location, or<br>
&gt; the test would fail and report EAGAIN.<br>
<br>
$ ./io_submit01 -i150<br>
...<br>
io_submit01.c:122: TPASS: io_submit() with NULL iocb pointers failed with E=
FAULT<br>
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), exp=
ected EBADF(-9)<br>
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), exp=
ected EBADF(-9)<br>
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), exp=
ected EBADF(-9)<br>
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), exp=
ected SUCCESS(1)<br>
<br>
$ ./io_submit02 -i150<br>
...<br>
io_submit02.c:76: TPASS: io_submit() returns 0 if nr is zero<br>
io_submit02.c:78: TFAIL: io_submit() returns -1, expected 1<br>
<br>
@Cyril, Li, Martin, Viresh: while this fix is valid using memset() (which i=
s required)<br>
slows down testing a lot. Any idea whether this can be avoid to keep the sp=
eed?<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">It would not be a serious problem if only execute the =
test once,</div><div class=3D"gmail_default" style=3D"font-size:small">I&#3=
9;m wondering if it really necessary to rerun many times(i.e. 150)?</div></=
div></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">BTW, the patch generally looks good to me.</div></div><div><br></=
div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div=
>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000050c04205dc1c9c61--


--===============0859506552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0859506552==--

