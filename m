Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B496EC02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739349039; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=U26YozbJUFReakPaxWOeaJe7WYajg6TdQinEm1eryTc=;
 b=Oc1onvDYGs6K8ZZKmYHwlywxMNCVN4gntbaL8NaIxavHJrjojncYeoXXJK4FoIBbAHx4z
 +lz/qFj0pOksqjODq0goEs3hGzSSKS/F2g7egJXswPkroWqMsAnR0KVCY7u0E6eDS6c+0j3
 Aaj8KFYCBlfSWgxu00QxJw94r85yLzU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48E103C99CC
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 09:30:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C8893C98E4
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 09:30:17 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 53B891A0239E
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 09:30:16 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43937cf2131so25458395e9.2
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739349016; x=1739953816; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWKvfLvRk0HRC/d2luKc0uzblGoye+c9YNnW08SFAmU=;
 b=MzQzq02kj6m9RYnMZxZEkEy8KWHrH9QzYRGTXog8N2cVV9Uonz323EW5cNzX5OqmUV
 8YPJpclz02qZCGcnKnklmIVuTh4+EgWVJ1jME0Ea4dTrJhvALymBkN8z+jvrdMT+xSyX
 xEzddim0M7PlTwlVqEs+yzC364YBtCCmfsxKT5PS3iMmiMbL2mYY6F/HakT0hz1UllsE
 HUE2LU3PV4qFGUK5j5b84Jhu4D4jUP9fa6CotbOFm9r2fmHDe8MhXXDDLLqoVGiCGgQd
 u4E7hMsiT8Dweq2itxp6akOJrb5dWiR4XdUjkxnJGr20nDPIryLnilyib9YCwaWi2+oV
 iH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739349016; x=1739953816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWKvfLvRk0HRC/d2luKc0uzblGoye+c9YNnW08SFAmU=;
 b=ZAXFTqV+OpFgcQZjjUZJHfwLCIA/1JF4rwI+RdX4z51JkhjYFbYUOUxiMbO+SmsMbN
 6eKR9TfT50xG8Cdw3yHDrwz+c96cF8/I7gU+BFSnmtQ3iid9dldTi56/858fNzvPwDfr
 yz8EfrRa2opaZcotrMfs4V0aQcWib/KYlXXX7FxP+nLnMIxFodlOM76idWHf76r5LRGh
 E3dcOLGZm9Tt0PqQwF0ATdUhZToacTdAEB92LWVskupdr5j+24+G6TUgV9v0pC0uzLuE
 UG+W6ah6LybTzTkCnOKvt1QoI+lMOmw7Da7KEwQrQKgZaR2kM2txrqediJJiDqRMS/JH
 HM5w==
X-Gm-Message-State: AOJu0YxRylSbjaT25OLdYSuR77zJSzmxzraeUqbOEQNQG5NN9gwLot2I
 B06NEv4XxPP8opz9akdjuJXHwM4wops5Jkl08kihlxORG5KA/bxgHRRXn7PLHx4=
X-Gm-Gg: ASbGncs8FxWjl1n7lJrnjGmu8cBIGUnxxsi19Rn799bRn3C3OEYS77H0pR07wysxPzL
 r+XR4J89LzqdD4ZvjqrpkyZVWPM5RB+zyaStpJ9bforGPoXUGQou06wSFaLFuWSai8YQb9Y4hkr
 /qTdz/V7jxJ4TejPVyaIBlEZJQnhLKKVgJMCD40mXJQfDhwz8k7r5lrgjBdxYsbomLJCJbKe1R0
 GZEhmqzmddZ0g2I3kJ2+pf3yMF6qW2dfhxci/j1nE4xZWWeVUWThn58Bwrcxb05yL9EP9iWaspD
 lt+UV20nti7EnfRsXPGmmdqdijg+PC7+qOfWzs29KZA/X8zpM42JSdf1WpwAZdiufb6D48yA3Ro
 cxqyJE2WHLuFv8MeuSq6SAm/PpcUAaqFX4iWbi/0dDvjrpPOy6Wg=
X-Google-Smtp-Source: AGHT+IF6Kmj9FkWeTrQvBawPTFRR6CfeqAqelEcLV1r5b62gaaUqI9JW1NX8JsbVjMZwDQymHMBscg==
X-Received: by 2002:a05:600c:45c8:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-43959a43fffmr14704535e9.14.1739349015738; 
 Wed, 12 Feb 2025 00:30:15 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38ddaf333c5sm8857938f8f.36.2025.02.12.00.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:30:15 -0800 (PST)
Message-ID: <399fc494-7c47-459a-927f-1c127e72c439@suse.com>
Date: Wed, 12 Feb 2025 09:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Ma Xinjian <maxj.fnst@fujitsu.com>
References: <20250210091044.359274-1-maxj.fnst@fujitsu.com>
 <20250211215917.GA1954123@pevik>
Content-Language: en-US
In-Reply-To: <20250211215917.GA1954123@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] semctl08: Convert docs to docparse
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

Thanks Peter!

On 2/11/25 22:59, Petr Vorel wrote:
> Hi Ma, Andrea,
>
>> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
>> @@ -1,8 +1,11 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>    * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
>> + */
>> +
>> +/*\
>> + * [Description]
>>    *
>> - * Description:
>>    * Cross verify the _high fields being set to 0 by the kernel.
> @Ma merged, thank you!
>
> @Andrea: I merged this and msgctl05 change even we are discussing [Description].
> Because /*\ is good to be added and if we agree on the conversion it will need
> to be scripted on whole tree.
>
> Kind regards,
> Petr
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
