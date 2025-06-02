Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46051C54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748870365; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=t/i+OiWNa0g2nLVmYi5Yjf7nb88+zXLx1azF2kX9hLA=;
 b=MFw9blB1oWrauG9ZW5apB2dOC/ceMcXqaO69DA0u9GrQqYt/ZVtK8aXLNxK9E0j0CgdlE
 HsRm6o52YUshuY9vZ76maees2WOIWmnPAEc5zowCMjHrRSorY4O6RvTA3wMc/If2c+rPSJE
 6viqbhyf+zjVV0cbufrqAf2Q9NuTCHA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95F883C9D37
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 15:19:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D36283C9969
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 15:19:04 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 725FC6008F9
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 15:19:03 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450caff6336so25557795e9.3
 for <ltp@lists.linux.it>; Mon, 02 Jun 2025 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748870343; x=1749475143; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTdo2wBiMfPumMlojh8l1F3vtcRLMaGRw1t8XNoPhQE=;
 b=dw2UmH79d4L/YVhn1Y3H0zYkkT0PHc41xIsaZYpkeTRb1tuS45qxu5SxtS1ROGTCZO
 fd+bVdYURdVUdxCAqa1Dp71ma/OeJ9H/+kgzK/eCZveSuK0vTRtzD0xVWY+M5vRujSN/
 5AA6UnyVgnfARSWDuZbw2zH5KySFw9gF1lJxSMkZkIMPTWgHOgT+D0RRC4JtNnCN7soZ
 qdyqAT1JZnS6oMOm3dht9l62BK1cUm3GF+Pr2XZw/ImwgDhtoiKaBmx4xBsMVcLk6C3h
 4jn+FDhk/oek5GT5RlYgFa84QCBemTQn9JUtQ9vOf/Oi4YEdAUbNSvijxoQoMKF1de/c
 8L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748870343; x=1749475143;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QTdo2wBiMfPumMlojh8l1F3vtcRLMaGRw1t8XNoPhQE=;
 b=g7QGDPuDZkZS1bqMPYHdSlhCFkK3fWnEBx1jtUa3KysNYtC7vd/hjzu1Zkt2IqmLnf
 cOnvZdIjgT20l62iExqL2YGDx4fKWPOVRqN0xhCMF8y7sGnEvtIlhUzhhnjUmX2k72PU
 aDP2xNsfLsckl+NnCs4Pb3YhmOrMKBArasSKxV6Q6khvNHZXEUSy4CDUSIBGf1cBcdre
 CWW3UiN5KJ9yD5tv/xQlyf3dnsQ5seQDbQ3IIz8J5ZdrMCLPwc1GjXdaKiyIVnf8pZxQ
 sEapRrZXTQTY6/vo/8I0SI20WhiZZOg5k+96SW4qCKjapzueXb7xahjYK1FInmvN/pk+
 GdIg==
X-Gm-Message-State: AOJu0YzS0ERoCi/UhmHWSJFNBiI6d8t0QrBy+lp2RhE6ikG3yyzQ4Tae
 dcpYKBanA4OI8MKBWcgITiU3WrIFnXhdNFLdzMlU2Y8LwtpRtFc99VoH9VX8/u6glkI=
X-Gm-Gg: ASbGncvgS/oC3GJ67UOp0IcNuuGbeCsNyrbpCM9iR5JvvJ8MmFY36i8d9DwseGfmq+C
 64RjpDqItde3TqObteJouGBPCYmnf9HZjIbLk/mD3PfFqwZFVVbtHfQZnQoXNXSTWFSYIp9H/GA
 Hz/ozLQLaA9tsNE/d/7ECd5QaLYIlSOb0FmITh1bCOT69GWNXGuSlpJmCPxXZazVUdvSJxJMxqg
 z6oJPxj1yWT+JuXmSalNBZAL/Rq+DfoW6MGSeFdeh/K4dYwqErV0gxd4AJRx9S0dysIsrgjPlWe
 lIEvqLAY4ctNq80bOc+hiMPEiJ0w6mCG1ehpxDPxJvnsdh8svwUrliNYhR+NlTld+GNLpyA3zjw
 4ez2BXlWneG4X8IlsFGoX9orN5W3CGCRmfrY20OJmNtLGaEo2JeB8joDvELl3lzdKiLfo/1+yLJ
 5zxOfPES4+ey7RROZQF5LC0HPf
X-Google-Smtp-Source: AGHT+IHv2VSxHsx7LtktDCNlQyGrU8B7sZiIQ2R8dImKmwghENCa5WedYgYAlt5ILAXeHVIMt8UJtg==
X-Received: by 2002:a05:6000:40ce:b0:3a4:dfc2:bb60 with SMTP id
 ffacd0b85a97d-3a4f89c0035mr9646986f8f.26.1748870342640; 
 Mon, 02 Jun 2025 06:19:02 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d14de5sm70156205ad.216.2025.06.02.06.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 06:19:02 -0700 (PDT)
Message-ID: <79b6bf40-b4d5-4998-af0d-4f0ba3c6fd9f@suse.com>
Date: Mon, 2 Jun 2025 15:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-4-602b7097e722@suse.com> <aD2dDODCBai0Ee-s@yuki.lan>
Content-Language: en-US
In-Reply-To: <aD2dDODCBai0Ee-s@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 4/7] Add lsm_get_self_attr03 test
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

On 6/2/25 14:46, Cyril Hrubis wrote:
> 				next_ctx(next)
>
> Otherwise we will fail the check below.
Right.
>
>> +	for (uint32_t i = 1; i < count; i++) {
>> +		TST_EXP_EXPR(strcmp(attr, (char *)next->ctx) != 0,
>> +			"Attribute and next LSM context must be different");
>> +
>> +		next = next_ctx(next);
>> +	}
> Have you actually tried this on a machine with more than one LSM active?
Fixed, also I think I we to check if "/sys/kernel/security/lsm" exists. 
I guess it doesn't exist if no LSM are present.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
