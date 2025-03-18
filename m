Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A6C28B28
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742298978; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=QIH5IxdttCIcKA4AWDfQ1Q3417JweaSgvll5tAWkpIs=;
 b=V4wvGQ/FOWz/PkIEW9KP6qXsL9sh/uLrABHPpK4X6iwswkb+xYDOrs0VgfkM5xs4AFxMz
 x1UuNVTSbkj1E4zi2gO/ZXHINY/4yzimvZt+Mr98KL83l5XlxVx66DO7zgrOTbfe/X2pcru
 gjOQ6KA2mscR29cghjBTCRTY8UKtgRs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A28C3CAB21
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 12:56:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D1513CAB21
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:55:54 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C52101400B96
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 12:55:53 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so1626207f8f.3
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 04:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742298953; x=1742903753; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d8M0X+91HRyYLdXapyeUG2KsScEKTEZRa1sBFGSGMSk=;
 b=bwdgthfIIIXxHSxU9E9u9IUHXWE/LvQcFwm/JhQxK5eoga3eA8GgTHkQ5UQ+JFWTsd
 SqtiyOzM6f7fhMzpYnP9z4BpXRAYy2ySj7WNP7BHjutruyg7Gh6TLkWTUSNayR0C5PT5
 ov37Y4uXDKN5HL1g7/kzhGJhb1UW5sqqYVv47cYseIAyyc+0Umm/VUeq8YqEXusI4Ndq
 nl7kSiMSjRcJb1E+EzCU33VWudLe++1b0NXpe2ZVwAkSU9Rq0/7+JWx39TSjvlIcQe52
 /RpJrxx2dVDGm4I65ULkTs9w3GsRywtMlzVH6YDeaJIFV41LwRgSdyrZe/o2AljYL7pI
 d0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742298953; x=1742903753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d8M0X+91HRyYLdXapyeUG2KsScEKTEZRa1sBFGSGMSk=;
 b=m7lXXT2u0RTbKix2xnpLEZhIGbFNH+NJyFbRCbjncuaCVpvCgoz1m/Qryh5sJJ7mFi
 x2tYDhuCzJomaUmLUonepVAQBSg1bH/a/CMP9Ypxras7RuhWBUFEiGBey20SYlEuKywB
 wvjZIpOOJTVA/b7MTfmWTnNsnjGv+u24KT6Vrawl1tXmAmTRjPIFJ6YOdHMQ9ekfjvhM
 bhZboua8rnf5RUJ05EUk6GYhYNDPIgL5UNrnD2QRoE+9Ms/n0Or5F/tmskFKE3n6Ag2B
 0qfkh4zrRAfUJLjKMO8cVSYPwSd6MTb/TISjh3m46lcmhIpTTijAZdE8jK5UIVD6s8iE
 P5yw==
X-Gm-Message-State: AOJu0Yy3c7/OqLzJ4ApwBtQ65pW1ZVIOAllAowkGKi0jk2YL0bEVT3dX
 3nsFGCFwAtLM1YmjTgwkWNS4danc6xU1S3Mz+X5UGXoNvnKUqGb0r6DmJbXLoSYtF5ZrliSlt5+
 24Hknhg==
X-Gm-Gg: ASbGnct1Zw6lR4OBOaz4a5FToIIOO8xw+tZlkxidVZRfT63VpoLAKG8QVxuQp0Bc6lz
 DeOkRRoCPSBzlIEgkVHUVpDcNTUNuvWGkbKGvrx1kUO227iG8phphnbaK+ZnyJnEte8bZAJvmJk
 0JQtCDTg/PLBoeKCZMktXCh9XhpsWVGG9os1osZ6emn6OXETmqu5uynoXAUKvoTf1A/hpnMs3mv
 HP8Dnbb4Lwc452Be8uE5AokeDvEiYM7ZXKuexkyqDQ+Uu2S5/8D0sIOmB7LROxNSzRy5L8wJG12
 FCzeSqoqVdI+dOd76yyYidhQfyUqZOEYEtNv7cEgKfz0iFypuYE1GRBA6aRCWJyg
X-Google-Smtp-Source: AGHT+IFrk5LGG7tOateSli9ykeVsn3ax8cotsUABpHA6ejLa6dDzA2af4siQFS73LEXSrkzLwioJUw==
X-Received: by 2002:a5d:6d06:0:b0:391:2c09:bdef with SMTP id
 ffacd0b85a97d-3971f7f91d8mr14179343f8f.30.1742298953085; 
 Tue, 18 Mar 2025 04:55:53 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3996d998545sm1769415f8f.34.2025.03.18.04.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 04:55:52 -0700 (PDT)
Message-ID: <4f4bc76a-d1ec-40d9-a9ec-b0527682180a@suse.com>
Date: Tue, 18 Mar 2025 12:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250318-fix_mmap_build-v1-1-648618f1df95@suse.com>
 <20250318114934.GA371075@pevik>
Content-Language: en-US
In-Reply-To: <20250318114934.GA371075@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix mmap17 build in older distros
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged thanks,

Andrea

On 3/18/25 12:49, Petr Vorel wrote:
> Hi Andrea,
>
>> Import lapi/mmap.h in mmap17 to define MAP_FIXED_NOREPLACE.
> Thanks for a quick fix.
>
>> Fixes: ac2f330fa ("Cleanup mmap17 test")
> And for adding the reference of the regression (IMHO useful, specially for build
> failures).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
