Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C6C433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:19:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304756113E
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 304756113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D602C3C9195
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 16:19:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C45533C2297
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 16:19:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1209B200C08
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 16:19:23 +0200 (CEST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C55CB3F229
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631110759;
 bh=01JdZjTz9NRjjKZ7eE3wBmERacJXaEE50fe7WDLhBj8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=bMHMe/ERuiG733VWohzcjiSYHyrI+ihtAlwWN2u3IjUNjhCIwYVO+3VjU0uHsgJ7h
 flfGNM1Na5vjEhB/R2MTy8t3J1Row9WHE7Fmq25fgfwztMRY9jeYvpZjCI/7So9cMA
 5bFpSK1fXb2KVmy2pt0V7CqkHHhlrhXFS0xMIyqdAD7/thRHItkg9QMAi8qN2/UyP5
 Bd6LNJSsAI+PXVpVxswRZSGeSbHXtJvPsr0T8ny8ne83gComm8dD61UtwmVwoB6nrc
 PJhtqahEFcZmo64GiYJHu1hiIYvOn4UCfanuwYNZ/pd+eEAA0RSBYDuedt+LVe16EE
 ohSb/8x3WdnYg==
Received: by mail-ed1-f72.google.com with SMTP id
 y21-20020a056402359500b003cd0257fc7fso1169581edc.10
 for <ltp@lists.linux.it>; Wed, 08 Sep 2021 07:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=01JdZjTz9NRjjKZ7eE3wBmERacJXaEE50fe7WDLhBj8=;
 b=BeYJVKiA7SEh9e9+jVQTxw+DgisIOE2EIWNRKBmnX3MI6kfOQ5PDtv8+gJNWQb5IHA
 x4W1q7x5xm+pcICqsZsl+DJbKi2GTjM5gLpe5sXuMtt8Lmi1iipiDQ+9FswcjCQGr/8B
 4EDZdpq7Kro252ZzdaTcygafM1hUF2xkdFQc5t63J49itRguTMxdE2xPLGZuUUkqrEQW
 C+P7IDHKGDiChF+fncn9no6LWZDpwIfOjetOndBE7dneD5aCbn95xNRliLBgINvjzywV
 HuSOMc3DZfuPCzsjrFrDEi75q+8NqPX3eW678cD1yF6/0OEr1zEdmrNED/1vIFiOH/1q
 rSaQ==
X-Gm-Message-State: AOAM530t6OjEhZ2gpfLb1w7ceksCFO3vXTQv4VqhYPRi5ReQCepwdRCK
 BuqvnxxS0bgemH/X+qXhO/psO4OCwSEZH1ciSKfRpPE6jukkUeV6dsx+7V30YfLl+zi6tCFXFJP
 UfmIZIVgJcTyfg2c59lLqqVEoWhXoDe3j7mlX4rkoU/FV
X-Received: by 2002:aa7:d40b:: with SMTP id z11mr4179531edq.224.1631110759407; 
 Wed, 08 Sep 2021 07:19:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrwg1UgRrtPjmCXJO/+Z9iMW7KhL2cpiDsDpEj7Bur+TULTtESQO2IvZ57ZujeGhFFzQ07kkatTlEGOTJ5Ng0=
X-Received: by 2002:aa7:d40b:: with SMTP id z11mr4179516edq.224.1631110759257; 
 Wed, 08 Sep 2021 07:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <YTi8qQOZU3NriZvZ@yuki> <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
 <YTjGCeaaA0Nv56hn@yuki>
In-Reply-To: <YTjGCeaaA0Nv56hn@yuki>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 8 Sep 2021 16:19:08 +0200
Message-ID: <CA+Eumj53j-AucdNdJ91-wHO6CN=jNg=kpNpxNwnRwqvbxsWMkw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
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
Message-ID: <20210908141908.gsL0di-KGJBtpncwJBA0X2bO985IchTzmBCgtMy8utw@z>

On Wed, 8 Sept 2021 at 16:17, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > I guess that this is another bug that should be fixed before the
> > > release. I still think that the memory pollution is a best effort
> > > operation and that we should be more conservative with the reserve. I
> > > would go for a few percents of the free memory just to be extra sure
> > > that we do not cause memory pressure.
> > >
> > > If we go for 2% we will add following;
> > >
> > > safety = MAX(safety, info.freeram / 50);
> > >
> > > Also it looks like info.freeram is the same as MemFree: from
> > > /proc/meminfo, I guess that this is not wrong, since memory that have
> > > been used in buffers is dirty enough for our case.
> >
> > I'd recommend dividing by a power of 2 (either 32 or 64) but other than
> > that, I completely agree.
>
> Sounds good.
>
> Krzysztof unless you disagree I will push your patch but change the
> division factor from 200 to 64.


Sounds good. In such case please also update the % mentioned at the
end of commit msg (0.5% -> 1.5%).

Best regards,
Krzysztof

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
