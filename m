Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D31C47DDB
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1706542897; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=NK5uCL884u+B1nsZHQ7Thu63DOoq7ALxBlipgdKoJfI=;
 b=b086mxPkHpJCTGSDwVkkWKDz95Sb7Zv6khEzcqZiKbvhO33ZGHGWicbBYPsU1dpQtNM1/
 mSXYqnbSMybPuOHRhpHvIH42SSWdHE243bWuNqfIYjyrx2hBbVt4YwO1EtC7roeNgwv5gb7
 WMOKKKNqeK1x0HXh6Vv79ZJHbPvdxP0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1E493CE164
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 16:41:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1622D3C1CA3
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 16:41:15 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DEEB2600C7A
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 16:41:14 +0100 (CET)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d0512f6e32so8102691fa.1
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1706542874; x=1707147674; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mvztxD45QfTHrFPD11Zj880fr2EMedL2y2aHEQPPzZA=;
 b=glECWwdjZiUMVWEAH9ayTPzvMNzQbQR5gjXbVeVDYa/Du6d4YcuBd2OnJkai4YQF87
 iwpjmhUxcKk6bqVMdTMpju6ph3GqXIVck9P4NL6OuK6LRvmG7zAogEHi9yEasDtT6riP
 OLdXmSl/P/XqblQubnzgfxQGht3kfRXvIClaZd0gRsGoMC0tV3WJrJ822jDPdb/HncRx
 sTxFZrfRwNzKPqmEK9vXjf29C+H7WstZiKMk+CZnAFrf6OHGjuugPt4u8zJnLiFaFd9e
 VpHj+jFNem1Vith142HNePnqtuAH43WfTTIVAq5mgYo/xYNe+WUA5lMQ5MRIDXI1cGGf
 PPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706542874; x=1707147674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mvztxD45QfTHrFPD11Zj880fr2EMedL2y2aHEQPPzZA=;
 b=U1Cwfl1jTiXT60andZKREc6nCXaPjFDrrgjtu34Rj1MlBEtG9698hdkgEU+OrTmJS9
 DVNisxUlwjw6ZwX0zNuWpC4+zz5nyVMvjtZGgr40mFdOil5wCvjyF//4CsGy2vaJLSma
 vz1kA4ZxBEGVUgkJVt5Aj0ynm5MfwUJKLtHNGRNOhNPYleQEKDVdL9ZlKBNU+spLuFbv
 PVRbSj2pP5pwcL7WA8toOTofzkK/u05l11TJSBc/8xh7SbI89jrT0XMc1p2OExKftGv1
 Ho3YscMwjYRqNRj5BCWjNp4WHxqbyi3i09nUSWFO6Njdv0q9DsPObWP9RNy/GqbOkCwp
 OzMg==
X-Gm-Message-State: AOJu0YzGk1hcJKry2A77XgXB4J1vs6I3l3ocqGpPC7LaiAIizX5TVo+4
 Hlxikx7fSzrYlYtir4IJHnMVMUvLd1GO8dc5vkB0IbrDCoK0ypBUweULXENDb70=
X-Google-Smtp-Source: AGHT+IHCSUqZhO3AGvkawoKFJioD7SX3jt9gXm8GRV9+DqNkX3GxC7DTwIOzan9iiZ9SxMz7dkMndg==
X-Received: by 2002:a2e:a54a:0:b0:2cd:fa17:cc2a with SMTP id
 e10-20020a2ea54a000000b002cdfa17cc2amr4716120ljn.47.1706542874135; 
 Mon, 29 Jan 2024 07:41:14 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUiHjTMcl3bPsCryYA1LW3YLuIS3iYXQ3WgCN2zoylSU6s4qhzOo7r1yL9zme1dQUTOqiAwuyUfCvJH1Ir+RfOV2UpNCo/kuWA=
Received: from [192.168.178.40] ([213.220.148.233])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056e021c0900b0036291d10ffdsm2274772ilh.75.2024.01.29.07.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 07:41:13 -0800 (PST)
Message-ID: <76d62bc7-ce36-45d6-8f8a-bb6602e3e27b@suse.com>
Date: Mon, 29 Jan 2024 16:41:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240129101448.14463-1-andrea.cervesato@suse.de>
 <Zbe9y0MHJZezVeFp@rei>
In-Reply-To: <Zbe9y0MHJZezVeFp@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix synchronization problem with dio tests
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

On 1/29/24 16:01, Cyril Hrubis wrote:
> Hi!
>> When system is really fast processing I/O syscalls, multiple childrean
>> running I/O operations might lock the parent, causing
>> tst_reap_childrean() to stuck. By adding a small usleep at the
>> end of the reading I/O operations, which are used by dio_append and
>> dio_read tests, we ensure that system has enough breath to end tests
>> correctly and to process children exit.
> This does smell like a kernel bug to be honest.
I thought the same at first, but I didn't find issues in the kernel. We 
can take a look deeper for sure.
> Which test is this? How to reproduce?
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   testcases/kernel/io/ltp-aiodio/common.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
>> index 200bbe18e..281072c3b 100644
>> --- a/testcases/kernel/io/ltp-aiodio/common.h
>> +++ b/testcases/kernel/io/ltp-aiodio/common.h
>> @@ -90,6 +90,8 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
>>   			if (!*run_child || !tst_remaining_runtime())
>>   				goto exit;
>>   		}
>> +
>> +		usleep(100);
>>   	}
>>   
>>   exit:
>> @@ -121,6 +123,8 @@ static inline void io_read_eof(const char *filename, volatile int *run_child)
>>   				break;
>>   			}
>>   		}
>> +
>> +		usleep(100);
>>   	}
>>   
>>   	SAFE_CLOSE(fd);
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
