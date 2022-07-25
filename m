Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348D0C43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 20:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7995F3C9725
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 22:26:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2A613C0727
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 22:26:20 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2381D6009D1
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 22:26:19 +0200 (CEST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1610B3F134
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658780779;
 bh=ASa3zkGCXEEm05g9X5WVCos8BE6N1Yf9Y0/4FqNhsdM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=onUSIomwW2BzMNmERz7/4L8nzXMIlNXIUWLkl1iegvMhnqRH007F5F7x3rAygfkEZ
 TIPXtICg7ju8IG/hJajXVV/RVphmCB0uBdiw97b10hDioPaL1n+WyNHT/5Zoh8KEAJ
 D2HAVpW1HYup137RQ1Mf2XPsHhFzgdVwNNf62KUcHSK1VRuWnYNRnIFKpZOgPuFHLz
 EVFZxRRnYwi47yqrLgQ4SlON0i0GCafpkR2VvpuXRbTnjdVhqcj/oTWIE1z7GJBfmN
 fXNlNpsXb1S5r6WG2xYMgiYHgSEKQnJRTV3r/NdLunaalcFLCeHpoN67sFUgfw+y7Y
 xhb/Mp+VcoXwA==
Received: by mail-ed1-f70.google.com with SMTP id
 g15-20020a056402424f00b0043bff7a68dbso2273253edb.10
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 13:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=ASa3zkGCXEEm05g9X5WVCos8BE6N1Yf9Y0/4FqNhsdM=;
 b=7gSeACmQGEfi/dY88Cqv+cxCs79Z4/RG0Uzc+YwxXo1DZEpOMSCbsbqR6a2StW0LKn
 SF35g5ceI6n/eYN2TehfZmpFXNWsY5n5U4Y5vdd8LqUSvxWDDQP9x/mRoFAIxY4NLAg+
 Tr9LHstvuTxRv2neMIA+sINtAQDSTjqSwolvIO+HwiZrF0liQQ6idXxlKkqpHxZW2qjJ
 e9NEk6wilNyk5K5X1DKXKD8ELO9apM4HEC6hAqdrd44PRkZ+mS806yC7ExdibGcDVEYl
 yw++PH67HzhZMYhuo5q3c9uniBlHdvWhTQTIyIr+ckrb5Ge3GqZyzzCw6bvgb3rGFCI/
 hJaQ==
X-Gm-Message-State: AJIora85UQIXfvM296nvHKiKRXwDUoHPQ3QmU1MHBOB7TismKWKd1WGm
 DpDHIeEv9E74L0/Y2wZGn5d8ivMy79Ap4lpELphW1Xb8dCE1MHtwEGk1R081WmjEu3+cZsS+R8L
 nwPzvNk7aqLCEemNJdBFeGVgiDEUp+QYB3xfhkLkyOdKV
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id
 22-20020a170906021600b00711f6238bb0mr11625848ejd.174.1658780778735; 
 Mon, 25 Jul 2022 13:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1spnkQ6BfR39VjhowacHXdtSqABJ+fnKZr0o5a7by5+C6eI3tYVrV6gV/cEPgqDqGOoFNOXdbPvvbJCzhdbISM=
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id
 22-20020a170906021600b00711f6238bb0mr11625834ejd.174.1658780778435; Mon, 25
 Jul 2022 13:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <Yt5Q/+Qmm+SVJLnA@pevik>
In-Reply-To: <Yt5Q/+Qmm+SVJLnA@pevik>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 25 Jul 2022 13:25:42 -0700
Message-ID: <CADS1e3eKZSWBGm1H5h+8R6=1QTXV1Crb4D59pRi2hgEuw65maw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 00/18] Expand Cgroup lib and modify controller
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
Content-Type: multipart/mixed; boundary="===============1329606182=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1329606182==
Content-Type: multipart/alternative; boundary="0000000000000f30af05e4a6ff99"

--0000000000000f30af05e4a6ff99
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Mon, Jul 25, 2022 at 1:15 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Luke,
>
> could you please next time use the same version number for all patches?
> Having different versions (patches have v2, v3, v5) is quite confusing.
>
> Kind regards,
> Petr
>

Yeah I agree..

It was supposed to make it easier to not have to re review stuff when the
version hasn't changed, but it gets quite confusing.
I'll use the same version number next time.

- Luke

--0000000000000f30af05e4a6ff99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>Hi Petr, <br></div><div><b=
r></div><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Mon, Jul 25, 2022 at 1:15 AM Petr Vorel &lt;<a href=3D"mailto:pvorel@=
suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Hi Luke,<br>
<br>
could you please next time use the same version number for all patches?<br>
Having different versions (patches have v2, v3, v5) is quite confusing.<br>
<br>
Kind regards,<br>
Petr<br></blockquote><div><br></div><div>Yeah I agree.. <br></div><div><br>=
</div><div>It was supposed to make it easier to not have to re review stuff=
 when the version hasn&#39;t changed, but it gets quite confusing. <br></di=
v><div>I&#39;ll use the same version number next time.=C2=A0 <br></div><div=
><br></div><div>- Luke<br></div></div></div></div>

--0000000000000f30af05e4a6ff99--

--===============1329606182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1329606182==--
