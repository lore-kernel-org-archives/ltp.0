Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2FDE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736860709; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=J7RWwLTdBP6IEH9LjpYNMuatMPOfBTogeg2iTOoTsxU=;
 b=EEHThuV0bLfEm2Aa1PczPt1gJrbMF/fJJ9f6aEenxdV+0LSOqrHAeCGxLS8qXtZpT1F3Y
 RFU1YzVLf1fHCLj61Yhx+fJmX8pxgctNNJZO7T11ud43+vFeaE6AuDozF3SKr7QAIKkjxB3
 F/7Dqw01Hv0QuQ7NzRvTMdflSLt2lnQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD6353C7A73
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:18:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58D8F3C7A28
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:18:08 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E8A871BDC58C
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:18:07 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso2860189f8f.2
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 05:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860687; x=1737465487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXP5oYWoq2rBM4WWDmpjfx4/fQXhyVoyM4FGXBs1h/0=;
 b=eGANdNVgBR25bBuEpvn3UTQ4LLXiXuoIpfF408d8qNnNYc5dBFpMi4h5GVAHbRVR05
 2nJlPrCLRxefNWLRHj2yWtq2VRuE1IY9JS5SuQ4ogdE7cwkBUzbhw/NXDnmi9T8OwMK+
 Lf7wNXxdjEcOUl7og5b53JDhO8SoDWNexTcPEvjA5gCT1GOZmNE933k3wzW7eO+bh7Xc
 YWqv+L/7kD7ZPklDKa2p44Xt1ao1iPeuAypQ+IRYAahruWNFCRra1HZ2YqR7Mok1Xp2p
 4bjXI0tLBIeA7/jfgd5kqVg98LFffvsENz0W190Uy6TIDqH/Tyvak5d2dv9VvvtfP6+N
 Dg4g==
X-Gm-Message-State: AOJu0YygdotY0hcO8+fHEeee5Y3/7A6CCQN1Fun3qo+DVtPBotesdZqX
 XWmXTIQ7Xpp1gHkk0quBzR9gqO+hvpSSh37kUPyiCYMpcTHL5ryPUcQIQA2M+PFRtai+Sb9IJHf
 E
X-Gm-Gg: ASbGncs7+kOxcHigFipXlIGrzS2R70vRcOSy6x5UhMaU198bh9TqC7zLZklTixzC93L
 txQThFk7UjSLgs9hgtWp8wb9nf6H9U8kEXEpolMm7mBjp074iVNJrCWi9CxYMXWQitzkelUONPR
 O0xs3v/1zq+8U4HP+wbwAcCmU8X6w1rMANik6gPDe4rOxbDciocAY7k7qjW4cDlZOrvCOYeN5GI
 2SyjGeze5dgWRq+zscKAryQOloejOH2M0EGGkC1MQ==
X-Google-Smtp-Source: AGHT+IG1/kPJwHuDp6zyrPzps1Eeno9k3Ew0arZUF2FZqsGkNn2D0uomNcnlejSVRAz85p727k9KOw==
X-Received: by 2002:a05:6000:712:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-38a87308c15mr22534920f8f.43.1736860687296; 
 Tue, 14 Jan 2025 05:18:07 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad80a525d3sm4971555fac.48.2025.01.14.05.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 05:18:04 -0800 (PST)
Date: Tue, 14 Jan 2025 10:18:01 -0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <cd47v5gs3f3b22fj2av6rjyjyoujm2z5qsbrbqb3mzg3e7p4gp@xgynztdlrmwq>
References: <20250113-tst_kconfig_stddef-v1-1-66c75790d127@suse.com>
 <20250114025507.GA564529@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250114025507.GA564529@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_kconfig: Include stddef.h
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr!

On 14 Jan 25 03:55, Petr Vorel wrote:
> Hi Ricardo,
> 
> > Currently, if a test wants to make use of tst_kconfig.h it must also
> > include stddef.h due to the usage of size_t. While at it, fix a few minor
> 
> <stddef.h> or <stdlib.h>
> 
> Good catch, it should be corrected.
> 
> <stdlib.h> is used in lib/tst_test.c, thus tests have it for free,
> but there are libraries, which load it as well.
> 
> > typos in comments.
> 
> FYI we usually split changes into commits (easier in case of revert),
> but this is, of course, OK to keep.

I'm aware, but when I was about to send I noticed these and figured it
wouldn't hurt to bundle them in :)

> 
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Also, I wondered if we want to remove these includes in files they use
> tst_kconfig.h, but probably not necessary.

I'll do some quick grepping to investigate.

Thanks for reviewing,
-	Ricardo.


> 
> Kind regards,
> Petr
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
