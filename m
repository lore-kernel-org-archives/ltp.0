Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559EBC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 01:25:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8377061132
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 01:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8377061132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2FD03C938E
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 03:24:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E14BC3C2327
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 03:24:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FB7C200D2D
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 03:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631064285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEsscoWsuTl9pWhDx96ErJVy7f55waOuDkQNsG7xPqI=;
 b=HPUvBR9B7mb21jyWUMJorJIh148KZqDPTEGLHQqW0J5czLA0QYAELGU3gT+4RLbimLEnDI
 0Cf0o9OLGZhdmT3s0ehEp4mROwp6uoEMACB5FCDi8orHcgraQn85vAHFtIrFo9na+WuzSn
 94WMt+ZIHUNx/0tX33hc4NUsDoGMI0M=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-MZWTmdY5OWKyf8xieTdD_Q-1; Tue, 07 Sep 2021 21:24:44 -0400
X-MC-Unique: MZWTmdY5OWKyf8xieTdD_Q-1
Received: by mail-yb1-f197.google.com with SMTP id
 o76-20020a25414f000000b0059bb8130257so615652yba.0
 for <ltp@lists.linux.it>; Tue, 07 Sep 2021 18:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GEsscoWsuTl9pWhDx96ErJVy7f55waOuDkQNsG7xPqI=;
 b=d3Yf2GY+99mQAwQmCBEWHmN7al6PA9qosTk4vuR4/6yZ6+lJZVrfekyNoC/kvLZTz+
 u/bxtjQwVB7ji2IVqHSep0v9mF7k2xqoTN3l6ZXEc5E0+dYK1P5b2in/qw+GO6GOvl2w
 boSxg0bLLL3+hexr4ygEhnnXApUoDUt/MXGbaViaBvUWrZKEOMbG3tDw71tZAxazsfLn
 r76vKkNOL5yinGulZc7myLeSD33sHGQFbUDSEZjnOgDKtz1Vz8O2P1G5hAAcWF67mOZ0
 S0Mh6fP/XJGZw8RQnd30/bAn/zo3j8FuPWj3hLQOrQJbEI+9/UkfezVDmt3iat++blQi
 JLiA==
X-Gm-Message-State: AOAM533nQrDUn7p1v7F+//hT48uTy6Ob5XHUrgT1wbAAt566g3MZKjii
 k1ty1IRrdsOY9g3bpoXk6TR4BlKGK1vslciwsROc4LIn8/eSwkV9OIsrnMyKX1ZgAl6Ya4v1We+
 ida/zIs/f4RhMx1m6hFZbijSx7sM=
X-Received: by 2002:a05:6902:120a:: with SMTP id
 s10mr1620275ybu.293.1631064283801; 
 Tue, 07 Sep 2021 18:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0Ee7VQkZ2W7lSYXOCAbqA286eXV37Y8Df1BGn3MhigK4KofXwb0zMM840CXXC670e8eusxEygPA299RDiWyk=
X-Received: by 2002:a05:6902:120a:: with SMTP id
 s10mr1620262ybu.293.1631064283602; 
 Tue, 07 Sep 2021 18:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210907025258.3294914-1-liwang@redhat.com>
 <YTc20vtM2HbhTVTg@yuki>
In-Reply-To: <YTc20vtM2HbhTVTg@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Sep 2021 09:24:26 +0800
Message-ID: <CAEemH2e66Yfkobgy1D7mDGmK3YkmWx0240imVroCDay66VBmUg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: make use of tst_process_state_wait3
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
Content-Type: multipart/mixed; boundary="===============0569384767=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210908012426.fV9yvxaRwDzRt1cYlBxxGZ1he9hB_GefGfgvgPLldnw@z>

--===============0569384767==
Content-Type: multipart/alternative; boundary="0000000000003afa2f05cb71bf67"

--0000000000003afa2f05cb71bf67
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 5:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> > index 04ef0a2cc..554714695 100644
> > ---
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> > +++
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> > @@ -17,6 +17,7 @@
> >  #include <stdlib.h>
> >  #include <errno.h>
> >  #include "posixtest.h"
> > +#include "proc.h"
> >
> >  #define SLEEPSEC 30
> >
> > @@ -88,7 +89,7 @@ int main(void)
> >               /* parent here */
> >               int i;
> >
> > -             sleep(1);
> > +             tst_process_state_wait3(pid, 'S', 1);
>
> This test is actually the only one that looks at the remining time as
> returned by clock_nanosleep() so it may make a sense to keep the
> sleep(1) in this test so that the remaining time is smaller than the
> sleep time by some reasonable margin. But I guess that the test will
> work fine without it as well.
>

Good point, I have retrieved that 1 sec sleep and applied. Thanks!

-- 
Regards,
Li Wang

--0000000000003afa2f05cb71bf67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 5:54 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clo=
ck_nanosleep/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/=
clock_nanosleep/9-1.c<br>
&gt; index 04ef0a2cc..554714695 100644<br>
&gt; --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nano=
sleep/9-1.c<br>
&gt; +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nano=
sleep/9-1.c<br>
&gt; @@ -17,6 +17,7 @@<br>
&gt;=C2=A0 #include &lt;stdlib.h&gt;<br>
&gt;=C2=A0 #include &lt;errno.h&gt;<br>
&gt;=C2=A0 #include &quot;posixtest.h&quot;<br>
&gt; +#include &quot;proc.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define SLEEPSEC 30<br>
&gt;=C2=A0 <br>
&gt; @@ -88,7 +89,7 @@ int main(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* parent here *=
/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sleep(1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_process_state_wai=
t3(pid, &#39;S&#39;, 1);<br>
<br>
This test is actually the only one that looks at the remining time as<br>
returned by clock_nanosleep() so it may make a sense to keep the<br>
sleep(1) in this test so that the remaining time is smaller than the<br>
sleep time by some reasonable margin. But I guess that the test will<br>
work fine without it as well.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Good point, I have retrieved =
that 1 sec sleep and applied. Thanks!</div></div></div><div><br></div>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,=
<br></div><div>Li Wang<br></div></div></div></div>

--0000000000003afa2f05cb71bf67--


--===============0569384767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0569384767==--

