Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E61ED7B8D
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776157145; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=gq8f/msgML3zA8BCyTZNIcDB5IFahTSgibFfwmUiQ1E=;
 b=X2/lLA5GOby3bUgpi6/jVgrfCys1NspUMXuI3nl57JLLhdo/z9EZLoCgo5DX9/793oyd8
 hwW47Dx5swGFG8+4bjg7OH1vsHwECkI5Ssogj8CUHCu6XWtzOSqy0neNqKpMS9Yb+NWiSEQ
 eofTH6n0xTgWrX9QGPPFBQrGUeC1GTs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D5923E2978
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 10:59:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 360F73C6EE3
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:58:43 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B8549140043E
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:58:41 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfd96354aso3056282f8f.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776157121; x=1776761921; darn=lists.linux.it;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29GoxD8MIGNWWabbfWfDpxchgvGKXfX//bc5wUbT9as=;
 b=NbmIIwsmz+mhodnhF+r2iQRCRCqgM5Rfn8EazHWfc7A2uQ+10ymiTtj+7sb+KBhAMP
 /16cOQFEYREhPUjjGjWZvUu1FuwHY9lCl4jlXQyyYVy34ldvmOJXs6ni2yeuZQGN8Skk
 BEnNf+PkrTbL3NWbV0F8WuDEKyjDddY2XUkU8xCVYFoXDv3KML4nbx3pUT4s0Gp/My5s
 RYxj+6wj7Ll6G55N41pjmoN1fd3ZYsu/dw9s2X7KWnFtIv8PWQIAHZoPQGpPoT3TbDBy
 RV02sb7PmK+nuW5UhZQnUiuAu4Yu9gMQCzkBweUZkHs8cYGrUGsjNGHfvCihZpEDfwl6
 oHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776157121; x=1776761921;
 h=in-reply-to:cc:from:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29GoxD8MIGNWWabbfWfDpxchgvGKXfX//bc5wUbT9as=;
 b=nnKcCbar4Ep2Y3QDRN2LFHrPhx0s+BnC6SImPe8sl0P1xCRIJLvFsUQElKYna7rJCF
 B2I9T9IRtvFPUnmP5+mKoU624FuP5sU3LPB1BRSQbmSs/5ziJ8Toyd14Twmtp1kqf4jV
 oMCzKxXgzFwCDIjkOnwjLIiRj6h11WBdiJ5Oj8lAx6+9S+jKtz9lMxMRAOVXTrrt+mt3
 U0L/LDFYeoVjKXw0DsMa7m7k438eCDTumg3TPggW4mUjWqhJjyLOsNFkzchEyZdkk481
 4BjJHEOaB3LbfUfi6POtlkelTrrgecQ5P7iGt1FRRlAEur0vWim3vzAEkyITxQVRDNXz
 El2w==
X-Gm-Message-State: AOJu0Yz6CQRYlVmV8vVw+P2vQIhjaAO++YBIszg51xJ7OgsMV7gj6bai
 visjmpjYoQ9Mmp5O2T1keTbQGZpDl/IjmPL2knyecZ9QI3qhG9YqJEECtiim52IIit+9HtNM2+4
 wnXAdE0Q=
X-Gm-Gg: AeBDietM/XphC+pLe9MhL61CyeyJaGoXXBDP4hWAG5MmXyEzQcZRg3KK3pTcITtj+L3
 IwmxjcTEAWlv7HMg3Lh+Vhn7c0IMxpg6mSIFOamsic90J6Kj92/HDcpw8Dur0fcFmtb6NdCgfWo
 fqTPnnJK8RsTd5U38BY/sYmVDbF3dg6EBlnWNgTJnQ7RLUdbH2oPso9ZhKIghvI6DZMeRMKRGmL
 4/7E/akpYcL5x7ic+b9DDwMMVJtiDYzqnWwclbT/1DiWap6AZ9Ows86KXYiAUgg+sBX5skY+R8D
 Bc76t8pn1pJ6dJbAa1AaegLEiyJHN4VQi2VGaqDtZMuB3/gf9A+rbvrvNZbEggar0nJ7d4Ky8gn
 nNj8LAKP7Xwf5IW60v9cOU2m6r3D/dcjDl3RE8ZtEGIYqzSzrJ15o2CXyA5ZcmGDEDi+9e80JcV
 Upuc0xrKl98qj+JqAqRx164ErBAB2P8ELTuth/TJo18/v1thTcTN844M6BAj3SVaJmrBO51SFLX
 mGyPQ==
X-Received: by 2002:a05:6000:2082:b0:43e:a70d:763d with SMTP id
 ffacd0b85a97d-43ea70d79a4mr2028011f8f.46.1776157120982; 
 Tue, 14 Apr 2026 01:58:40 -0700 (PDT)
Received: from ?IPV6:2401:4900:891c:dd64:c9ee:91a4:aa73:a65b?
 ([2401:4900:891c:dd64:c9ee:91a4:aa73:a65b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7e61af8csm6725494f8f.34.2026.04.14.01.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 01:58:40 -0700 (PDT)
Message-ID: <bc07e39b-2ac3-486f-89cc-e3e21b0d8fd9@suse.com>
Date: Tue, 14 Apr 2026 10:58:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20260413115129.30239-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20260413115129.30239-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: Treat kernel ntfs3 as a separate FS
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

Hi,

Tested-by: Avinesh Kumar <avinesh.kumar@suse.com>
Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
