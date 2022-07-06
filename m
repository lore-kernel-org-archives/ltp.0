Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D1CC43334
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 06:25:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B46D93CA0DB
	for <ltp@archiver.kernel.org>; Wed,  6 Jul 2022 08:25:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 355183C8BCB
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 08:25:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 88C821A00CA4
 for <ltp@lists.linux.it>; Wed,  6 Jul 2022 08:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657088742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SactpO3fo3Z89hJP5p5hNpmLNBa89BtoY0ywmJl2aMA=;
 b=dUiVu7hf8Y7q7LNPQ13tD0sYTq6U9Ri5iR9gQz/HihmmqjYJu8H49N9NuwmNrbM01C1pSy
 /9ekcFwwJmvl2Dbki3JeC/IRyLiWNjPc8E/hLVP9Wc3NjdmYNLAqNmgLXujtYPPMaUu4gL
 fyXwZSLIXYvOCqnlFOinUHD8l0RpJP8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-0Q1UsVv7Ptms0cYp4qx7WA-1; Wed, 06 Jul 2022 02:25:35 -0400
X-MC-Unique: 0Q1UsVv7Ptms0cYp4qx7WA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-31c89c753b3so57706957b3.5
 for <ltp@lists.linux.it>; Tue, 05 Jul 2022 23:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SactpO3fo3Z89hJP5p5hNpmLNBa89BtoY0ywmJl2aMA=;
 b=z4t2MOc6pLH2tnJnmtnEJ3/xDnHsWtOzuusj7IL3Oj3gXEaZ/gGLGYV8QUr+wT9Xnb
 DEQDQPhYXdbm4yXJSQDeOKjl5CZNmxCEwZ1Hmo7A//UVzfuiYdFwgKA1OMxDy7e3Q9xt
 5IZUjLRSBKEgVrA0qWT9Tt/xrU+dpRZY42O/Z7NKhgFV92b+eyrY9p9auKjfgPpPGS9B
 PRgYWjoVk7QNgW69pvB2QnpMMl2/nFoNvfLPkICjnbwkqZ2M3O/wiKxpH9Go/oBJiEFA
 Trnu4JEpXi38cAlMIY+Mb3fvcY+R8u0NBKvEXhMWM51lqF0K+m+urZG1L5UMVvtDCjJF
 p3EQ==
X-Gm-Message-State: AJIora/XGbi/3WpvwzFJqM1KppujfKdcxtkw5b0IVuZ+EtJRyQAavo4c
 3KgjXUSyedcs1oYl8QtjG5507gklg4qy0neQOPmJCrHI3O0FH+sARVg4SaFir5iOu4Qa7myTXNf
 qDu0EecKj6iyJbfhLiMpkyDUGZ98=
X-Received: by 2002:a81:4987:0:b0:31c:89bd:dfc5 with SMTP id
 w129-20020a814987000000b0031c89bddfc5mr21407774ywa.53.1657088734599; 
 Tue, 05 Jul 2022 23:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uMagI4TGjLPYrnv8GepST7rvTLo2en44zi91TKeNl/qTQXhEUmTzETD1ehi5mpV8CPHjA0/daSb4m0lGhZM5k=
X-Received: by 2002:a81:4987:0:b0:31c:89bd:dfc5 with SMTP id
 w129-20020a814987000000b0031c89bddfc5mr21407759ywa.53.1657088734441; Tue, 05
 Jul 2022 23:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <YnOBiI6OgjhrAjr7@pevik>
 <CAEemH2fa3fmdTZxzFv0Yx3HG0XxrVrrEuK+XdCY8_CYrX7B2Bw@mail.gmail.com>
In-Reply-To: <CAEemH2fa3fmdTZxzFv0Yx3HG0XxrVrrEuK+XdCY8_CYrX7B2Bw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 6 Jul 2022 14:25:23 +0800
Message-ID: <CAEemH2fVc28ahv1aU+hwqsww8i3QJb_PF+K=tCOncbbSpx=zTg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, 
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0695612519=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0695612519==
Content-Type: multipart/alternative; boundary="00000000000060cbb805e31d0990"

--00000000000060cbb805e31d0990
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 6, 2022 at 2:17 PM Li Wang <liwang@redhat.com> wrote:

> Hi Petr, Luke,
>
> On Thu, May 5, 2022 at 3:49 PM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Hi Luke,
>>
>> I suppose this patchset supersedes your PR #933, thus I closed it.
>>
>> FYI If I remember correctly we intended to slowly rewrite all cgroups
>> tests from
>> shell to C (that's general approach due shell being fragile and less
>> reliably,
>> in long future shell API may disappear). But to add v2 support in a
>> meanwhile
>> should be ok. Richard, Li or Cyril are the experts for LTP cgroups tests
>> to
>> decide this.
>>
>
> Right, but Luke's patchset does really help stabilize current Cgroup shell
> tests, I think it's great to have them at this moment. At least it makes
> use
> of the Cgroup C API and that's substantial progress:).
>
> Feel free to add my review after doing rebase in V3:
>

Correction: sorry, the newer patchset should be V5, I misread the patch
version in numbers.

>
> Reviewed-by: Li Wang <liwang@redhat.com>
>
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

--00000000000060cbb805e31d0990
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Jul 6, 2022 at 2:17 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small">Hi Petr, Luke,</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 5, 202=
2 at 3:49 PM Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_bl=
ank">pvorel@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi Luke,<br>
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
decide this.<br></blockquote><div><br></div><div><div style=3D"font-size:sm=
all">Right, but Luke&#39;s patchset does really help stabilize current Cgro=
up shell</div><div style=3D"font-size:small">tests, I think it&#39;s great =
to have them at this moment. At least it makes use</div><div style=3D"font-=
size:small">of the Cgroup C API and that&#39;s substantial=C2=A0progress:).=
</div></div><div><br></div><div><div style=3D"font-size:small">Feel free to=
 add my review after doing rebase in V3:</div></div></div></div></blockquot=
e><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">Cor=
rection: sorry, the=C2=A0newer patchset should be V5, I misread the patch v=
ersion in numbers.</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
"><div class=3D"gmail_quote"><div><div style=3D"font-size:small"><br></div>=
<div style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:l=
iwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</div></div><d=
iv>=C2=A0</div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr=
"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000060cbb805e31d0990--


--===============0695612519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0695612519==--

