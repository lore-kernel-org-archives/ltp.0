Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A396DC433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 07:53:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B602610C8
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 07:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B602610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD5233C0758
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 08:53:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCB523C06E5
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 08:52:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D4FDE601331
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 08:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636444374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBLmBF6AJ6Bd2fbI0lswjsdxhjJgbPpXkVq+m5KZgcI=;
 b=RyeMOMpKs1BFiVbAePCXGcqE0AuI/E5OzP/JbW7X+gDNhaU21fezMUeJEhtRvFnZdjJcqU
 EPAUGzkImCpsZrYaTS5AC/lXsPpgzffQu3Coj6Ub8vhxQaa0AaH0wB04n9QUFRUDs0Y5JG
 Shl7gJpWvH/EM7hPYyjb9pziajSfAic=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-BbN3c9D1MzCOfILSL4bxsA-1; Tue, 09 Nov 2021 02:52:52 -0500
X-MC-Unique: BbN3c9D1MzCOfILSL4bxsA-1
Received: by mail-yb1-f199.google.com with SMTP id
 d27-20020a25addb000000b005c2355d9052so29009652ybe.3
 for <ltp@lists.linux.it>; Mon, 08 Nov 2021 23:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sBLmBF6AJ6Bd2fbI0lswjsdxhjJgbPpXkVq+m5KZgcI=;
 b=xFUeusU/gCOr73v+tVuAKUF3KWc5bGiKzWMBybDAeHJkSuJiejkVFLkssfRTCVaLZC
 hdsMdUgclqzHLxVI7Trm7VL6Ecw+Tq5VmKzIooKVz7f1r5lVw7kH2g9kHP62l3wQDYWG
 c41U582MPzED/5FFcGF5D9KsQ+oxYOJ42KNX0mXMDJ8QjpP3n74Cw8SmIo71GeY6oHX+
 hd+knSz3L7q8GSp92f1h17bJ5VSYIdSQIwNpEmGrxARJqTFSiVi910vSgJ8f4hc2i782
 h4AVXcA+M5Wl43CWfS0SUTGOrJMpkZdGYWJoCye9UA0h5LillodxRq0nIB6+HtX9/O33
 Jtbg==
X-Gm-Message-State: AOAM532mQVP5LcEyWx54s24kZXS+RMyOiMW3hdOEXggy+8X+QX2DZwm4
 /ZYDIw8hGEvnW4o2IdrXUC+oO1bvPNiIAE8szfqXUAD/gfyJ/fNWMJfYt+M14VzMmmhliOLNmfl
 gNEDBXhJLzmEsQGIIjVC6bBTj5Ug=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr5734392ybi.186.1636444372152; 
 Mon, 08 Nov 2021 23:52:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/qbqmAI/Bkz2Mteq8vDt7/hXY2sEEYViariL8GqDdYg0J+kikvs1qPnFN5JwbHcHNbvzK4l4AUOzd6jFMD+k=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr5734379ybi.186.1636444371973; 
 Mon, 08 Nov 2021 23:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20211108021450.1460819-1-liwang@redhat.com>
 <YYkZXtBn+ZKOXVzB@yuki>
In-Reply-To: <YYkZXtBn+ZKOXVzB@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Nov 2021 15:52:39 +0800
Message-ID: <CAEemH2fB1kyM9OYNgHKf-4MxZf+ifXvVry4UpWO=Ute2wG8Z2w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Content-Type: multipart/mixed; boundary="===============0372677789=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0372677789==
Content-Type: multipart/alternative; boundary="0000000000007c8dc105d0566571"

--0000000000007c8dc105d0566571
Content-Type: text/plain; charset="UTF-8"

> > diff --git a/include/tst_arch.h b/include/tst_arch.h
> > new file mode 100644
> > index 000000000..784c3093b
> > --- /dev/null
> > +++ b/include/tst_arch.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later
> > + * Copyright (c) 2021 Li Wang <liwang@redhat.com>
> > + */
> > +
> > +#ifndef TST_ARCH_H__
> > +#define TST_ARCH_H__
> > +
> > +enum tst_arch_type {
> > +     TST_I386,
> > +     TST_X86,
>
> Why do we have both i386 and X86 here? Isn't __i386__ synonymous for
> __x86__ does gcc even define __x86__?
>

My fault, I just copy that from testcase defines and didn't check
if __x86__ validatable or not.

>
> I doubt that we care about the differencies between i386, i586 and i686
> at all. I would just keep TST_X86 in the list for any 32bit intel
> compatible hardware.
>

I prefer to only keep TST_I386 and TST_X86_64 for use. Becuase
so far I didn't see there is a requirement on i[4|5|6]86 in LTP at all.
And, we can add that if we really need it in the future.

The rest of the comments looks good, thanks.

-- 
Regards,
Li Wang

--0000000000007c8dc105d0566571
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; diff --git a/include/tst_arch.h b/include/tst_arch.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000..784c3093b<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/tst_arch.h<br>
&gt; @@ -0,0 +1,39 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + * Copyright (c) 2021 Li Wang &lt;<a href=3D"mailto:liwang@redhat.com=
" target=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef TST_ARCH_H__<br>
&gt; +#define TST_ARCH_H__<br>
&gt; +<br>
&gt; +enum tst_arch_type {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TST_I386,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TST_X86,<br>
<br>
Why do we have both i386 and X86 here? Isn&#39;t __i386__ synonymous for<br=
>
__x86__ does gcc even define __x86__?<br></blockquote><div><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">My fault, I just copy that=
 from testcase defines and didn&#39;t check</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">if __x86__ validatable or not.</div><div class=
=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
I doubt that we care about the differencies between i386, i586 and i686<br>
at all. I would just keep TST_X86 in the list for any 32bit intel<br>
compatible hardware.<br></blockquote><div><br></div><div><div class=3D"gmai=
l_default" style=3D"font-size:small">I prefer to only keep TST_I386 and TST=
_X86_64 for use. Becuase</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">so far I didn&#39;t see there is a requirement on i[4|5|6]86 in L=
TP at all.</div><div class=3D"gmail_default" style=3D"font-size:small">And,=
 we can add that if we really need it in the=C2=A0future.</div><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">The rest of the commen=
ts looks good, thanks.</div></div><div><br></div>-- <br><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></d=
iv>

--0000000000007c8dc105d0566571--


--===============0372677789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0372677789==--

