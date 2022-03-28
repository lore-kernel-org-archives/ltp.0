Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64378C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 10:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC17A3C9AD9
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 12:25:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F39F43C07BE
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 12:25:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CFAB5600795
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 12:25:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648463104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMJkEGigzMtZuDoEpktjB+HNPuKEnW8jWHnt20KJwKM=;
 b=SF0Bw9AfzqGxgdCXLOptlVJv6mNTzIoeTqR3TuEQk/bNOzJagJtkeUWAp4jQJHJGZyqSRy
 a3EwjEmb3r+rEBL6YcI/URh5+7qNOl91JnVgLpdo+xxt7q+pmPOhX5fupvF4wyWqDPVhQT
 DC64KTq2Cq6BgaDOrydPMH6Ww2KOWDs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-FdJSynczPICTJDflvXulZw-1; Mon, 28 Mar 2022 06:25:02 -0400
X-MC-Unique: FdJSynczPICTJDflvXulZw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2e9ae7bd8deso64435537b3.9
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 03:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KMJkEGigzMtZuDoEpktjB+HNPuKEnW8jWHnt20KJwKM=;
 b=j9tyogkDEZgHFfGy/vYuSRTmgjiEfSWqg7pVJFZGOrYatkDgE18xrZ/MEoip4zO7ZH
 xXW05gfWY5BGKEz/Sy4OCdG1KUwjDu6u7dk5w2uDjG0NinTkIH4OUmZX0tIpTxJMvxJ9
 mmgNwN6eqhhpBhPFXFwa/HMB2PwXFbQacylyxLzsC3CF92+wj8UtUlYOteOeu31XbObU
 klI9894OvznloO/owj6M2KnkqFB84U2cOwIdKj00DJCFBOTRalv4HsYyzPy/qOI2S9yi
 N9/9IdRZ7turE1369MKVe34vmjlIDjB85CpeSvAoptxZuObgK/lrwrbcQFJ23e/P3iGU
 FSDQ==
X-Gm-Message-State: AOAM531j7HNYmMjr9afiyKQP2XasWeHLO9tAtQS1pqHavo53FNzvKaS9
 JZAcYSkMb50LB4dxAYe2bfVL5Ya8oPIWOJ8B6ecPto5XQjKvve9FovN1neQ+POAH9aUVZ/Hm44J
 xsrVH2TQUCkGBwX1Nh0LjBYTHw70=
X-Received: by 2002:a25:18c1:0:b0:633:7a25:5c39 with SMTP id
 184-20020a2518c1000000b006337a255c39mr22571093yby.177.1648463101367; 
 Mon, 28 Mar 2022 03:25:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykmsFtE7HFxoJhQm6dDKrEBwszUM4so64U/lZW1NkUVTOHIec0sSsnrkkdZId/pQPqe8lMmgc+TQ/5T8Pl5go=
X-Received: by 2002:a25:18c1:0:b0:633:7a25:5c39 with SMTP id
 184-20020a2518c1000000b006337a255c39mr22571011yby.177.1648463099788; Mon, 28
 Mar 2022 03:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220325040057.544211-1-liwang@redhat.com> <Yj2V2fu/3Zzio3TZ@yuki>
 <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
 <YkF4pVQXMqEO32r2@yuki>
 <CAEemH2dSkAFF6Mh7m=o9Ejnut9iKT-Ud=Wm10+98-1BT9w+TPA@mail.gmail.com>
 <CAEemH2eSWor_gpVv=vpXCz0+9bt6xK5+2H4zjg66Y=yVPeS1Mg@mail.gmail.com>
In-Reply-To: <CAEemH2eSWor_gpVv=vpXCz0+9bt6xK5+2H4zjg66Y=yVPeS1Mg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Mar 2022 18:24:45 +0800
Message-ID: <CAEemH2e4d1RicxROvxgY79GYnL9kAx88oyBZ03N7s6GuyGFX-A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1080132105=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1080132105==
Content-Type: multipart/alternative; boundary="0000000000007fe4df05db44b987"

--0000000000007fe4df05db44b987
Content-Type: text/plain; charset="UTF-8"

> My concern here is that seems a bit looser to the rest clocks.
> Because "10ms" as delta is a big value to the precise clock since
> the resolution of some is only 1ns.
> (The delta will be "10ms" on x86_64 and "15ms" on aarch64.)
>

delta will be 55ms (not 15ms) on aarch64, this is too big  ^

-- 
Regards,
Li Wang

--0000000000007fe4df05db44b987
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_=
quote"><div><div style=3D"font-size:small"></div><div style=3D"font-size:sm=
all">My concern here is that seems a bit looser to the rest clocks.</div><d=
iv style=3D"font-size:small">Because=C2=A0&quot;10ms&quot; as delta is a bi=
g value=C2=A0to the precise clock since</div><div style=3D"font-size:small"=
>the resolution of some is only 1ns.=C2=A0</div><div style=3D"font-size:sma=
ll">(The delta will be &quot;10ms&quot; on x86_64 and &quot;15ms&quot; on a=
arch64.)</div></div></div></div></blockquote><div><br></div></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">delta will be 55ms (not 15ms)=
 on aarch64, this is too big=C2=A0 ^</div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--0000000000007fe4df05db44b987--


--===============1080132105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1080132105==--

