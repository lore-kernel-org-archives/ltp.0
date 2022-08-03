Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39569C19F28
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 07:57:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 194433C2730
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 09:57:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FCA13C1ADE
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 09:57:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F2BD51400BE1
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 09:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659513452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h97bM0StfwCG/uiF5q/4sNCBcA8vYiGSiZyaRHeNP4k=;
 b=jKSdCN/UfKQ9s1OfWcm10GCwZVjApE9j5eWPafnGt8UlJbxL/CD/6N5NVcGJvr07C1cEf5
 TgCX4GHgTr3/B2vmd0AMXW6CEMtm3jpSAYq/6gLo/GqrmUfEfYyaWZkfV9S5bghZDwb2w+
 Of5LtULoDvpPXcAId4Lpw/r8l7HSMJc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-pfWqhgZeP4y1IUsEZVMVjg-1; Wed, 03 Aug 2022 03:57:31 -0400
X-MC-Unique: pfWqhgZeP4y1IUsEZVMVjg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-31f4450c963so138598147b3.19
 for <ltp@lists.linux.it>; Wed, 03 Aug 2022 00:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h97bM0StfwCG/uiF5q/4sNCBcA8vYiGSiZyaRHeNP4k=;
 b=5jmYKUbiL664Lort8TYRvgIlwOoB+qsihxRxaVkM8LwFTVM44UX3umD5da/Uo7k+Hz
 CFuU7JDRSfSaSR7jWXiompWW5O+0nINez+uvjMwzc8G0tNE4vSF6ACQOfYgFlaoXwYp0
 pYQ9uayZB72zGYHC9zviSwF0sFaw9LOfI2wsM7fzeIrTkrYi7pOUaHICxGiMVJPy0Vft
 b7uLEoo7907ICAOWz4qkEJj4c+7VH7jqW8aoNUonim7Mr21aisBFnmL1uZddCGDBawfA
 dx3v94un6lYXyF768ZXlPfvBo9LSZncpHHb0k0T+dq4sh/Szfa9OaUcce5nzHhX657XQ
 TMpg==
X-Gm-Message-State: ACgBeo3cyF7rGDGH7qMZeYm31z9phfOVAhHPozw278eQ9dLvdrJfE2fz
 O/dAt9ce2+oqxFnHef4QccLeVWSceK1k+lUfmRkVVQK4ohyFOfBDXBDQsztPupsGb2B9Qn0z4aa
 ynkG+yuKXc0u9CE1YJ8T2it6mJco=
X-Received: by 2002:a81:7c03:0:b0:328:25ee:40d with SMTP id
 x3-20020a817c03000000b0032825ee040dmr4335821ywc.12.1659513450526; 
 Wed, 03 Aug 2022 00:57:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73JtdHyeSbQClaSRdOo3WzEpQbhC4Uv7cermE1GUeQaEsLohR1il6LWrwbzrIi66idwqqlEIFXeOkg06lDm2g=
X-Received: by 2002:a81:7c03:0:b0:328:25ee:40d with SMTP id
 x3-20020a817c03000000b0032825ee040dmr4335812ywc.12.1659513450307; Wed, 03 Aug
 2022 00:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220725100641.11625-1-rpalethorpe@suse.com>
 <20220725100641.11625-3-rpalethorpe@suse.com>
In-Reply-To: <20220725100641.11625-3-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Aug 2022 15:57:19 +0800
Message-ID: <CAEemH2cUmxYU0RLojX-uV3t=aeFftn94pgQrS3p63DvngwSXeA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] read_all: Allow /sys/power/wakeup_count
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
Content-Type: multipart/mixed; boundary="===============1764136931=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1764136931==
Content-Type: multipart/alternative; boundary="000000000000b4b60805e5519536"

--000000000000b4b60805e5519536
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000b4b60805e5519536
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><div class=3D"gmai=
l_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"ma=
ilto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><=
br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"=
><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b4b60805e5519536--


--===============1764136931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1764136931==--

