Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7310BC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 11:58:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 548F03C987F
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 12:58:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22C003C9826
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 12:58:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E85B6600044
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 12:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643716720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZDnhgC36kZnMLfNBoh+Nk/i7FrvBXjkmzVtQDxpXQAo=;
 b=A/RmtlwyJPo+d3XKpwW/eVqK0gcQRJKBTfNZeJTOG7Zs8Jl8PE43+zoQZ7xfuPPekEBx/u
 Gl9pfD2ec3vxZ7OqukDozjizcqSRtzXLPzwKMlkq9QaXW0374YoRPw07LQuQp/Pust6+LD
 hx0Ww4aPPOS9ETs7niuFcHiMfrGdI6s=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-O3l470igO1aIA6VevKXzGg-1; Tue, 01 Feb 2022 06:58:39 -0500
X-MC-Unique: O3l470igO1aIA6VevKXzGg-1
Received: by mail-yb1-f200.google.com with SMTP id
 g67-20020a25db46000000b0061437d5e4b3so32223360ybf.10
 for <ltp@lists.linux.it>; Tue, 01 Feb 2022 03:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZDnhgC36kZnMLfNBoh+Nk/i7FrvBXjkmzVtQDxpXQAo=;
 b=QeW8mQzjXlsmUU88X84Yj3CKadhzBTPyHO2b6dHtdDEm3nV1h3n9mcueZgtHSvysiE
 nzv1x70TwJKZRT+TBUwQv0aa/It/OVedfufF6YJoomc81O3U9Rjp+aTD+xJolajwRqGW
 FbWpb31jXdiEEzO77rU/MobT9WPAlMOPKkgkV8cE+UtoA2bUy5ZlGjsAJ+C/FpqNIA5y
 mBfd3iDuwaz0bw1Pku/ieEnbRoDKyXXRIp/xPwmIzKhArEAOkSwZc6uBLJHnctrYuptP
 /YJCt2959CEBM7sluWLZzb876yrf6Z9/2U35X8mpuae5Im03qytsVorV+3ToR3Z+9Ox4
 AL/A==
X-Gm-Message-State: AOAM5300m7mL2s0EYXqnTLImHqQFkIgInK6IaaxbNtuqztzWBSVhxfT0
 8hDmFIAfelWLlLDa+gGObBI0/4HM+ghO28266qTmXnlcC81zHo/liBdToP4Dg2Jh8uMNAsBC3/8
 vVqfkEM/Px8VWVlhIThd53BJV298=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr36972734ybp.71.1643716718892; 
 Tue, 01 Feb 2022 03:58:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlqt3srwN3rMJYM9pM0+N7L9UE2JTSqyRMl2D5oqObSyMeNqx1cBTwdoh1h2oa+kTCGsq3PwUkPAzx231P9EM=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr36972708ybp.71.1643716718580; 
 Tue, 01 Feb 2022 03:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20220201094451.7651-1-pvorel@suse.cz> <YfkMR3oM/QD9a3I9@yuki>
 <YfkPfjqRz9j2Jbuw@pevik>
In-Reply-To: <YfkPfjqRz9j2Jbuw@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Feb 2022 19:58:20 +0800
Message-ID: <CAEemH2di8y4qiyn45EOgdxQo-oebEsZRhYmyCfkifpvS1rpsaw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci: Remove CentOS 8
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

On Tue, Feb 1, 2022 at 6:46 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > Hi!
> > > It EOL in 12/2021 and CI is failing due removed repo:
>
> > Since it's EOL we can't do anything else.
>
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> > I wonder if we should add a different distribution instead. Maybe
> > replace it with Fedora later on?
> We have CentOS 7 (EOL 2024) and also fedora:latest, which is 35
> (their devel called rawhide is currently 36).

Is there any possibility to convert from CentOS 8 to CentOS Stream 8?

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
