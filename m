Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAB6C55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785482738; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=0fr/DKSL0xyQb+n9w8kvEwl4JXKjLUPm8uwxTCrapZM=;
 b=VE1ZjkBB5e17vtVRqoDeJ7EWK5wYvYHrj734+OdL7vdlNQysvkHF5aoi7N//+oN5gdEP9
 GGPGIEHKh+7hvZiCeo4viEEQvQk+WV8I+0EQTSuWs0vfISPrmw9yly38hyfeBoEMD1RbsHp
 hIpbcuyEH6rnUZjRprobOA8q4vKKU8k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C73D3E2D20
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 09:25:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80DB73E2958
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:25:17 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A8AF01A00A45
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:25:16 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69c7ab350e9so1039993a12.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 00:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785482716; x=1786087516; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TqBdPWwaK4JVxnDUy/u5Gkwn1mPdcEoj+LJFLoEdoJU=;
 b=Y05kWqgCwovgpgdBV7DcIm3jkZ7FbYzp8/EzmLuDOzRevSiMHi7vY5BolXuFQcqWuE
 RD3CLt97kVgGV8THaQgb94bZBXM/LLbDERWTtwiRbNfti3JPVQettq05ptVVasDsRUAe
 pmjauRI1aK5oUhvqjhWUSlk/a6Bqk1YB/ofC3YGdCI5IW8NPzxF/MMQEcfbwhD+/p9b+
 +QtU0YRySjpuRk46e/Fbv7q/mOz+KLFOso38Ikzv83J7bOjvdz4WEqSzzV83e+G0peCh
 peeOCAO4sioWMofXmd47bsE4LeOTtFPjZWMB3dphU68a11lDdF85MFcMrdxWt/0MYMGP
 ZO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482716; x=1786087516;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TqBdPWwaK4JVxnDUy/u5Gkwn1mPdcEoj+LJFLoEdoJU=;
 b=YxQOMAaV4VM2cm0vzUIfnZvBOv8rHjJrvQhROmRL1KA6ZBsYQWssY80e/k7l9zk4xf
 Dh8GBjNXC/p9CWjLaQleuoMoVzzEO8Sf5dsAD/R/MJFP9VBI8VW8WqqlxdqrTouhwtn6
 vGLVrzZifI+MBK3sAJnP2z4Rs8sLy2hGboXa2qRwRfRoJwgtyp9MvKt00EPr5aW5ljQu
 yE0Z4tJPlqjq667cteafx+3HsnhQDjEuUHHDghwXKr1V/2DgHRO2EbGhIcqOMI20Kt47
 x8uio8T+VOZfAQntIozEKg2y+39RxyRVDzRPzAYpxemovR9RpRSpxW1KihBmMuqQUPKj
 Mtyg==
X-Gm-Message-State: AOJu0Yyed7Ni1uakD/01jUCXEZO9GW27FkuBEUzZrxyBGEmPZkuWxPii
 7wm4Uok3S1IUkZKNYoQTJ9VqCcsx9JgmoydxajNe741dki724pGju6mzG+qwcy6j/Do=
X-Gm-Gg: AR+sD12Zqc+y6DmZB0Yti80KQjaR8z3TZbs5v4ai8PNx0BmiMP5Vcbuya7lCMJS6fbn
 jw2cGuLhk2b9jhm4kozMQtxMXRezR+l8cH31MR/K4XwcYkjMobox3MeauGUA7N74TGPlhxdlRIo
 0aiP0eVaAmFNtTv7LrElMYdM0INecx2ArPodEJExHiyL1iAXwDvbIvA2e9O1F3jmu3s4yks521t
 QZs9bow78UWzXq1SL5UpK+mhXGLm3zc+yhs2Y0Jamx6+9uFP48P/XPtzlgCsbXAUU71PDDHIjSy
 BCmTWFnjnxNYwUKRewYnzRUa7pUkk05/BolLZB7jev+Dq31/Z+pBBU9tDwUrn9NHQfEeqrY8O4l
 aQbHNGDHh330OScLjYuRLPNm8NcaiIIyuN5CWJATFdATN33Cnhm6u0o6hH4W4ZcQS0/fu7lF40V
 LIJpIAKRODUton8SMrgVtx4Lv2uM/gCNQr5ctrynzxme0wWIzliGgKp1JPtxID5ESSMuqhYPg0S
 8+tfxlUi17y76og
X-Received: by 2002:a17:907:9303:b0:c1f:bada:4b2a with SMTP id
 a640c23a62f3a-c1fd250d2cbmr40249066b.31.1785482715803; 
 Fri, 31 Jul 2026 00:25:15 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm44028166b.41.2026.07.31.00.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 00:25:15 -0700 (PDT)
Message-ID: <67369208-fbca-4bae-8a24-bb26ae62293e@suse.com>
Date: Fri, 31 Jul 2026 09:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260731054548.133241-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260731054548.133241-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

This is great, Thank you!

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
