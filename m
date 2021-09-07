Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC009C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 05:39:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E912660E8B
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 05:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E912660E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A74583C708B
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 07:39:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5295A3C23EA
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 07:38:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 06BB61A0089F
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 07:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630993127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSl7xrLdNEFBynp6GVoht5wPa8WFgBcUhs/nvKe4Cp8=;
 b=PGbT28NhED6W5P/PqgmVLO1JbqCde8kb2p7ZKK/CQY1PsKFHxjaq5huhsylAAEg62zNyrr
 cIN3CPYyfPlwSUZyTJXgVNwXdT/Fm6/xxlk3mWDaTVhuScYar3Eq8olXHGnI/ELI2HS2MI
 H3FOjkrR2lA1JswkavzDZHNQo3iG/x0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-6No1Ko-mPvCQFoonrR6ULQ-1; Tue, 07 Sep 2021 01:38:45 -0400
X-MC-Unique: 6No1Ko-mPvCQFoonrR6ULQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 j22-20020a4ad196000000b002903f4c4467so5218461oor.1
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 22:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RSl7xrLdNEFBynp6GVoht5wPa8WFgBcUhs/nvKe4Cp8=;
 b=MxgezsmHZQjyCCAF+f/prTXu+c+b4USDtAh2MoKrBDapAMXXwRJMZKaJGRZiBrrD3X
 MEMHAy2im+tIlbeiestdjWeVz9qSNypaEnvmhUcp1tn2AWz6a2ZDTUfu2vpow/gHdtvT
 50WhzArPjMwFBiTbvJYIk5annUxMIcx8/ikkEwhm9ELAsJISXhC1jR/3oGh5afcbxM1S
 +VIXpe+nrsa29gvwHZLZdid/aVgVZfhLOdDbw2p+ql70BDWxQo1UnxGUffLG86cmNyBK
 gBruJSsGJStmDxrGvwqKgh9XUC0YXnVonGYOfUFOn4Rt7btCl38tjqH3ccgEWrRtKlOJ
 YyAg==
X-Gm-Message-State: AOAM5330FyoctdTD7Ii0NZnuy1kxsuo80oMudbhMNfByMRhLwy9FlStz
 iIpBJAS8FUJMZYIKA4Bm0MIe6Ygx/c5YqAOrKFvrrahkNB7F6zoumu36rECcQj2iqoR/TW1QGDM
 GmIbomyFf4R/cHYDSm3DIYP6lC6I=
X-Received: by 2002:a05:6808:56:: with SMTP id
 v22mr1772296oic.49.1630993125125; 
 Mon, 06 Sep 2021 22:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkQQfYEJC1kGyXNuWqJWx6l/iqG2RRA82WOpzwhyK/kCMxoXL3DMvC/DBhOC4WBUB3Ywj9y9hGtBbeNG2Vges=
X-Received: by 2002:a05:6808:56:: with SMTP id
 v22mr1772284oic.49.1630993124731; 
 Mon, 06 Sep 2021 22:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
 <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
In-Reply-To: <CAEemH2cZNzOawYPHQGgeLGVxob37=0kbJyQz=NSvBM0uGpANSg@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Sep 2021 07:38:26 +0200
Message-ID: <CAASaF6weZ3DTLCRkpYfBbYwT+0b2EdDvm6Z0Q--oDyYC2fY+1w@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1052316579=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907053826.RCSTNogga5zUZH0PNlue7iorDQ27U6fzqp9lhaKVc7k@z>

--===============1052316579==
Content-Type: multipart/alternative; boundary="000000000000d4bf2205cb612d05"

--000000000000d4bf2205cb612d05
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 4:20 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Mon, Sep 6, 2021 at 4:36 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>> commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
>> removed mandatory file locking support, but mount option
>> is still allowed and produces no error. There's a warning
>> in dmesg but it's pr_warn_once() so we can't rely to always
>> find it there.
>>
>> Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.
>>
>
> I'm wondering, if the SUT without CONFIG_MANDATORY_FILE_LOCKING
> enabling, why the mount-check in setup() didn't report EPERM?
>

Because kernel commit f7e33bdbd6d1 removed that code, it generates
warning message instead.


>
> And, should we drop the mount-check for EPERM from setup after adding
> this .needs_kconfigs?
>

I'd keep it, it doesn't hurt anything and older kernels could get EPERM
for other reason (like running test in namespace where you don't have
CAP_SYS_ADMIN)



>
> --
> Regards,
> Li Wang
>

--000000000000d4bf2205cb612d05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 4:20 AM Li Wang &lt;<a=
 href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div style=3D"font-size:small"><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 6, 2021 at =
4:36 PM Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" target=3D"_b=
lank">jstancek@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">commit f7e33bdbd6d1 (&quot;fs: remove mandatory fi=
le locking support&quot;)<br>
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
-family:monospace" class=3D"gmail_default">Because kernel commit
<span class=3D"gmail-im">f7e33bdbd6d1 removed that code, it generates</span=
></div><div style=3D"font-family:monospace" class=3D"gmail_default"><span c=
lass=3D"gmail-im">warning message instead.</span><br></div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div><div style=3D"font-size:small"><br></div><=
div style=3D"font-size:small">And, should we drop the mount-check for=C2=A0=
EPERM from setup after adding</div><div style=3D"font-size:small">this .nee=
ds_kconfigs?</div></div></div></div></blockquote><div><br></div><div><div s=
tyle=3D"font-family:monospace" class=3D"gmail_default">I&#39;d keep it, it =
doesn&#39;t hurt anything and older kernels could get EPERM</div><div style=
=3D"font-family:monospace" class=3D"gmail_default">for other reason (like r=
unning test in namespace where you don&#39;t have CAP_SYS_ADMIN)</div><div =
style=3D"font-family:monospace" class=3D"gmail_default"></div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,=
<br></div><div>Li Wang<br></div></div></div></div>
</blockquote></div></div>

--000000000000d4bf2205cb612d05--


--===============1052316579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1052316579==--

