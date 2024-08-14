Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27125C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723628192; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=qsGNtHKEXq67Pg6PDHrrE5f4IVpSR7sY+eKHPi+gK4c=;
 b=rKNg8khU5l9Sh5/gGiH4xMOF+wIJ/XZINjosrGs3EgP7oY0yLXKU4noY+571MqqCPzN5i
 C+QJzZLYFjb/0aaL6t7srl0RStA9aChOqkKjDMqfgH+iCoz/i6zkH5zSzUwl/jpkLSmX8Pw
 AZyATTJbZwtZctahaUuwRg2ZenR6RqE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A946C3D2151
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 11:36:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D5463D212D
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:36:10 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A178D140043B
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:36:09 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso645661566b.0
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723628169; x=1724232969; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xh8Q+q0ak5N6LUPWrGQlnLeYWo7Nj/EWzO+H19/9xq8=;
 b=CGN/i6jmhzfkoE8UmjxnCdCnDcOisloWJX7Dbcl7dZK8VVdxYvvl7mfUieDVID6RcH
 +E4JPsoJCjUy0/QBRJyAAWupxXLisyhtMFlfAXMusSpNneo3V6c6pTMcInmHj1uP6G0/
 HVqzhtm/m2jotCT4Eju/O3Z+xkLtbIGC9KSe/3pNxc+eHNGmBAoJQl5EEK0Gd0vfyUF8
 UFIixoseXB9aLg98KFYHxOGNfseTpnj8LUCilff4bgv8kRWDwhuAbfhqYEa36DB5JXNg
 UWbKunBTNQ0DbZygef4FY3jjDsOWSH5BBPhMxgPkHP3yGaDueih5UqFQhOinQ8hGBtDt
 FGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723628169; x=1724232969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xh8Q+q0ak5N6LUPWrGQlnLeYWo7Nj/EWzO+H19/9xq8=;
 b=l9kKytivUtkU400CsdZFY+pq+ZiPB5HNmL1MetTMGcAAPUDK6G8www3zV+Rjjpunqb
 0sa6galZT2D/jv9p0DPjtskHQTCmtzN+kZjmdyMH4Kzrld3TdD63tZYWzfHoXn22LEi5
 q1u6HqSsWyvALrk4342xVOgvqYZdNXZRvLF7L7oV9IKR9qPV3i6bV2IUSdVx1xDC5pci
 d8tMgy9RjfF/S6YqKdl2eAidyoK7kz2WF8JfE1Rt9bmEUC0QnVcnNcgRFQrvW63yOpPh
 g2br+45DeacWjCvZ1XI1qbaG6NlgBKgDRPEg7A23SuiD1vxGUTLv9lPjdl4ifrLvK/vO
 Y4AA==
X-Gm-Message-State: AOJu0Yzuqmq2zqZR5Rct1H2nwdeSGNoPPfBoxzaKJ6GtlvF/0FXqDfWD
 r/kj9Hda0YA7uXrSBvYOb/TUJM/HbW7BFjXTxqHE+3tJ+yNn5jPqg2giXy6keuE=
X-Google-Smtp-Source: AGHT+IHzKdGXk+Zw64AbTaopEHHyZ3YCIxRIi1aarusetg2ROEV4MQ1vQCx05MXKBFIbr3R6z8/lxg==
X-Received: by 2002:a17:907:e644:b0:a7a:9f0f:ab18 with SMTP id
 a640c23a62f3a-a8366c31ea8mr143792566b.20.1723628168229; 
 Wed, 14 Aug 2024 02:36:08 -0700 (PDT)
Received: from [192.168.178.49] ([213.220.144.240])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3feab58sm151028366b.95.2024.08.14.02.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 02:36:07 -0700 (PDT)
Message-ID: <35eaf26b-386d-405f-86e9-ad085c8e9fdc@suse.com>
Date: Wed, 14 Aug 2024 11:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240814-landlock_remove_doc_stats-v1-1-b5821d0bb3de@suse.com>
 <20240814092806.GA521753@pevik>
Content-Language: en-US
In-Reply-To: <20240814092806.GA521753@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH RESEND] Remove landlock from coverage stats
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

On 8/14/24 11:28, Petr Vorel wrote:
> Hi Andrea,
>
>> Following syscalls can be removed from the documentation coverage
>> statistics since we they are tested inside landlock testing suite:
>> - landlock_create_ruleset
>> - landlock_add_rule
>> - landlock_restrict_self
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks!
>
> BTW for these stats, how about generating them on fly?
>
> Take list from glibc sysdeps/unix/sysv/linux/syscall-names.list [1]
> and git grep source code? Or do we want to add them manually to make sure we add
> only syscalls which are really tested?
>
> BTW this list could be also used for include/lapi/syscall/ generation
> (Cyril asked for some automatic approach).
I started to work on it, but I didn't find time yet. When I merge all 
tests for increase LTP coverage I will work on it.
>
> Kind regards,
> Petr
>
> [1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/syscall-names.list;h=7871f93b94d731d26928a3e12e4ca8b88606aad5;hb=2be0572f3a41d5d5a8bb3b2b04244b7c01ac0f58
>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   doc/conf.py | 3 +++
>>   1 file changed, 3 insertions(+)
>> diff --git a/doc/conf.py b/doc/conf.py
>> index ac1220450..425f72257 100644
>> --- a/doc/conf.py
>> +++ b/doc/conf.py
>> @@ -88,6 +88,9 @@ def generate_syscalls_stats(_):
>>           'getpmsg',
>>           'putmsg',
>>           'putpmsg',
>> +        'landlock_create_ruleset',
>> +        'landlock_add_rule',
>> +        'landlock_restrict_self',
>>       ]
>>       # populate with not implemented, reserved, unmaintained syscalls defined
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
