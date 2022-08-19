Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00EDC32773
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:56:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A663C8CA7
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 14:56:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 375953C8CA7
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:56:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7FAA36002B4
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660913760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uISs9+AHNlrGbVWzHCQQlc5xCccyoWlrEAD3hh8mVjE=;
 b=RcJbGNECDcLuG6E32kHVpcyTSRnm7FJbyVhL+3aj8Ilkm+CEND8f3xMQkK8dEHXzCRiDJY
 7aunnX4gKYL/DYisD+Ni72KzrxpRg5zfSUPR0WIYUQQi0yIbni3y0w5hepG86magDYzNiM
 2i7G+j9L5PqKYgkFjPGu8Esxm+0c5ks=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-jOw-Lm56N--tmZ5iEkAJXw-1; Fri, 19 Aug 2022 08:55:59 -0400
X-MC-Unique: jOw-Lm56N--tmZ5iEkAJXw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-3363b1dffa0so75852567b3.23
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 05:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=6i9Ta0ds3yuu0ZuzmxB8FsBX8ivSlF9bmLsHkSqalqY=;
 b=n2V/WMG3TXrtPdVsY/XgYw2/kgEHbmrxpkHsjwR/idoM4Igv+n4Ma0UA6HxeMXQ5+4
 LhVeSwT0eMYGFX8p6BQam+cSPG/z32ymJ7UUDx+Oc6xHvYo41EDKK4wi55/vyB0vIgy9
 3PY33yBJfjPXnGDW/PfV3k+VsQK9b0hghnm+9VrVGJL0+o5WGXxo3Yawi/bVXFFI8Umw
 3HyD6CBy1YskhYbBxSU2OZYR4rKKpuF8GQy0Ip5nkedRm0GLwtj2Wiuk8tXEs03LWncz
 LL5DVbAwjGdFELFZWYSC3dnIGS3Shkvo1fY/mRKXV/jLZZcIRYykYX609Vvt10ugdiLI
 5f1g==
X-Gm-Message-State: ACgBeo3j9DOw47KdCIwOakmM1mnuVdyn2Ks++xZsyPdj53Iln4uBjLKU
 G2tPTtknBDahQfPY2MUXxM1d3Dye0/Y19XGWuoJhPBnidIeI6yY4HZmPAi7la08DR/PpNYJvunz
 HmnHVKpqUzv2cAiBgw65Xu/ZBgWA=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr7531430ybn.597.1660913759182; 
 Fri, 19 Aug 2022 05:55:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4py+/uhpSlZ4KUA6WIRw7IMJFN4qXu8xt6nzCpPmUc+v2i0eV4mIGzODuDhirjLFyjXPXTUF7+A4sMwRyRd8U=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr7531415ybn.597.1660913758957; Fri, 19
 Aug 2022 05:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
In-Reply-To: <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Aug 2022 20:55:48 +0800
Message-ID: <CAEemH2d97boX8x3+XKS23djO93S3+og+5r9RDFp3gzo97mMp+A@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0704564569=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0704564569==
Content-Type: multipart/alternative; boundary="0000000000009b0ac705e6979ed7"

--0000000000009b0ac705e6979ed7
Content-Type: text/plain; charset="UTF-8"

> So for me, If remove kernel commit in description, then I only see
> useless commit id number, unless I go to search them in kernel org.
>

Not exactly, another thing to make people's attention is test fail with
hint,
then we can simply click the link.

    58	HINT: You _MAY_ be missing kernel fixes:
    59	
    60	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93bc420ed41d
    61	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=99652ea56a41
    62	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04a87e347282
    63  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f955f26f3d4


-- 
Regards,
Li Wang

--0000000000009b0ac705e6979ed7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
So for me, If remove kernel commit in description, then I only see<br>
useless commit id number, unless I go to search them in kernel org.<br></bl=
ockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Not exactly, another thing to make people&#39;s attention is test fail =
with hint,</div><div class=3D"gmail_default" style=3D"font-size:small">then=
 we can simply click the link.</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><pre class=3D"gmail-code gmail-highlight" lang=3D=
"shell"><span class=3D"gmail_default" style=3D"font-size:small"></span>=C2=
=A0 =C2=A0 58=09HINT: You _MAY_ be missing kernel fixes:<br>=C2=A0 =C2=A0 5=
9=09<br>=C2=A0 =C2=A0 60=09<a href=3D"https://git.kernel.org/pub/scm/linux/=
kernel/git/torvalds/linux.git/commit/?id=3D93bc420ed41d">https://git.kernel=
.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D93bc420ed41d<=
/a><br>=C2=A0 =C2=A0 61=09<a href=3D"https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git/commit/?id=3D99652ea56a41">https://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D99652ea56a41</=
a><br>=C2=A0 =C2=A0 62=09<a href=3D"https://git.kernel.org/pub/scm/linux/ke=
rnel/git/torvalds/linux.git/commit/?id=3D04a87e347282">https://git.kernel.o=
rg/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D04a87e347282</a=
> <br>=C2=A0 =C2=A0 63 <span class=3D"gmail_default" style=3D"font-size:sma=
ll"> </span><a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux.git/commit/?id=3D5f955f26f3d4">https://git.kernel.org/pub/scm/li=
nux/kernel/git/torvalds/linux.git/commit/?id=3D5f955f26f3d4</a><span style=
=3D"font-family:Arial,Helvetica,sans-serif"></span><br></pre></div><div><br=
></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><=
div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000009b0ac705e6979ed7--


--===============0704564569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0704564569==--

