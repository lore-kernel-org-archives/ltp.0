Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C1AC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 02:55:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 881BC3CA192
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 03:55:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F1A93C97EB
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 03:55:32 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FFA5200A08
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 03:55:31 +0100 (CET)
Received: by mail-pg1-x530.google.com with SMTP id z4so15827366pgh.12
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SG7S45ZndEWvfYtDNMNbGzm1w5e/CL5qIs3eXP9nAIY=;
 b=xwH69k37o41IbFPAU3OYcnq1gsuk1WQGLVdF1o1oEvxH8ctQyEwl8p5J0Klf+qGrZl
 92okLVUs5xEN5yD9F8kenW7WP4wBdUFuphZq1mGKeLUm931feZWWHje6GfKZwti51e5a
 HNWq85MYZvNx+b/g+lF4x9EBny7B2wrKAKnfyS7jLqeQcHyik0UuFw6U3tZqWFXD2EXS
 /AKSPupKjAJixEpxmCFwtCuWba4pNFpu5TEouuUhBkYi7GPjD1DkjKlfQu2ftG8lbE2i
 3A+0jUesTG/qbo4uR/edUv1tbC58JRBbkJZiSkCTdR/XqxaqfqV9xJ3xaRDIyOcRxWKw
 nc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SG7S45ZndEWvfYtDNMNbGzm1w5e/CL5qIs3eXP9nAIY=;
 b=HlSQb0L/sPKn1grN5f45Mh7/6Cub0f95vMxvsGDw2Ar+kdFBs4qq4AJIGnvwj1kA+d
 W5a8gkeJguKdvptEaOV0IZ3+x/pJ72AzmLVierHCGDr+m6P/YlN5t26J4L+IBsESKaZY
 Z2Dcmtfayl067VNWNOdwZohLQx+QPHTQGlbhVrzhHK4Jjl6bAO9pwkBf2Mpsa+BCuqRv
 iDbwfQc/U6EkjL8c/fjOQI56FSnJK/+QOuUJKjzzhfag+3Ph/cnatQgX/11l2HxXvuxo
 2GHo2NZc2NutGYQtM62Uy3c2bG3iL8oFOyPc0RVk/2T3ZWLEvkuCwoQhwhHWSTaNuwlD
 aAyQ==
X-Gm-Message-State: AOAM531BuB3ulnlmgQz55iAP40yrji1mZUL22dltrcUiJsdD6b0NO8Cj
 927lHxxu/vsONRjXudXAoQaYxg==
X-Google-Smtp-Source: ABdhPJxMXj11Kh1a3Gws8MgNI07g7jqb7ijfxCRxOZWsLlGuifUpvy0E2HI0ITxMy7vkDPywgPM7OA==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id
 k7-20020a056a00168700b004e1045d3dedmr22605477pfc.0.1645498529989; 
 Mon, 21 Feb 2022 18:55:29 -0800 (PST)
Received: from localhost ([223.184.83.228])
 by smtp.gmail.com with ESMTPSA id s19sm14622867pfu.34.2022.02.21.18.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 18:55:29 -0800 (PST)
Date: Tue, 22 Feb 2022 08:25:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20220222025525.wrmmugthxq737yjc@vireshk-i7>
References: <1645459842-1609-1-git-send-email-daisl.fnst@fujitsu.com>
 <YhPUSnQatwz3BFbg@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhPUSnQatwz3BFbg@pevik>
User-Agent: NeoMutt/20180716-391-311a52
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/fsmount.h: remove useless sys/mount.h
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

On 21-02-22, 19:04, Petr Vorel wrote:
> Hi Dai, Viresh, all,
> 
> [ Cc: Viresh, as he's the author ]
> 
> > Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> > ---
> >  include/lapi/fsmount.h | 1 -
> >  1 file changed, 1 deletion(-)
> 
> > diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> > index fa25306..eb98c97 100644
> > --- a/include/lapi/fsmount.h
> > +++ b/include/lapi/fsmount.h
> > @@ -7,7 +7,6 @@
> >  #ifndef LAPI_FSMOUNT_H__
> >  #define LAPI_FSMOUNT_H__
> 
> > -#include <sys/mount.h>
> 
> indeed now is sys/mount.h useless, but we're not sure if there is no wrapper 
> for new syscalls (e.g. fsopen, fsconfig, fspick, move_mount, ...) in any libc in
> the future. Because we have configure checks for these functions.
> @Viresh, was this the reason why you added <sys/mount.h> ?

Right. Once the libc has the prototypes of these routines, most of fsmount.h
will become useless and sys/mount.h is the one that is going to be used.

-- 
viresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
