Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E9C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 08:41:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2BBE3C94FA
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 10:41:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30D963C4DF4
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 10:40:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3D38510008F8
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 10:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660120852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GyRX7RlzAtoHQ8QlUs6Ce8ADxhfHcheZCuebJjcnJI=;
 b=jCAJqgKb6bWDuzFGx1/TDlBBXusPURTWDQes4pJA/kJyHQkjYnralUmVmwvRGmLfUY+hMX
 0W6lR2M4zflMDEaI58gDLTpjFp/aqVVpAv2b/yM/WZ5QoiwTKykcCoiii0UGO46FwjW8lB
 HHGSCfBp/NQau3n/KvP+KJ5pO4UKnRQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-2xI1LxHbNb2rRe2Q5fOCHQ-1; Wed, 10 Aug 2022 04:40:51 -0400
X-MC-Unique: 2xI1LxHbNb2rRe2Q5fOCHQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 q2-20020a05651c054200b0025e77ad1ec6so4214675ljp.23
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 01:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=4GyRX7RlzAtoHQ8QlUs6Ce8ADxhfHcheZCuebJjcnJI=;
 b=gShYeEwainHGokS2TviL/ei6FMyRfgE61BzcXkIlzPHUTD74v+O4m0AqNXFfQcllJ7
 MeoCNQdXP7BfZ5NDuNmZbfqlveGhiaAHdRGAC4+dvXpoavl/WFUdcvYXfokcbJhzs8ku
 FQThRDt930uXCeiZAiAsrUYcH0LWUuQ45glc9af/TzCxMSZ58C/2OuP5UhpgoqgNXYdP
 hyg8D2NKtGA7SXCdT6pMeIQc1Nq/mEgNHlJnx5AqUJU6O+jUsF8XkKT9299927RJxmMk
 dIVWNxoZfDJlKzyu9DaK3aeDqGn8FaX7HfHw/nQePd6bpu6dkZT67T0BXLLZUee2ilv0
 2ZsA==
X-Gm-Message-State: ACgBeo3It7tbJ2v5zPWnxqvOLoAkqiyFMjXPbsSmmBuz+J7ecpJEo3Z/
 bNxXl8ajfb7/Tm9nVG0QL/Oditm3nPYSlGS/rCBB05jXHZoenc0SUQLxLVVATA0QuXsPnZ0v9az
 o9JvDsoxNI3OuIgdrQnoXniZwn1o=
X-Received: by 2002:a05:6512:c19:b0:48a:f3bc:5537 with SMTP id
 z25-20020a0565120c1900b0048af3bc5537mr9130874lfu.490.1660120849767; 
 Wed, 10 Aug 2022 01:40:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QRJHOefJ/OrTFDnLEX3mCfVnPJ/YvHSOM420Ac2FWLvQ6mQF0CqMY/zPdgRiO7QhXCC5+/2ddkU6yQH2rzUQ=
X-Received: by 2002:a05:6512:c19:b0:48a:f3bc:5537 with SMTP id
 z25-20020a0565120c1900b0048af3bc5537mr9130868lfu.490.1660120849595; Wed, 10
 Aug 2022 01:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <6a56618714e577c437a489a6050e3d29c2236022.1658842322.git.jstancek@redhat.com>
 <YuAU4ttO/VmuWdrD@pevik>
In-Reply-To: <YuAU4ttO/VmuWdrD@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 Aug 2022 10:40:33 +0200
Message-ID: <CAASaF6z0KF=h3B2DdyJx0qkvqBtNyVjw3D7gFVSJmgJgdVqt3Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/accept4_01: don't hardcode port number
 for test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 26, 2022 at 6:23 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > Leave it to bind() to pick a free port number.
> IMHO more common use case => +1
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks, pushed.

>
> Kind regards,
> Petr
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
