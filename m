Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8241C433F5
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 15:12:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28636101A
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 15:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B28636101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFE813C9643
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 17:12:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B68E63C8261
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 17:12:23 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E3A3600FE8
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 17:12:23 +0200 (CEST)
Received: by mail-qk1-x72b.google.com with SMTP id b65so36738260qkc.13
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9z/rBIc24V6v6YB/9Gf/83Vvt0GFZG07oZQV0hlLuV0=;
 b=pKsEapGo/uHnGqzda2XSr8zcn40GH64HHY1TTxJM9N+kFtltTEhLestET2LXP5P+vl
 HUqOJmDQtbXZ5vqXz7DZWQeHROgNxZ9s/RVdN4p4O6vjyzt/w55lG4YXTRIwhlPPZfJ4
 2JTF5yQ6joajVj9ThLWyWST9bZ0rONHoGddeuc7sYof0QoRLwQbnNsysLVX2meJu58si
 KWb2QtD5tD9NvYx97cmQJ3dNHjOjwD4C+xDyY9nu2e53Bw5JzvGYKTRcCO/KqX3k3LYo
 f/co3LeOD7XOeLJrIW0XXsagATF1sNvj+G3W9bXHDH4BNUv89lAVlSzGL+qwU5OCb2e0
 kwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9z/rBIc24V6v6YB/9Gf/83Vvt0GFZG07oZQV0hlLuV0=;
 b=LSxo9DRCeUbJHVyRQdsZW77XzzsfyGcMiJB0aSZydJ/7pvvhChJhRp1SBXvrJQyY42
 5B+DOXC1/+PVZ5tcmz/eHjQ3jwzzf/YGtF1likZW+1ZL6+5rQDMQ8L5YNyjO24fhM+nM
 +90wVSldoQaoyYD9K/cDkQY1heaJv5P6t9je4fK4afZqA3AG6WBtUbDgonCOKYpCdYJF
 wBEB/Op25WA7kEw11FKUtcgUZqSt0TQHhQvO07KEwEa+P6YpTFfC7Lk28/aPsnEfFl7v
 Xl3LobpM0Gjh3FgtDvIIvNPoxM7uWl+6kyhgBSaVs/bYLlEUt4GbGSutUFI1EFr+Op8U
 xMww==
X-Gm-Message-State: AOAM530Ax6YqsY4oL5Q2mvTbg4vMBxOGi5FNYnGZSTPh29VadQwlK00r
 j2aPFWXPUBY4rx34fCZaD/NrRQ==
X-Google-Smtp-Source: ABdhPJzntNpt0/3SXli/2uU4XAsgJjeFnQ8LQO1iQvEenCLEnWsWFjOpNsijrGbIeZEXMRcbMixfiA==
X-Received: by 2002:a37:951:: with SMTP id 78mr487012qkj.244.1632755541963;
 Mon, 27 Sep 2021 08:12:21 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id p17sm12732337qtl.52.2021.09.27.08.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 08:12:21 -0700 (PDT)
Date: Mon, 27 Sep 2021 11:12:20 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <20210927151220.GB4173236@maple.netwinder.org>
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU3fTlVIIUU7Ff3d@pevik>
 <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

On Mon, Sep 27, 2021 at 10:39:23AM +0800, Li Wang wrote:
>On Fri, Sep 24, 2021 at 10:23 PM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Hi Li,
>>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>
>> nit: I'd add Fixes: c305a53c5 ("lib: limit the size of tmpfs in LTP")
>> if anybody searches on Fixes.
>>
>
>Thanks for the review, I added this and pushed it.

I just tested the 20210927 release (commit 12beeda351) under qemu ARM. 
It seems that fallocate05 test is fine now, even with the 32MB fallback.

However fallocate06 test is failing with OOM. It seems this one still 
contains .dev_min_size = 512 , should this be removed?

Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
