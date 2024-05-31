Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FD3C25B75
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717144045; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Tq4wbFqSO9yoRviuIk3VACOc67voPPp+aglwcwaj4qw=;
 b=diiNPMaDkVwzEyayk4/iSDc5spMIZGSoIviq0w9u/FApL1e7UmhoNyLWDsWm8OeoTq/wj
 sKcAEIHF2lb6D2lpSvxJ5lLwtlxhED4/tzs5nKxP7cu3Hrr0YPrFcGvdqFuRzm81WZL9J4B
 jD5+xjKTABT+vJ+KMADDpXaoYMZlNrQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B48323D0756
	for <ltp@archiver.kernel.org>; Fri, 31 May 2024 10:27:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D88E53D0732
 for <ltp@lists.linux.it>; Fri, 31 May 2024 10:27:03 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B06960562F
 for <ltp@lists.linux.it>; Fri, 31 May 2024 10:27:03 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso2782144a12.1
 for <ltp@lists.linux.it>; Fri, 31 May 2024 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717144022; x=1717748822; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eEmeLCqzAPyyDLVzbBhRBRHhSA90T149S6tlCeuzT4s=;
 b=SOTrllrCywZAB7bX1wawwzJBkCKHG4gNFvMz/YNwRwHdYdT1IlkgTtHFNh0PAkIb5k
 ZptOD32uCD2DrhwMb32aJlk4TdRJvy/5sId35S29Ntz1Bce6ie8LpfqE/BzmvZRHorwR
 bStyamJqjCfGxtqGeaBKPfEKokT3wA1kIhawz3f1DYpP+8hcSTX91J31BcBe7APvaFJL
 gWwODCWAc1y1+NPNdx+3aPjiMWGCRc4Ju7UYuK1JdlsV4m3Y/p3M7P4fD+tq7D21UQS9
 XnVO1KtKQ2CyUZcCyhF0YZB1b4ApbxxT9hPGhb09qtA3Qs5rvDymB8Jn6wleu/xqhSq7
 Eq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717144022; x=1717748822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eEmeLCqzAPyyDLVzbBhRBRHhSA90T149S6tlCeuzT4s=;
 b=WBh1QMBrrOsZ8affpL4pLbXf8bsSNEXoxhYkgvYIkFEttaAZ5DzKcRxz4Ddo864V4n
 WP85J/X3+lfIv1vOqEf6Tnmkt931jv9da4TDLmlPmFDY+XGJAFir5nUepvvJ2LS2rEOV
 sCR6RThk5aYntVcPnJnMSdpqSvUk/Ne7okgmvUByHxN+5pMUQYLLOYmwt0cbDN6ls057
 3ocj4rW5cvXPWgnGkI2qF82blzaN7e6yhx7GT+ggfKDpUiSl1c0cprBANPxds7FXtL+H
 9cXM/C7iCMqc8qdp8q0pVSaTLHFTzqzSBT/CkLoU1EO9ZNBjaOvYCGwMaBbpQc+QZs+t
 9c9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUihUfiRIGaOTAiGGqdHYGrwqkYjuLDQhmjPT8MnLiEr0T0QkR+PvBtqGADcCG/U9fJO6TyccoMCqaUK5Pak/AmH9s=
X-Gm-Message-State: AOJu0YzNECtBoD2/ShnYo0VvpyfuRzncBxt7Un+SktxNGGA7E7fAn9p/
 Dkuyu6sDrSm7E+VkvCWGqu0qjFDRTIv1apmNHk6henzRrlJGsMywUZ4MJuhMkrdob4PDRMtOmbJ
 SEjc=
X-Google-Smtp-Source: AGHT+IF8zrp3lbt7URaDB/N/x1Ni/ORX4aG0hHafqTbwrZFYaYO9GCxL3wIfD+0X3QfWazh9Iv3LRw==
X-Received: by 2002:a50:9ecb:0:b0:579:fb7e:2112 with SMTP id
 4fb4d7f45d1cf-57a363c778dmr1144864a12.11.1717144022368; 
 Fri, 31 May 2024 01:27:02 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.46.100])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb828dsm731197a12.33.2024.05.31.01.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 01:27:02 -0700 (PDT)
Message-ID: <e6a9dd37-73bd-461c-9f82-fde658d84ced@suse.com>
Date: Fri, 31 May 2024 10:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-1-fa96f07d0fca@suse.com> <ZlhZiZBUsEnmtwNT@yuki>
 <885f7007-5726-475e-8f34-5554bed7aa1f@suse.com> <ZlmDyAiceBB_-2V_@rei>
Content-Language: en-US
In-Reply-To: <ZlmDyAiceBB_-2V_@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add ioctl_ficlone01 test
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

Ok thank you

On 5/31/24 10:01, Cyril Hrubis wrote:
> Hi!
>>> I suppose that we need .use_filesystems or similar and convert the
>>> dev_fs_type to an array so that we can run this test on xfs as well...
>> This might be tricky to implement, since we need to adapt .dev_fs_ops as
>> well..
> I guess that we need to do a bigger surgery and put all the device
> related flags into a structure, e.g.
>
> struct tst_fs {
> 	const char *dev_fs_type;
>
> 	const char *const *mkfs_opts;
>          const char *const *mkfs_extra_opts;
>
> 	unsigned int mnt_flags;
> 	const char *mnt_data;
> };
>
> struct tst_test {
> 	...
> 	struct tst_fs filesystems[];
> 	...
> };
>
> That way we can specify all the options per a filesystems. I can try to
> do prepare the patchset next week.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
