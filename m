Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309B1CEDD98
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 13:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728481964; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Vhgfp7yw6wEI5R2hH/rQ2aGksh9qFrRl2SYwlfBOHSM=;
 b=lBCb1ALHgdxOrwsZJWUGOapc17Cs/9Pb3ITgZphNbX8CT6b4yJSFG399862gqIaqA1Ijs
 XgeKB7Og1mBgGto+G+u5HuedR9CmWmT3RqnOfb7sxQBXYPAmOzUi3zaOZv5SjjuZi0HUmdP
 yhkbhtTl+zT/N9D55nhd4ERhEw67h8g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FD933C3063
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 15:52:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32A363C2F62
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 15:52:23 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 917E3201744
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 15:52:22 +0200 (CEST)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5399041167cso11032466e87.0
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728481942; x=1729086742; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGV+ongfrZoADir0L1BEBa/xK+nZJ+yfE5oM5TSTkIU=;
 b=DcPQyRhZQymFgrbcul8ZskRgj11K9ka6AhbCDnEUHh0EdZcocw2EsA/qsrbQLzj9oP
 fsEvYZPby++Wa5Hq5r0x99hUCZPmJdgJgw0PZEL8rOo0q5qwCsVGSXNxXzLrp08r9AQJ
 pgtwq6gHYExIlm6SrCU2aPpusFQPV7zRcWLRsvsxfBuNwdMjlfXqwmlMTkHCqU80exC/
 8qDTZB13yW8F1gpg7QHEwhife7+6QMVZAZDwqtGb9gNOH05/RX0Js4rcqUSNroUBLXEf
 Y+lpqe8m7T6VI1XC8IrtCW9o8r/U1UZhqQSEsV9K9jpcd5VUqopFEqazsdSFmjbf0OJQ
 Z39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728481942; x=1729086742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGV+ongfrZoADir0L1BEBa/xK+nZJ+yfE5oM5TSTkIU=;
 b=jZSMxi4A2Ap/kVcpXCTfXrC2MReWgxc/41iPMCU6qj54EzGxCAOdO9yzDMdqcVGiXo
 Q+BmDveg3GvBIMR6ljh2rCWPKaSLkgKiMHx/jCpZ8rsZkX2UlZhNdIM91EYFn5rRiPBv
 OTehSsMHC4Bge1Rkqym+VvDhuxGIpn11/aqvRyOOxX3vWNxMxlvO8o3JUPYZPRGbz6S5
 7RhZHg+R+J+n1qECqm74QgUu0+zJeI1bWZeVuFotvbAFaEac6rGaPuuzgJFJuezuHBGj
 ANoLxalqu83WCCvHqcxC7GU3958DtcTvjaoiaTjsN6H6yFNmd+JmiUvFcbRyTndXzSau
 CjYw==
X-Gm-Message-State: AOJu0YxiSKDx2U7dJmHdkb6CeYnL/OOz5OudpOfZB7H5+XfV04wtSv+y
 Y98lauTwWjFjvp7Y2B45EcjIy7yrQOjc04Xcf6fjCvjetoC1fjKK39cfqK9dYEs=
X-Google-Smtp-Source: AGHT+IHDQ4AMJzr6rMxrb+jhIfLmO1SjHOUx7akBmqk3orZrECSb/fOGHvVky5QBVasQms4aRRjL1Q==
X-Received: by 2002:a05:6512:12d3:b0:530:e0fd:4a97 with SMTP id
 2adb3069b0e04-539c4799486mr2438939e87.0.1728481941662; 
 Wed, 09 Oct 2024 06:52:21 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99431f247bsm556918566b.168.2024.10.09.06.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 06:52:21 -0700 (PDT)
Message-ID: <d34f46aa-179d-4000-bff6-cc1f19fcd9dc@suse.com>
Date: Wed, 9 Oct 2024 15:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
 <20241008-ioctl_ficlone01_fix-v4-1-eae3adac33c9@suse.com>
 <ZwZzL9g8iqIweUW6@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZwZzL9g8iqIweUW6@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] Filter mkfs version in tst_fs
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

Hi

On 10/9/24 14:12, Cyril Hrubis wrote:
> Hi!
>>   	if (!op_token)
>> -		return;
>> +		goto error;
> This is not an error case, when we get NULL token it means that there is
> no version embedded in the string and that we should return 0 here. This
> does not cause any problems for us because we do not use the return
> value in the case that we pass commands without version, but we should
> stil be consistent here.
>
> That also means that in all the rest of the cases the op_token will be
> defined and we can use that directly instead of the op_msg.
>
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index d226157e0..4f4a53080 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -1250,6 +1250,7 @@ static const char *default_fs_type(void)
>>   static void do_setup(int argc, char *argv[])
>>   {
>>   	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
>> +	int ret = 0;
> This is now unused.
>
>>   	if (!tst_test)
>>   		tst_brk(TBROK, "No tests to run");
>> @@ -1310,7 +1311,7 @@ static void do_setup(int argc, char *argv[])
>>   		int i;
>>   
>>   		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
>> -			tst_check_cmd(cmd);
>> +			tst_check_cmd(cmd, 1);
>>   	}
>>   
>>   	if (tst_test->needs_drivers) {
>> @@ -1415,8 +1416,12 @@ static void do_setup(int argc, char *argv[])
>>   
>>   		tdev.fs_type = default_fs_type();
>>   
>> -		if (!tst_test->all_filesystems && count_fs_descs() <= 1)
>> +		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
>> +			if (tst_test->filesystems->mkfs_ver)
>> +				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
>> +
>>   			prepare_device(tst_test->filesystems);
>> +		}
>>   	}
>>   
>>   	if (tst_test->needs_overlay && !tst_test->mount_device)
>> @@ -1805,6 +1810,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>>   	tst_res(TINFO, "=== Testing on %s ===", fs_type);
>>   	tdev.fs_type = fs_type;
>>   
>> +	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
>> +		return TCONF;
>> +
>>   	prepare_device(fs);
>>   
>>   	ret = fork_testrun();
>> @@ -1832,7 +1840,7 @@ static int run_tcases_per_fs(void)
>>   		if (!fs)
>>   			continue;
>>   
>> -		run_tcase_on_fs(fs, filesystems[i]);
>> +		ret = run_tcase_on_fs(fs, filesystems[i]);
> I've send a patch that fixes this separately with a proper Fixes: tag,
> it would make more sense if you added your reviewed by and I would apply
> that patch separately...

I already have a patch for it, I will send it soon.

Andrea

>
> Other than that:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
