Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D19C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:08:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CED403CABB5
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:08:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37B343C952D
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:08:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B162B200C13
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663056485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtGOBHEpdHRWry+ivjl9/Bb8EhGe/GXlVmIaJR4RhcI=;
 b=Z61rSEUoVJNCI24zk7VYPusdtmBymL5Y/IiuBdG9Vfl9KOlyevOOLxcVrQw+VgJZK3NwhR
 4+DN2LkZiHIm1I9tZOcf/DzYvAAKq+vmbhzb/qiU9Bbh2UqVUm3PS5OnLMXqDCif25BlEG
 /QR3vFwOAK4MllkB3BHxqmvtGSfoUyg=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-NwmSbR49NxWpYik4ixCvGA-1; Tue, 13 Sep 2022 04:08:01 -0400
X-MC-Unique: NwmSbR49NxWpYik4ixCvGA-1
Received: by mail-vs1-f69.google.com with SMTP id
 188-20020a6707c5000000b00390645f5b40so1080696vsh.6
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 01:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=GtGOBHEpdHRWry+ivjl9/Bb8EhGe/GXlVmIaJR4RhcI=;
 b=kC5fArn9QO7kXWwYl/izDMcq5cQTxg7wJ8NxWo6l/xXxIrvm59wSyR4DTnTQANso3B
 o5GWMPxCLbw6hThWu0/sUgyPG/c42COEtIsfmd8aTp/y/dxATChL9OU5hCZyYZqwedTE
 nIUciwq2aYp15AVA1C8/5HH6gDCNXnFfvxypr7bsAUvKIEyK3Le75NF5//DMbGMSHqUu
 +nHHqUVtuAKf8zq55b6ETzYg8QY3teFE4cIf8/qC+pu5NTtKOFhFszH51QA4D8ZB0O5i
 KsOvhJ65/nrU7fKxhg3zc3J/ZhQOCQ6CRBsY+7h7EyViOXM313mE6r0DPQwMImkqCFZ9
 vfQg==
X-Gm-Message-State: ACgBeo2ho1NdOiRHVcguiY8fAuBmlnFpc069IC4twhi9e7oPOON2MsE/
 O5QPgpeED2kuXiYaCu7GZ8G0AU3MvzvKu8HF+hee5atSw3g4fG5hpeJcznWCXNhJj/LY3qIHqq8
 9sRenRN+TTQ/b/WLlhX4Ww06Ou38=
X-Received: by 2002:ac5:cdd9:0:b0:39e:8fbf:dad4 with SMTP id
 u25-20020ac5cdd9000000b0039e8fbfdad4mr9967131vkn.0.1663056481051; 
 Tue, 13 Sep 2022 01:08:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5V6KitjiFJGd+5Z6SpYhQbMlkAixiVfnQSSVJj8vVs5o19vyOtMMHTRoAaNlVe6PRhcakjdffHRR7h+Hx6U1Y=
X-Received: by 2002:ac5:cdd9:0:b0:39e:8fbf:dad4 with SMTP id
 u25-20020ac5cdd9000000b0039e8fbfdad4mr9967126vkn.0.1663056480886; Tue, 13 Sep
 2022 01:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220913062103.3910-1-pvorel@suse.cz>
 <20220913062103.3910-4-pvorel@suse.cz>
In-Reply-To: <20220913062103.3910-4-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Sep 2022 16:07:49 +0800
Message-ID: <CAEemH2fC+Ld9uLdBR=_wUyciqoY29=GFKL4DQWpGhm8xp+pqUA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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
Content-Type: multipart/mixed; boundary="===============1166283176=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1166283176==
Content-Type: multipart/alternative; boundary="000000000000c8f98a05e88a82a6"

--000000000000c8f98a05e88a82a6
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

The TST_EXP_FD_ERRNO in the subject should be corrected as well.
Otherwise, patch set LGTM.


-- 
Regards,
Li Wang

--000000000000c8f98a05e88a82a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Th=
e=C2=A0TST_EXP_FD_ERRNO in the subject should be corrected as well.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">Otherwise, patch set L=
GTM.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div>=
</div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,=
<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c8f98a05e88a82a6--


--===============1166283176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1166283176==--

