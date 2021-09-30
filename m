Return-Path: <SRS0=m48/=OU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4410C433FE
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 17:17:18 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14406124D
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 17:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D14406124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4E3E3C9633
	for <ltp@archiver.kernel.org>; Thu, 30 Sep 2021 19:17:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 788453C29D6
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 19:17:06 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C936B1A006E2
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 19:17:05 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 q127-20020a1ca785000000b0030cb71ea4d1so4907304wme.1
 for <ltp@lists.linux.it>; Thu, 30 Sep 2021 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to;
 bh=rqifwGlTww4S/a0Ga/T0jVan08yTSulgOtaTWy/ZQBA=;
 b=TNgbqMMPRIn5MPjj+D0WjKI2UZincxbO+xfBE9eM1ZCR5HoKFKJHe4UzbjW7SQm/6N
 TMI2bYp5DZ9JnsRBQhamwJcBlU+Wz4G5OLBakvejWuAEpuMPPu1DJXTq4KXFcwauhXx5
 J2H+V7yqy9+zXPOMtUT6DZC3CcbR4oD+9zbElV1cHzvtgU/jXzcoyemOQgr32f+sW9G7
 /NhpKRgdvSqKS8tuHzeWlUg8Kd8JQ2OehQhcyFZo3rPJxWrK/qD3TtmPuqRitnAcZJv1
 CaN7T3wNjP5yToli3Huin17XT3PVYUsha1fLEb6gNEWNeLXN4BL/22a7vlXBc2xg91oK
 B+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=rqifwGlTww4S/a0Ga/T0jVan08yTSulgOtaTWy/ZQBA=;
 b=R96TagfGHVxUnKMCr6LkAfmysxL5uLtqdg2rKq4r9O3eQWpsp8OU0CECNYfXEFGqPD
 NpEQoP/ZL/g/+U7S20RC7SwFhI6Z2WhxkasbRJNNnJCENLRlcuoreZ6VuNZ8tHEh1Oo1
 qfy+zzUNadROqaE6vt8UE0WQADP0Egyj3GWFc1lmSkNtcmmoz/yBSRngx4Lmm+8SCIQ7
 tcHoozjf/whdLa4V8xFNvoV6320IuQnkVRqNFCSE4VhpugncT6Q59dWFDNHRb+8LqeOm
 tQ4e6mGJ3aBl9audfDn/7/WovgEXVrYLk7ynLtprU5btWH7vzd2ecqU6zVi3qFfiZ2Rq
 RIDQ==
X-Gm-Message-State: AOAM531hQrmerY6b19q/3AWH+M8k3EWV/I3RF3Pddu8Qgq0A/QgSxpsA
 XJkJXzEeUI+DkcqKd5TxC5vb6qVv/nk=
X-Google-Smtp-Source: ABdhPJwqnkoHaYrYVE+To3Fc3/m3G8M97sCoSYNVd6/AONXDsShpBRd7TD3JGxBdw3Y0VAa5xssxtA==
X-Received: by 2002:a05:600c:ac2:: with SMTP id
 c2mr405463wmr.118.1633022225384; 
 Thu, 30 Sep 2021 10:17:05 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id s11sm2677565wrw.8.2021.09.30.10.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 10:17:04 -0700 (PDT)
Date: Thu, 30 Sep 2021 19:17:01 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YVXwjNU3MbZxmxWq@pevik>
References: <20210929181709.31788-1-petr.vorel@gmail.com>
 <20210929181709.31788-3-petr.vorel@gmail.com>
 <17c1aab9-6c53-f1ec-692d-735721eb9290@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17c1aab9-6c53-f1ec-692d-735721eb9290@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] lapi/if_addr.h: Define IFA_FLAGS
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin
,
> > +++ b/include/lapi/if_addr.h
> > @@ -8,6 +8,10 @@

> >  #include <linux/if_addr.h>

> > +#ifndef IFA_FLAGS
> > +# define IFA_FLAGS 8
> > +#endif

> I don't understand why the move of IFA_FLAGS from lapi/rtnetlink.h to
> lapi/if_addr.h is split into two separate patches. IFA_FLAGS is required
> for compiling tst_netdevice.c so this patchset is not very bisect-friendly.

Ah, good catch, thank you. Silly error I mixed up IFA_F_NOPREFIXROUTE and IFA_FLAGS => v2.

Kind regards,
Petr

> > +
> >  #ifndef IFA_F_NOPREFIXROUTE
> >  # define IFA_F_NOPREFIXROUTE	0x200
> >  #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
