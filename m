Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9475FC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:13:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8689610A0
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 09:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8689610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E4683C7713
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:13:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18BE53C7595
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:13:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7263C1000D52
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 11:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632302007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hQVKgry5K8nSy4V1OqDPTREKEykS5MZ6M+0DalX6ISo=;
 b=WZuKeOilB4f0ReVFLHKsXsR3RtnAea/mLJlMon4ZajR/VOogXLTj8oJ46IYbSkl3p7aRgD
 1hZTW0nsG9i72vyfqw03qPZEwrk9Pkrdm+1u3PnlfFmYswW6wKQ6uDiSGnJo6pzEnAwpYB
 +V7gAbWJrE/vwrq2UxABGgoyo4G9JXc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-ndw8joU1NY62l_dYHwPCrA-1; Wed, 22 Sep 2021 05:13:24 -0400
X-MC-Unique: ndw8joU1NY62l_dYHwPCrA-1
Received: by mail-qv1-f70.google.com with SMTP id
 ib9-20020a0562141c8900b003671c3a1243so9328135qvb.21
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 02:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hQVKgry5K8nSy4V1OqDPTREKEykS5MZ6M+0DalX6ISo=;
 b=fvLubr9vKkjv0Rwqpo5FtQsagcUnfuLHirTXGfBw397XBt5zS56hiQF4fr/cAZWyM4
 THIYZMbgM/63UYuLw4O2gVz3XueWFdPWCYYccKXNagFrcJQ7elC95tF+EQX/Sy5/VY/l
 HaQKjjfch1ts7hu1sRKkr2Iud1ajs+gsy70saqbYWgBuHGurtat+78ocKReRjdcUofYK
 PBU7b4yby19Hcj68McjazU7xKoyFWKbD2VNyrLaUsLq4oFeFHxoiVyyykbfPNxHRz0mm
 UEGHFIkYH480AQSSJvYNJI5ncAjmx1LEMXUL7N4TIyA4tdFDoYJHgnFugePq/2EtD0RU
 az0g==
X-Gm-Message-State: AOAM532X0A7yfbPoIpwgeh6NwIHJcyHFmc/RelQdwBKgLgHWD3p74cKg
 hirR5v2bIvIaI7ubaTA4JH5Iawu0ZyDK0x6fRsTt11k3uvT3eSzciLJo9d5tm0i4EWL2FwrBipe
 g9DiV3aex9jNM5cS0VvBjEryNWGc=
X-Received: by 2002:a25:94e:: with SMTP id u14mr19565700ybm.425.1632302003819; 
 Wed, 22 Sep 2021 02:13:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjV2SVZN+6SeVZGVVlBxq9W7wxfLtThY4V9ElplxwFcpukq9V0VlHRe0ire3piYlh1bjMhueE/5dpGX7oDnDI=
X-Received: by 2002:a25:94e:: with SMTP id u14mr19565675ybm.425.1632302003581; 
 Wed, 22 Sep 2021 02:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210920122146.31576-1-chrubis@suse.cz>
 <CAEemH2eRgUDNLmmzNF5cDaAXp7kMgPOBHeJeWqyStOiAq7QLHw@mail.gmail.com>
 <YUnCYvtAZkO/LZIP@yuki>
 <CAEemH2e0kHun++Y2w99N68WAhjFdQkSvkF-1UaDxjbkA1sBrAw@mail.gmail.com>
 <YUrxJfAOO3+B8//7@yuki>
In-Reply-To: <YUrxJfAOO3+B8//7@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Sep 2021 17:13:11 +0800
Message-ID: <CAEemH2d=+h1k62SnVY8Rh=c0UGGEvvTQieW3YgUq8j2Mg6UW=g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: shell: Fix timeout process races
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
Content-Type: multipart/mixed; boundary="===============1748805418=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1748805418==
Content-Type: multipart/alternative; boundary="000000000000170ec405cc91ed58"

--000000000000170ec405cc91ed58
Content-Type: text/plain; charset="UTF-8"

> Hmm, and of course this does not work since the timeout kill process is
> around. Maybe we should make this process a separate process group from
> the start, what about calling setpgid(0, 0) instead of setting up the
> signal handler? That way we can send the signals to the whole process
> group and make sure everything has been cleaned up.
>

Agreed, that sounds like a great method.

-- 
Regards,
Li Wang

--000000000000170ec405cc91ed58
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Hmm, and of course this does not work since the timeout kill process is<br>
around. Maybe we should make this process a separate process group from<br>
the start, what about calling setpgid(0, 0) instead of setting up the<br>
signal handler? That way we can send the signals to the whole process<br>
group and make sure everything has been cleaned up.<br></blockquote><div><b=
r></div><div><div class=3D"gmail_default" style=3D"font-size:small">Agreed,=
 that sounds like a great method.</div></div></div><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--000000000000170ec405cc91ed58--


--===============1748805418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1748805418==--

