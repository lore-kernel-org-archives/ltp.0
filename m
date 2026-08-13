Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F49C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786650341; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=eN3WWrIRsioNLyzlZXH87/cb9ZDeAHQStWkAQoii+Xc=;
 b=fL4ZktWNHNFZ+a0pwIPNejqI1NOX2IOvWEyFtUKNV4oMu3pU9mHy9fGmWrfWSTQ2FE8Lw
 eZPWDk4x8pAy6yWP2M8X0Y3g0It3PfiBT0+yHtE0E5hCR5qitc+Gw9t5j1ktOidhOgLs1xa
 jAEqyULu2NfXISYrH2ItfZA+grdA1zY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BEC93C6F2C
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 21:45:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E97423C5E07
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:45:22 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36D7C600453
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 21:45:22 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49978908b35so2781005e9.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 12:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786650321; x=1787255121; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q82w1meeNR9o9XoNPK6pbpd5HP47G8GOyOQ5t5/3QQk=;
 b=AEFO1fFmFu4RdGDOF0mqYnqoXJRLuOgz0vIXHWL5XOHgUvobtJPTL+EjFOFT4USDya
 MM2RxF1edWIYygOfVY5+qGQm5yye1VbJvesw9gNCdec0VanhQ4vkvuYnofJjNay6iQPC
 6stzTW/bekwRQ1sfE1oQRn5FKqUKTdmR0+PQt2RVH/TfDAvkRXI7INUIvA0T9TkwHcL1
 UNrnRdkYalLyxhU9IdHunwx1GkhDCT2raXrHSPnMMVOk0V+FT441j0+kzYZLEYXBcQ32
 md3x+wgC2yMY5BHV2gjb5vryPDz3T+UrUtr1xfi/FAY8BGj/8EUu9H5i/6leZ39giqJP
 hkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786650321; x=1787255121;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q82w1meeNR9o9XoNPK6pbpd5HP47G8GOyOQ5t5/3QQk=;
 b=KEbQVRgvoOBdw1vYEf660rDcu+oxv+G/xBzjY6uf6tOEln//A4DWubQ7+Isdtd980g
 UCoqueAjZ0JaYrkVWp465IZUW5CvW6FujkNVGWCmeHXYqAw6NqoarxD7UYvW1C2o3j15
 x9sVtFM4cR0j8hjo2kg4LfaaNsgCnEdepF69hFkm/FuYIRKO/IhqqfhPT5jtoG/Dl8KF
 7H+fuei+wCA5qWQpY2JU7+f4uPTDvh62XkMmUtAueQ/KC/B3FNHWHO0EeN3yFiUl1oXt
 cwSxy16YHmNBMROj16BuV2OE15A9t4UPmhl0f5miK2o+cfBA1ERxOHG2lrsmSn+Cj20t
 SuFg==
X-Gm-Message-State: AOJu0YwqGfOs+b8WAY17ekyWQd5uhfeGGl7RkcKxQ3E7VO0ZyvWYUAaU
 nYEuciGuK8R6LUtHt8bERpl5L58gyl1chVV1px7qZ87NZZ2aH94lRZmrDXe1AGea/Go=
X-Gm-Gg: AR+sD11Zzb02MDUyD7V9TnZdo+B0gZWgMvDJD/UdSG4ToCjSc04w5iOmmebLuC6ODui
 5Btl0NO37jwj0E/KhGy472oZjxsuThCjJQEaSCiqKoYC6CtSF1ENR8/rCYfrDMxk7YpoStjMD3b
 NaTYygBeMUOsthK/El7JcrGmKeA2EmUvUMHTYd77pwjTL/XEEiVm6XTsCpTmgc3QxfPEgBapv1k
 ASXWoG0whPsoYOzb5rZxgIvk1gikq7QznVKboN3ME24LSspBDK5c/2zFeVwmRT5YchHes5zUhNJ
 zUdBIoaXrRoo25dnpaWvYHm3SFgiI9dwLKxXYAQrRaonY63CfthWPRV6yxziEQ75w/h1rKLUjDS
 HZ63iafM1irqqCH81tmUy2+LX9oKlm/BPHOItxE1MHj4i9ux6NuBe0+BlDvYag6rj5871TH8w9N
 l+l9g4QcsGyiMZ9ww/U/6iPEvrIM2hR3wn5XhyChty2UT5wX46hLyr44vR5FqMntAd+CHGiSQ8f
 GjXVA==
X-Received: by 2002:a05:600c:5715:b0:499:5e50:5be9 with SMTP id
 5b1f17b1804b1-499879af71emr7804335e9.16.1786650321510; 
 Thu, 13 Aug 2026 12:45:21 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f20059asm1569335f8f.5.2026.08.13.12.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 12:45:20 -0700 (PDT)
Message-ID: <1e02153c-ed07-4648-b576-528610ba87c7@suse.com>
Date: Thu, 13 Aug 2026 21:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@hygon.cn>
References: <20260813023216.79848-1-li.wang@linux.dev>
 <95979fc4-682a-4fa5-8833-28f9b9573be8@suse.com>
 <20260813062654.GA1801742@pevik> <an1oDw9Q8yp_66Zh@linux.dev>
 <20260813065036.GA1812963@pevik> <an2Kjkp02wyB3B1M@linux.dev>
Content-Language: en-US
In-Reply-To: <an2Kjkp02wyB3B1M@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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

Hi!

On 8/13/26 11:12 AM, Li Wang wrote:
> Hi Avinesh, Petr,
> 
>>> Patch merged! Thanks~
>>
>> Thanks for fixing it!
> 
>> very nit: there could have been
>> Reported-by: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> That's true, apologies for my carelessness.

No worries at all! I've already credited Claude in my
private journal anyway ;)




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
