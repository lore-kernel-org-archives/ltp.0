Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79073C7EE30
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751369995; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4OpKitapqzHV6LwPWFH3U1jNO95kSyeV2/nauac0SXQ=;
 b=TLOV5w2sTSHXyT0hJWfiUtLg8GK2wg0RI8jkX2+tu20oA9lfWK8mZ3IhCrqvy6c6MEL+j
 bKwm6kz2JQ6dVc7KOrJRjV/Mc2BxjXQcxEIHsF0Xj4FqG5uT7K9E3+Q/BdWkUvbee7oVJ0d
 LFYjPf3NFOmpCegIHgeMqzdILR4x9Cs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5EE33C7420
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 13:39:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23C133C7113
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 13:39:34 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EC45200905
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 13:39:33 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so38787035e9.1
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751369973; x=1751974773; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jzFpN9Ol6peHvbDik2WqPlv6zaqyTKFpinSen+jMdms=;
 b=YPSKboKFvW8DbKHkH0QQryx6lup9eEb25wxUx3F9g1/oU13JzeRkUL5OWY2pjxB6f6
 31aOPf6qj2YFD+8NHUAvookfzIuUJesFPTw2mr2oVYhxb5hnOpL1K9CuCIvFGPCcEW7k
 qfhlVrfKErYlcarsQaAiWfg0pUx3PXk7bupKy3YEXD5CrU7EawWoVolmiXU1M4xWHl4i
 NWpbYJg4IeK87PWCgkMeNjHYsCe74J9KCUA3fYi785xIdBV4JU9c78C/VoMjudDS4AsA
 JKgSmzTYURs88KYRHhQKFEUYMjexCSg5jVhRrQ4G2bifGaVhGnEfkgxLB+IEG1t/G25o
 w2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751369973; x=1751974773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzFpN9Ol6peHvbDik2WqPlv6zaqyTKFpinSen+jMdms=;
 b=Dc0LJ9W5jwTBQfimeefc2ItL/H/1zzlrcTxUldstOyvWjYVFQOb1Ch1bThSHPyB/i7
 6jAj+caeuR8pATF75bZM3AYBavibnCEBnYTBTco1NM/C8AsMXrnkViWnyad7cq5pmHAm
 mcOwnGA0sKwb+CGlwi9Yfm84jstK/M83JvDWCmn8haIfszUEJjT3f3r0MUyuj6FBzRVG
 /lRGzQFC36hUW1K8EjfIMNZwBxPqEsk7QnI/Rc1+KXesvBY6ud5AbEcE2G/R/hcXT48B
 VGocT3xyUsLRg4R6gnV0XfeN4vNk41TPtlQZknqqagwHxIC8q5Dg12GB3ho6V+JDstXQ
 4YtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCSbRT8UBSH0NBda4LEbqqamS0ZFdzAebb8i+vmY9Pv92SoSRG9aTUJTAm0jmr7bRKdU8=@lists.linux.it
X-Gm-Message-State: AOJu0YytIVKmXEpUtazDVeptMXeN3BGZes5sQ4kTxxKYa2WGHDE6ph75
 v07buCD/KLNW536qhU+1o6fibJt2xed+dJspOSWKWnRKY41wu5j1T/FqSTD5rqH+INrSXpHuXVC
 Oa+sezYY=
X-Gm-Gg: ASbGnct+E1oWreRIHtEBkkLO0vPqTi5kiLwMOVOnimPNvBNSY/o/8HamD9kfwVADdef
 CwAjfFgMKryqK72eTxsPYs0a1eeruQqDXIw1dYsO5ODFnYugiRX39/OUzPQLVuk1R/PaHfllbkF
 0t3hsxbfjCLW8A0TH4et4mtEqwPpwi6R8w6hm8WdIJ6HjLeBV7DwCilkxfRY761hbNkUtUmFXgp
 9YoWHEMlJr5awOe2JHBX1gZEAIDjN1yp7LfcK6M6RPIhTvJTIVDIdjsyDzG+DsE4M8nIPOziVlb
 BzzdqMqO+36sJqvxnXqtx9yVklKhA/IaW2cr0nUfFDB0UAm3fSwXgN+Jv08ZsNJvjOTPGWR4Owj
 NZ2Ftq5ptOf7gTazjGC0Hv7H+8qMoex3SOfmUwFx4FQjDy1pRf2wF123/WdHxqyE0xde4vDgbMA
 nNa+yGRwiaY/SwkjJ/yrLzQVY3NA==
X-Google-Smtp-Source: AGHT+IG3A/THfZbaed9IEVYrXiWL4eXwfGVJvZn9SNq1rWUd3hzUrEUrWBZDDV4maVnhXQNCRX9UyQ==
X-Received: by 2002:a05:600c:45d0:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-45422f306b3mr21101265e9.3.1751369972672; 
 Tue, 01 Jul 2025 04:39:32 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e529c5sm13276365f8f.63.2025.07.01.04.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 04:39:32 -0700 (PDT)
Message-ID: <c4dc4603-3adf-4da6-b0b2-a464ad453eb6@suse.com>
Date: Tue, 1 Jul 2025 13:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250624-crash02_rewrite-v2-1-c4eaeee8598f@suse.com>
 <39406791-8bbd-4447-bbcd-0b25710a55e8@suse.cz>
Content-Language: en-US
In-Reply-To: <39406791-8bbd-4447-bbcd-0b25710a55e8@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] misc: rewrite crash02 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 6/30/25 3:51 PM, Martin Doucha wrote:
> This algorithm has two problems:
> 1. Undefined behavior if i == 3 && (rand() & 0xFF) > 0x7f
> 2. Except as a result of the above undefined behavior, the algorithm 
> will never generate a negative value nor a value larger than INT_MAX.
I see that using multiple rand() create an issue on the numeric 
dimension. By calling rand() multiple times and move the bytes results 
around, usually generates big numbers values.
Probably we should just get back to the old algorithm. WDYT?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
