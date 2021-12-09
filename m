Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D107C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 21:43:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF5003C7FC9
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 22:42:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7CB33C1D8F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 22:42:49 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B48660077B
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 22:42:47 +0100 (CET)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 604813F1A9
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 21:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1639086163;
 bh=BvtnihgqjjSzOENC5j/ve8VxndS2YIvaCfJhyJBFNqU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=IpXOSqg6k7fU51/XkdT9XhmsX8qUaCAuFI3zRMX/dm8MzX1EPk9Md4IZCGt8ZSxQh
 zr53mEJgqfxqPDsxu+L5zlq6rMlhPKkLJy2qIZkxKR60pKy0JLlPcRFA2yU31AzDet
 5yTkU1Yeq9e+bjOJohjLGrlyY3Fej3RGUPQ8bbPO2tU5HZY+nYKC2dOzmrgAIpa+jq
 WfnncjgtMisddPp/kwN3UCitMuQUyez8siglU3H+0zxFQzri/y1Y2ymLwHyHY+4ECc
 4xFhchBYEbdnNuh4oG+sYTfXItnsBEGNx9FiDu129ZUxaMoevNf+B5u94urL3pCkTQ
 YypdpB6HhyiwA==
Received: by mail-ed1-f72.google.com with SMTP id
 b15-20020aa7c6cf000000b003e7cf0f73daso6391020eds.22
 for <ltp@lists.linux.it>; Thu, 09 Dec 2021 13:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BvtnihgqjjSzOENC5j/ve8VxndS2YIvaCfJhyJBFNqU=;
 b=ARiZCd8H89At3HIzK+td+pm+vqLD3Ku+1X1xtstlTVvYBzGSpUd9+AbG05CY6QGyPM
 2m4C2BW2CmeoS7TJMz+Nz11V1OfPUGxq9tMilX8aYD9jSqLsrhiawJUGxcr+S9EjpNoK
 MUbqjSfhXbM0ttUArUIuDm1td69YKax8QSfG5SuowfoU0QbqO6y5XjRs+m7lisPzItHj
 Pzq3Edrkj+wE4JQL/4M4vdTmT73s1Wu50ln02Gsa/qc3QFbFvNpVcBtSvzCixPe2k/Fx
 vwTTaIDEw5C49/KtW0U1FeET7LQ95y8GX7LZtVMrCj89uMTleQDNZhBW3oolvyxGUJlQ
 RoEg==
X-Gm-Message-State: AOAM530pH9ZuFzT8FWIc6JY4Qa9612E2FHJqxT3gpZqR5jvX5nWNAksz
 kkE+pwt4KEyPUqB0DH8WlkYK2aRQKCQqFXP1ZJPN0tmX3Mqs/gICnSthUHgh5ubRCMjDR/5ub5h
 uF9aBDpC1EjIff5VjLgOqO3S7yih9yw7WdLrfkwge4nm8
X-Received: by 2002:a17:906:dff1:: with SMTP id
 lc17mr18324236ejc.215.1639086162699; 
 Thu, 09 Dec 2021 13:42:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgrQD1wTlgAUZ9X/5wCGm4D9Qai8NdapW6aRIFgNKy9aOX9ULvot3k0ZWoU6Uu75FLkZslQFrcqXkOuBQw04M=
X-Received: by 2002:a17:906:dff1:: with SMTP id
 lc17mr18324217ejc.215.1639086162446; 
 Thu, 09 Dec 2021 13:42:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
 <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
 <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
 <CADS1e3dkYtRibN7ADGh_c9T5uZ4BFTpjgPaXH1+xfBUS8xpKcA@mail.gmail.com>
 <87ilw2ccgv.fsf@suse.de>
In-Reply-To: <87ilw2ccgv.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Thu, 9 Dec 2021 13:42:06 -0800
Message-ID: <CADS1e3dEh6YAnWmhizVpkuN_EAqwDOeeVnfT_C23mzN2LS-2XA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] controllers/memcg: update stress test to work
 under cgroup2
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
Content-Type: multipart/mixed; boundary="===============0019392027=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0019392027==
Content-Type: multipart/alternative; boundary="00000000000078297d05d2bd7cde"

--00000000000078297d05d2bd7cde
Content-Type: text/plain; charset="UTF-8"

Hi Richard and Li,

On Mon, Dec 6, 2021 at 1:24 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> I suppose we also need to remember if the current test created the ltp
> subdirectory or mounted any controllers.
>
>
We could do this by just printing the required command line options to
> stdout when the utility exits. Then save this to a variable for the next
> use.
>
>

Yes, we would have to remember what we mounted. I think the part I am most
curious about is how we would generate that state i.e what we mounted,
because the Cgroup library does not expose any of this as far as I'm aware.

If we want to use the tst_cgroup C lib to cleanup as well we would have to
find a way to reintroduce test state to the lib that we are losing between
calls of the utility, which the only way I could think of is introducing a
way to export and import test state within the lib. e.g.
tst_cgroup_print_test_state() tst_cgroup_load_test_state(), which doesn't
feel good as it exposes some of the nice API you have going on. This is the
easiest way to tell if we are mounting things because we can just print
what we mounted, what the test dir of the test is, and reload that state.
This could have further applications to not just this scenario but also to
scenarios where if a test dies its state can be reloaded, etc, almost in a
checkpoint way. Not saying its common but adds some flexibility to the API
and I could see it having applications outside of this utility.

Alternatively we could inspect what we created and generate state that way,
i.e. make a call to tst_cgroup_require() and see if new things were
mounted. Then we would have to manually be freeing things. I don't like
this approach because it goes against the whole point of this which was
code reuse. But the cleanup of things isnt the most difficult part so it
wouldn't be the biggest deal to redo the logic.

Yes, sounds good.
>
>
Let me know what you think. I wouldn't want to add anything huge to the API
without your blessing :)

> --
> Thank you,
> Richard.
>

Thanks,
- Luke

--00000000000078297d05d2bd7cde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard and Li,<br></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 6, 2021 at 1:24 AM =
Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_bl=
ank">rpalethorpe@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
I suppose we also need to remember if the current test created the ltp<br>
subdirectory or mounted any controllers.<br>=C2=A0 <br></blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
We could do this by just printing the required command line options to<br>
stdout when the utility exits. Then save this to a variable for the next<br=
>
use.<br>
<br></blockquote><div><br></div><div>=C2=A0</div><div>Yes, we would have to=
 remember what we mounted. I think the part I am most curious about is how =
we would generate that state i.e what we mounted, because the Cgroup librar=
y does not expose any of this as far as I&#39;m aware.<br></div><div><br></=
div><div> If we want to use the=20
tst_cgroup C lib to cleanup as well we would have to find a way to=20
reintroduce test state to the lib that we are losing between calls of=20
the utility, which the only way I could think of is=20
introducing a way to export and import test state within the lib. e.g.=20
tst_cgroup_print_test_state() tst_cgroup_load_test_state(), which=20
doesn&#39;t feel good as it exposes some of the nice API you have going on.=
 This is the easiest way to tell if we are mounting things because we can j=
ust print what we mounted, what the test dir of the test is, and reload tha=
t state. This could have further applications to not just this scenario but=
 also to scenarios where if a test dies its state can be reloaded, etc, alm=
ost in a checkpoint way. Not saying its common but adds some flexibility to=
 the API and I could see it having applications outside of this utility. <b=
r></div><div><br></div><div>Alternatively we could inspect what we created =
and generate state that way, i.e. make a call to tst_cgroup_require() and s=
ee if new things were mounted. Then we would have to manually be freeing th=
ings. I don&#39;t like this approach because it goes against the whole poin=
t of this which was code reuse. But the cleanup of things isnt the most dif=
ficult part so it wouldn&#39;t be the biggest deal to redo the logic.<br></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Yes, sounds good.<br>
<br></blockquote><div>=C2=A0</div><div>Let me know what you think. I wouldn=
&#39;t want to add anything huge to the API without your blessing :) <br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
Thank you,<br>
Richard.<br></blockquote><div><br></div><div>Thanks, <br></div><div>- Luke<=
br></div></div></div>

--00000000000078297d05d2bd7cde--

--===============0019392027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0019392027==--
