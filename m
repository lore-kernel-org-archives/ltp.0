Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7C7CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756469183; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=yr7pmYFTyYw8KyrsGp3wk+5Kxs4uM1PomZgWrk9uFmY=;
 b=mEEim2HBLfICCpAnfl1nDTX1fTX0A8jfN+ww9LVlsy7Kf90AFPOWCAD1mywQ3tVioqWNi
 f0uPvPJQ7+0j+zX8wZEAwvUMa82jacjDhZXVdAHkDJw1s3fV01V0uKtlALjB4yRyiCGHEeT
 EBblt/sy/H0U7PXXEHPGcE/VzamVAfU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 138233CD16D
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 14:06:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E61CD3C4B63
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:06:03 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 35D4660075F
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 14:06:03 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso12272805e9.2
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756469162; x=1757073962; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T514qYF/Y8n6oXNyrfQdA9weeRGV3cMbPqqg4EbK+dM=;
 b=MOcvUVcqjaHHR2FobWXUWkV7yhDYV12UOqm2fw7R0tiAXOVhRsvXAPD/zyalcmXfaq
 F/x+Hfo6dL+5vfgvVftCT3SSV9iv9Hvw//Y3dk/owz8FreWNLRdNKFtdvoe19AG0PcNy
 8yA9hvNkGt5yvWiYgZu0K2p3XggrjjmLCiQsmXK1n6hstbrlD3Nkso+bzgeGDPE8n5ie
 wIcRrdRBN7rQS7MA67h5C702ZOspDJkSkcnHDH/nm+2b3NGymIcndvWPE/6z5zfT3iSu
 /c4mBzlqvPV0P5yTOT2LH0xaOOAJjbH/WKTpz0CgIKjmeLWgqAPtOtOF3NLHBkGQJAm9
 uK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756469162; x=1757073962;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T514qYF/Y8n6oXNyrfQdA9weeRGV3cMbPqqg4EbK+dM=;
 b=J5ytpOnN6ExapAmUvuSKFm14VEqhmH7iITPnK0a5UeKYD9aaDgl4CkXNGoloYXOR+L
 m8GRO5kd0oqOrDwuMQgcmEydYk6xbCiZGYqlou3NxnMEoIQK2unJYQW6Zq1r2kTTRFbT
 li5O/6UjlTIJjPHcl1sI7jnMClM/DZl1QTV5vmj5yA1V7PQe1/gVYA8kOyOoi8j+84ZB
 yA2y4i3zJRxf5F8tHuFz2OmFv7t51dfZYOggdueTCogiITX9G/B+jePPK5lDj5VCvHwb
 PQYYnD6ktHd0DcyeMuDuX7AuB9g7v8b7SHLUXKZxLdgfhgxMffX/noBtryfQgl8Pyc64
 yz0A==
X-Gm-Message-State: AOJu0YxKmNFodzJw5EUy6LPYAMO96LcBznL2O+Xa+owMBA5ZqqQ2NH2h
 MtPEXoc5naPbVbx9foSf5QXtEXGPe9Xjvfzeb+4N8YHzxWvSt7Qq5/2JDmVLvwWLlxU=
X-Gm-Gg: ASbGncu8cfjaKc7lwsCfkTHaxsGapvbqaP8MsugAQ6iVBQFVfboa7YImpq61OuQeXtn
 jisoE0CgKd1mtMT4jVYitv/AU6/3OeCgQAILdMCCplxmUpbPBH+zKzZ68/dCFkiUGGgBhfYWK2P
 KAMso+TYaZOTyaDeQrfUIVFwoHwKOf5oFMNtU159FER42srfmMgfv+MI8waIhTaWhUuH7GWIBZ0
 xqLuhwrViVpw1MoXvYqGokcDI+5RDoU0bK9E10fSmSjtKssgi1dsww6js3HH6Jne8LkJpQ6KWaC
 eLT5h90L74wnO1rSm5Zf8QkR9erVRN+atVVPXeqI8QjQIdL5WAMKcgRsreEo3SVvSB3Yd8CTO7L
 MtJkfGe2jmMAxGTd/Rlt6iessJgGdg/0MuNU=
X-Google-Smtp-Source: AGHT+IGp5LOuA0qXBGwcld+7tW7BLkoPtnbawGCPm/qvqiywHYRoCg8Z603tiNvc0aao8a/8NAzykg==
X-Received: by 2002:a05:600c:5253:b0:45b:7ce0:fb98 with SMTP id
 5b1f17b1804b1-45b7ce0fcc3mr49697445e9.5.1756469162391; 
 Fri, 29 Aug 2025 05:06:02 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.145.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6fe5sm116450645e9.5.2025.08.29.05.06.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 05:06:02 -0700 (PDT)
Message-ID: <191532ce-b780-4f71-a31f-e6dbbb5acd5e@suse.com>
Date: Fri, 29 Aug 2025 14:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
 <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
 <aLDhgFRA8ppAmYlH@localhost>
Content-Language: en-US
In-Reply-To: <aLDhgFRA8ppAmYlH@localhost>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] mount_setattr01: add open_tree_attr variant
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

On 8/29/25 1:08 AM, Wei Gao wrote:
>> -	otfd = (int)TST_RET;
>> +	if (tst_variant)
>> +		otfd = open_tree_variant1(attr);
>> +	else
>> +		otfd = open_tree_variant2(attr);
> I am not sure this is perfect way loop the function, add function point into struct tcase
> is better in my opinion.
That's actually an overkill, considering we already have one variable 
deciding what variant we are going to execute. To add a pointer in tcase 
it means to define a type, declare a pointer, initialize it and to use it.
>>   
>> -	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
>> -		"%s set", tc->name);
>> -	if (!TST_PASS)
>> -		goto out1;
>> +	if (otfd == -1)
>> +		goto out2;
>>   
>>   	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> I suppose we can also check mounts option take effect or not like:
> https://patchwork.ozlabs.org/project/ltp/patch/20250828225157.982-1-wegao@suse.com/

Also this would require a map between mount attrs and strings which are 
going to be converted back again. It would make sense if we were testing 
move_mount, but we already have the attr information via tcase and statvfs.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
