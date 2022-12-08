Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5686AC6370A
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 02:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D4C03CC161
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 03:39:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E963A3CAEDD
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 03:39:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78ABB10007FD
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 03:39:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670467177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UlZaUmAIwRgMUgi0dI75C+LuTHKMcoIzAT5chLkxp30=;
 b=UpXDIWEKFdy9NkPVwN6f5d4VUiy/vlDpxFUGKIcPksDQDQ98oJxowsFg1mbwojTdFcTzEI
 MOOG+tcwQGynUQ5FyI3gF9hEFcbEoBspdMw57muuXrpObI4wU7av3AqhcWizrhzY9gWgSD
 h0hCrX2EHwVYcDCUAZQNgVJz9cC49dE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-K7ANlsHyNnmPuPHIKg7uHw-1; Wed, 07 Dec 2022 21:39:36 -0500
X-MC-Unique: K7ANlsHyNnmPuPHIKg7uHw-1
Received: by mail-wr1-f72.google.com with SMTP id
 l9-20020adfa389000000b00241f907e102so5896wrb.8
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 18:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UlZaUmAIwRgMUgi0dI75C+LuTHKMcoIzAT5chLkxp30=;
 b=XyX1mQWVeNAPTNjzqEfrAyj/bpXaljqZIbkzZlFX87RJe92mpzoFVZpnS/jJDZENkm
 o4WoC0Cvdb6el2lM/RLlUxlCIXFGiI2ityFMzO2jFBQg4YjEEm0vrR0nEcYio+GKa8mi
 MQT9Gw0zJssEGAC4IP6++/YZKH5XFBjD9/a9ecBc7fGwwXIDMDoT1mxmVR+tFfnqADGG
 Kv5UdUMIezr5kU99HA54L8xHPH2lnIlzT3Wg4EQ8D+KblIhZlhP9FAdvm2mWlkOm/NUX
 cHtYkLg0t+kFXnFbeMBoAzf1eLNe9OCtMQUliLi+sAZciY9I7Xr8h5y4x/GBE6CAUgr/
 fWSA==
X-Gm-Message-State: ANoB5pkquLHiBAfJuKHeVlMlTzm6IpXr+UmmqnPqgJcJfv+yeEJNnTH2
 Dxh5a2ODRJhlMbUy9fJQ9WkAXHy3lqmVCInVIxmXBbuPG68ey2kZztQWKQMHmsMRWJp80xutTbD
 4HwMkBTqz0X7eG0smjsxHAuNBkqg=
X-Received: by 2002:adf:e5c6:0:b0:242:5c6d:30d7 with SMTP id
 a6-20020adfe5c6000000b002425c6d30d7mr10516801wrn.316.1670467173426; 
 Wed, 07 Dec 2022 18:39:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Msnd9GHwFvfUmuEqgJEh5uf8hEcu4l01ZEukrP34Nc/RmhkFsqUoABZuKRQClr+zjDe3niNdZGEYTpuZOjGg=
X-Received: by 2002:adf:e5c6:0:b0:242:5c6d:30d7 with SMTP id
 a6-20020adfe5c6000000b002425c6d30d7mr10516795wrn.316.1670467173215; Wed, 07
 Dec 2022 18:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20221206115329.17760-1-rpalethorpe@suse.com>
 <20221206153302.GC21839@pevik>
In-Reply-To: <20221206153302.GC21839@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Dec 2022 10:39:22 +0800
Message-ID: <CAEemH2ceSkk_+KOVMzVPQ1ER879dpt0NTT2CEMAp_PNa43MAGw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fs_fill: Add max_runtime = 60
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged this 1/2, thanks!


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
