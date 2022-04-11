Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6395C433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 12:36:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 102033CA538
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 14:36:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D49FA3C1BDF
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 14:36:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F7271000760
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 14:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649680568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsN/k0izI5z6kZl4+sAE1FQzyJnhbI0Zbism76yWRRs=;
 b=inYz+4Q19ZT0scbLB9J9//XroTBgnrU1Svr1fNAgHwVmDmPLwRZT5J250kpR5OSaROPWHr
 roXRaklKC4i9Fp/jY9kZYmH5L/8BJ4TpKnyAbdNX1I3rondSh5IE8FVthyidNl+WSzeC/Y
 2ATuz6g9LahuAwDvm9Be0w3EahwANBI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-uyw0fTJuOSyzrSt5FB7feQ-1; Mon, 11 Apr 2022 08:36:07 -0400
X-MC-Unique: uyw0fTJuOSyzrSt5FB7feQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2ec13b4bd42so25882087b3.16
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 05:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fsN/k0izI5z6kZl4+sAE1FQzyJnhbI0Zbism76yWRRs=;
 b=kwvlY9fQk7bijrMHeaAXnpeF1NIdSIqv2Xvuiv9AwxkVo9UFG0vGS0smqxtQfuxE0V
 ALH8Q+V4PYj2iZi+JRXHOGezFPcXkCR3AH7zs0eXcG8JqpPy0sPROV5QvyRqPncUq2vh
 vVvWpq3cMyWS6DyYnnS/n53RvBHVeFc3Z1mce5fKN/ViVQlVyMTxo/kdqyhVeQJTy/JD
 BWowy0CIEx0LBR6k5vx78M0q/shJxvDjMvL2VwOzbq2rKZYNhEkxaWlQTudMTYzAg66o
 9TW+0xwO7hFqQa7hzB/Eqad2kVWAXqJq9H0iZucLl7zexlx1QTd4zdUFINAFNH9VsqKl
 Mm3A==
X-Gm-Message-State: AOAM531ZycoXTkfvW2I8HL6D3JaS++nZ+250lEOG6OMFCaSPJ37nDcYI
 GMpMb0VCVmMNIyZqwreMiVzknDZBSY0hyomTIY2KEc/Cx36lrucIJv7toai6D2j9F28oHFAjQ1b
 PDmYLZ0gsImsE2ke+nnT5nZmhvYA=
X-Received: by 2002:a25:2c89:0:b0:641:2884:b52e with SMTP id
 s131-20020a252c89000000b006412884b52emr6127368ybs.506.1649680566850; 
 Mon, 11 Apr 2022 05:36:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzt8UFDoPOPCCnsERC7ON3Z+5ALVCGaOIA3GRtry4zaPUblFYQIoXVvROJiF64uNvXNde3qVGuaoEcl3F7Hr+k=
X-Received: by 2002:a25:2c89:0:b0:641:2884:b52e with SMTP id
 s131-20020a252c89000000b006412884b52emr6127339ybs.506.1649680566474; Mon, 11
 Apr 2022 05:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220411094048.1143292-1-liwang@redhat.com>
 <20220411094048.1143292-2-liwang@redhat.com>
 <CAASaF6wZSGKi+ePOcYYiuvQ=RNhu5mPTrY-FFiRMA0UhMaO1Zw@mail.gmail.com>
In-Reply-To: <CAASaF6wZSGKi+ePOcYYiuvQ=RNhu5mPTrY-FFiRMA0UhMaO1Zw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Apr 2022 20:35:52 +0800
Message-ID: <CAEemH2djWZ5ZPj8uYWESy+CGLo7zFD_V==1ROMRLZW78itY51A@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>, Ram Pai <linuxram@us.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] pkey: correct the PKEY_DISABLE_ACCESS
 definitions on PowerPC
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
Content-Type: multipart/mixed; boundary="===============1833160652=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1833160652==
Content-Type: multipart/alternative; boundary="00000000000028707505dc603096"

--00000000000028707505dc603096
Content-Type: text/plain; charset="UTF-8"

On Mon, Apr 11, 2022 at 6:57 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Mon, Apr 11, 2022 at 11:41 AM Li Wang <liwang@redhat.com> wrote:
> >
> > Reference:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e9506394a159
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/kernel/syscalls/pkeys/pkey.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/pkeys/pkey.h
> b/testcases/kernel/syscalls/pkeys/pkey.h
> > index 6e32326b6..6cda88ff1 100644
> > --- a/testcases/kernel/syscalls/pkeys/pkey.h
> > +++ b/testcases/kernel/syscalls/pkeys/pkey.h
> > @@ -11,6 +11,13 @@
> >  #include "lapi/syscalls.h"
> >  #include "lapi/mmap.h"
> >
> > +#if defined(__powerpc__) || defined(__ppc__)
> > +# undef PKEY_DISABLE_ACCESS
> > +# define PKEY_DISABLE_ACCESS 0x3
>
> Where does powerpc define PKEY_DISABLE_ACCESS as 0x3?
>

Good question, I previously thought that was officially defined as 0x3 on
PowerPC (per Ram's patch).

But after looking at 'powerpc/include/uapi/asm/mman.h' it still includes
header which define PKEY_DISABLE_ACCESS as 0x1.
    #include <asm-generic/mman-common.h>

@Ram Pai, could you explain why you're using 0x3 in kselftest?
Did I miss anything?


-- 
Regards,
Li Wang

--00000000000028707505dc603096
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Apr 11, 2022 at 6:57 PM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Apr 11, 2022=
 at 11:41 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_bl=
ank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Reference: <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/=
torvalds/linux.git/commit/?id=3De9506394a159" rel=3D"noreferrer" target=3D"=
_blank">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3De9506394a159</a><br>
&gt;<br>
&gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=
=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 testcases/kernel/syscalls/pkeys/pkey.h | 7 +++++++<br>
&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt;<br>
&gt; diff --git a/testcases/kernel/syscalls/pkeys/pkey.h b/testcases/kernel=
/syscalls/pkeys/pkey.h<br>
&gt; index 6e32326b6..6cda88ff1 100644<br>
&gt; --- a/testcases/kernel/syscalls/pkeys/pkey.h<br>
&gt; +++ b/testcases/kernel/syscalls/pkeys/pkey.h<br>
&gt; @@ -11,6 +11,13 @@<br>
&gt;=C2=A0 #include &quot;lapi/syscalls.h&quot;<br>
&gt;=C2=A0 #include &quot;lapi/mmap.h&quot;<br>
&gt;<br>
&gt; +#if defined(__powerpc__) || defined(__ppc__)<br>
&gt; +# undef PKEY_DISABLE_ACCESS<br>
&gt; +# define PKEY_DISABLE_ACCESS 0x3<br>
<br>
Where does powerpc define <span class=3D"gmail_default" style=3D"font-size:=
small"></span>PKEY_DISABLE_ACCESS as 0x3?<br></blockquote><div><br></div><d=
iv><div class=3D"gmail_default" style=3D"font-size:small">Good question, I =
previously thought that was officially defined as 0x3 on PowerPC (per=C2=A0=
<span style=3D"color:rgb(51,51,51);font-family:sans-serif;font-size:13.3333=
px">Ram&#39;s patch)</span>.</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">But after looking at &#39;powerpc/include/uapi/asm/mman.h&#39; it still=
 includes</div><div class=3D"gmail_default" style=3D"font-size:small">heade=
r which define=C2=A0<span class=3D"gmail_default"></span>PKEY_DISABLE_ACCES=
S=C2=A0as 0x1.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><span class=3D"gmail_default">=C2=A0 =C2=A0=C2=A0</span>#include &lt;=
asm-generic/mman-common.h&gt;</div><br><div class=3D"gmail_default" style=
=3D"font-size:small">@<span style=3D"color:rgb(51,51,51);font-family:sans-s=
erif;font-size:13.3333px">Ram Pai, could you explain why you&#39;re using 0=
x3 in kselftest?</span></div><div class=3D"gmail_default" style=3D"font-siz=
e:small">Did I miss anything?</div></div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000028707505dc603096--


--===============1833160652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1833160652==--

