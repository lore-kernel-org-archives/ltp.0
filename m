Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AD0C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 02:10:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B813A3CA2EA
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 03:10:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F00B3CA1D8
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 03:10:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BFD99600702
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 03:10:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646187022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osc2CRdnBafR+OetflT/MrS5Ol64PiGZA79mx97fxk8=;
 b=FzW6yQ/Zu5DaKnXMkN/Mh0tgTo8H69uc9T46bIKLg6vlBdlqm8zg20shDgrfiIE55lMthe
 EnJ3J8jVQfQfuTgw3of0nHnl9Vg4jC2cMNGM+xaSEM/vP1h1mp1BgZrPP3t6y6UdQRtk2a
 AEH1KradWyTGA8jCJvV3NcDGwgVr3OM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-f6JaD1HPNry7JzbJppecLg-1; Tue, 01 Mar 2022 21:10:20 -0500
X-MC-Unique: f6JaD1HPNry7JzbJppecLg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-2dbd3691096so2074587b3.7
 for <ltp@lists.linux.it>; Tue, 01 Mar 2022 18:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=osc2CRdnBafR+OetflT/MrS5Ol64PiGZA79mx97fxk8=;
 b=5lQLZyRPCrPqQC6YxbSjR1JMY/WIg1WO1hJsXnhF9VdP2xW7KZ/tnQAXPlR2XQAnK9
 qFa8/YxBlnJhGudVaFwLrjCbJHwg+AU4OEIEbY1JrSa1HhUnjNsGgruiGs7m9ofsRfI2
 MgKNC/4MsSViZU/Bzk5Ty2aMb/Tuu8JqCCl4+FfXe3aBtC5EwLl1L9etvfz4l5Bvpx6d
 Y1GQP0pG1sQz7oKXPm/+kxGciNSx2EU51j+AN3krMq1ZzF3gcmnMeZhMjvG8AB+QjA2I
 al7XmHG+t0lnETy1qWKWb0oJdCMlHTPBe/pxPLGUow9mCBAJv1/mL4wKIOo+U89Rzzlk
 aUfw==
X-Gm-Message-State: AOAM531Ysqc83UjLBU6fswAjO2agc2Xic0fC92tm3uRGWqPAh1lULqP/
 vN2e7CJ8EClt+oevoA+VJlF+KeZZYsZGwRgqE8eqMolhsaMRi4HcOuxB/N/wRSZncVj6Kaf0Fo+
 50vR1t6QOiFT8C8jp5AWK9aomreY=
X-Received: by 2002:a25:ad07:0:b0:628:78df:ff24 with SMTP id
 y7-20020a25ad07000000b0062878dfff24mr5879549ybi.233.1646187020346; 
 Tue, 01 Mar 2022 18:10:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxvnRuWltkzgHYtrO3U8KbtkiBQAne6KS/8ZgBugm9UrHAAq7X+zBDB2jv9V/GbirZJPuKWHrGcqcOffCQH9s=
X-Received: by 2002:a25:ad07:0:b0:628:78df:ff24 with SMTP id
 y7-20020a25ad07000000b0062878dfff24mr5879541ybi.233.1646187020108; Tue, 01
 Mar 2022 18:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20220301122353.16137-1-rpalethorpe@suse.com>
In-Reply-To: <20220301122353.16137-1-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 2 Mar 2022 10:10:06 +0800
Message-ID: <CAEemH2eyid8c=rXFWXT0g1XFrCw1zLVuTz1b77h3zFe1ZPG48w@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] API/cgroup: Try to mount V2 with
 memory_recursiveprot
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
Content-Type: multipart/mixed; boundary="===============1365975374=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1365975374==
Content-Type: multipart/alternative; boundary="00000000000091592b05d932c802"

--00000000000091592b05d932c802
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 1, 2022 at 8:29 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Moving forwards system managers should always mount with
> memory_recursiveprot. So we should test with this by default when it
> is available.
>
> This change will only effect SUTs which do not already have CGroups
> mounted.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--00000000000091592b05d932c802
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Mar 1, 2022 at 8:29 PM Richard Palethorpe &=
lt;<a href=3D"mailto:rpalethorpe@suse.com">rpalethorpe@suse.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Moving forwa=
rds system managers should always mount with<br>
memory_recursiveprot. So we should test with this by default when it<br>
is available.<br>
<br>
This change will only effect SUTs which do not already have CGroups<br>
mounted.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br></blockquote><div><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: L=
i Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@re=
dhat.com</a>&gt;</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--00000000000091592b05d932c802--


--===============1365975374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1365975374==--

