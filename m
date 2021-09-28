Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD91C433F5
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 02:23:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9448861213
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 02:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9448861213
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E4823CA751
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 04:22:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9290D3C7591
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 04:22:47 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBCE7200B93
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 04:22:46 +0200 (CEST)
Received: by mail-qt1-x82b.google.com with SMTP id j13so18598889qtq.6
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 19:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SbYHx5xfgPeM2de6sicMilKF11vnKZd/g1LWiYGuedA=;
 b=hrxbOcBfdPR8RRM+mSh7Fl7+GeHtXvC6XPasFDRQM04AgqAZJ2O/VlpBahYP8+Z5O5
 SMW8z5+UBd1HFRKZsTrHCV85F1Bby34JU/Eu9BxbUsd8PYb7+7ZWtIhqfkKaHj6BbyM+
 T+d6olauwUI7VT5JwMV4cAPDgoJNBeKhzg3O9zOiR582IJR8MVR+xorGX8gfZMroaObS
 rKIixb7PLT2Rl/OuvA1e+51sOC+T7PCHHx445aUXQvaot7HnO82xApeZ7bYthQz13YjN
 a+7kdvItHmHn+NZvLYdblOP60FYEUM8C6+YsKLcE+uZmdffKzinc1j3sbdu0CFk4XrFy
 5aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SbYHx5xfgPeM2de6sicMilKF11vnKZd/g1LWiYGuedA=;
 b=4pqwDkxQwWaF1fpdX8PFh8lA7kMX/t71KJEeMHMViAFOZIe7pv5PCDlpPfAbkkZjrQ
 ltptcbNco/Y4zhejHvybHRdB9MAKAavAdMHDPr2D+zSzjegG95CyRO/D1PUAmbPNkOOZ
 860P5s8D6KqgxLb1dpgs2BIrWA4dskTcK2HR4qhJ49INU50XYpntbZtpu918dIHUSJwH
 GetZlq3kEY3wXFIBt32DcRW3jb7b5P9qq9XAF/bEezPYpnywauao5lOYU4F0L/UbyqDO
 e8wP7LD9bu76q6rtvHOGJHiQSR3qNZibKOrOTFmDkMYZSRk8c2JFwiz/1IE9LRjCrlwv
 aARA==
X-Gm-Message-State: AOAM533Bgip3T94PelPzMvP0V530EahnaXUHwTcdSzuDVTVFymdfunrH
 RSf7x2rpfYtD3vIe/J0oX7FSgA==
X-Google-Smtp-Source: ABdhPJyjxXhAaP42IBGrt3ULanIhOnJK8u0LMZO7QLUnP3lJE7B/VpmptAUVhZu31zNiXMUtHSPtzQ==
X-Received: by 2002:ac8:4149:: with SMTP id e9mr3148348qtm.249.1632795765652; 
 Mon, 27 Sep 2021 19:22:45 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id j15sm7984199qth.3.2021.09.27.19.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 19:22:45 -0700 (PDT)
Date: Mon, 27 Sep 2021 22:22:44 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <20210928022244.GA2015014@maple.netwinder.org>
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU3fTlVIIUU7Ff3d@pevik>
 <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
 <20210927151220.GB4173236@maple.netwinder.org>
 <20210927190951.GC4173236@maple.netwinder.org>
 <CAEemH2cntaCBq+BJRZiWpBcrzOvzcBdhS-Hz4O1vZstjT6G=mw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cntaCBq+BJRZiWpBcrzOvzcBdhS-Hz4O1vZstjT6G=mw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: adjust the tmpfs size according to
 .dev_min_size and MemAvailable
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

On Tue, Sep 28, 2021 at 09:19:28AM +0800, Li Wang wrote:
>
>Thanks for the debugging. Can you send a patch?

Yes, I will send one in a few moments (and then it's off to sleep).

>> Also, when I remove the .dev_min_size=512 from fallocate06, then it 
>> uses the default size of 32MB, and the fallocate06 test runs and 
>> passes.

Should we also change fallocate96 test to not request 512MB?

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
