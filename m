Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA3C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 09:44:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F82E3C9459
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 11:44:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695693C54ED
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 11:44:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E604601039
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 11:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659692662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7cyIk0xCRws7Woo+Hh/F6Iwf/iVU3hkAUB8DB+V76w=;
 b=SNT190e6o8DHnzelFfeM/8bHVlHMHcBDgsCLHJiUTMCMKETYmDZK0gQZEMKgtFhgK6Kuio
 pFbNkFxRRCS5GsCmz1cY8kIK0rxm4MS0xJLBb1j4JCeZMuKsDmZKK+dbP14KlnsaF7fxV0
 tay3R+3f2XFP8Tb9WQYZKXq6L0EYNZg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-FOyzgEqcPn2IAvaIrS2m4Q-1; Fri, 05 Aug 2022 05:44:19 -0400
X-MC-Unique: FOyzgEqcPn2IAvaIrS2m4Q-1
Received: by mail-yb1-f197.google.com with SMTP id
 137-20020a250b8f000000b0067a5a14d730so1672893ybl.12
 for <ltp@lists.linux.it>; Fri, 05 Aug 2022 02:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r7cyIk0xCRws7Woo+Hh/F6Iwf/iVU3hkAUB8DB+V76w=;
 b=4qGcjz5MMNaFAnmqxloDTCFAPlGkAsn+xNdYlf3MFPDl7O43AyC9kolBYPf0V6In6M
 54iPCXBd+kEyJGH2h6Oft4EqaIL6tPZEBzMduHMpgDfWTz+dZaPW3PT3pcBcadV7w6ql
 X4hWMKEOMKidnqIouoxt0x+SvB8sF5HWFric3PFmRKkwrf1LyPh99vowajR+9/MsjTN4
 1SJ4NlSuQUzjQRRl/CwPTu6x7nAynqdfaql7J1ifkYUnGjyaR+2BfCj7gBAAEy6YT3Xi
 56sVBFoRjmvWz0eg+Y88weV4pwi6giUKZMKHpsTL5RYifn4DFeusY0+fDwz2BSiwArQG
 JPQQ==
X-Gm-Message-State: ACgBeo3sGc6RZzDN/dWjPIsIAsPuf8e2TtJoGS90bNaIbyd4yI5x+MGi
 LbUfLIrgcg4PvHIfxlatU3Hhi/+igyBZEEYSkb490csBspCjC9ZZXgM1BzYn6wSmbrh+QTvRWtD
 6LpJxnmh0ObQVb89gd5RGk6rl0hc=
X-Received: by 2002:a81:2409:0:b0:329:38e0:2b71 with SMTP id
 k9-20020a812409000000b0032938e02b71mr2482188ywk.424.1659692658824; 
 Fri, 05 Aug 2022 02:44:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SejuAVlqqI/8wXwn/WlvpfzYPeH749OQljYnXjez8/geQ/KojxOQFa+erE5aLr4FZ6jpGCFnAso2TSz/jFPw=
X-Received: by 2002:a81:2409:0:b0:329:38e0:2b71 with SMTP id
 k9-20020a812409000000b0032938e02b71mr2482173ywk.424.1659692658555; Fri, 05
 Aug 2022 02:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220805063401.1647479-1-liwang@redhat.com>
 <20220805063401.1647479-3-liwang@redhat.com>
 <YuzI7w3MnBgdiaza@pevik>
In-Reply-To: <YuzI7w3MnBgdiaza@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Aug 2022 17:44:07 +0800
Message-ID: <CAEemH2c-AktZmBmuHA+TYg+fjrPE=i=ToY=fq5DB3V2Z_Z_HbQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lapi/fsmount: resolve conflict in different
 header files
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
Content-Type: multipart/mixed; boundary="===============0906567046=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0906567046==
Content-Type: multipart/alternative; boundary="000000000000599a2d05e57b4f04"

--000000000000599a2d05e57b4f04
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Fri, Aug 5, 2022 at 3:38 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > The latest glibc added new wrappers (e.g. mount_setattr, fsopen) support
> in
> > sys/mount.h, which partly conflicts with linux/mount.h at the same time.
>
> > We need to make adjustments to header files to fix compiling error on
> > different platforms.
> thanks for fixing this!
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> LGTM, with suggestion.
>
> > +#include <sys/mount.h>
> >  #include "tst_test.h"
> >  #include "lapi/fsmount.h"
> How about instead adding it to the tests to add it to lapi/fsmount.h ?


It's weird, I was unable to compile successfully like this way yesterday.
So finally go by one by one including the header.

But after doing `make distclean` it works now, I guess there is probably
something messes up my source directory.

Anyway, thanks for your quick review, will merge soon.


-- 
Regards,
Li Wang

--000000000000599a2d05e57b4f04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Aug 5, 2022 at 3:38 PM Petr Vorel &lt=
;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; The latest glibc added new wrappers (e.g. mount_setattr, fsopen) suppo=
rt in<br>
&gt; sys/mount.h, which partly conflicts with linux/mount.h at the same tim=
e.<br>
<br>
&gt; We need to make adjustments to header files to fix compiling error on<=
br>
&gt; different platforms.<br>
thanks for fixing this!<br>
<br>
Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt;<br>
LGTM, with suggestion.<br>
<br>
&gt; +#include &lt;sys/mount.h&gt;<br>
&gt;=C2=A0 #include &quot;tst_test.h&quot;<br>
&gt;=C2=A0 #include &quot;lapi/fsmount.h&quot;<br>
How about instead adding it to the tests to add it to lapi/fsmount.h ?</blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">It&#39;s weird, I was unable to compile successfully like this way =
yesterday.</div><div class=3D"gmail_default" style=3D"font-size:small">So f=
inally go by one by one including the header.</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">But after doing `make distclean` it works now, I guess=
 there is probably</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">something messes up my source directory.</div></div><div><br></div><div=
><div class=3D"gmail_default" style=3D"font-size:small">Anyway, thanks for =
your quick review, will merge soon.</div></div></div><br clear=3D"all"><div=
><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"lt=
r"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000599a2d05e57b4f04--


--===============0906567046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0906567046==--

