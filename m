Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E99C433EF
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 11:33:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8254660F39
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 11:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8254660F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25EDC3C8F42
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 13:33:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F00BE3C8F12
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 13:32:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 67F876002C2
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 13:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632483173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qKitiUszJar9GqpjXFwi310p214tm/NzL5/005heKiA=;
 b=VxWMDlDQJMFM6gUOO1HcwYPXjNLNB5oQcvfpPqrGpM2PuKfgSup0FpUij1EkI+ESFPB37k
 rfYbtrSj9hpUUs2lbbtqlvZx57wdLWcHvDxVM46f1HzK1f1zz/6+9/HWvmEdapI/kyZVHa
 fFEj3udJgBfVJXffol70stOAWwqW1yw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-epOffu4wPqqrRUBcHBnGWA-1; Fri, 24 Sep 2021 07:32:52 -0400
X-MC-Unique: epOffu4wPqqrRUBcHBnGWA-1
Received: by mail-yb1-f197.google.com with SMTP id
 v16-20020a256110000000b005b23a793d77so3028995ybb.15
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 04:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qKitiUszJar9GqpjXFwi310p214tm/NzL5/005heKiA=;
 b=C/gdGmVTON2a8ZmmCinM88+26Ro4ye1oEeua+TK74amMblW0iyELoqwsAUDL7hWvmN
 0npowhvMNFz3rzcQatyszdbcG+zvY25QjkqYvF7tC69KYAHkWd7XFDv4qLqvgrYTEmq6
 0yG9mwiC3JcjZ9X48GFqXAxksDgWxGuTLYp/Pcjl91DiSfiV3+s9IUuWsyHoPT/yvffP
 WyVNzPwJtTv3rBJjnKsEeHd9s8fHbkQdRdASLgXfJ//UL45eyN0cGlzT/dAU23BQBXDW
 Bhp6NomdP9IxEKN9Xwy7dbxtAFOovsvCJRiXjs0BHY7oIQl4sz9gX6r2+/AqPjFRhYwb
 Qcxw==
X-Gm-Message-State: AOAM532dMjrejSfeytwU+mB0PQWVjTecbQbYUmVPAxiUe12melS2Rr/K
 mkLL/PDPZA3Ck+waJg/tNfz9qKt86qAUPytUflhk96JLL4w9ARmpMbLlvskRRmThcLTCDBgyI8D
 zbnGt56q3o9t7QPyh/g2nfdlEvkI=
X-Received: by 2002:a25:2455:: with SMTP id k82mr11461643ybk.186.1632483172083; 
 Fri, 24 Sep 2021 04:32:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6bWumimsPA2PLjOHMts/lh+PPONw0AgibX6lYidERpWcUSnbeyhHcvuOWszNvTSQIisZvRbwViTYmovAepUI=
X-Received: by 2002:a25:2455:: with SMTP id k82mr11461627ybk.186.1632483171870; 
 Fri, 24 Sep 2021 04:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU2w+MA3+esk8aYP@yuki>
In-Reply-To: <YU2w+MA3+esk8aYP@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Sep 2021 19:32:39 +0800
Message-ID: <CAEemH2e_sOvyQ6YBYowNgaavg4K4OYcJCuvLBYogwxAhXSwudA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: adjust the tmpfs size according to
 .dev_min_size and MemAvailable
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
Content-Type: multipart/mixed; boundary="===============1352803857=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1352803857==
Content-Type: multipart/alternative; boundary="0000000000008fc07a05ccbc1bc8"

--0000000000008fc07a05ccbc1bc8
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 24, 2021 at 7:05 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Looks good.
>
> For the whole patchset:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Thanks for your reivews!

>
> Also I guess that we should remove the .dev_min_size from the fallocate
> as a last step, right?
>

Yes, as we have DEV_SIZE_MB for all other filesystems,
.dev_min_size is no need for fallocate05.

-- 
Regards,
Li Wang

--0000000000008fc07a05ccbc1bc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 24, 2021 at 7:05 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
Looks good.<br>
<br>
For the whole patchset:<br>
<br>
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Thanks for your=C2=A0reivews!<=
/div><div class=3D"gmail_default" style=3D"font-size:small"></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
Also I guess that we should remove the .dev_min_size from the fallocate<br>
as a last step, right?<br></blockquote><div><br></div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Yes, as we have DEV_SIZE_MB=C2=A0for all =
other filesystems,</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">.dev_min_size is no need for=C2=A0fallocate05.</div></div><div><br></di=
v>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li W=
ang<br></div></div></div></div>

--0000000000008fc07a05ccbc1bc8--


--===============1352803857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1352803857==--

