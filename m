Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9D1C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 07:42:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC7C63CCB94
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 09:42:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10FAA3C2C74
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 09:41:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39EED1400E19
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 09:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679989315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=E3Kgcr9jpybz6q0lwnq/M6STZHgHetc7FRgV1UNPCWLd4Jt9vK09oWLpa1ufxxb8ekDPqj
 tBpymnj55g5jkm5vKuEqpRI40Iui9lTGo8zadxeM/u1q9XcC8FYUDHVZ8pVhzqCGoMo+Ll
 3pMV9E2aOS/IPKi4jpUmeDd9t3P8blA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-_ByrHACLNimtkOyvsbRE3w-1; Tue, 28 Mar 2023 03:41:53 -0400
X-MC-Unique: _ByrHACLNimtkOyvsbRE3w-1
Received: by mail-wm1-f69.google.com with SMTP id
 j27-20020a05600c1c1b00b003edd2023418so6867940wms.4
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 00:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679989312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=7USsI8j1OHl3JOdK+aHA6R7wHXww8xDezY/+V5j/llOJJV5st0vzOwl6RfN4s0nyDA
 vCrj0dSXQtMts7WKfSiErZlfGix1SxFO12WxfxE5+6jVYNwsTrmeQKEV2QXV6gz1B+pw
 MWWbJUtfzwaUR+knF9Db98xT38ip+fk5vMzob9i8PDse0ieVlBMfLENsMZpZPZ80/Gsv
 Ab8U7+AyVYaNJj9YaS7y6Rb50jPZonIDMz7VLKDuGl142+Z9GXb+45iOBe1FHRs3FVsm
 CUbvWNJM1izokmxRPs7D4oVjIbKFH1iMtPAwvP7EFG65GC56DFW3vc/PRl7V4irfzqUB
 zF9A==
X-Gm-Message-State: AO0yUKXhZcu1x7UeODzcR2mZlIpe+vSLG0pyXA4XY7228WBrE39Jable
 eLpbCjClUjCecFbCn7ZzTXCtKB6ubDzfvWGWekb4lQ/qW4WmbWEu3jUt5ZyTjv9hw+nc9WkbhUm
 xx5vzm4Yzz5hsFnGewSj21PWAl9o=
X-Received: by 2002:a05:600c:2295:b0:3ed:779c:4063 with SMTP id
 21-20020a05600c229500b003ed779c4063mr3299966wmf.8.1679989312358; 
 Tue, 28 Mar 2023 00:41:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/onILtUBfim6F2hD91I1pJ5RD183obqXc5OKvAoJ8cVk1i6cvDJIKKlI2YCAgUquOBUDB5zp8w7g3mpgw1O40=
X-Received: by 2002:a05:600c:2295:b0:3ed:779c:4063 with SMTP id
 21-20020a05600c229500b003ed779c4063mr3299961wmf.8.1679989312070; Tue, 28 Mar
 2023 00:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230324101630.562727-1-pvorel@suse.cz>
In-Reply-To: <20230324101630.562727-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 15:41:41 +0800
Message-ID: <CAEemH2fXxvAKiDvBHY+Pbg=OXtgzCALoW5HD8Fi7gGucgsRtbA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi/mmap.h: Add MAP_SHARED_VALIDATE
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
Cc: ltp@lists.linux.it, paulson <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
