Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AA8C433EF
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 01:35:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE1623C1B93
	for <ltp@archiver.kernel.org>; Fri, 27 May 2022 03:35:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27013C051B
 for <ltp@lists.linux.it>; Fri, 27 May 2022 03:35:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 904E21000763
 for <ltp@lists.linux.it>; Fri, 27 May 2022 03:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653615329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQhEgvwaj5nyB9hVq8J96zC830xICD0/MAr65+ov+iY=;
 b=AbrJlZR/UHkwnWjXpy1sLz68hnyqMUKhTWL57DYOSGQwXaExmysMoIyqolNRq0Bw6VfbBR
 ++F9Et22S5rykWY0GM5Bj6rxkubZj0TslDHrEGiAsSGTZCzH5JejscBUMorpCAF5iAYOKB
 pJi1x/VZyBsYkon0qycX0NFZTQN/FIc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-SQ48RI7XNRSRLF3jZCLS3Q-1; Thu, 26 May 2022 21:35:26 -0400
X-MC-Unique: SQ48RI7XNRSRLF3jZCLS3Q-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2f7dbceab08so27403087b3.10
 for <ltp@lists.linux.it>; Thu, 26 May 2022 18:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eQhEgvwaj5nyB9hVq8J96zC830xICD0/MAr65+ov+iY=;
 b=43YfWkHk08dD2+k0VYTTJ7tApM6btQm6eLxNw2c6sjCLtHSyeb3OC6+TDASS/pRF8K
 H1MV+0zdsJN/S/oA+JGn6aNRhkLh6syN5Zn48BjS1GbuDyNvF6CrvMBCWjq6M75rq3Ay
 Cw+AnirQMVjUpGJ1ArmLSsneVKkjhfUkGnt+wD252EB/CYGiiHQEACexU3JLoxhBbQyO
 nFU82eHg1aVnp2gUwyOmOn1GeN+TyyskeNvaOCTh5RDBGr+ulKSwJl4aiESTm8P22nxY
 5o1aFcNEP4/fkr5sxQPpx3IOsYgmZlhWPTXmX9zA/yyVO4nT1+CAejvw20UfuWIAdZRo
 gSwQ==
X-Gm-Message-State: AOAM531jnCeUFElioIzQkcxKPl9d7kmfXSY4oTSC7msAAmvVjWcdyrGG
 hVMsl2WfAdf74gNKSotm5OWDxSf2h6YShyW/bToxVeXEiURN6Bc0AXHZdXJ3oZ3kMThN7hyP7oF
 l25piCVxUk1OKS4sNs6cRjjF/X3w=
X-Received: by 2002:a0d:d853:0:b0:306:ec2c:67f7 with SMTP id
 a80-20020a0dd853000000b00306ec2c67f7mr98926ywe.15.1653615325976; 
 Thu, 26 May 2022 18:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZpqR1lKnZac0FqHz+G02f2I28FCJwAbRgBPj40FGz8Zd9D7Zxz2yGpdU3kGwCpOuWzF8Ztq50PlpaHwhYGM4=
X-Received: by 2002:a0d:d853:0:b0:306:ec2c:67f7 with SMTP id
 a80-20020a0dd853000000b00306ec2c67f7mr98907ywe.15.1653615325639; Thu, 26 May
 2022 18:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220525113113.9811-1-chrubis@suse.cz>
 <CAEemH2dsasry++GmBxgbTRRAryrBs3FPtYgXMNEmDcOK--r4XQ@mail.gmail.com>
 <Yo9+wTjKm3H9lgpd@pevik> <Yo+ZhTGlhQ7Go0l+@yuki>
In-Reply-To: <Yo+ZhTGlhQ7Go0l+@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 27 May 2022 09:35:14 +0800
Message-ID: <CAEemH2cy2d_2Cx7oG5HWjxU82zFUat9V_Vg5v5Rma=0kt6uLeg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/timer_settime03: Scale interval with
 clock precision
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
Content-Type: multipart/mixed; boundary="===============2037214265=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2037214265==
Content-Type: multipart/alternative; boundary="000000000000148de805dff4528a"

--000000000000148de805dff4528a
Content-Type: text/plain; charset="UTF-8"

> > Could we merge this before release?
>
> I guess that this is pretty safe, it does not change the test behavior
> on high resolution timers and fixes false possitive without them. So I
> would vote for merging it now.
>

Yes, tested also good from my side.
Pushed, thanks!

-- 
Regards,
Li Wang

--000000000000148de805dff4528a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt; Could we merge this before release?<br>
<br>
I guess that this is pretty safe, it does not change the test behavior<br>
on high resolution timers and fixes false possitive without them. So I<br>
would vote for merging it now.<br></blockquote><div><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">Yes, tested also good from my sid=
e.</div><div class=3D"gmail_default" style=3D"font-size:small">Pushed, than=
ks!</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signat=
ure"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></=
div></div>

--000000000000148de805dff4528a--


--===============2037214265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2037214265==--

