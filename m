Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C412C43334
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 06:18:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0FC13C9767
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 08:18:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35FFA3C04C3
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 08:18:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFF201000A39
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 08:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657088289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kX3q7nU3GqCmWptrzXf43Vf2BfHzg5OMaOTkhTTH674=;
 b=FRv3j2JyM7IcwCq4ZN51rFWQcKwLfaIUT2FgKoKIpy7dRRZglWTm1hTse5cYtcCKGiGUAL
 r3VvE9NTc8DBiCYQ9y6Y4kIQ0gJZFY0PdR8aNksIIf7bbL1CVUsJjqj0AEEdjPUUdCH3NO
 tQY6LeDrrOja+Fu2GEu1U6CUitrskhQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-nW3gNp6xOfW67-9jl9R9Cg-1; Wed, 06 Jul 2022 02:18:01 -0400
X-MC-Unique: nW3gNp6xOfW67-9jl9R9Cg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-31cd7ade3d6so19870877b3.3
 for <ltp@lists.linux.it>; Tue, 05 Jul 2022 23:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kX3q7nU3GqCmWptrzXf43Vf2BfHzg5OMaOTkhTTH674=;
 b=yV3HzdzFjw2oFO93qzOTrk1MYoEDvfM7rQ4wtUs3pZrADKFIrt/0eED1Zs4XROYmbw
 GynxFrU9Bt8UDs+LltJDA5Uoi8x0bpWhug+OU+Y+Jx3+u8oizffLZxZJ41WnBNZCZN+Q
 HJmOk8C1fXT6bR5xQRrtOApfoDZ/si9S26bvcf9zwbV5gOydf3gCP7B645Gr/C72mBeH
 KkFFg2QQzVW1wSd1XlhqJjDFaEWdUQCf7RTfGJ1+Rn+J2zsdvctuk36MoJRCkIUWHIVD
 vBjva7KFzA/HuIgKp8Z25d/iqPhdk7TPg8hqkJBY4BBVYu7NSMPiQOSRLA9suZAezPW7
 tIGg==
X-Gm-Message-State: AJIora8besEDthw/gjOuL8emXOT3KVmZavt1176fSxu2LFwhuVH+xc7q
 JMZ56vWM3C8y+LdJTDzyz3a/6UO01Afp5rNZaMwpxq+Bq2qibF73a0bbAfc9xrZ/tJaCPgABxeM
 T381rwXpqIUV9N9fRHpQgGIDI190=
X-Received: by 2002:a0d:d654:0:b0:31c:8777:946c with SMTP id
 y81-20020a0dd654000000b0031c8777946cmr20778988ywd.15.1657088280842; 
 Tue, 05 Jul 2022 23:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vz12mYzh9q1nrYeK8oETzh9oNhdvUKRyjMAy4E49f0pXTEWtm+7mtRum5H2UMXagtU3I47ETV58PbXEuHJIHk=
X-Received: by 2002:a0d:d654:0:b0:31c:8777:946c with SMTP id
 y81-20020a0dd654000000b0031c8777946cmr20778979ywd.15.1657088280664; Tue, 05
 Jul 2022 23:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <YnOBiI6OgjhrAjr7@pevik>
In-Reply-To: <YnOBiI6OgjhrAjr7@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 6 Jul 2022 14:17:49 +0800
Message-ID: <CAEemH2fa3fmdTZxzFv0Yx3HG0XxrVrrEuK+XdCY8_CYrX7B2Bw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, 
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 00/19] Expand Cgroup lib and modify controller
 tests
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
Content-Type: multipart/mixed; boundary="===============0534406766=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0534406766==
Content-Type: multipart/alternative; boundary="00000000000054b47c05e31ceee3"

--00000000000054b47c05e31ceee3
Content-Type: text/plain; charset="UTF-8"

Hi Petr, Luke,

On Thu, May 5, 2022 at 3:49 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Luke,
>
> I suppose this patchset supersedes your PR #933, thus I closed it.
>
> FYI If I remember correctly we intended to slowly rewrite all cgroups
> tests from
> shell to C (that's general approach due shell being fragile and less
> reliably,
> in long future shell API may disappear). But to add v2 support in a
> meanwhile
> should be ok. Richard, Li or Cyril are the experts for LTP cgroups tests to
> decide this.
>

Right, but Luke's patchset does really help stabilize current Cgroup shell
tests, I think it's great to have them at this moment. At least it makes use
of the Cgroup C API and that's substantial progress:).

Feel free to add my review after doing rebase in V3:

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--00000000000054b47c05e31ceee3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr, Luke,</div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, May 5, 2022 at 3:49 PM Petr Vorel=
 &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Luke,<br>
<br>
I suppose this patchset supersedes your PR #933, thus I closed it.<br>
<br>
FYI If I remember correctly we intended to slowly rewrite all cgroups tests=
 from<br>
shell to C (that&#39;s general approach due shell being fragile and less re=
liably,<br>
in long future shell API may disappear). But to add v2 support in a meanwhi=
le<br>
should be ok. Richard, Li or Cyril are the experts for LTP cgroups tests to=
<br>
decide this.<br></blockquote><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Right, but Luke&#39;s patchset does really hel=
p stabilize current Cgroup shell</div><div class=3D"gmail_default" style=3D=
"font-size:small">tests, I think it&#39;s great to have them at this moment=
. At least it makes use</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">of the Cgroup C API and that&#39;s substantial=C2=A0progress:).</d=
iv></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-siz=
e:small">Feel free to add my review after doing rebase in V3:</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"ma=
ilto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div></div><div>=C2=A0</d=
iv></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--00000000000054b47c05e31ceee3--


--===============0534406766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0534406766==--

