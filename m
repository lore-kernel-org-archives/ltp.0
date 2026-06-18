Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AC4CD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781794660; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=sS6kVINhgPWgJAOl1pANPIvgqEjGyyS7T1TzpYHvyLg=;
 b=dl7jMcD70HSFoHi1cYWmHiTuvjrSxpru/1Rv71F/ItMhaFfIcwWslNez74AuiTC+8+Ahg
 adCw6gK4TNcKgjDSrrefSMHkmjajWUDRg/rL3E6sTyxev91PhJIy9+R5Xj3rLs+4Lmtb8dO
 Z6k33o1kWWUBdisq2xgr2EfV83VpDl8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EB1E3E5898
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:57:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70B793E11C6
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:57:20 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD78560004A
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:57:19 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso12285425e9.2
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781794639; x=1782399439; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dRbhkFjMx1zLA9UIgE3WqJSJSFI3cbMlTDgAyrqJwHs=;
 b=eG7iUwc0tEG6CLQHEZOKh5/3Y4ujScdpjc/OZLe3tnoCivvJbTsle6DdTV0d0bN4g5
 vmkpaFmFH7lIUKsuTIC9atlrHmKlZiUdoy36L5bU+RaXPwhaoeVra8oPvFD+bcTNnt7y
 kCnAFcDsihKU1pM88Bse70MHkM2gal4PFDHSvpXFLidAICg9qMmi+NmCT5QytWWnJzqV
 m7n9I8PN0vzTMjb6yFPV3Udq+jkK2xANNCSZMyftus2COipoxkF1nA7wljEJog0ORGCj
 IbsehaLnHY0NxHOW3/TFP1lsOtPxqoshtq5jeRz/Sa/xgt8zrsrsv4HjdBT6gp+EPPMV
 gSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781794639; x=1782399439;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRbhkFjMx1zLA9UIgE3WqJSJSFI3cbMlTDgAyrqJwHs=;
 b=TtkymNiZgI1MuP7YcOoWl9VlUWIpjK6MdUTQ/MWugRfGTPAYAKAk+sX0g+STP9ejxc
 +AAcZHjvnEcqSxxc55gR9GwvjrQoLxkqWYYoUMI+8U+2KzNd88ee4eem5d4hOZAZfF6Q
 Nf+n5xQfisgenlugHV7SAqjT90CZAi9FIkFxKuzkMJsRzSeLWNBr0CxB0sDuZRNbDomr
 AVAMSG3Zt4l/tsJ7QrePCiKnh/uiELx489/7+dcLjL1nkJUFuKniwXea12cRrK02I4et
 86JcHA82hjTIpYktUcxp3pIBobgBCOa8cUUzP5e4ZcEbM5UzUcwSg9lCXzAD4Ktc/+c4
 5cFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YWCVRsrsGInUnwRfNuBE8yuP394YSbn+Q8UgCR6kOd2VmEtB2Tn0pTAIpOOIGY5der+0=@lists.linux.it
X-Gm-Message-State: AOJu0YzunIPONelW2BWIXk7YbiiKZhtTwwhypqO7OBiSFuR5Sp7Y1eUd
 mkqFaKFMtrYqkl3BrT5XB3z3ZAVUuOfbULMFqFnbZuyPP+7iQM1sdV06PBZLDzgjD5va8WfffAW
 fLKTazxS9EQ==
X-Gm-Gg: AfdE7clKCGfBniVorRceLFscXpRNSqndujftc5NIAHyRvmntYgQlSpRwKzHLnNxuhYg
 jl3Qa0sSs2zKQ3kddyfcQbJX/M1S99EPzNERsM+QD46KZEkFa1RWK8OYYrpuj29M4yOhGNYsh6w
 alGKvXtZB612NMlVYiw5cugPxOV7yVkgo5ohjT4ZXyHn304PJjbIL0OtCwACkCs5SRiCEvd1WiQ
 JQWpQbtZaFTbLiYNLNMljXP/IImX3rJ6yAW/u+oQSxuvKmo0Dpene8/FkR+sAF/4wNFPEn7nQdN
 FPZcF0iY2If8pVUWYwl96AmXnYp4jA0MHJmPD+Hi3hHGVt51eafSXg07vp78qC524kS/q0Drtq9
 13yFQtVFg6qkU6P1tntht0sJKb4jub6mplGhDVOidvTRZMhBFINgeEUssocbESHgUEJHC3jC00Q
 HnYAsoKuGmjDAiAIS1KjzCy1nhGN3crbDwg4hGLDCRQDRLG4JbnGDdvv+JOmOEeQ==
X-Received: by 2002:a05:600c:810c:b0:492:3347:12a9 with SMTP id
 5b1f17b1804b1-4923822defemr63486995e9.26.1781794639003; 
 Thu, 18 Jun 2026 07:57:19 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm65419112f8f.37.2026.06.18.07.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:57:18 -0700 (PDT)
Message-ID: <6a34074e.b3e625ec.17a57c.e0d4@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Thu, 18 Jun 2026 14:57:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> thanks, this fixes the swapping issue for me on s390.

Great :-)

> 
> There is just one remaining problem: when exfat is built as a module
> (CONFIG_EXFAT_FS=m), the build fails because
> generic_swapfile_activate() is not exported.
> 
> Please add EXPORT_SYMBOL_GPL(generic_swapfile_activate) in mm/page_io.c.

Ah that's right, I will wait for kernel devs reply and then point
it out in the conversation. Thanks for the suggestion.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
