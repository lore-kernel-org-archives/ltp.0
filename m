Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A584C54EE9
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 07:12:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C93E93CAAEC
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 09:12:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E61FE3CAA8E
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 09:12:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D0F73200BCD
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 09:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663053126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bl+OZbXqkp3dVUtxWeNpGTDCvNFW/urNqV7weKdhHX8=;
 b=GBVjGdNk1DRvCpCgfssjMn4EnXxwOUOykeyu2tLcff75jqCX/xzx9yl6nCszv0ugrH7fX1
 XaR0g6adIPe9SmDtP0zRpy9DJJzuIapcVF9HpIfl7JysN9+dTL8ozyt6S+3UBLjyR1SHmt
 7IRNmAGC7bLW1ISiabCgu6GdxTGFvMs=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-251-Lb65oohWP0erw-5rw62iRw-1; Tue, 13 Sep 2022 03:12:04 -0400
X-MC-Unique: Lb65oohWP0erw-5rw62iRw-1
Received: by mail-ua1-f72.google.com with SMTP id
 w38-20020a9f31e9000000b003ace5e909e2so3386826uad.3
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 00:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Bl+OZbXqkp3dVUtxWeNpGTDCvNFW/urNqV7weKdhHX8=;
 b=smrMIH4/XFe7hglY/qsd/OeAQ8Fj3mK1NrEVB3WsOWuRYJFzP1Onlk+Ndu7dRRPBvS
 NGIzFAMjzmmDb6Z1vdZKRgJWUTmfakUw1JjsoFZbt5UW8MZnm4V6X77Xe/lFObG0cns9
 oy1VD2VK9sKQk9RtwxGGRisy5Xngf+KSYilGmRudqBc0/0XFmnh3WgytszNpAp5xm2LP
 GdxBgdDTlFDUTs3mAvxl45AgkTpXzjKhuqS2hAGqGQpgp/POOCJ6uUR+5yRxCc/0uspP
 lA5mvDXCn6UoKNd3CFwY2ft6hHLmW3G1qZXSBQvy0fb4VwKEotDq9WbbQ9oTNtX1gDrt
 Dzhw==
X-Gm-Message-State: ACgBeo2PTmgtgZm26vRHe07A9CsXmRSG5+1iuTYEh9F3oeb2g91vjhcC
 N8KnpjeXwukgmniBpz4zsJvbA93eUVTjgNEFapjoB5ETwe+uTQjUo7PKSR2JvAUSRZ/24PPOX6G
 VnOY5LIntI/p0JXHgnQr1FrtkPkg=
X-Received: by 2002:ab0:2b05:0:b0:3af:13aa:b107 with SMTP id
 e5-20020ab02b05000000b003af13aab107mr9906827uar.20.1663053123863; 
 Tue, 13 Sep 2022 00:12:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6dCkcr3EhT39PIHDkgIcruKqH/YWEUuXSsXC/aG6nHAWWzpQSQ1/txlph8qfu4cHIERzH3J6/Oc+5TRNZIDq4=
X-Received: by 2002:ab0:2b05:0:b0:3af:13aa:b107 with SMTP id
 e5-20020ab02b05000000b003af13aab107mr9906814uar.20.1663053123616; Tue, 13 Sep
 2022 00:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
In-Reply-To: <YxtPfXA6I64lS2oK@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Sep 2022 15:11:51 +0800
Message-ID: <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============2093140692=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2093140692==
Content-Type: multipart/alternative; boundary="000000000000ad200705e889ba55"

--000000000000ad200705e889ba55
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 9, 2022 at 10:36 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> [ Cc automated-testing ML ]
>
> > Hi!
> > > Maye split this work into pieces? something like:
> > >     - announcement email,
> > >     - collecting patch lists for a new release,
> > >     - writing release notes, or paperwork,
> > >     - uploading tarballs
> > >     - pre-testing against different Linux distribution
>
> > > You can still send the announcement email, and other volunteers do the
> rest.
> > > (if applicable, I can take patch reviews or upload tarballs work)
>
> > I guess that would work too, as long as we have volunteers.
> I could do part of work as well. I volunteer to upload the tarballs.
> I also try to help with reviewing and testing pre release fixes.
> I usually do network tests changelog, which is tiny part of whole
> changelog.
>
> I try to do at least some of runtime tests on SLES and Tumbleweed, I
> suppose
> Martin helps with it as usually. Obviously more people should do
> pre-release
> testing.
>
> And in my non work time build testing on Buildroot (finds various build
> problems
> on other libc and generally the embedded world).
>

Well, if more than three people are involved in the release work,
I think that the release workflow should be arranged in time order,
otherwise, we're easily going to fall into chaos. e.g.

Assumption work starting from the second week of the release month:

1. Collecting the patch list for a new release, like this email does (Cyril)

2. Reviewing and merging the patch list of step1 (All maintainers,
LTP-users)

3. Pre-release widely testing, we need to explicitly post results in step1
email (Petr, Li Wang)

4. Tiny fix according to pre-release testing result (All maintainers, users)

5. Writing release note (Cyril)

6. Uploading tarballs (Petr)

7. Announcement email of LTP release (Cyril)


Does this look useful? or anything else?

IMO if any more volunteers hope to be involved, they just need
to pick up any step they are interested in.


-- 
Regards,
Li Wang

--000000000000ad200705e889ba55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 9, 2022 at 10:36 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
[ Cc automated-testing ML ]<br>
<br>
&gt; Hi!<br>
&gt; &gt; Maye split this work into pieces? something like:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- announcement email,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- collecting patch lists for a new release,<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- writing release notes, or paperwork,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- uploading tarballs<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0- pre-testing against different Linux distribu=
tion<br>
<br>
&gt; &gt; You can still send the announcement email, and other volunteers d=
o the rest.<br>
&gt; &gt; (if applicable, I can take patch reviews or upload tarballs work)=
<br>
<br>
&gt; I guess that would work too, as long as we have volunteers.<br>
I could do part of work as well. I volunteer to upload the tarballs.<br>
I also try to help with reviewing and testing pre release fixes.<br>
I usually do network tests changelog, which is tiny part of whole changelog=
.<br>
<br>
I try to do at least some of runtime tests on SLES and Tumbleweed, I suppos=
e<br>
Martin helps with it as usually. Obviously more people should do pre-releas=
e<br>
testing.<br>
<br>
And in my non work time build testing on Buildroot (finds various build pro=
blems<br>
on other libc and generally the embedded world).<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">Well, if m=
ore than three people are involved in the release work,</div><div class=3D"=
gmail_default" style=3D"font-size:small">I think that the release workflow =
should be arranged in time order,</div><div class=3D"gmail_default" style=
=3D"font-size:small">otherwise, we&#39;re easily going to fall into chaos. =
e.g.</div></div><div class=3D"gmail_default"><br></div><div class=3D"gmail_=
default">Assumption work starting from the second week of the release month=
:</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_default" =
style=3D"font-size:small">1. Collecting the patch list for a new release, l=
ike this email does (Cyril)<br></div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:=
small">2. Reviewing and merging the patch list of step1 (All maintainers, L=
TP-users)</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">3. Pre-release =
widely testing, we need to=C2=A0explicitly post results in step1 email (Pet=
r, Li Wang)</div><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">4. Tiny fix a=
ccording to pre-release testing result (All maintainers, users)</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">5. Writing release note (Cyril)<br><=
/div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div =
class=3D"gmail_default" style=3D"font-size:small">6. Uploading tarballs (Pe=
tr)</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">7. Announcement email=
 of LTP release (Cyril)</div><div>=C2=A0</div><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Does this look useful? or any=
thing else?</div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">IMO if any more volunteers hope to be involved, they just need<=
/div><div class=3D"gmail_default" style=3D"font-size:small">to pick up any =
step they are interested in.</div><br></div></div><div><br></div>-- <br><di=
v dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div=
></div></div></div>

--000000000000ad200705e889ba55--


--===============2093140692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2093140692==--

