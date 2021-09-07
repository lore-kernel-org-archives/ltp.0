Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6856FC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 05:53:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C35A60F5E
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 05:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C35A60F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C2F13C91CF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 07:53:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06BB23C23EA
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 07:53:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DDB7E1000A5C
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 07:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630994001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOg7gA/Uae+ZjztPz+X5VrQIu+oyAhGzX5D009iScaQ=;
 b=iA967b3oc+XMR7cViqNwxbkF1PfVVdn+BRlebQhlUbv6obiZXN/fgFvdt4UC0W22jP922E
 +5fljICegeLQFe0Uo+Xp6zV+wuVuvJA8ztlG/ecuyggNStM5O0rLWQiIXWqXP+354AXFkT
 j6L8kle/myzssW8E3KcOEhYEa7Nqgi0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-lexIEX1sMt-snke09jA7jg-1; Tue, 07 Sep 2021 01:53:19 -0400
X-MC-Unique: lexIEX1sMt-snke09jA7jg-1
Received: by mail-yb1-f200.google.com with SMTP id
 d93-20020a25a366000000b0059fff274d9aso5460388ybi.4
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 22:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lOg7gA/Uae+ZjztPz+X5VrQIu+oyAhGzX5D009iScaQ=;
 b=BTH4vs8IBYAA7YSN+zi38vicYh5rSY6g8Cf5NiJ7XBf/gWVbfNPIOihw/uhBeggU5H
 /5EB/yKIY4WgQgX7Nx6xTmEv+NwBf7TypC7crligkuzv/XS49vA8k0Pnl2ahw9SzRP05
 DVBLtb2fAzmzJgvL2Krpa1+oKdT1qCIwVY9045iEA951CIgd0FdOTn1k4mZlxGq2qJYi
 uLnG+IemmCVDkowbEWW8dClnadSVwaNQybt2zSi6MPzAvFx/uWqDVyb0UsaIsQJ/fpvo
 dxj3CJ2AruViv+0EJnO14OT0PXn4G/Mgczq8BAGDmnHVJVRrqgsjVy5uMN3kkViUtybK
 h1uQ==
X-Gm-Message-State: AOAM5311pFHSTGWXmvfiggFW+8wWeXDlZyQPASLufLQ8Aq1MZbjbEoq4
 QCOSlEgLLPv4xH6ZfBq944iAR+zfsECFPlxIq/zz2/hbwS2nzMLVISWpYFnIEEdztMKrCWb9Ly2
 92D//6dJXID/NwOE5+5oYFWID49s=
X-Received: by 2002:a25:6902:: with SMTP id e2mr21576624ybc.526.1630993999277; 
 Mon, 06 Sep 2021 22:53:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSpvKef0EZhvbm2VUzNtDIwn2JmhONbzbBtoP8XbxkhIJmq8kio1warvc2986psflREUXjFFZ+EUWLg8dWGgw=
X-Received: by 2002:a25:6902:: with SMTP id e2mr21576606ybc.526.1630993999064; 
 Mon, 06 Sep 2021 22:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
 <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
 <CAASaF6weZ3DTLCRkpYfBbYwT+0b2EdDvm6Z0Q--oDyYC2fY+1w@mail.gmail.com>
In-Reply-To: <CAASaF6weZ3DTLCRkpYfBbYwT+0b2EdDvm6Z0Q--oDyYC2fY+1w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Sep 2021 13:53:07 +0800
Message-ID: <CAEemH2czbWNQ2d3wbtRmGAfZ4+aoCp4NRRTfE7ksaZ0m6hXx2Q@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0411276314=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907055307.nRz7TXQ4NJ610OyRW0DhDvAFONHQ41UjlvQRgpPhDhI@z>

--===============0411276314==
Content-Type: multipart/alternative; boundary="000000000000f2063605cb61616a"

--000000000000f2063605cb61616a
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 1:38 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> On Tue, Sep 7, 2021 at 4:20 AM Li Wang <liwang@redhat.com> wrote:
>
>>
>>
>> On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek <jstancek@redhat.com> wrote:
>>
>>> commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
>>> removed mandatory file locking support, but mount option
>>> is still allowed and produces no error. There's a warning
>>> in dmesg but it's pr_warn_once() so we can't rely to always
>>> find it there.
>>>
>>> Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.
>>>
>>
>> I'm wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING
>> enabling, why the mount-check in setup() didn't report EPERM?
>>
>
> Because kernel commit f7e33bdbd6d1 removed that code, it generates
> warning message instead.
>

Ok, I see.


>
>
>
>>
>> And, should we drop the mount-check for EPERM from setup after adding
>> this .needs_kconfigs?
>>
>
> I'd keep it, it doesn't hurt anything and older kernels could get EPERM
> for other reason (like running test in namespace where you don't have
> CAP_SYS_ADMIN)
>

Sure, that sounds acceptable too.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000f2063605cb61616a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 1:38 PM Jan Stancek &lt;<a h=
ref=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div style=3D"font-family:monospace"><br></div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, =
2021 at 4:20 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"=
_blank">liwang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"fo=
nt-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com" target=3D"_blank">jstancek@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">co=
mmit f7e33bdbd6d1 (&quot;fs: remove mandatory file locking support&quot;)<b=
r>
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
></div></div></blockquote><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small">Ok, I see.</div></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmai=
l_quote"><div><div style=3D"font-family:monospace"><br></div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div><div style=3D"font-size:small"><br></div><=
div style=3D"font-size:small">And, should we drop the mount-check for=C2=A0=
EPERM from setup after adding</div><div style=3D"font-size:small">this .nee=
ds_kconfigs?</div></div></div></div></blockquote><div><br></div><div><div s=
tyle=3D"font-family:monospace">I&#39;d keep it, it doesn&#39;t hurt anythin=
g and older kernels could get EPERM</div><div style=3D"font-family:monospac=
e">for other reason (like running test in namespace where you don&#39;t hav=
e CAP_SYS_ADMIN)</div></div></div></div></blockquote><div><br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Sure, that sounds acceptabl=
e too.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wa=
ng &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat=
.com</a>&gt;</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div=
></div></div></div>

--000000000000f2063605cb61616a--


--===============0411276314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0411276314==--

