Return-Path: <SRS0=fZpt=OP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FEBC433F5
	for <ltp@archiver.kernel.org>; Sat, 25 Sep 2021 02:16:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10B460EE7
	for <ltp@archiver.kernel.org>; Sat, 25 Sep 2021 02:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D10B460EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F403CA1B1
	for <ltp@archiver.kernel.org>; Sat, 25 Sep 2021 04:16:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C4363C4D45
 for <ltp@lists.linux.it>; Sat, 25 Sep 2021 04:16:28 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BFA5E1001713
 for <ltp@lists.linux.it>; Sat, 25 Sep 2021 04:16:27 +0200 (CEST)
Received: by mail-qt1-x832.google.com with SMTP id 2so11355633qtw.1
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 19:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7+8C79LM+kyzmYjMcvgd3QcEpM5uddCSq6cmU81KCIA=;
 b=U7pn30t5nZ8UKHl3UMCazjSYle5iA4baE0dk3BmVjHZOTLVGEH+NihUmVj1ZPVkwif
 2VS8NHTOf5DLi+n0/xLSpaEeFaQYRNVNJFBAZFuqdfIb0dtB8Mzj4g4xRl/pOlKRIGQV
 Hl4XH5PDoYFckxG3J6twbSMqd/hXlbfy5eIOG+KCD8crwmZcgbzA+bAUd9JsfMHIvAIx
 oHwG8PJYb3e1cMnog6KKrd/ygeyBEw8Fo274YEFgGjglHgA/1U6DdunasxSIY5F5g5Ut
 /Bz9jMrf9z4Ms8caeTUoYso7vPJyy6tzpyYzSOds0wT32bDBGyhauWEIgbbNbmOOxL4N
 BkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7+8C79LM+kyzmYjMcvgd3QcEpM5uddCSq6cmU81KCIA=;
 b=ruXFPH76yn2o5iNBTiFEvxJYjQQLFSgO2ixmh1q3jl3lREJoh1L4uMdU7KT/7lwwtm
 iyTRsgcJTPYEIlU+I8NpiNxZGyr0iRG2cDI7Duw81GwAIPztNwaleV3ijxTFtO9Axg5X
 C6TCtPf/mMiBIHTZ+aQfENn4eIdJDcGfI7Q+EaNDog3jKFTui0moEr0f1FwPT28vRVah
 RVixknESCbzZCq3/zCa5V+SUgfb2axhWjGbBPRzFmIiVO3xKXwuFf+oNMYJawfIOvF9U
 aUy4aEyLdnYXHGbpWoQ25oNKq/V4cHScK+voaFA8eNUpadvmjPpPe/7CFadKOz//sEyS
 zQQA==
X-Gm-Message-State: AOAM530wiA9rgDlJoVINw6vjx9IyXug3CClwOYHWpRcXhoPiPfEmfX64
 xXqkrvAMB0eAPdFrsnpt0YgXqw==
X-Google-Smtp-Source: ABdhPJzjvtmOMxbaRLzLtYuw9kjDDx3rZUMkpEWoKeZ0uAcVnp5GoT0Dx7bSJRfpNeUyAOu5RqgbLg==
X-Received: by 2002:ac8:3d51:: with SMTP id u17mr7676627qtf.348.1632536186420; 
 Fri, 24 Sep 2021 19:16:26 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id z10sm6564935qtv.6.2021.09.24.19.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Sep 2021 19:16:26 -0700 (PDT)
Date: Fri, 24 Sep 2021 22:16:25 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20210925021625.GC4029248@maple.netwinder.org>
References: <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
 <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org>
 <YU4YOI4yPufWP9uC@yuki>
 <20210924202601.GB4029248@maple.netwinder.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924202601.GB4029248@maple.netwinder.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Sep 24, 2021 at 04:26:01PM -0400, Ralph Siemsen wrote:

>Well, this is certainly possible, although there are no intentional 
>changes in the kernel (esp filesystems). Only drivers for flash, 
>architecture support, etc. One possible option would be to try testing 
>a generic ARM kernel under qemu, to see if we can reproduce it there.

I am able to reproduce the behaviour under qemu ARM emulation. The 
kernel in this case is 5.4.142 -- a vanilla version directly from the 
stable 5.4.y kernel series.

I repeated tests 1) and 2) in this environment, getting essentially the 
same result as on the actual hardware:

1) LTP 20210524, fallocate05 test passes.

2) Latest git 443cbc1039f, fallocate05 seems to trigger OOM while
    filling up the tmpfs. Here is the complete log:
    https://gist.github.com/rfs613/f58bd803d1119bf30eb723aef4abf1f5
    The tmpfs test begins on line 759

It's getting late so I won't try the other tests right now, but can do 
so later if desired.

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
