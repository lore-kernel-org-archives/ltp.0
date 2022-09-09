Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC78DECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 10:40:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7303CAA6B
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 12:40:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63C0A3C1B7E
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 12:39:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A4496601AC6
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 12:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662719988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jq8p7Ol/hii1HyAEQEVNzKPcp+7o2cPzAjCzqO2jRqA=;
 b=OqrAEAfc3RYKlNWlIWvwskAaHk1r7a/0yqj+7oGD7BmIcjY2e81kt3LiPiIXqdqXf6u5mJ
 3Y+oH7rc3acpp5CowYGHZcOg8sk0eD/n34RDu7+Kr3LP7jbcTL56hB8q1wYheMnGYtsESk
 E+1BR5rudZWyYt6j9wTn9OAaTRelXWo=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-a8jQFwyVPjOlzxS89snslg-1; Fri, 09 Sep 2022 06:39:46 -0400
X-MC-Unique: a8jQFwyVPjOlzxS89snslg-1
Received: by mail-ua1-f70.google.com with SMTP id
 k48-20020ab01633000000b003af70af1b2aso434934uae.18
 for <ltp@lists.linux.it>; Fri, 09 Sep 2022 03:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Jq8p7Ol/hii1HyAEQEVNzKPcp+7o2cPzAjCzqO2jRqA=;
 b=24S4cJnJ3qrMHcCC6ihF61WSR4T2flooZic42HsPUjfeLFnkfj3ToRoYK/e4ee3D+F
 JNYUdWWi7yVxMZ9YaX4QAoP/dQeNKIpGdNl4m4bsu3JrdkQQeWCmUIkgZDARMtUV2R7p
 dyGM+6quS6om8Hohm4Adh32c+VI9CcDxS5D5pT19/cTf4M1tk2PMZCySfzP4lSXr9ijK
 3fd00l0XqVDswMgEaprRuAclV74pzvO1x1iwzom7X6oIgz1sjnsTWLW2tocsNPVAksHD
 vqerMlUrjpwojjTFKXNqgeGlr3u5k66lmpvnO2+5tSEzECGZ/j7/fevhM91ycDEFwZdT
 l7xQ==
X-Gm-Message-State: ACgBeo1ET9GogHwLdutlvuaV6GdPCQjamPFXda0godKywdVsdXt1m6Hk
 DYtL4gYU4jywAU0IpFiqCDL71d4xeeZGjuwPmWJbRxaTL0wtL8b/cxCCP6g6LnDbKEaX0avYt29
 6xL5NA4d4uIPfcln8lxPlHXSIsVc=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr1037346vsu.84.1662719985853; 
 Fri, 09 Sep 2022 03:39:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Mbexh5ZBnBmB29IrLnFynK1AYZ+ojl7LztiU95R7t6FR8XqbTvsX4ka9b59xANrriDsYy+EAaRw83+K697Bc=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr1037340vsu.84.1662719985590; Fri, 09
 Sep 2022 03:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <Yxr+EpKTnKQbKXTb@yuki>
In-Reply-To: <Yxr+EpKTnKQbKXTb@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Sep 2022 18:39:34 +0800
Message-ID: <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1960263301=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1960263301==
Content-Type: multipart/alternative; boundary="0000000000001a3bef05e83c2a86"

--0000000000001a3bef05e83c2a86
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 9, 2022 at 4:47 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> It's time to start working on LTP September relelase.
>
> First of all I'm thinking of increasing the bus factor for LTP so if
> there is anyone who wants to drive the release process instead of me
> please sign up ASAP. I will of course review patches and help with the
> release, but it would nice if someone else tried to do all the little
> things for release as sending emails, deciding what should go to release
> after freeze, preparing release notes, uploading tarballs on github,
> etc.


Maye split this work into pieces? something like:
    - announcement email,
    - collecting patch lists for a new release,
    - writing release notes, or paperwork,
    - uploading tarballs
    - pre-testing against different Linux distribution

You can still send the announcement email, and other volunteers do the rest.
(if applicable, I can take patch reviews or upload tarballs work)

Btw, I'll also cover the full pre-test against the RHEL series before
release.


> And in order not to delay things further, please start pointing out
> patches that should go in before the release. I guess Martin runtime
> fixes should go in. Anything else?
>

The "Track minimal size per filesystem" from Petr should be included as
well.
(I guess it is still WIP)


-- 
Regards,
Li Wang

--0000000000001a3bef05e83c2a86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 9, 2022 at 4:47 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
It&#39;s time to start working on LTP September relelase.<br>
<br>
First of all I&#39;m thinking of increasing the bus factor for LTP so if<br=
>
there is anyone who wants to drive the release process instead of me<br>
please sign up ASAP. I will of course review patches and help with the<br>
release, but it would nice if someone else tried to do all the little<br>
things for release as sending emails, deciding what should go to release<br=
>
after freeze, preparing release notes, uploading tarballs on github,<br>
etc.</blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">Maye split this work into pieces? something like:=C2=A0</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 - a=
nnouncement=C2=A0email,=C2=A0</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">=C2=A0 =C2=A0 - collecting=C2=A0patch lists for a new releas=
e,</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=
=A0 - writing release notes, or paperwork,=C2=A0</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">=C2=A0 =C2=A0 - uploading tarballs</div><=
div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0 - pre-t=
esting against different Linux distribution</div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">You can still send the announc=
ement=C2=A0email, and other volunteers do the rest.</div><div class=3D"gmai=
l_default" style=3D"font-size:small">(if=C2=A0<span style=3D"color:rgb(51,5=
1,51);font-size:14px">applicable</span>, I can take patch reviews or upload=
 tarballs work)</div><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Btw, I&#39;ll also cover the full pre-test against the RHEL seri=
es before release.</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small"></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
And in order not to delay things further, please start pointing out<br>
patches that should go in before the release. I guess Martin runtime<br>
fixes should go in. Anything else?<br></blockquote><div><br></div><div><div=
 class=3D"gmail_default" style=3D"">The &quot;Track minimal size per filesy=
stem&quot; from Petr should be included as well.</div><div class=3D"gmail_d=
efault" style=3D"">(I guess it is still WIP)</div></div><div><br></div></di=
v><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--0000000000001a3bef05e83c2a86--


--===============1960263301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1960263301==--

