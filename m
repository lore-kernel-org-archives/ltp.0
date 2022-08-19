Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284A5C32773
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:37:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C908B3CA1E9
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 14:37:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B4F23C2A8C
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:36:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 518521A00995
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660912611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fm+fFKeEwsOZqXL5ubI0LrR7wVKlT5T0/AVjOdCStM4=;
 b=WNEI9g5juIaGulSR6lIpImyrOvSMh++1nHnvJg5Ivy/ztskFj5/57zIyBxFczh1FCmQOrJ
 abA7Aq0QoGXL/ZOJbepY5QC2M1+PbgyK5bVPDisEmcauDhudHZ8ZRAUkqNpL7MltLK0z7i
 ONXrwxfwF64UEyedatCVRSHgxDVw7Dw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-qIDrMA-xNx6Zi2ya2Rgi0w-1; Fri, 19 Aug 2022 08:36:50 -0400
X-MC-Unique: qIDrMA-xNx6Zi2ya2Rgi0w-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-337ed9110c2so31869337b3.15
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 05:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Fm+fFKeEwsOZqXL5ubI0LrR7wVKlT5T0/AVjOdCStM4=;
 b=oyir8+s2wrToWlgN1avTVCeSxN6VTjIj4P9Tv6mIolr1ICnVB+qgmVfL7qRRP8C+hD
 F86r4lH2YYip9j5Z4Nv48EhkWdPAnWerdH8WqV62sqqU7dwphEA+tHcLpk9CYavHqNTX
 JrBf2vmdjA17mob1DX/WSR/guUb1RyiVGT+gPrNVS6Gl1HTVLotOvp02cGiKp4IbP1Pc
 zg8+o3xneIftMPkyUg1KZ8CB1uB/QqUoF5hasj2guj9P7R4Pir++XnDJhE0tUWZhuRIl
 9pvYHTRoxC+RjWf/ERi1zCYA1CuZcqg5xBwVADG2w4KIl9SPqHMpnq66dOGNBXFe1ZPe
 IIoA==
X-Gm-Message-State: ACgBeo3/86sAimDwb9F6ORY7MeYAuoY8887DqZ7EXpY2qDJZvWWq3lDA
 XmPMZGZ8jlDpGRr2bxkzey7Jvk91fWjaIuPT0axQnZ8zUEhIBoNF3WvwQETKYCEViGMnYpC6naw
 MhqGt5wXkKf4KwjNEo+zWaC8AtL4=
X-Received: by 2002:a25:ce06:0:b0:67c:3308:c38f with SMTP id
 x6-20020a25ce06000000b0067c3308c38fmr7379491ybe.591.1660912610018; 
 Fri, 19 Aug 2022 05:36:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6kmZefVeCuj4WhTHjACFLfrYE6dcJ4oWHD1GY73HAQ6qArbGj5i1ilcU0u/KB8EXNF50kOzZx+9R//7lP8Xls=
X-Received: by 2002:a25:ce06:0:b0:67c:3308:c38f with SMTP id
 x6-20020a25ce06000000b0067c3308c38fmr7379472ybe.591.1660912609705; Fri, 19
 Aug 2022 05:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220819090704.17219-1-pvorel@suse.cz>
In-Reply-To: <20220819090704.17219-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Aug 2022 20:36:38 +0800
Message-ID: <CAEemH2djrQ0u7UzBz45jBgyVGvrKk-n4NPG9oyNsdxiehtmRRQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0770734592=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0770734592==
Content-Type: multipart/alternative; boundary="0000000000001ad6dc05e6975a0e"

--0000000000001ad6dc05e6975a0e
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Fri, Aug 19, 2022 at 5:07 PM Petr Vorel <pvorel@suse.cz> wrote:

> They are defined in .tags, having in docparse results into poor
> formating in metadata.{html,pdf}.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Li,
>
> I've done cleanup like this in the past, but sending a patch just to
> make consensus about it. If we prefer to have git commits like this in
> the code (i.e. if being in .tags is not enough), they should be in
> normal comments /* ... */ so that they aren't in docparse.


> IMHO docparse can mention some commit if wanted to add some description,
> but just as 5f955f26f3d4 or 5f955f26f3d4 ("xfs: report crtime and
> attribute flags to statx") if the commit subject is a description
> itself.
>

Good to know this. I agree to remove those commit info as you
did in this patch. To be honest, I don't think that helps people in
code reading, they are just as reductant info pointer to the feature's
commit id.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000001ad6dc05e6975a0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Aug 19, 2022 at 5:07 PM Petr Vorel &l=
t;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">They ar=
e defined in .tags, having in docparse results into poor<br>
formating in metadata.{html,pdf}.<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
Hi Li,<br>
<br>
I&#39;ve done cleanup like this in the past, but sending a patch just to<br=
>
make consensus about it. If we prefer to have git commits like this in<br>
the code (i.e. if being in .tags is not enough), they should be in<br>
normal comments /* ... */ so that they aren&#39;t in docparse.</blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
IMHO docparse can mention some commit if wanted to add some description,<br=
>
but just as 5f955f26f3d4 or 5f955f26f3d4 (&quot;xfs: report crtime and<br>
attribute flags to statx&quot;) if the commit subject is a description<br>
itself.<br></blockquote><div><br></div><div><div class=3D"gmail_default" st=
yle=3D"font-size:small">Good to know this. I agree to remove those commit=
=C2=A0info as you</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">did in this patch. To be honest, I don&#39;t think that helps people=C2=
=A0in</div><div class=3D"gmail_default" style=3D"font-size:small">code read=
ing, they are just as reductant=C2=A0info pointer to the feature&#39;s</div=
><div class=3D"gmail_default" style=3D"font-size:small">commit id.</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div></div><div>=C2=
=A0</div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div=
>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000001ad6dc05e6975a0e--


--===============0770734592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0770734592==--

