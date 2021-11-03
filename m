Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572CBC433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 14:03:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACDF610FD
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 14:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8ACDF610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA76C3C72F1
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 15:03:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BBC83C0F7A
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 15:03:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66B47600F93
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 15:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635948201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DULBPQ1y+PRqVL1cwl4oCMqjGur3k6B3ANF5GDvpxtE=;
 b=GltJzGtf8j7a/F/4GpbucuVrwjP8f2nW7F19ZRonMGdEjmt0xdu4jggCxnNBpdzmxilzMf
 S4maqBgVOse2TRnYgaEJ0zZls2fZoJA4qYvw0rS6SSyHy2jH53G3l1/z4K2p2tHwWDGPZl
 KPqaG7R2jofwAZicyCKebeJYixgaFdg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-k0ScehzLOqGWEtAbfF3sRw-1; Wed, 03 Nov 2021 10:03:20 -0400
X-MC-Unique: k0ScehzLOqGWEtAbfF3sRw-1
Received: by mail-yb1-f198.google.com with SMTP id
 m78-20020a252651000000b005c1f44d3c7bso4012306ybm.22
 for <ltp@lists.linux.it>; Wed, 03 Nov 2021 07:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DULBPQ1y+PRqVL1cwl4oCMqjGur3k6B3ANF5GDvpxtE=;
 b=cgQtJ7c7ssUCucAanIzvji74Fx6Httt3gzDK8Ubp5xgdUL247OfydAjvrJaQazyslq
 dBghbfJJdGIRomLx5JfZtedASk5SO6Hje9Uy1nxglsj3nNLoy3jiwTrCJXrGae7v1WSE
 oKE7kRNaZOu9eWMJ01b/1F+T+BofgR0HZHLLRLEAVyGHkNPzg3xhCpEgpVdqFOdxI2BF
 8FRtz/jN/88vZZhF8kq1NNZfDLc7I/mdB9MJA/sguhhWmq37xWhsh5wYh8szI+nmEtTy
 FSTvYR+nWvKXX3hfxStMwrf6lLugMkQoTXIpAx2hnrKf0njzjuGbVLY0rFrQxGlCBvWr
 zPlw==
X-Gm-Message-State: AOAM530zC8gWuaNWBWoLVA2MHPCIsx4uU5bOP1/dwUTBtwDfdHfxExyf
 7fr8/h8iY86fjSsqotqIC6LQ5cTdt/G/fKll3+KolBAz80bU+aCXPfs/JjVSrprFJ71mcucYOsc
 oCmwt/bsPRSmzAQjxDaf6whMkRok=
X-Received: by 2002:a5b:445:: with SMTP id s5mr32236683ybp.425.1635948199578; 
 Wed, 03 Nov 2021 07:03:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVxvhwrNZzKqTb81Na2MWcQCg/zKW30cn0U7QyqetUQyUOVHvd9sFfSuNQOPmKeSD6SoPxfG6HxO2wmvoIM5c=
X-Received: by 2002:a5b:445:: with SMTP id s5mr32236655ybp.425.1635948199350; 
 Wed, 03 Nov 2021 07:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190615042048.29839-1-liwang@redhat.com> <877ddpo35n.fsf@suse.de>
In-Reply-To: <877ddpo35n.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Nov 2021 22:03:06 +0800
Message-ID: <CAEemH2fDxJ1xQ9qNejHDxv0p_Cx2cq5LsXTesuhAEBrDe43Hmg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>, Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
 structure
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
Content-Type: multipart/mixed; boundary="===============0029157136=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0029157136==
Content-Type: multipart/alternative; boundary="0000000000004b275d05cfe2dfa7"

--0000000000004b275d05cfe2dfa7
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

On Wed, Nov 3, 2021 at 8:10 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li,
>
> Li Wang <liwang@redhat.com> writes:
>
> > Testcases for specified arch should be limited on that only being
> supported
> > platform to run, we now create a function tst_on_arch to achieve this new
> > feature in LTP library.  All you need to run a test on the expected arch
> is
> > to set the '.arch' string in the 'struct tst_test' to choose the required
> > arch list. e.g. '.arch = "x86_64 i386"'.
>
> What is the status of this patch series? Is there a V3?
>

Um, I can't recall why the V3 development for .arch
was suspended.

Maybe we thought there is not much sense to replace
ifdef __arch__ from code at that moment.

Now, if that can benefit the tst_test metadata more in the next runltp-ng.
Should we keep going to work out the patch V3?

@Cyril Hrubis <chrubis@suse.cz>  any suggestions?



>
> Maybe another option would be to check the kernel config?
>

That maybe works, but I'm not sure if that can distinguish i386/x86_64 or
ppc64/ppc64le.

-- 
Regards,
Li Wang

--0000000000004b275d05cfe2dfa7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Richard,</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Nov 3, 2021 at 8:10 PM Richard Palet=
horpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">rpaletho=
rpe@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hello Li,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; Testcases for specified arch should be limited on that only being supp=
orted<br>
&gt; platform to run, we now create a function tst_on_arch to achieve this =
new<br>
&gt; feature in LTP library.=C2=A0 All you need to run a test on the expect=
ed arch is<br>
&gt; to set the &#39;.arch&#39; string in the &#39;struct tst_test&#39; to =
choose the required<br>
&gt; arch list. e.g. &#39;.arch =3D &quot;x86_64 i386&quot;&#39;.<br>
<br>
What is the status of this patch series? Is there a V3?<br></blockquote><di=
v><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Um,=
 I can&#39;t recall why the V3 development for .arch</div><div class=3D"gma=
il_default" style=3D"font-size:small">was suspended.</div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">Maybe we thought there is not much sense to rep=
lace</div><div class=3D"gmail_default" style=3D"font-size:small">ifdef __ar=
ch__ from code at that moment.</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Now, if that can benefit the tst_test metadata more in the next runlt=
p-ng.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small">Sho=
uld we keep going to work out the patch V3?</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" hr=
ef=3D"mailto:chrubis@suse.cz" tabindex=3D"-1">@Cyril Hrubis</a>=C2=A0 any s=
uggestions?<br></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
Maybe another option would be to check the kernel config?<br></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">T=
hat maybe works, but I&#39;m not sure if that can distinguish i386/x86_64 o=
r ppc64/ppc64le.</div></div></div><div><br></div>-- <br><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--0000000000004b275d05cfe2dfa7--


--===============0029157136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0029157136==--

