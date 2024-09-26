Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF3CDE00F
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727362724; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=L5so31F5Vn0aAb2XVpZpkIx11o+u4vCCU4fTgSMSdXg=;
 b=euhk9qAKgw3fiBfuWr+MW0LCh9jl52KvHQj1XkdYpSoQVt+ysA/83NdMIhWLRaVH8FlMF
 tjiGgFAjlp2o/XBMe4SABDUlMD0UImCa7lLGq4YWmlGT3lpRsr8KsU8qAYIBCTKZ0M/Gmr9
 GKrIxVfJzVclS9Jkhv7xLIXB0n88sH0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF63C3C4EE8
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 16:58:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 801173C247D
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 16:58:24 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF2311A00E08
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 16:58:23 +0200 (CEST)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so18025341fa.1
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727362703; x=1727967503; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MponbkIbR4rjGQK5AMr5aQxzcYDxHmfz59TB6HkW0kw=;
 b=BieFNztzQxK3016KjOV1KdAQQ83EeIi/C+qDY2eis3FOXCJDcq3YyEKeKyEoaCPxuF
 FgH04SraVuvx3UxkWrlA35msn5s/7QH88Xuwpn6gs4+afKT2izC9ll1BDx3YL9Gv5dpm
 37FoYV0gCfSM2PZyL4u0J6iW2mvXm0NvP7CIxcisHTI0UppHEIEaKkB3srRa+8vTPVoP
 UPraxVzBgEtP6VgUOuiBn3kVQCvU9bGAD7DUUiPSbjr0mILgCbvbfIN+7ik8VNCB+rMS
 AvyCDd6/hpHXaxiksN0VKs0R2Z4ze1ShC5dQ2IAhIUeDuVU7Vk0GrBUeq4OeUuxFrzR/
 0J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727362703; x=1727967503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MponbkIbR4rjGQK5AMr5aQxzcYDxHmfz59TB6HkW0kw=;
 b=RvUEXXoJOsfMEbzOhCinP2sO6Sf+TIb7msa+CF3ts7inj5JDyur3oFSMFZ/oiGxHzT
 2rJ4ZS5cYmdEuIvDxFZuVoM/eAXj39OJEpPTOY9ahlGxbMFzjtl2ODztOdaKolBPhuzc
 2gYZhwNxj+k3pBlkuz7iLEItiPqzmuFKWKsmxA7uE7L1XvfB3WI531ehNywcSsfTlqFy
 oF85NOJQmgvBeNlQmZsjYJLmgdjspc7MqmOtFoaxLjB0n3X9m0J6h7DygPPsmHuQ9gUl
 YkoqVrc8ar7hs2p/vMPbMver+k3OtKWQL5fMivDhvX08Pqaj4AoZx91M7Qzxjmz4Ct4m
 uYaQ==
X-Gm-Message-State: AOJu0YwXbvdF+9ecE/SlBr5XLPpd+A48IBZKxEceWUZf1kkBGRbfDr43
 b0BdkB1r5BLsep8aHg0Pku4XcVMEK1iPq7wWiuM2l6i/sWby3FTP3W0eji+BrKQ=
X-Google-Smtp-Source: AGHT+IFBezdLN3TsRVg3VIiyiDQZMKvmveq4yp+VR2HEZjscnKBrk139nQmhMuUzuQutX15FE2aGpA==
X-Received: by 2002:a2e:4e02:0:b0:2f6:2855:5c8c with SMTP id
 38308e7fff4ca-2f915ff8089mr46284001fa.20.1727362703054; 
 Thu, 26 Sep 2024 07:58:23 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.59])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27c5aa0sm7167766b.48.2024.09.26.07.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 07:58:22 -0700 (PDT)
Message-ID: <e28fb881-d48b-4390-997e-a366574b2ea2@suse.com>
Date: Thu, 26 Sep 2024 16:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
 <ZvVMJQhI_4tTFfYB@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZvVMJQhI_4tTFfYB@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix ioctl_ficlone on XFS without reflink support
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

On 9/26/24 13:57, Cyril Hrubis wrote:
> Hi!
>> +static void setup(void)
>> +{
>> +	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
>> +		tst_brk(TCONF, "XFS doesn't support reflink");
>> +}
>> +
>>   static void cleanup(void)
>>   {
>>   	if (src_fd != -1)
>> @@ -106,6 +112,7 @@ static void cleanup(void)
>>   
>>   static struct tst_test test = {
>>   	.test_all = run,
>> +	.setup = setup,
>>   	.cleanup = cleanup,
>>   	.min_kver = "4.5",
>>   	.needs_root = 1,
>> @@ -115,7 +122,7 @@ static struct tst_test test = {
>>   		{.type = "bcachefs"},
>>   		{.type = "btrfs"},
>>   		{
>> -			.type = "xfs",
>> +			.type = "xfs >= 5.1.0",
>>   			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
>>   		},
>>   		{}
>> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
>> index 3cc386c59..8e32ba039 100644
>> --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
>> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
>> @@ -62,6 +62,9 @@ static void setup(void)
>>   	int attr;
>>   	struct stat sb;
>>   
>> +	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
>> +		tst_brk(TCONF, "XFS doesn't support reflink");
>> +
>>   	rw_file = SAFE_OPEN("ok_only", O_CREAT | O_RDWR, 0640);
>>   	ro_file = SAFE_OPEN("rd_only", O_CREAT | O_RDONLY, 0640);
>>   	wo_file = SAFE_OPEN("rw_only", O_CREAT | O_WRONLY, 0640);
>> @@ -113,7 +116,7 @@ static struct tst_test test = {
>>   		{.type = "bcachefs"},
>>   		{.type = "btrfs"},
>>   		{
>> -			.type = "xfs",
>> +			.type = "xfs >= 5.1.0",
> Does this even work? I suppose that we do have a minimal version syntax
> for commands but not for mkfs.foo. And even for commands the version
> parser needs to be implemented for each command separately. We have one
> for mkfs.ext4 at the moment.
This is clearly an error I'm going to fix.
>
> I suppose that we need to add .mkfs_ver string to the struct tst_fs and
> possibly .kernel_ver as well so that we can add both checks to the
> structures as:
>
> 	{
> 		.type = "xfs",
> 		.mkfs_ver = ">= 5.1.0",
> 		.kernel_ver = ">= 4.9.0",
> 		...
> 	}
>
I'm not sure if it makes sense to add this feature if we already have 
.needs_cmd and .min_kver. It's better to keep things simple in this case.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
