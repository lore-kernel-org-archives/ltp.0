Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB401C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:35:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F2C61167
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 09:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F2C61167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB9793C07BD
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:35:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BCF83C0781
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:35:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97804601405
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 10:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636450518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXy2a05U58Qzn1E6p8XozfnpYkqcTMWAV5bhLY7GLw8=;
 b=b4C5WsjJdAkuu59h4SH3ZyQc9ry6n7q7oIqtykm697l3e4ckEFU7G3U/YDeWsKXosqb/Na
 yf+k/zUtb8Z1x1oUooaVvuHK11VSNGhr6GItn6YTDksLF01xkXztA8UmOCmyJh2bFXf9lm
 CpBvFQ87znPuj0MMQtwrjIbct6GbZXE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-EOg8yVjLNP-q7lNt9bDX4Q-1; Tue, 09 Nov 2021 04:35:17 -0500
X-MC-Unique: EOg8yVjLNP-q7lNt9bDX4Q-1
Received: by mail-yb1-f197.google.com with SMTP id
 y125-20020a25dc83000000b005c2326bf744so29419284ybe.21
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 01:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nXy2a05U58Qzn1E6p8XozfnpYkqcTMWAV5bhLY7GLw8=;
 b=x8sJYppUcBscuEhYph69xmi13knh+30FymOp/gUiV8oevUDdkjuuh4JqR+vOqFnUye
 Y7AF5bMRGmHu/fGxyveda8SmzZfcetETi88krICn0rn2DmPPCwaTgY+pdabVxsTvON3b
 3CcHVXBTVwxtmqgv8Btq32acHgy+kX/gd5hESWTggxqNe9fyouXRVIaeZSQkmHd3qpQt
 0Cs1vhUhaiXldSS63XG37Bs3FbE3oMrgSPLUESf0lHJWMHBOCtlxIy9cw0n8nI4eQev6
 PypcmcYDFugmFoQFwoypdrTLfMZiRiLc7dKEjKOBO0PVfZ6IkUY85HcpEwdLs1b7LRMW
 CFvA==
X-Gm-Message-State: AOAM5309myRnUoyQ1IKduGtHlcD+GjZ5gqmcDg7nnDJXy874AATknwmz
 sx4hBvQkpPixW3vqS/SG3rxUoSiw7US1LHBoeNn9o9d7+OKpaf4lm70kvIGM8suark0FUaU262+
 NOP4rXMzXXnu8l5j90JUWwf5P9nE=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr6298139ybi.186.1636450516619; 
 Tue, 09 Nov 2021 01:35:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfF/bNOfGl0GNpGvDUSynqC/sBqxeHOwpCwTlI8887wfNG/2vi8RF7t/y8QoUe3px0tdoVkgvQhjrfwXNFhKc=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr6298117ybi.186.1636450516417; 
 Tue, 09 Nov 2021 01:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20211108021450.1460819-1-liwang@redhat.com>
 <20211108021450.1460819-3-liwang@redhat.com>
 <YYkbujntxMkANsG6@yuki>
In-Reply-To: <YYkbujntxMkANsG6@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Nov 2021 17:35:04 +0800
Message-ID: <CAEemH2cw=cSgoX=5-A_Q0_N4rhSBUYmqvWdtPEZoEngc1wZxsA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] max_map_count: replace ifdefs by tst_arch
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
Content-Type: multipart/mixed; boundary="===============0073443864=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0073443864==
Content-Type: multipart/alternative; boundary="000000000000b9723f05d057d38f"

--000000000000b9723f05d057d38f
Content-Type: text/plain; charset="UTF-8"

> > +     switch (tst_arch.type) {
> > +     case TST_X86:
> > +     case TST_X86_64:
> > +             /* On x86, there's an old compat vsyscall page */
> > +             if (!strcmp(buf, "[vsyscall]"))
> > +                     return true;
> > +     break;
> > +     case TST_IA64:
> > +             /* On ia64, the vdso is not a proper mapping */
> > +             if (!strcmp(buf, "[vdso]"))
> > +                     return true;
> > +     break;
> > +     case TST_ARM:
> > +             /* Skip it when run it in aarch64 */
> > +             if ((!strcmp(un.machine, "aarch64"))
> > +                             || (!strcmp(un.machine, "aarch64_be")))
> > +                     return false;
>
>                 I wonder if this would be better as:
>
>                 if (tst_kernel_bits() == 64)
>                         return false;
>

Actually, we have TST_AARCH64 already, I'd go with switch to that.

-- 
Regards,
Li Wang

--000000000000b9723f05d057d38f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0switch (tst_arch.type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case TST_X86:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case TST_X86_64:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* On x86, there&#39;=
s an old compat vsyscall page */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(buf, &quo=
t;[vsyscall]&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case TST_IA64:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* On ia64, the vdso =
is not a proper mapping */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(buf, &quo=
t;[vdso]&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case TST_ARM:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Skip it when run i=
t in aarch64 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((!strcmp(un.machi=
ne, &quot;aarch64&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (!strcmp(un.machine, &quot;aarch64_be=
&quot;)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I wonder if this wo=
uld be better as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_kernel_bits=
() =3D=3D 64)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return false;<br></blockquote><div><br></div><div><div class=3D"=
gmail_default" style=3D"font-size:small">Actually, we have TST_AARCH64 alre=
ady, I&#39;d go with switch to that.</div></div></div><div><br></div>-- <br=
><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<=
br></div><div>Li Wang<br></div></div></div></div>

--000000000000b9723f05d057d38f--


--===============0073443864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0073443864==--

