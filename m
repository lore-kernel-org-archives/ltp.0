Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E06C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 08:08:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63AE3C9B04
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 09:08:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 000153C26B4
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 09:08:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 67389600815
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 09:08:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644307697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfzfFkJSwMqubCrv86XbOprDCQ8a5lUV16khDIF9aRc=;
 b=YVTrpsR7qjSl12CN8aR0dAyUS5+faOa1FQDp/86clVaRnZIT9dmAq3yr6f3L5W1fIvWQsj
 qPlVP3vcSmSCF2vvnRlIBCrGmBd2ywd6KM5Xh3zjIz5vUDBw9ERW4IHHTPTlWjD0DRm3J0
 fomdEQrfDr+ubv6SmLcll3Axq534c4w=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-iNz1BbndOCWU-Imz5t7N9g-1; Tue, 08 Feb 2022 03:08:16 -0500
X-MC-Unique: iNz1BbndOCWU-Imz5t7N9g-1
Received: by mail-yb1-f197.google.com with SMTP id
 127-20020a250f85000000b00611ab6484abso33847408ybp.23
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 00:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XfzfFkJSwMqubCrv86XbOprDCQ8a5lUV16khDIF9aRc=;
 b=iGMsjrjVlethWUwCVnITKBut2hm37uKMqvhXxwFqW6SLIF6v0ZuqUKIVm09i5q3y+B
 inMT0qLLcWGM3lhrZXiAR6oLS+RdWt3yGP/WhjQnL3OHK7tN4x/UUGO54l417mjU+t1D
 PUBCXsQ6ljzK1l01kHfy+uTRDNSfiiJQP0dIIFpJ1t73Y/f2Lkhg5vv1Pe3rw526svgI
 J0OrGEBOC8sAb92SEz3C5efveSAIPhWxiCmhrECLXySn3vVmpJ6dy5b63QyJthAWVP3b
 YZufTheMDmepZGHfJkoHXfmwk8yqHRCuuE0A47Y8TneTXbXBo7uPl5n3qdH8vuuL+WPu
 Z5Ww==
X-Gm-Message-State: AOAM530f8RuEuwVJmwtSbCrQpK2EoyBmdPzG/mdzQMe5etXvQoC9w2ZF
 xx4/4sYMhBtN8fW+G3sJlxGBIncAwt/ZSE8AHzrseL8HhiUA0OBPEg51jac0H1Vddayyjra87Ru
 RaGBZ7kwj6+2666Acu70nD+fIYto=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr3567030ybp.71.1644307696116;
 Tue, 08 Feb 2022 00:08:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxT9cNqbe7vrB2owRMeMGrwyqfJ5VgU711mBpF29IzY5FDuc1rRsxxH2/WaQjkjDu7o7BmNc+Hr+kfSn0X/EFE=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr3567018ybp.71.1644307695939;
 Tue, 08 Feb 2022 00:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20220207141618.2844-1-rpalethorpe@suse.com>
 <20220207141618.2844-6-rpalethorpe@suse.com>
In-Reply-To: <20220207141618.2844-6-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 16:08:00 +0800
Message-ID: <CAEemH2dL-ocgx_bARt=paAxYMtFvypM98czjf+=3eMUMP568Cg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/5] memcontrol03: Copy from kselftest
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
Content-Type: multipart/mixed; boundary="===============1091547377=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1091547377==
Content-Type: multipart/alternative; boundary="0000000000001e586d05d77d38b9"

--0000000000001e586d05d77d38b9
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 7, 2022 at 10:16 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Note that the tolerances had to be increased slightly otherwise the
> test only passed on ext4 in upstream 5.16 on x86_64. In all cases it
> seems more memory is evicted from C than expected and not enough from
> D. This may indicate some tuning is possible, but does not look like a
> serious regression.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000001e586d05d77d38b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 7, 2022 at 10:16 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.com" target=3D"_blank">rpalethorpe@s=
use.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Note that the tolerances had to be increased slightly otherwise the<=
br>
test only passed on ext4 in upstream 5.16 on x86_64. In all cases it<br>
seems more memory is evicted from C than expected and not enough from<br>
D. This may indicate some tuning is possible, but does not look like a<br>
serious regression.<br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br></blockquote><div><br>=
</div><div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-=
by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwa=
ng@redhat.com</a>&gt;</div><div class=3D"gmail_default" style=3D"font-size:=
small"></div></div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D=
"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000001e586d05d77d38b9--


--===============1091547377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1091547377==--

