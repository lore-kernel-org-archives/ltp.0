Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB07FC3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719928960; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=lzagMgY5mqOXAH4uSfU/LmnoJZXsKCjKhJlDhJ7YygY=;
 b=DkCtX+89ElZ+B4MPWKunYjKmtxK9GaItvzEByjX6zW2wPij7RXBEnIQ3tsCbzVPYp+s6i
 MBLGJB2LRlIGabHQEaUFpPgXuL1wwmThaPE7SRMNiviqxJVbMRUOE7h2g6lhqDFZU1/Bcb4
 W80dZ9bI+CrWRe6fsKoOo64NqRRxp4U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D68E3D3ECF
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:02:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65D3C3D0FA2
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:02:19 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97DD4100CD12
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:02:18 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36703b0f914so2671910f8f.0
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719928938; x=1720533738; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AcZIjIt+gJkzF1KuAU8BjuG082TkkdWqxJ/+n4FFESM=;
 b=f0FV/4i0Er7inLe3VmqgfEKT3ZqQ59TiJiO+T7R9yabqL/JmDzX5Xzok2bJU/vImWO
 0/tFwEBSsZqY6lXpru5JUMu/F8TvE7tULnnWPs6BvBxmrKVQqXvY7dEJiw9FhevYLnnd
 W/bkUoX/lKhZ1RHFsenGClxvz26abxCBrpOPzt+S0FJXXO04dTFl+eyPzrFGeVT+K2YB
 2tZIb6Jahhkj9fmFs7A9EZwc5eOB/QJmSunZDMo/gZiIuCxDmGysMu+Q012Emi5BigJe
 0y9kUXppIteShnxVOIJg7NRD9gyWNO+GCWtrN+uZWbrC9x/rikR6ALne/91hcKpctoVh
 u1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719928938; x=1720533738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AcZIjIt+gJkzF1KuAU8BjuG082TkkdWqxJ/+n4FFESM=;
 b=eXLGnzLmsle43JPDP2t3/JenT9e2XgWV2eyHeV2mH2AgehRc4RYzPNC0jK0Z+rM9Gm
 U8D1iZtf/AVWv5P38z5q9yGhOmuR4r63ICCDiDwnK3mrfIGpmlAH/2gY/FaTcL+tLTga
 I/AWte89LLJAb3Ir/G6HXR90dhWq3ejasCgkVNJ8bA0vWmJs/2sXDHTUsfBI5S7qWFA9
 hv3qOyEwfG4dvBWQeTIk0KVZO1+NbzHxqmPalEXWVUIMAqCLXqfarwPFDBDbF44Gj26c
 RmWZV+yM7Z+UQyUs1kRlKL8hfPG4XIJdipntK1UNAkt0O5SGs5Vo5ge7/wXSXP+HLnqy
 L43A==
X-Gm-Message-State: AOJu0YztZxvwIfmShQ/kQnVIdJqz9qG+hpcEQb0lGwsFmJPUXrDWnAE6
 RyqMTXO5Z0X1e1gw+RbdgN79mL/k5KFXslOyYt/5QtH5tVEUp2zh5B3GpG7Uq70=
X-Google-Smtp-Source: AGHT+IFmpbEX2CMdiP/P5RkNc3YOytGv0UOHNwEXiOKgv6jNGfCw1pIvyTiUIoI3z3+S8e/cNmhfeA==
X-Received: by 2002:a05:6000:dc3:b0:367:8fe2:7d8b with SMTP id
 ffacd0b85a97d-3678fe27e7bmr85640f8f.31.1719928937700; 
 Tue, 02 Jul 2024 07:02:17 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10c8ba8sm84883265ad.62.2024.07.02.07.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:02:17 -0700 (PDT)
Message-ID: <e929ef75-1dc9-469c-9e1f-a5505aba3b46@suse.com>
Date: Tue, 2 Jul 2024 16:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
 <20240702-unlink09-v4-1-d8df24772a76@suse.com> <ZoQHSwgeD--VPnAQ@yuki>
Content-Language: en-US
In-Reply-To: <ZoQHSwgeD--VPnAQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] Fix unlink09 test
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

Hi,

feel free to add the modification.

On 7/2/24 15:57, Cyril Hrubis wrote:
> Hi!
>> +static void setup_inode_flag(const int fd, const int flag, const int reset)
> I find it a bit strange when we pass reset flag, since I would expect
> that if we pass non-zero to this function the flag would be set not
> reset.
>
> If you are find with it I will change the reset flag in to set flag and
> reverse the logic before pushing the changes...
>
>> +{
>> +	int attr;
>> +
>> +	SAFE_IOCTL(fd, FS_IOC_GETFLAGS, &attr);
>> +
>> +	if (reset)
>> +		attr &= ~flag;
>> +	else
>> +		attr |= flag;
>> +
>> +	SAFE_IOCTL(fd, FS_IOC_SETFLAGS, &attr);
>> +}

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
