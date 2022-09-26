Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF477C32771
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 10:13:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456233CADE7
	for <ltp@archiver.kernel.org>; Mon, 26 Sep 2022 12:13:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B84E3C97BB
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 12:13:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EFD40140098C
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 12:13:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664187203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RN/2Ayc3w0xR84xARpMMZ1H/yOdoL6lOy8f+lDMOxH0=;
 b=goqmT7iEOMdAbBRPIuiEh5aRLxWIRLH4sAWYJUuArqgDprnahLMMY88f+3jGPpHFABhwwd
 EQY3FLUEhgyVfElkWkbTa42jXf1vq7u0quntsQFQYzHee2FSoFdBnTlSnpxuZW71/SA3m8
 L/5CbCE/lfpsVPqgZq7H/p3W3iuooTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-O05C2BXVM0iZBOBq0QiKpw-1; Mon, 26 Sep 2022 06:13:21 -0400
X-MC-Unique: O05C2BXVM0iZBOBq0QiKpw-1
Received: by mail-wm1-f72.google.com with SMTP id
 62-20020a1c0241000000b003b4922046e5so3950407wmc.1
 for <ltp@lists.linux.it>; Mon, 26 Sep 2022 03:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=RN/2Ayc3w0xR84xARpMMZ1H/yOdoL6lOy8f+lDMOxH0=;
 b=IYAkR3qDxAQotB4eoF5IQ3EnwBknV3ZbwCnuqcBrTA9g7fdVH33eYOhlX8Fj4IwCOk
 itoe5++y3tBR06HneybCZ8ge+lHPTzdL/+c6P4aCfF1lMTvp1p7IHbhypirUsDRKByX8
 JNFN4Nas52EoaRFTFgQwXwb0FdWirse4x7M30b4IXANzM3G8eH1Y2HrAcqrTqi9vhBzs
 YzQTGPYAGYnkIHPOWIEVqZ4QRFBz+z0gnr1Z5yoPUuMtMVEhJozJZo4rF1TO6VljJXV4
 8ULxxDLCNIr8nrgw5f3LKcB5hSOAv4IwzGyXbCYSCZby4xiM3IHcWc+0LZJ6DlH0eqLO
 LroQ==
X-Gm-Message-State: ACrzQf10PJfQ7ZKIohuWk7ZWx/4p7KSkfDq9dn/fnropcQP/JJL+Nkee
 KKLOhmcMIylhlZKJmkVPweNG/UviRxZkYzRlDsTEnAmTNFLasQfyD1W+kli87iXWzvMqlJrkq8V
 C1p4czZC4/UsTvIe1frjnDrk8nG8=
X-Received: by 2002:a05:6000:22b:b0:226:d378:50f1 with SMTP id
 l11-20020a056000022b00b00226d37850f1mr13100231wrz.316.1664187200607; 
 Mon, 26 Sep 2022 03:13:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5J2Q9if1X/naP0Abu+jGbYg89l7f8dMrNodUbmSnkFEx/SKLQna72zWF2aRK6q+cwMaPo/vd5mfhtAC4URwds=
X-Received: by 2002:a05:6000:22b:b0:226:d378:50f1 with SMTP id
 l11-20020a056000022b00b00226d37850f1mr13100217wrz.316.1664187200423; Mon, 26
 Sep 2022 03:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
 <YzF3wLk9cMTdU1z7@yuki>
In-Reply-To: <YzF3wLk9cMTdU1z7@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Sep 2022 18:13:09 +0800
Message-ID: <CAEemH2feEgX1oiTPD=_ub0Dc-5RTyKqVhSX0QrMAJPTo-0Gdhg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============2039270534=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2039270534==
Content-Type: multipart/alternative; boundary="000000000000ebe50205e991c672"

--000000000000ebe50205e991c672
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 26, 2022 at 5:56 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Well, if more than three people are involved in the release work,
> > I think that the release workflow should be arranged in time order,
> > otherwise, we're easily going to fall into chaos. e.g.
> >
> > Assumption work starting from the second week of the release month:
> >
> > 1. Collecting the patch list for a new release, like this email does
> (Cyril)
> >
> > 2. Reviewing and merging the patch list of step1 (All maintainers,
> > LTP-users)
> >
> > 3. Pre-release widely testing, we need to explicitly post results in
> step1
> > email (Petr, Li Wang)
> >
> > 4. Tiny fix according to pre-release testing result (All maintainers,
> users)
> >
> > 5. Writing release note (Cyril)
> >
> > 6. Uploading tarballs (Petr)
> >
> > 7. Announcement email of LTP release (Cyril)
>
> Lets move on with the plannig, I would say that we are done with step 2.
> and we should move to step 3.
>
> Also I would go for a release date at the end of the month that is 30.9.
>

Sounds good to me. Thanks!



>
> Does everyone agree?
>

I agree, and the more test the better.

I'd test on RHEL8, RHEL9, RHEL9 + mainline-kernel-6.0-rc7,
and will post the results here if anything needs improvement.

P.s. actually I already did some pre-test last week, and let's
see how today's new merge patches performing.


-- 
Regards,
Li Wang

--000000000000ebe50205e991c672
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 26, 2022 at 5:56 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Well, if more than three people are involved in the release work,<br>
&gt; I think that the release workflow should be arranged in time order,<br=
>
&gt; otherwise, we&#39;re easily going to fall into chaos. e.g.<br>
&gt; <br>
&gt; Assumption work starting from the second week of the release month:<br=
>
&gt; <br>
&gt; 1. Collecting the patch list for a new release, like this email does (=
Cyril)<br>
&gt; <br>
&gt; 2. Reviewing and merging the patch list of step1 (All maintainers,<br>
&gt; LTP-users)<br>
&gt; <br>
&gt; 3. Pre-release widely testing, we need to explicitly post results in s=
tep1<br>
&gt; email (Petr, Li Wang)<br>
&gt; <br>
&gt; 4. Tiny fix according to pre-release testing result (All maintainers, =
users)<br>
&gt; <br>
&gt; 5. Writing release note (Cyril)<br>
&gt; <br>
&gt; 6. Uploading tarballs (Petr)<br>
&gt; <br>
&gt; 7. Announcement email of LTP release (Cyril)<br>
<br>
Lets move on with the plannig, I would say that we are done with step 2.<br=
>
and we should move to step 3.<br>
<br>
Also I would go for a release date at the end of the month that is 30.9.<br=
></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Sounds good to me. Thanks!</div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Does everyone agree?<br></blockquote><div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-size:small">I agree, and the more test the better.=
</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small">I&#39;d test on RHEL8, R=
HEL9, RHEL9 + mainline-kernel-6.0-rc7,</div><div class=3D"gmail_default" st=
yle=3D"font-size:small">and will post the results here if anything needs im=
provement.</div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">P.s. actually =
I already did some pre-test last week, and let&#39;s</div><div class=3D"gma=
il_default" style=3D"font-size:small">see how today&#39;s new merge patches=
=C2=A0performing.</div><br></div></div><div><br></div>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--000000000000ebe50205e991c672--


--===============2039270534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2039270534==--

