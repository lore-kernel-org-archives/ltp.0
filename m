Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1CAC05027
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 14:17:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DF523CC25B
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 15:17:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B383CB289
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 15:17:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C264600700
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 15:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675693060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=haj50ExdT3GZ1EwDipcGnZ/3Az41okX8zWC5S4GWUIs=;
 b=MztHMftQ7CZ2Ma9rkWHTeI+/ufX+WeMM/ZDry/vZaEk9TYxS5RO+x781m6gNieFUSHKITS
 uRPFD8tzkVrVmMcsy3OFysgiNW2o1U67JM6K4c4ydjLe2Uh5u5dIOr0qQNo3zFRcdG9U+V
 jXGoDr3FUj/BxXO/SawjjLLvPIFoUY8=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-IbqvbmeEOWqQYfM6-KYR_w-1; Mon, 06 Feb 2023 09:17:36 -0500
X-MC-Unique: IbqvbmeEOWqQYfM6-KYR_w-1
Received: by mail-vk1-f197.google.com with SMTP id
 g63-20020a1fb642000000b003ea9b485123so5185937vkf.2
 for <ltp@lists.linux.it>; Mon, 06 Feb 2023 06:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=haj50ExdT3GZ1EwDipcGnZ/3Az41okX8zWC5S4GWUIs=;
 b=WeiVDyS9rfSPluyHLyOHkK7FptI3mh8fsvUIi2CHX23jtMRr8XVgIcO1CuX4Ok4YEa
 q/7Fb67r9hRrorQbOtOauunnCxLwsIegqSAGETeJyZfQ2qYR+bHocmas6E4kC1nTAjmO
 U8tuwP8Ll9vcbiQyGgGJXLEzcB5m6jvgtZHy5ZHQgzvoDRaNP1IuvOsxP31DR53siyb+
 71fxdN72/vVgtBLjTimi7MnFTQorLHNV801h8VhjpJxAho/SZJO69zeJIs26+QDHOSem
 w8MmvzK8fVyC6X3xKUnq5rik2SEqGcG/quO66vXIquYyLv/hejwYVm/4hNntHguEWqYd
 Zlew==
X-Gm-Message-State: AO0yUKVW/sWaAlTCm0Y4MB/nXg/WfeAoXHKHQHiZ8PTYqt3UQrMW+DOQ
 W+9SDM7LwxH2jQNtcpISTBAPK5QMYQ8anRbSLTlH20ZQeV0Qd9gyBItSs09cvjBtBAeyvO+kL0Y
 hknU14+An+nlIiHOlpPaDq0ijxW8=
X-Received: by 2002:a67:b404:0:b0:3f6:8f1:f86b with SMTP id
 x4-20020a67b404000000b003f608f1f86bmr2823176vsl.71.1675693056179; 
 Mon, 06 Feb 2023 06:17:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/u7lV0YAQrC2pb6NrGL+9II/kLRbnhWGbfLcKpMREqRJ6CB0wuMzHgqDTrVWGbbeydo7x4QgAm34w4SUJkfHg=
X-Received: by 2002:a67:b404:0:b0:3f6:8f1:f86b with SMTP id
 x4-20020a67b404000000b003f608f1f86bmr2823170vsl.71.1675693055888; Mon, 06 Feb
 2023 06:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20230206061001.13164-1-pvorel@suse.cz>
In-Reply-To: <20230206061001.13164-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Feb 2023 15:17:20 +0100
Message-ID: <CAASaF6yvWLPpvKgXwhk5Z=USN_+yz7pELStWco0A9oGs8yiNag@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Allow zero iterations (-i0)
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Feb 6, 2023 at 7:10 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> -i0 is helpful to test if setup and cleanup are working.
> We suggest that in maintainer-patch-review-checklist.txt.

Until now, I never thought of trying -i0 :-)

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
