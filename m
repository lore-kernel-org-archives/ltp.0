Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95687ECAAD8
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 05:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0911E3CAD2A
	for <ltp@archiver.kernel.org>; Tue, 20 Sep 2022 07:54:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F2153CA00A
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 07:54:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7BECD600954
 for <ltp@lists.linux.it>; Tue, 20 Sep 2022 07:54:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663653245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRF9lFo0vy3dOEqFUMP3PFDtyayewhKQ/HutwATF4pw=;
 b=NpjA3Cd2pjgrYGurS2UPjYJ+prbsxwYT/5KS1b0ZZ1uqeTFMGvkURKbGEELP8Wo3dgcR6T
 KKy0vDhtbhIVIpnJJS6GQz46dx3jt24UxnMvthycB7wDKI4YXiDr24JqWIdeeSG4Yq2Shh
 TvyJDMo9yCimTLwoDWBteXiS6GG1gLo=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-486-rQfWLwxGOiOlntKf7a4iaA-1; Tue, 20 Sep 2022 01:54:03 -0400
X-MC-Unique: rQfWLwxGOiOlntKf7a4iaA-1
Received: by mail-ua1-f72.google.com with SMTP id
 y10-20020ab0560a000000b003af33bfa8c4so501254uaa.21
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 22:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=eRF9lFo0vy3dOEqFUMP3PFDtyayewhKQ/HutwATF4pw=;
 b=PqlIplZnM/Mwka1si5BcKLevHkAvozYvQB8hXWIxWuCOOh1F8RYWftoaknA156VhNa
 +UhL58YTiRvIWyTvOJq0s3HFy9FKaCzysU4YDrG7p6N22yD/AnGUQDrNwZ/IKs6NGSl3
 oAoHCwGS7maUbiyDoaQW234zf4o5ipOfBMwOWGQZz648Dl/6y9TPdOL8WH2q3Sft2GBc
 QUEgTRMZUv2PaebEYinnxHOIyJqcKC2BQfEBJmBDELTBANW7e4cg92y1VU1QB2/05M67
 9DRdy6KmevXoyCY9LHsSktBT27GYOMd+9bUJUMi20u88dlCaZRfwyShLUcXVYZBaOwXV
 9/rw==
X-Gm-Message-State: ACrzQf332l3iLG7QM6K7CiBxAf7Qjkb8OCPhs6wtATBt5xR6oUxtiJnO
 6UuUX5SMkhWxW4Kn6tnrv01wHJCq/LR7JXveBvdCeJoo/yzbOHnKbemph1YJRDz5TqQuV9q/jd4
 e9kMrvMhe24nI0SIpETILnOcXMzA=
X-Received: by 2002:a05:6102:23f7:b0:398:bce4:ead with SMTP id
 p23-20020a05610223f700b00398bce40eadmr7240070vsc.41.1663653243197; 
 Mon, 19 Sep 2022 22:54:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6xyukJOir82oSMt88HDIjL5ppqUgyUIXWfCSReJb9x0A256ph+Bvtttto5RxDVH4kbDylP4xOPQazSj1p1tkI=
X-Received: by 2002:a05:6102:23f7:b0:398:bce4:ead with SMTP id
 p23-20020a05610223f700b00398bce40eadmr7240058vsc.41.1663653242831; Mon, 19
 Sep 2022 22:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220915031020.2633347-1-liwang@redhat.com>
 <YyMgBQu+phGCulxV@pevik> <YyM05nwf1+0eCd3w@yuki>
 <CAEemH2d_ckW9Zm77wRcoejiY0rCDB1Tpgs7c3LB=WNwYYLF7Hg@mail.gmail.com>
 <YyRER2kntqxXG7tl@yuki>
 <CAEemH2eDc0qfdkaOxrbEPsmOmZp7MA=exHRkjQPgxaJAh7HP2w@mail.gmail.com>
In-Reply-To: <CAEemH2eDc0qfdkaOxrbEPsmOmZp7MA=exHRkjQPgxaJAh7HP2w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Sep 2022 13:53:51 +0800
Message-ID: <CAEemH2c1m7H581fn0VDq0nsjV6DN=+NwtmAegm0_WEqT0OmgiA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04: add EMFILE check
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
Content-Type: multipart/mixed; boundary="===============0215397667=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0215397667==
Content-Type: multipart/alternative; boundary="000000000000919c8705e91574b4"

--000000000000919c8705e91574b4
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 19, 2022 at 8:12 PM Li Wang <liwang@redhat.com> wrote:

> Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
>> > > I faintly remmeber a similar patch where we decided not to work around
>> > > for a test harness leaking filedescriptors into testcases.
>> > >
>> >
>> > This also should be a solution, I searched the mailing list and got a
>> > patch[1].
>> > Do you mean adding that close-on-exec flag when opening fd in harness?
>>
>> Yes, that way you can be sure that no file descriptors are leaked to the
>> tests.
>>
>
> Ok, should I send patch v2 like this below?
>
> Note: the automation test open04 got passed but I'm not sure
> if this has a side effect on logs. But from my observation, some
> tests (with old-API) log can't be collected anymore.
>

Seems we shouldn't fix by adding 'close-on-exec' flag simply,
it brings more issues to some old-API tests, I'm still looking into
the problems which look like caused by ltp-pan designed.

So can we just merge the patch as the original?

-- 
Regards,
Li Wang

--000000000000919c8705e91574b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 19, 2022 at 8:12 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chr=
ubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div><di=
v style=3D"font-size:small"><br></div></div><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; I faintly remmeber a similar patch where we decided not to work a=
round<br>
&gt; &gt; for a test harness leaking filedescriptors into testcases.<br>
&gt; &gt;<br>
&gt; <br>
&gt; This also should be a solution, I searched the mailing list and got a<=
br>
&gt; patch[1].<br>
&gt; Do you mean adding that close-on-exec flag when opening fd in harness?=
<br>
<br>
Yes, that way you can be sure that no file descriptors are leaked to the<br=
>
tests.<br></blockquote><div><br></div><div><div style=3D"font-size:small">O=
k, should I send patch v2 like this below?</div><div style=3D"font-size:sma=
ll"><br></div><div style=3D"font-size:small">Note: the automation test open=
04 got passed but I&#39;m not sure</div><div style=3D"font-size:small">if t=
his has a side effect on logs. But from my observation, some=C2=A0</div><di=
v style=3D"font-size:small">tests (with old-API) log can&#39;t be collected=
 anymore.</div></div></div></div></blockquote><div><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">Seems we shouldn&#39;t fix by addi=
ng=C2=A0&#39;close-on-exec&#39; flag simply,</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">it brings more issues to some old-API tests, =
I&#39;m still looking into</div><div class=3D"gmail_default" style=3D"font-=
size:small">the problems which look like caused by=C2=A0ltp-pan designed.</=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">So can we just merge the=
=C2=A0patch as the original?</div></div><div><br></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--000000000000919c8705e91574b4--


--===============0215397667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0215397667==--

