Return-Path: <SRS0=BYKQ=OV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302A4C433FE
	for <ltp@archiver.kernel.org>; Fri,  1 Oct 2021 17:40:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA241619EC
	for <ltp@archiver.kernel.org>; Fri,  1 Oct 2021 17:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA241619EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34F5A3CA880
	for <ltp@archiver.kernel.org>; Fri,  1 Oct 2021 19:40:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 682183C6D24
 for <ltp@lists.linux.it>; Fri,  1 Oct 2021 19:40:17 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9941C1A007F4
 for <ltp@lists.linux.it>; Fri,  1 Oct 2021 19:40:16 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id v18so36575580edc.11
 for <ltp@lists.linux.it>; Fri, 01 Oct 2021 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=android.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+p+iOXPb80TeDrBIx7IgN7FfgwUufqOtN56eT56HygA=;
 b=LdQIdaa168ncPDWZd1z1/nQUHhkgJ0+Mv+u74YTKQmGsSy+rOypbRxJAfZYQbasOWR
 ewsQARPqJFAGoC9Zv3fpDM+xUx6AehqF7pTZUvDztvje6bHLOOohftx6LXurXPIJHc7K
 2RQexFrq0nvdQ+Kg0ANfr6VOzMIi8hr0yd2SIZkZHNvSItlqhHipEHriD9b/R/gCwlGu
 Jr8k78N0tIQneREQ0VwfKiW2P0UYcbNkWyB53XAjZEc4IkHOdUp4kwgkFhnXNvAhe8BN
 C5/tq2hVYKkBMRkKoKKAF/a/aLELTAIZ2KHHbcoT7ICO1YPd2ch+DBPjifX7yVFuk/j9
 FVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+p+iOXPb80TeDrBIx7IgN7FfgwUufqOtN56eT56HygA=;
 b=CrY+Y9VfqFCRdTU/ExlRmNBI01RBAc/Ul6RnTm9MZ22Yjkvqtwvssa6MAvVU9pjYqx
 SRdZKZaGCdo+KXXlBNnTV525A464JJ7aBvrd9ge3lVGq8m+r05+m/Beehqf1hhW9EbLh
 mGmcfEOUAUM8WAi9UbXF14uGFmusABfETIogwVyQy5X7rGMTLgXM3l+QhmJrATHfmVhX
 EpFmgCRF2430DqA5oC/6gxOM7+WmOFakpq9TN8uButw4YxNoXzUrf3kPxKgF0SBhXjd5
 JFYJOTw+slVdRK1tTtKlRCFk/jj/ONiT/+fptIKAZgsRL1vecCQzuaxPte5+bkRTUxi+
 ZuFA==
X-Gm-Message-State: AOAM532U0V+e7dpE2YKtNMKPu1LhemfeNE7iS0xvLdD4e6tuYTPMmvrP
 wlb8iL8GSRezIQM0LabOIuB07YCn0Mx3Dsgv/gxY1Q==
X-Google-Smtp-Source: ABdhPJwISk9pjNDNPS1jMPtZcouXyouQx6oCgsHh575IcisuVW3uKqj248+Thd0UF0mTC6QGy2TTFXPL8IVf6nPOki8=
X-Received: by 2002:a05:6402:2889:: with SMTP id
 eg9mr16496730edb.384.1633110016016; 
 Fri, 01 Oct 2021 10:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
In-Reply-To: <YVQf9xSxrXjobBM9@pevik>
Date: Fri, 1 Oct 2021 10:40:04 -0700
Message-ID: <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
From: Sandeep Patil via ltp <ltp@lists.linux.it>
Reply-To: Sandeep Patil <sspatil@android.com>
Cc: Steve Muckle <smuckle@google.com>, Sandeep Patil <sspatil@google.com>,
 Martin Doucha <martin.doucha@suse.com>, ltp <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1804289328=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1804289328==
Content-Type: multipart/alternative; boundary="000000000000625ae205cd4e0eac"

--000000000000625ae205cd4e0eac
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 29, 2021 at 1:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> from 20210927 LTP release:
> > * Testcases were fixed not to expect certain users and groups to be
> present on the system
> >   - some tests were expecting bin, daemon and similar groups and users
> to exist on the system
> >   - now LTP depends only on user 'nobody' and group 'nogroup'
>
> At least some tests (e.g. fchmod02.c, chmod07.c) require other groups
> ('users',
> fallback to 'daemon' which is on AOSP):
> ltpgroup = SAFE_GETGRNAM_FALLBACK("users", "daemon");
>
> @Sandeep: is 'nobody' on AOSP or do we still need SAFE_GETGRNAM_FALLBACK()?


AID_NOBODY seems to be part of the AOSP already[1], so I think that might
work.
I dont have a way to test this immediately right now, so adding others who
may be able
to verify in CC.

- ssp

1.
https://cs.android.com/android/platform/superproject/+/master:system/core/libcutils/include/private/android_filesystem_config.h;l=183?q=AID_NOBODY



>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

--000000000000625ae205cd4e0eac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 29, 2021 at 1:12 AM Petr =
Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
from 20210927 LTP release:<br>
&gt; * Testcases were fixed not to expect certain users and groups to be pr=
esent on the system<br>
&gt;=C2=A0 =C2=A0- some tests were expecting bin, daemon and similar groups=
 and users to exist on the system<br>
&gt;=C2=A0 =C2=A0- now LTP depends only on user &#39;nobody&#39; and group =
&#39;nogroup&#39;<br>
<br>
At least some tests (e.g. fchmod02.c, chmod07.c) require other groups (&#39=
;users&#39;,<br>
fallback to &#39;daemon&#39; which is on AOSP):<br>
ltpgroup =3D SAFE_GETGRNAM_FALLBACK(&quot;users&quot;, &quot;daemon&quot;);=
<br>
<br>
@Sandeep: is &#39;nobody&#39; on AOSP or do we still need SAFE_GETGRNAM_FAL=
LBACK()?</blockquote><div><br></div><div>AID_NOBODY seems to be part of the=
 AOSP already[1], so I think that might work.</div><div>I dont have a way t=
o test this immediately right now, so adding others who may be able</div><d=
iv>to verify in CC.</div><div><br></div><div>- ssp</div><div><br></div><div=
>1.=C2=A0<a href=3D"https://cs.android.com/android/platform/superproject/+/=
master:system/core/libcutils/include/private/android_filesystem_config.h;l=
=3D183?q=3DAID_NOBODY">https://cs.android.com/android/platform/superproject=
/+/master:system/core/libcutils/include/private/android_filesystem_config.h=
;l=3D183?q=3DAID_NOBODY</a></div><div><br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Kind regards,<br>
Petr<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
</blockquote></div></div>

--000000000000625ae205cd4e0eac--

--===============1804289328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1804289328==--
