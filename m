Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455DAC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 03:54:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCB5A3CB14E
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 05:54:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09A233CAF2C
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:54:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3C3F2600688
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666238046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5yt8uqU2MrNLGQKCnKL/RYTSJMxKe2QrfrQcYVzwnw=;
 b=UXHjwWc2moeSIY20PQdoH4FuhzEn2LWj+Mp4kFnuAit5ULQTa/iXp+1bzOvVsWf1J5zmEF
 60jJKxqxKIY69geED34UdJ8Lau0A5yHFuMcx1/ucqXSBXvp61DS8V6+YaR/RMQ/CR7HOca
 Z3V1CrQlUR5XA1aV1ikudw7X/JiVY+w=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-GWuyvcihP9e0BFI7Df3BCw-1; Wed, 19 Oct 2022 23:53:57 -0400
X-MC-Unique: GWuyvcihP9e0BFI7Df3BCw-1
Received: by mail-ot1-f69.google.com with SMTP id
 3-20020a9d0b83000000b00660d7acf0dfso9164611oth.9
 for <ltp@lists.linux.it>; Wed, 19 Oct 2022 20:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v5yt8uqU2MrNLGQKCnKL/RYTSJMxKe2QrfrQcYVzwnw=;
 b=lIPkm7uTFpbIJupGgBBKpF7ikNZMKRgTmzyGVo0WPiajaJCqYNZEyZzpDY4KUHnxXK
 IhuH5nIe5NfiAex6LFO7ysFbhinbkevp+GN3JL+JPEchSJKsY9/kD7UkB7LUpn14bxK8
 4uUn2o41W3EE3kI34EFax6UIF9mGzxjW838UxaxejJUZZPdV/ITAh2zUpQ4cgTLA+5UO
 Mr0pZ0I2GB7SqFnzr8Pl51siqpkY2Ah2RqrGRpFc0zV8Xl+ovkUur3ZVoqOA6NH4Qz2d
 WVFlAdE7Pel3aAOSBYku+lO3RjrBL+uQxEn7D9rxpEgb6utJoF/ULau3Y9qmVV83XUDa
 oyEw==
X-Gm-Message-State: ACrzQf0/irjt1IL9bQ7cbxt1rxCEUQEoUt6G0BoXH5bw3crr6+AU6Dks
 uKEymQ/XxpVmEQR+6rL+3pSi0zTi/OX6MUwSmLBqYRuK1q5P7tLW3bB1/EgVb02RYlahb3pclXH
 tZgB6/nCkZ07hHKaPTrAeLJBwsGk=
X-Received: by 2002:a9d:12a6:0:b0:661:d26c:708c with SMTP id
 g35-20020a9d12a6000000b00661d26c708cmr5810095otg.160.1666238037122; 
 Wed, 19 Oct 2022 20:53:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yUydIr8fg1CImHch+HpozzKzDuVTxRGUfbsOqqY+5OJMoq62b/1Nzk8yf/WWzTAecMfaYG5UCtfPgzteksFw=
X-Received: by 2002:a9d:12a6:0:b0:661:d26c:708c with SMTP id
 g35-20020a9d12a6000000b00661d26c708cmr5810085otg.160.1666238036850; Wed, 19
 Oct 2022 20:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <f15cfed9-b389-b176-9d7d-8f2fcc8aaff0@suse.cz>
In-Reply-To: <f15cfed9-b389-b176-9d7d-8f2fcc8aaff0@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 11:53:43 +0800
Message-ID: <CAEemH2fVhxhZNsMx0_CU8am_MRoOxnJ1fgu=qJTRag5z1=o0Yw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ptrace07: Fix compilation when not on x86
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0140312342=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0140312342==
Content-Type: multipart/alternative; boundary="0000000000004c578705eb6f46ce"

--0000000000004c578705eb6f46ce
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 19, 2022 at 5:30 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 18. 10. 22 17:25, Richard Palethorpe via ltp wrote:
> > Strictly cpuid.h should not be included on non-x86, but this means
> > each test author has to remember not to include it. Instead we can set
> > a blank macro to allow compilation.
> >
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > ---
>
> Hi,
> defining an empty macro is a bad idea because it'll allow a broken test
> to be compiled and then it'll behave erratically for no apparent reason.
> It's better to get a build failure.
>
> Reverting 1df4de06206b079f24dde7157d037b48727c743d is the best solution
> here. Building ptrace07 and similar arch-specific tests without a key
> piece of code does not make sense. The preprocessor arch checks should
> wrap around the whole file, not just a small non-portable bit that's
> crucial for the test to work.
>

From what I know, one of the uses of "empty macro" is to conditionally
include certain portions of a program. In ptrace07, it invokes that useless
macro for compiling pass on non-x86 arch but does not allow execute it.

I don't see why that's crucial for a test, if we wrap around the whole file
and
avoid it compiling on non-x86, isn't this essentially same as that?

The only distinction between them is partly or wholly skipping the key
code compilation. or maybe I completely misunderstood this part.


-- 
Regards,
Li Wang

--0000000000004c578705eb6f46ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Oct 19, 2022 at 5:30 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz" target=3D"_blank">mdoucha@suse.cz</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 18. 1=
0. 22 17:25, Richard Palethorpe via ltp wrote:<br>
&gt; Strictly cpuid.h should not be included on non-x86, but this means<br>
&gt; each test author has to remember not to include it. Instead we can set=
<br>
&gt; a blank macro to allow compilation.<br>
&gt; <br>
&gt; Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@su=
se.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
&gt; ---<br>
<br>
Hi,<br>
defining an empty macro is a bad idea because it&#39;ll allow a broken test=
 <br>
to be compiled and then it&#39;ll behave erratically for no apparent reason=
. <br>
It&#39;s better to get a build failure.<br>
<br>
Reverting 1df4de06206b079f24dde7157d037b48727c743d is the best solution <br=
>
here. Building ptrace07 and similar arch-specific tests without a key <br>
piece of code does not make sense. The preprocessor arch checks should <br>
wrap around the whole file, not just a small non-portable bit that&#39;s <b=
r>
crucial for the test to work.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default">From what I know, one of the uses of &quot;empty macro&=
quot; is to conditionally</div><div class=3D"gmail_default">include certain=
 portions of a program. In ptrace07, it invokes that useless</div><div clas=
s=3D"gmail_default">macro for compiling pass on non-x86 arch but does not a=
llow execute it.</div><div class=3D"gmail_default"><br></div><div class=3D"=
gmail_default">I don&#39;t see why that&#39;s crucial for a test, if we wra=
p around the whole file and</div><div class=3D"gmail_default">avoid it comp=
iling on non-x86, isn&#39;t this essentially same as that?=C2=A0</div><div =
class=3D"gmail_default"><br></div><div class=3D"gmail_default">The only dis=
tinction=C2=A0between them is partly or wholly skipping the key</div><div c=
lass=3D"gmail_default">code compilation. or maybe I completely misunderstoo=
d this part.</div></div><div><br></div></div><div><br></div>-- <br><div dir=
=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></di=
v></div></div>

--0000000000004c578705eb6f46ce--


--===============0140312342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0140312342==--

