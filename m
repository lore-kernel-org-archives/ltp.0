Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B57ECAA25
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 17:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FDF33CA417
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 19:39:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C00883C1351
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 19:39:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BBD13140034E
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 19:39:40 +0200 (CEST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 466193FB9E
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1661449179;
 bh=R4C6oZbj4fRSjMdKk0fOLHv+Kf6WkjfsLDKwll+45BM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=gZz9ZLPjemSQZS+kREjVcvTfQD4ezmuG2n5NgHSdICmfCx1Y7Tt6lC8akDuPHJbbj
 zLmbQplolQJCZwOk3JMyHBrrAMZwTeE4UX4JvUHxAnFzIZ4yQa+ohRtK/4/8kIErsF
 OJRi9u79f3ng2Kb5yOBz/1nqrG/kJbHfI35stk1b1OzTqhVHsb8QUR3kQ6ATojaU18
 rLiQ08DkLUNk/ICdfZN62rko0C3CPfYDNBuPGP+1B5GFHgIDV7V1rU3LlcQv30LtHV
 ltV+t2T8Op0x3yLHdRsLfaJ28Ju7eVrhkT2neCKm6AcX682eBL///1dM9IsQGCAH5H
 t4LL6VislskWQ==
Received: by mail-ed1-f72.google.com with SMTP id
 z20-20020a05640235d400b0043e1e74a495so13346696edc.11
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 10:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=R4C6oZbj4fRSjMdKk0fOLHv+Kf6WkjfsLDKwll+45BM=;
 b=DYjqB243I+XXusTaA8z41muFLEuvUbf2gm5CIEHm89gMjmi3LkskkmJgqBDrw5n52l
 K9qjBSlyp8Jv1BRWHROAoVjJjqRT6rbQptc0OO/GNjrAE+PoFirKIj3k9xKYlVkaHqia
 RGA/WpvCFE0T++LvyS+4rPItkR/ABDseW+oohelaEMdzrzw6l1a5yuvlEygHY/bdy9EJ
 dQBIFka2ajXOr8trjI2ETYkEND7Q4B/YB2iFcRs0dOLbBR/gIaHILTSGNKBfAtZRN360
 lmV9md4Qr4fazPViBApfOjBOWFTQw2ymRQlyWCtRxFEW41OC9zMXNs/3+JCUCfKqfWhl
 Hmaw==
X-Gm-Message-State: ACgBeo2eRh7zJkv6iQhI0tnmygCXKDXwYW5Ys6zcKqeiLpQCwLAJYW5F
 XjnSlseWI+IelCNlDmMEQsroDkgXsS8J6Gj7s2Z0X+VSYfAJFeFaScGOltaDypgzKo1aJGWm/WX
 DlpE/jcdXzj+MEnZUorfufEhiBTomTnL6kPnOQKhG8+/z
X-Received: by 2002:a05:6402:19:b0:447:901f:6b28 with SMTP id
 d25-20020a056402001900b00447901f6b28mr3943061edu.392.1661449179007; 
 Thu, 25 Aug 2022 10:39:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7zaJwTgwjzQrdHA8GbFTssT5lX6mPyuUftMaHAIqsqgLvAJDNGm5+ItYzAYEcj6FteXyvL/y0kZnPbW7P8sVQ=
X-Received: by 2002:a05:6402:19:b0:447:901f:6b28 with SMTP id
 d25-20020a056402001900b00447901f6b28mr3943052edu.392.1661449178809; Thu, 25
 Aug 2022 10:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220824215421.90947-1-luke.nowakowskikrijger@canonical.com>
 <YwdWKb/Imzwk5F1V@pevik> <87wnaw1ebh.fsf@suse.de>
In-Reply-To: <87wnaw1ebh.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Thu, 25 Aug 2022 10:39:02 -0700
Message-ID: <CADS1e3dmMMsBQggVPBKHdYRwV0pw6277HmBPoHpkL3=b5AN5MQ@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] API/cgroup: Add rdma controller
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
Content-Type: multipart/mixed; boundary="===============1931952255=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1931952255==
Content-Type: multipart/alternative; boundary="0000000000001da23405e71448d9"

--0000000000001da23405e71448d9
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Aug 25, 2022 at 9:24 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hi,
>
> Petr Vorel <pvorel@suse.cz> writes:
>
> > Hi Luke,
> >
> >> There is a test reporting "TBROK: 'rdma' controller is unknown
> >> to LTP" so lets add the controller.
> >
> > Out of curiosity: which test?
> >
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >
> > Kind regards,
> > Petr
>
> I'm not sure, I think it was one of the shell tests which tries to mount
> all the controllers. Anyway, merged thanks!
>
>
It looks like cgroup/cgroup_regression_test.sh test 7 was the failing test.
Li ran into this earlier too I think.

Thanks for merging :)

Thanks,
- Luke

-- 
> Thank you,
> Richard.
>

--0000000000001da23405e71448d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, <br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Aug 25, 2022 at 9:24 AM Richard Palet=
horpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@s=
use.cz</a>&gt; writes:<br>
<br>
&gt; Hi Luke,<br>
&gt;<br>
&gt;&gt; There is a test reporting &quot;TBROK: &#39;rdma&#39; controller i=
s unknown<br>
&gt;&gt; to LTP&quot; so lets add the controller.<br>
&gt;<br>
&gt; Out of curiosity: which test?<br>
&gt;<br>
&gt; Reviewed-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=
=3D"_blank">pvorel@suse.cz</a>&gt;<br>
&gt;<br>
&gt; Kind regards,<br>
&gt; Petr<br>
<br>
I&#39;m not sure, I think it was one of the shell tests which tries to moun=
t<br>
all the controllers. Anyway, merged thanks!<br>
<br></blockquote><div><br></div><div>It looks like cgroup/cgroup_regression=
_test.sh test 7 was the failing test. Li ran into this earlier too I think.=
</div><div><br></div><div>Thanks for merging :) <br></div><div><br></div><d=
iv>Thanks, <br></div><div>- Luke <br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
-- <br>
Thank you,<br>
Richard.<br>
</blockquote></div></div>

--0000000000001da23405e71448d9--

--===============1931952255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1931952255==--
