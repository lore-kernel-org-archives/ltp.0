Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A060C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 07:50:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594B661102
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 07:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 594B661102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B35DA3C703D
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 09:50:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 370F03C246D
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 09:50:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 431E51A00CC7
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 09:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631001014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWnpgoWHRR9rbevFMi7b1BTQrNburt12sxrc9hahQ6A=;
 b=a2t/+bMPP5t2iYgKoO0jsCaHwrj28AiHvaAnVGoIBasN/e0wiU9W6FPqFLIu2sY08tceJU
 AJehbOqTfRRxvQQlhoxZsXQa/89EEmayOxUYFnb+Wm4ilYeaKpAzBdEJViUyw9B47uGPVW
 i0UIzX9KZQutw9vokuVUfjyhlBGCtTQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-uVhYEdJRMveuyD6hi3MYcg-1; Tue, 07 Sep 2021 03:50:13 -0400
X-MC-Unique: uVhYEdJRMveuyD6hi3MYcg-1
Received: by mail-oo1-f69.google.com with SMTP id
 p188-20020a4a2fc50000b029028b072e133dso5316168oop.19
 for <ltp@lists.linux.it>; Tue, 07 Sep 2021 00:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AWnpgoWHRR9rbevFMi7b1BTQrNburt12sxrc9hahQ6A=;
 b=NetyrB1Z+bcwWruB/jlTXaD0T1qc4fy9weAyZeBAbMQ5Y/h8N45AphO71uPi8w2y4m
 zvxW/myeug8xKyzZKRE+szCgo/jU5QFCfwSMePudtU06fvjERFTePmSSY3bQkEBNQcrN
 hCJ5iTZJRGSgKmigFC7MYe5hFJIOt5IDxo3DFpDMC5AEHsqn1OaRvCd4iAybFXvnYAHZ
 YTa95/2nahrG7mxbnsIAH64ercU95UivZGh/Ww3cK8F7zX8mOHxpowrjv3Ls6UyHZUgp
 /LiYN18ZOBl5Gt6rdaElZTRdcf2JrOYxhkzb0McokCyJw0D70g2kbnSityaZ/U1nUXMk
 lf8w==
X-Gm-Message-State: AOAM532/u9RyKtu6nqUsqNEoCQ+CiX3PhaeDQslN0ZetKPvX1nb93raJ
 ts7+ALl8XpNlQGSI0CUE63UwifvVDs3NvmegaU7wLV88xl8oV/PR4Mne5GjBI3HWQc1Mb/eRLu5
 fdXiz/nC9vqxb4uLq6EmSpV2FsdI=
X-Received: by 2002:aca:adc3:: with SMTP id w186mr1972161oie.66.1631001012766; 
 Tue, 07 Sep 2021 00:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY9V90PmuO/uFwCNLJZRTCpqtzTK01rd5ZM/PNZrDYO1T0IQ04bZl2now+Dy/alp0zBzGcnI4cGj3p6ESmYPU=
X-Received: by 2002:aca:adc3:: with SMTP id w186mr1972157oie.66.1631001012525; 
 Tue, 07 Sep 2021 00:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
 <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
 <CAASaF6weZ3DTLCRkpYfBbYwT+0b2EdDvm6Z0Q--oDyYC2fY+1w@mail.gmail.com>
 <CAEemH2czbWNQ2d3wbtRmGAfZ4+aoCp4NRRTfE7ksaZ0m6hXx2Q@mail.gmail.com>
In-Reply-To: <CAEemH2czbWNQ2d3wbtRmGAfZ4+aoCp4NRRTfE7ksaZ0m6hXx2Q@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Sep 2021 09:49:54 +0200
Message-ID: <CAASaF6zZW2m9jUbBBMi5M=tv33n5J0jqrd-EZoSaNo4tzozDig@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ftruncate04: require
 CONFIG_MANDATORY_FILE_LOCKING=y
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
Content-Type: multipart/mixed; boundary="===============2134652136=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907074954.jMnBPYsgttghmpwIzw95HB_8x1-QSssihZmPtAqlcJg@z>

--===============2134652136==
Content-Type: multipart/alternative; boundary="000000000000faef6205cb630347"

--000000000000faef6205cb630347
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 7:53 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Tue, Sep 7, 2021 at 1:38 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>>
>>
>> On Tue, Sep 7, 2021 at 4:20 AM Li Wang <liwang@redhat.com> wrote:
>>
>>>
>>>
>>> On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek <jstancek@redhat.com> wrote:
>>>
>>>> commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
>>>> removed mandatory file locking support, but mount option
>>>> is still allowed and produces no error. There's a warning
>>>> in dmesg but it's pr_warn_once() so we can't rely to always
>>>> find it there.
>>>>
>>>> Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.
>>>>
>>>
>>> I'm wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING
>>> enabling, why the mount-check in setup() didn't report EPERM?
>>>
>>
>> Because kernel commit f7e33bdbd6d1 removed that code, it generates
>> warning message instead.
>>
>
> Ok, I see.
>
>
>>
>>
>>
>>>
>>> And, should we drop the mount-check for EPERM from setup after adding
>>> this .needs_kconfigs?
>>>
>>
>> I'd keep it, it doesn't hurt anything and older kernels could get EPERM
>> for other reason (like running test in namespace where you don't have
>> CAP_SYS_ADMIN)
>>
>
> Sure, that sounds acceptable too.
>
> Reviewed-by: Li Wang <liwang@redhat.com>
>

Pushed.

--000000000000faef6205cb630347
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 7:53 AM Li Wang &lt;<a=
 href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div style=3D"font-size:small"><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, 2021 at =
1:38 PM Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" target=3D"_b=
lank">jstancek@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"fo=
nt-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 4:20 AM Li Wang &lt;<=
a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-size:small"><br></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Sep 6, 2021 at 4:36 PM Jan Stancek &lt;<a href=3D"mailto:jstancek@redha=
t.com" target=3D"_blank">jstancek@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">commit f7e33bdbd6d1 (&quot;fs: =
remove mandatory file locking support&quot;)<br>
removed mandatory file locking support, but mount option<br>
is still allowed and produces no error. There&#39;s a warning<br>
in dmesg but it&#39;s pr_warn_once() so we can&#39;t rely to always<br>
find it there.<br>
<br>
Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=3Dy.<br></blockq=
uote><div><br></div><div><div style=3D"font-size:small">I&#39;m wondering, =
if the SUT without CONFIG_MANDATORY_FILE_LOCKING</div><div style=3D"font-si=
ze:small">enabling, why the mount-check in setup() didn&#39;t report EPERM?=
</div></div></div></div></blockquote><div><br></div><div><div style=3D"font=
-family:monospace">Because kernel commit
<span>f7e33bdbd6d1 removed that code, it generates</span></div><div style=
=3D"font-family:monospace"><span>warning message instead.</span></div></div=
></div></div></blockquote><div><br></div><div><div style=3D"font-size:small=
">Ok, I see.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><div style=
=3D"font-family:monospace"><br></div></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quo=
te"><div><div style=3D"font-size:small"><br></div><div style=3D"font-size:s=
mall">And, should we drop the mount-check for=C2=A0EPERM from setup after a=
dding</div><div style=3D"font-size:small">this .needs_kconfigs?</div></div>=
</div></div></blockquote><div><br></div><div><div style=3D"font-family:mono=
space">I&#39;d keep it, it doesn&#39;t hurt anything and older kernels coul=
d get EPERM</div><div style=3D"font-family:monospace">for other reason (lik=
e running test in namespace where you don&#39;t have CAP_SYS_ADMIN)</div></=
div></div></div></blockquote><div><br></div><div style=3D"font-size:small">=
Sure, that sounds acceptable too.</div><div style=3D"font-size:small"><br><=
/div><div style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mai=
lto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</div></d=
iv></div></blockquote><div><br></div><div><div style=3D"font-family:monospa=
ce" class=3D"gmail_default">Pushed.</div></div><br></div></div>

--000000000000faef6205cb630347--


--===============2134652136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2134652136==--

