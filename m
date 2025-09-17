Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA195CA0EE8
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758112930; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=aB4PqsLEiKWBHUcJrxfPJ/HzGwHIo/MFhMn2XxFNhgw=;
 b=kmvL7p6PI/BCb3w5uZdVsNOSyNDvNfbucNpMXKK2ZgDIvJMdmGmCL9dztCVp02RCm+0T7
 zscn5d1dahke+iopAWYKqVg5lMuqY59yUbuj5gIqWYQ+Ep7BmpIJ/P/s2C5Omqcd7yGWdxs
 +cv6gqFMBwTOgYS3KUtda8z/cw34tHE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2EC23C7F94
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 14:42:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BA343C008D
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 14:41:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74ED91400184
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 14:41:49 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b07c2908f3eso800041066b.1
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758112909; x=1758717709; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqEbTKkSUeLdNek1zz2CRAaj5NmsFKoVvAaFtWQD2gc=;
 b=QYRT10fM9+hRI+ebVRhEqC+o7xt5dSlNZkK0jPk6NV0pY8yZ34ttUclyqTwYJKkl9O
 oQZn/aVLJLfSPpame8yzdr77A/67E1m8eLP8oBmy/oVqcxIcVOdW5vxAvNbuUtNeDAac
 BomuACd3ISo6IeuSOyhlG76M45PmZx07kcmcgG0uYl//zbEk6FSUddomNOnRIl4hnTL5
 CKPZhkiFbQvZwhl8altfN/dwOHrX5J5Yd9zrvDgSr+BcV3xCpKrG/MpUfEstY2sa+IJp
 BneCcRQ2+5UURXa/Izp7NSJO1Vj1dmIKxQJODRSL6zNuOCY6MTgVm8kjBFJXoqvNqOGV
 a5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758112909; x=1758717709;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqEbTKkSUeLdNek1zz2CRAaj5NmsFKoVvAaFtWQD2gc=;
 b=MjvPbviHTStJc7d5Gk1x7gzpuWvNl1ODDYRBEpPrjqYFCe9y2bQp85bk22f5zbb2nZ
 zCukRGvB3ot7Ej5cf+b/14v3vplab1piHJLvax1t9icU2i8UrJCe5UGpHGRt0/+P2GbR
 fXU9zFTkaNs5MvKQf05VEDHbhywqc8Gz1kVogIsd8X3dAV6YG+14adcUmQyDHYNSRFes
 X0FYg+tMYXXOg+bU6pUpbxLsYWfFcaD35c6wXugwVjBXH3oqv5UHpV8JAPod1lFld9OE
 ZcbRmEIt8tWwsKwG6nmMx/34w75vzLX+2MX5/43q5gSQsw6bKzgR+veeHgqjCk3k6n2C
 d2uQ==
X-Gm-Message-State: AOJu0YxuMc6oywoZWbmvlIpdnLkWvIRY9AahiUYLuCWZ2Jg9CfU2WSnx
 /YpKy/DHWLzf7UqcbxthvcH/6hL+oN4RM8rKhsBRmNDFamoTzRIRzNrD7EhhNQmfyDg=
X-Gm-Gg: ASbGncugSvdmvHuJUWCmA50l3teqVv8bQXz79CZAaIDoZiML3W28BYMAp3XEacSFgI8
 WUWCcBx4toe2WIElOSXWk1IALkqc5uTtBa8CYZsM8as1We5j3M5N2fL8kzbj7tYf7z9UCC61J1k
 GupepaH1rQPAretsHFZn5+AJJDbpXni0PemuwfCRjft64lsX4q8Rr9RkcQDqDbTgCEQ9xkUZ6sg
 xD3QqF8pqJm537AlWXLijBVOMq959lD5Ll4P337x3IoRKstO/6B9O9CB2FcCxfQVAlnaBI9ACkf
 ElMb8rR8E3y/mj3XHo0/p2m/+YoecK29naI6ExYKYHIxQ5tmmL0PCzvj6CP8O0Bri+hnjWXj82M
 3uFUqooWOAwr+dbXyO+ipVQbRGHVdrmiE
X-Google-Smtp-Source: AGHT+IEUoRVRamm0BS/vk+yn2sDcKOwKrB06CGkT/nJ6E0EuzZVDR0Tro35iLmTGPm//GFiFXMIc0g==
X-Received: by 2002:a17:906:d54a:b0:b09:d915:1416 with SMTP id
 a640c23a62f3a-b1bbe5ef8b9mr238573566b.54.1758112908810; 
 Wed, 17 Sep 2025 05:41:48 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b19a4c2d3cfsm209299666b.26.2025.09.17.05.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 05:41:48 -0700 (PDT)
Message-ID: <a49c282d-3d37-4f22-a309-7a673c46294c@suse.com>
Date: Wed, 17 Sep 2025 14:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
 <20250902-open_tree_attr-v2-2-b23d2585986d@suse.com>
 <20250917122228.GB343943@pevik>
Content-Language: en-US
In-Reply-To: <20250917122228.GB343943@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] mount_setattr01: add open_tree_attr variant
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

Hi Petr,

On 9/17/25 2:22 PM, Petr Vorel wrote:
>> -	struct stat st = {0};
>> -	if (stat(OT_MNTPOINT, &st) == -1)
>> +	if (access(OT_MNTPOINT, F_OK) != 0)
> Out of curiosity why this change? Faster?

Because in this way there's no need to declare any struct. I will 
achieve the rest of the review and send v3.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
