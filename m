Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB384C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:50:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C4C73C9528
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:49:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 637943C075E
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:49:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 919AF600B73
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655974186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUjzvIiyQkJDa7wt3TbisV8aJ6L9B2z1cTg8NeyqJFI=;
 b=Yy3YW70W4KCfstOQvlJzf3vgOcNYO1jJu5KwbbSoqna2NmklBI6spG67Kzcf8aS1hlM98s
 tZOinhIVphKFoW43v0ft5/yAeV8H6GD7tC6HDp9QUf14lZiiA96p+UlYYbNrwmHvLAgxBk
 ZOpLSGAlG6dtC8GR22c2uYa/0I407qg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-rW840OJrNJKtaIFZokfKCg-1; Thu, 23 Jun 2022 04:49:44 -0400
X-MC-Unique: rW840OJrNJKtaIFZokfKCg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2fed274f3fbso164281447b3.17
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 01:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OUjzvIiyQkJDa7wt3TbisV8aJ6L9B2z1cTg8NeyqJFI=;
 b=5Mc4cZSMkJZSh8Dp4nkF+CqFa+saHaQbSIkDGU3yhBqI5jK+vepcZgBBKAejR8lNDH
 s9GEEJFg56NHBRQFlAMXSQFfGkiWXA5Ao/pe/S2ROfbX+Dw3YzwrjQJh4orx7Ne2Koz1
 v8MzJKTBz58JPDtomcM6IzV1MDONDhiVCk9X1oPJQiqYol+3rgzyTjZ0oxykiYythTF0
 sP/ezlS4Z6/e4XLoMXRQXnCEtKnZzmWHqQi1zfD/2qDTgaAUkEZ7XmfkapiuSrKTCkdI
 WrbNOh3Qt1OnMWoSqBMPfI6Rqk2HUHKpmgg25ijDDEuT3uksj5gkCrCVvQ2LYY7VFC+e
 GbfA==
X-Gm-Message-State: AJIora/NoCcOUIsySbtRn1Mq9YmmkSU1wv7oEIMGqFvCcNi/YqLVD1l9
 T1Zx8SEi/H8ROreUjktS6sPwaf0HlQsnOaeLE9MyDdl9y/AXitUpqHnGHrZGUI5fcVcS1YGKg5B
 Eo7FaOUtf2SC70/PU4vAqHQ/Yz3U=
X-Received: by 2002:a5b:88e:0:b0:668:f134:f743 with SMTP id
 e14-20020a5b088e000000b00668f134f743mr8302914ybq.301.1655974184012; 
 Thu, 23 Jun 2022 01:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vKyLXNDxJra4NnjKQ2soi4q1hRT1yBOjRRQYpFnJtmnFMCKnlV5in/DS5uGXvEIK8W2hhspbG6MX2saNgQIjc=
X-Received: by 2002:a5b:88e:0:b0:668:f134:f743 with SMTP id
 e14-20020a5b088e000000b00668f134f743mr8302902ybq.301.1655974183796; Thu, 23
 Jun 2022 01:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220620092146.7604-1-chrubis@suse.cz>
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Jun 2022 16:49:32 +0800
Message-ID: <CAEemH2eEvbaYyMrqSHxCLPPPuZGAuX8Fot7YvFzCp94GyhzC1w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/7] openposix: Fix 'no return in nonvoid
 function' warnings
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
Content-Type: multipart/mixed; boundary="===============1703559835=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1703559835==
Content-Type: multipart/alternative; boundary="000000000000fb955b05e21988d2"

--000000000000fb955b05e21988d2
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,

Generally looks good, thanks for the fix and cleanup.
Tests work well from my side.

For the series:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000fb955b05e21988d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Cyril,</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">G=
enerally looks good, thanks for the fix and cleanup.</div><div class=3D"gma=
il_default" style=3D"font-size:small">Tests work well from my side.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">For the series:</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a h=
ref=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div></div><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><=
/div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div =
dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000fb955b05e21988d2--


--===============1703559835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1703559835==--

