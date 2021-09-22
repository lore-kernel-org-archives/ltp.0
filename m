Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF77C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 06:45:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05B7611B0
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 06:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F05B7611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE633C4D40
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 08:45:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3A5B3C309A
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 08:45:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D16CB10011A4
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 08:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632293118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvI0AQ6NwO3QAUNXemE9QpvS3zHXpIJx+eFR6ayiUd4=;
 b=IY7GGBbMDyU1H1rR0xgKLJvNcCe087bvzp/nNuVsdyNO7GaBbDfbn9re44bEaNtss1ca+P
 HFj+zoBWy3JpZJnpnVihjcvtjUjbLboqcfWB9z4djaVY9wA81aRD0AoGyVex4WaiF69JAW
 10O+/ezVrhxVCbf3fWSzztdCXA0q19g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-2qjbgKpBMHCRoo3s9X-Zwg-1; Wed, 22 Sep 2021 02:45:14 -0400
X-MC-Unique: 2qjbgKpBMHCRoo3s9X-Zwg-1
Received: by mail-qt1-f199.google.com with SMTP id
 c21-20020ac85195000000b002a540bbf1caso7319644qtn.2
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 23:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PvI0AQ6NwO3QAUNXemE9QpvS3zHXpIJx+eFR6ayiUd4=;
 b=ZDY8nbkrCNcSkS8pXSErsynBZ4hm86XNq2q5nflYYRJG5k9xZYEkopdom7wZ0UWWzH
 YGyWU15Z+TM+khy8Ch6vfrj6nFQL7uNOVzcp/OlsyStlrlLceewKooix17lHnX1axVjm
 LX60l4blWxM3gLjZwCwSbkJlZetU+iVyDqw17UwVcDUNCXl342VWwbR3zMshtAMWeUod
 7Mb7Mzv+rcMCW9cGC8LSYRUdAhMOa2WlFeF6Xfd/S5+YPPkr97kT1hFKYiunqtvwxy/l
 PfbladaYd1L4pBUBbsDanw3JbZUU/qK41IZ1NjLycm5ecwVTWEmtCsCwdOm7Y9/wXpz9
 VHBw==
X-Gm-Message-State: AOAM530kuYSF5ZgqPDeKdiuYYWUY1Iif1221Q4V1wpkY6kZjt5p7QaLB
 L224my/DVztkpOgrrvLKvKpIgr5iALmE1Me940quT9/DSJ0A4m7cKq/OWbUXDZbjiExQYoSuczM
 uWMLizFGPxIU8kRn2ysIXa0z28T8=
X-Received: by 2002:a25:e4c7:: with SMTP id
 b190mr41179290ybh.302.1632293113433; 
 Tue, 21 Sep 2021 23:45:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC2MpH8jVWeRlm/a5/UFISHNwb8X3dUAe9Rw1sCWVZp2V0PsGJLAoJHKplN684SPfz4bIJlWjafrFLyABUa7k=
X-Received: by 2002:a25:e4c7:: with SMTP id
 b190mr41179280ybh.302.1632293113268; 
 Tue, 21 Sep 2021 23:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <YUmFUVdkr133eqa0@pevik>
In-Reply-To: <YUmFUVdkr133eqa0@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 14:45:01 +0800
Message-ID: <CAEemH2dLGZLhg1z1_5Z+ziGcxAS7e=m8_c8U_eQ+U-2U+oYt7g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP archives on lore
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
Content-Type: multipart/mixed; boundary="===============1240661939=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1240661939==
Content-Type: multipart/alternative; boundary="0000000000002fa88005cc8fdb80"

--0000000000002fa88005cc8fdb80
Content-Type: text/plain; charset="UTF-8"

Good to know this, thank you Petr and Konstantin!

On Tue, Sep 21, 2021 at 3:10 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> thanks to Konstantin Ryabitsev [1] we have LTP archives on lore [2].
> It currently starts from the September this year, later will be added
> history
> from current ML on lists.linux.it and from sourceforge.
> Thanks to Cyril for providing the archive from sourceforge.
>
> Kind regards,
> Petr
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=213861
> [2] https://lore.kernel.org/ltp/
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000002fa88005cc8fdb80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Good to know this, thank you Petr and=C2=A0<span class=3D"gma=
il_default"></span>Konstantin!</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 21, 2021 at 3:10 PM Petr Vo=
rel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
thanks to <span class=3D"gmail_default" style=3D"font-size:small"></span>Ko=
nstantin Ryabitsev [1] we have LTP archives on lore [2].<br>
It currently starts from the September this year, later will be added histo=
ry<br>
from current ML on <a href=3D"http://lists.linux.it" rel=3D"noreferrer" tar=
get=3D"_blank">lists.linux.it</a> and from sourceforge.<br>
Thanks to Cyril for providing the archive from sourceforge.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
[1] <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D213861" rel=3D=
"noreferrer" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?id=
=3D213861</a><br>
[2] <a href=3D"https://lore.kernel.org/ltp/" rel=3D"noreferrer" target=3D"_=
blank">https://lore.kernel.org/ltp/</a><br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000002fa88005cc8fdb80--


--===============1240661939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1240661939==--

