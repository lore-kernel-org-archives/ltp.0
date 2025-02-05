Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D0C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 11:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738756125; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=NeqPmwIUPnOev0Ox66WKpXmF+TjB8BxKDPCSFs1G2WQ=;
 b=HnKOYiNqBs0KjUMBSYrtAMB4yrm4CLQb8WwYdY/fRK66MjPBVwpebotBmXJfU3QNhvLx0
 GidYcevZJ0ozVeNi5A0uoQtOtvV9gCaMa9fjySVZgWhYybkxIEQO8BeGhkbSJ70PU0V3UEb
 ipW54Y/loCtLVZw3I5G8BPzkUc132EY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E33A83C91FE
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 12:48:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89273C80B9
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 12:48:25 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A9BC121536C
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 12:48:24 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso49534885e9.0
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 03:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738756104; x=1739360904; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XiBy8ZCN8qrVDziLT1AlGKcGgRX2d9PbsOTnFTtpndc=;
 b=BnGL9OS114MiGERh0J0CMlkLSF/DTLR/KWChHL3tQKIle/QY1/knMFePr81BlRrsVb
 7QQOL9HHk2cKfzr9GemzVETfnUbYK1lL/ih5bsYD6Fpf3S8VjzPdo2shHIZCWUc6tWZI
 z/L8W59CCOzmB3tQWTAbl5nH+Z9rj9Vr4FhosWxnFAOUYQzLCOoBMvVmc4pstXxo9SOE
 DEmqRKElgG53sxg5OgKBgmHLLFmPqLUq9J+5RamKo2VK6vGoPEx+Wu1NGlZ5XMiBuJbn
 L9pmPxE3uyJNbMMqXtrovlP0aFtlmAfRsjR/seidMAk+9N7akWPHkn1YWqp+yNvcFeYe
 S9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738756104; x=1739360904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XiBy8ZCN8qrVDziLT1AlGKcGgRX2d9PbsOTnFTtpndc=;
 b=rydrkPQbwNb+QaHvTCJLDtfvJBQMknTGkdn4gloScuVO9mDSzAlYRlVwt+Oa6fMV1q
 gGon/nyVyQkSkCfl32/t/V0fNkz9O4pjl2jZrqLswOxasDhRjZX5iNWsBEevcxX9mTix
 biKKKtk5TmHiBB9pDkIzZYt71eu2KXT6UUl0mkAtRcwrw4jXHGyoU6DYBs5g/9qVu/bk
 8wEo7mXrSqralSGVcFWHU6VfhhCZGmiGABw176UTuLXnqK6A4st89gjrlbfsAjk845iy
 A9r6kmamEsPjJN54Us/ERG4sw8LERjPLwZE4epDcU1wtLJIrwazoJei4TUmFukfbiOx4
 qdDQ==
X-Gm-Message-State: AOJu0Ywsj4AC4t4p6OIR1rc9+ETxeQD+WeNF69pnBiQCincO8zSGPgkA
 E4d+LsKMDw17A5xWwI9QLcW9AchdAOTi5lgLcOVtPTfXDhmvzO0xORgrLgjJHio=
X-Gm-Gg: ASbGncsD0vzKZWRQublypmu9TfY5Uji9bb/1Ozyb5pBv+an0gO960eGdI7TNp5hchif
 Qo60udrOppnp3Aa482UGxwtf1sondvfce36WAEIdUARgs++xpFDTylipUn2Vi6S+AV467NSdLQ7
 r4iBZvfPkU1IxGfqUvhl/K0n2LFjwrAXBqpXZajvIg8LEQ9YL31dMiBlZC1N2N8wOjRGtO8C0y4
 0BRVBWnawz6Dj5JxkuSaMttKkZGTAQ3UEHRmMCZZFugXPQleKdOQSRXY67D+M8SyC4hn8iifCo9
 pqgniZXEaBonfbZdCQNh7GhPXw==
X-Google-Smtp-Source: AGHT+IEfSN+nCVhPQms3bb+Azhq1Sph7ouTMEB4uu3Sv7MqoqE5RIfYux7v+tDZO4N+m830EXDUuHg==
X-Received: by 2002:adf:ff8c:0:b0:38a:673b:3738 with SMTP id
 ffacd0b85a97d-38db48db1d6mr1571791f8f.33.1738756104123; 
 Wed, 05 Feb 2025 03:48:24 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d802sm19493635e9.12.2025.02.05.03.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 03:48:23 -0800 (PST)
Message-ID: <3ba0ff4b-6465-46dd-af32-60a66c6a58e6@suse.com>
Date: Wed, 5 Feb 2025 12:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Avinesh Kumar <akumar@suse.de>, Martin Doucha <mdoucha@suse.cz>
References: <20250205101938.25689-1-mdoucha@suse.cz>
 <8511918.T7Z3S40VBb@thinkpad>
Content-Language: en-US
In-Reply-To: <8511918.T7Z3S40VBb@thinkpad>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] flock07: Initialiaze the sigaction structure
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

Hi!

Pushed, thanks.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/5/25 11:53, Avinesh Kumar wrote:
> Hi,
>
> On Wednesday, February 5, 2025 11:19:36 AM CET Martin Doucha wrote:
>> The sigaction structure for child SIGUSR1 handler was uninitialized,
>> which sometimes resulted in SA_RESTART flag being enabled by accident
>> and the child flock() call never returning. Make sure the sigaction
>> structure is properly initialized.
>>
>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
>
> Thanks,
> Avinesh
>> ---
>>   testcases/kernel/syscalls/flock/flock07.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/flock/flock07.c b/testcases/kernel/syscalls/flock/flock07.c
>> index 652fe3777..368147370 100644
>> --- a/testcases/kernel/syscalls/flock/flock07.c
>> +++ b/testcases/kernel/syscalls/flock/flock07.c
>> @@ -42,7 +42,7 @@ static void cleanup(void)
>>   
>>   static void child_do(int fd)
>>   {
>> -	struct sigaction sa;
>> +	struct sigaction sa = {};
>>   
>>   	sa.sa_handler = handler;
>>   	SAFE_SIGEMPTYSET(&sa.sa_mask);
>>
>
>
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
