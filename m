Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E75F94CBC
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 02:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 569E53E28F1
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 04:32:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B72633E1DD1
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 04:31:41 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 169461A0021F
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 04:31:41 +0200 (CEST)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82f1bfc9b8fso2184223b3a.1
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776825099; x=1777429899; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1FHq//HUG24K4mF9U0C9gIe4t74PMV8Cpm0CUrFJzwk=;
 b=bBD0oFu93PtY1+czhNvozAnb9I3w1xfcfriNZJUODV2QZa2SJCrOb2hMct8FqrzEkS
 SVNfqkqCFM1wqGTZJlPFU4EsLkmNJ43uhTPjTT4zZRvjE8MWH0w8obZSJk4+ZsGXMt2i
 c4DO9+1c42ng2TI9E712I3bhtuAsm4zTL3YUo33gKh5FROWtGfKmIHmuWroA0SdFYmgD
 dgNeuJ+fhAHmTk77l/R9fXxU3AmjAsU0mTGpO3kg6PFOgOleTAUOlbwtkKL6Kle+RNi1
 iIT/WzdAUEjl/Gscp68E8FLw7J1VMdbsAd9Giz3yQ/QjtoIx3xY/7PTJJeaWngjIF4ZV
 jN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776825099; x=1777429899;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1FHq//HUG24K4mF9U0C9gIe4t74PMV8Cpm0CUrFJzwk=;
 b=qfMLlCKX3zFb1N2X5CIFTlVHsNqmCO89H+XsXaAJU2hu2Um2sb1kgPSDNgaOsKv5qz
 jaZNe7R0lRKpzGCTbchjKaT9nI/OGj5kCVu52r4Pjom1WxLYd9pQR5rw17kvLfCMNrFd
 C+1H+cTYpOkXmEMvgzcP0cWOYIQyYcr8/9Rm783NdExCF0JYMJT8t6IbEAQf1cA2Ycr8
 ZGQ5+6sZqnmtqeJ9IAeXg8/8Ed4QJ0sH5h2BRyXqTNt58fFXRkDAyt45Gvw6VQoMnNA1
 wICMCwcsHTbh7W6q9YZ6gq9+ePAdUIS/HPKCuExfPokLrSWGNCMET4eh7DApF1qx/vHA
 Yf1w==
X-Gm-Message-State: AOJu0Yyu5ISygIB4crZij0gH6L29xNqwWZABOA+qm1tf3CCzWfCFPrE1
 W1gSEOAbnooFN17Yxwn+MccBLfTDO4ruxYstUoY3KE7ELWEc4IVpMME=
X-Gm-Gg: AeBDiev6WdTqaSPcIG/3+E48/PKWuLDv99jzbpKeELMWlY+h635ZSygSWTHgpA1xIWJ
 Vc10/VGbVGvTzXRldU0LzsQvmWaozKHt1XDM4DhMzHLSVdHk6ZDWwPLV3zcGqm2ROZ9lg7k6AX9
 OmGG/gkd1JvbUEovNtng4UDJw3/wtuwBwEArDUxpe09RxnThTAQuPWYRdjTGCDjPXp+CzfR8zdK
 +u4MFMNhAf09k0sb8Wwp6HcTC/NBKospRyQNH3YeTRJA4C2KKMlh1yydYUKQSNzb9WikpxmNMbu
 YgdZDY9RWQ23MQuLfxF5dZpX3pT/ujyO0SmiL2TIda4cVb+4m1d3KpCFuGBlRynVtypSULJ5G2I
 bvu39mg7GPPqYI2ACqV2TX4cSBsPMFUHHs2LKRgS6VUtW1y5KtskjEYch6jElZTYohlfdXjlAnM
 B3x/oYck0Mt+jVOINQqu/+BMqtlSze+QDm
X-Received: by 2002:a05:6a21:6f15:b0:3a2:dd8a:508d with SMTP id
 adf61e73a8af0-3a2dd8a5ccbmr9315342637.47.1776825099416; 
 Tue, 21 Apr 2026 19:31:39 -0700 (PDT)
Received: from localhost ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797702fbfcsm11575317a12.22.2026.04.21.19.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 19:31:38 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:31:35 +0800
From: Li Wang <wangli.ahau@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aegzBwYNEDupcBQB@gmail.com>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260421130706.14254-1-wangli.ahau@gmail.com>
 <aeeJOUaVAXqkqRfI@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aeeJOUaVAXqkqRfI@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_kconfig: rename runtime_check to
 config_runtime_map
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

Cyril Hrubis wrote:

> > Notes:
> >     Hi Cyril,
> >     
> >         It seems you forgot to add this modification at the top of
> >         the patchset. So I made it for the name consistency.
> 
> I was going to send the patch to the ML but you were faster...
> 
> Anyways:
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thank you, pushed.

--
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
