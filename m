Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BCDC433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 09:02:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3782A3C95F8
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 10:02:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E28B33C07B8
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 10:02:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F252F1400BDA
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 10:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642496544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzPIsg//osQcZ4qsKwh9hyRTxmbJHrQN65a4xmJHB4k=;
 b=I1vO6yL47s+5E0bUfbK6+JKp0Ac8dWW+jpzmppdzA43vGyP/KtmrxxQKOo8u9yD/YRFX8x
 W6KPmAuAFVhyILBLQH3miMhJW2iniYdx/k8s6urv3Ud5TJ7E7d5YwNpwijzrAOESvEbebz
 zflqqvLBgbfg+VO0lnDrMD7mWGq0Ewg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-YGnjnIPpMSOvzeZVLuqYrA-1; Tue, 18 Jan 2022 04:02:22 -0500
X-MC-Unique: YGnjnIPpMSOvzeZVLuqYrA-1
Received: by mail-yb1-f197.google.com with SMTP id
 2-20020a251302000000b006118f867dadso37447252ybt.12
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 01:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FzPIsg//osQcZ4qsKwh9hyRTxmbJHrQN65a4xmJHB4k=;
 b=V6HcJfgrMTilBrg6k5lQag1sosIHygBpoEd9uvLrGlAzLIoDGUOsIVoQgsDmLo+dbM
 zhwueqILienrSpdJQkCujIY56ev4WTH6zxKO0L4rNi/eb5zZB5L83Fwi+HZSLJo9RpTX
 p+cjP1lNKI2sA447Yg3bAL4X4LnOayPhhVhDeBNsz6lHBIdRu6VRmpsjTQ6uCJ1Nfaty
 C3p4lvbgFtf48+Q5R6w66MM3LIQnSA+5+3IPEiFgqUHZd0idyXjqFYTX6jw1nNj1q1ur
 JtTcso0gzU6BJ1upDzCrnu44nDfxXR7ZzxkDl5jECCjZBO60jV+0OmSoFFbLtQOgYyvj
 bbHA==
X-Gm-Message-State: AOAM531tX67fYHYVGamn/aZ+vio7eR4MDxnXI8qEK6PGiKZZV5bTF0y7
 S7Yl+aCn1P5z66so/HKJsjVQoiujJN1xFSlZWD0/3sNt6qfYuY20IAaxYSM2ZCnD0Sd5Rz6IIor
 nTfN1L3VVbvaZ4zc7XA8e9EFDSqQ=
X-Received: by 2002:a05:6902:1365:: with SMTP id
 bt5mr23688788ybb.145.1642496542088; 
 Tue, 18 Jan 2022 01:02:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/skheHkebNEpfiQkDY0k2tnjcp3zqk+G5g3hVnzRJPxRWvtx9BYARLtX4zPo4aAcZTGnQWlFPP4LENaS4U/A=
X-Received: by 2002:a05:6902:1365:: with SMTP id
 bt5mr23688759ybb.145.1642496541816; 
 Tue, 18 Jan 2022 01:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20220113123418.1911231-1-liwang@redhat.com>
 <87wniyzpj8.fsf@suse.de>
In-Reply-To: <87wniyzpj8.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jan 2022 17:02:04 +0800
Message-ID: <CAEemH2fMvqTVLa7B35Hp3W8BhyKe69NrtA36CDzPcwQceAVzDw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: rewrite cgroup_find_ctrl with using
 for_each_ctrl
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Richard Palethorpe <rpalethorpe@suse.de> wrote:

> > It is safe to start from controllers[0] to traverse each of
> > the controller whatever V2 or V1, then we can make use of it
> > in the cgroup_find_ctrl() function.
>
> Right, it seems we never set ctrl_root on "cgroup" nor is it added to
> ctrl_field. So it will be skipped in other loops. This might not be what
> people expect, but I'm not sure what to do about that.

Yes, but that's fine. It's because of the difference between V1 and V2.


> >
> >  /* Determine if a mounted cgroup hierarchy is unique and record it if so.
>
> Nice simplification!
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Thanks for the review, I will merge this after the new release.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
