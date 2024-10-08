Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6A6CEF152
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728387324; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=PpxrjuHKB5miCYnVgz4xEga2f/HFu0gfHkguvOqAdOg=;
 b=K/BRJ/NtjrNDG0A2CD+gMjdu2j39F322GTreZkxVgoAyZ3qdalwx4G4fO4WeQ7DckAxbx
 sSRR7EKm9JtVG+l3xs1Z5iqa6fGE6w+1utFLSa5Zu5ptA81EGU3NGSY5oUGMJFlrxilACS7
 /xUfxhZIMsqHp0ysxeXBvBaAMWlEu3U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A61B63C1B77
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 13:35:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37ECE3C08AF
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:35:04 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 883D11A00922
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:35:03 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a995f56ea2dso249490366b.1
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728387303; x=1728992103; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=STf/JIJ5I8uW9HIWSK3bJscibFNdSc73GZ5FsfEDH1c=;
 b=WltY9Fd1JFRd5/t7jaPWnremp7KLfAeikd6Xos3DEiTuRkaoGiTFpVF3XxhjnEdet/
 RWa0oBKc+1adTQflEV7nosBfc4Tm5s4vIhOk/XU28vdANK/ZmvCKvplMyMVBgXx0jiea
 5vGqnU1NhDojpd0rxidHpoOuUUV0JQ3ZTfBwwFTslHzWA3mOoq99xjduqAWKADcREPn/
 gUt9hFSAK8Qz9/3Fio0wdKxpccRNUbKKFFZVYZZBYmWnBAhG3XMBsgRjo6WFbinSN58r
 6wlQdcaK7U83nFTGLmoUU6UkG/6KC3i5RAM+jZnJGFsHQEuPHAtaktu1+RJXnpHfnY9f
 e9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728387303; x=1728992103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STf/JIJ5I8uW9HIWSK3bJscibFNdSc73GZ5FsfEDH1c=;
 b=kagjLD0UhcLRvAyWLLUpHtJkWF/HMqhQ7LCICvQNetLjEzIaDgH1mOKyBx4BHNIJN6
 MLdG8C9pKc/JSUOcKWknlO08VHUiX7foCO+nbKooulMyBK5P2fTVRF6n0BSNkjiAO2r4
 XmpFng+FaOLCcTo+7LaMZhPCCRUEUsEABin0jP2BPMxX45KI3OLrPZaTCn7vx+jPbKT+
 DPzxsEX+jiCr1B7MvU9w/nXdTTeFpApXub7NN0ylW21LVpZQ9VCzCUjNG8n1BWA4agLb
 J4wevBQBTwEnmmGx6mgb4Z38ZJCK1fX8ugpHTvCJzldiVT2131wwgUImc9PX9XHz/kis
 +OLg==
X-Gm-Message-State: AOJu0YyNuy07ki8kTca/9+PrRLgj/TuJaA0lQu5VOL/hll1m8jrozBVi
 m0m9JuT8KFDbwx9jhqCy7Jb+HD7yVY+K3KK7AGK1ApDG3O+lOnf8h3/hbi0yyac=
X-Google-Smtp-Source: AGHT+IG4u4XuZ3yr9MsLRDJ9/qpzHXx1Nrn7vKBxqdnaGUCkKQmcQB12vShtYlZ5D+qfxflFwRNBuA==
X-Received: by 2002:a17:907:7ba7:b0:a86:7e7f:69ab with SMTP id
 a640c23a62f3a-a991bd477e4mr1633112066b.15.1728387302791; 
 Tue, 08 Oct 2024 04:35:02 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9940410be7sm419609066b.8.2024.10.08.04.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 04:35:02 -0700 (PDT)
Message-ID: <6b2ef410-f979-45e6-98db-22a0c6a5104c@suse.com>
Date: Tue, 8 Oct 2024 13:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
 <20241002-ioctl_ficlone01_fix-v3-2-7e077918dfd4@suse.com>
 <Zv_21V0x0Kv-ViJo@yuki.lan>
Content-Language: en-US
In-Reply-To: <Zv_21V0x0Kv-ViJo@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] Add minimum kernel requirement for FS setup
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

On 10/4/24 16:08, Cyril Hrubis wrote:
> Hi!
>> In some cases, a filesystem that is going to be created and mounted
>> by LTP can't be supported by certain kernel versions. This is the case
>> of the CoW support: mkfs creates a CoW filesystem, while underlying
>> kernel can't mount it.
>>
>> To cover this scenario, a new flag called .min_kver has been
>> introduced in the tst_fs structure, giving the user a possibility to
>> filter out certain kernels not supporting certain FS features.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   include/tst_test.h            |  5 +++++
>>   lib/tst_test.c                | 27 +++++++++++++++++++++------
>>   testcases/lib/tst_run_shell.c |  5 +++++
>>   3 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index 38d24f48c..8d1819f74 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -270,6 +270,9 @@ struct tst_ulimit_val {
>>    *
>>    * @mnt_data: The data passed to mount(2) when the test library mounts a device
>>    *            in the case of 'tst_test.mount_device'.
>> + *
>> + * @min_kver: A minimum kernel version supporting the filesystem which has been
>> + *            created with mkfs.
>>    */
>>   struct tst_fs {
>>   	const char *type;
>> @@ -280,6 +283,8 @@ struct tst_fs {
>>   
>>   	unsigned int mnt_flags;
>>   	const void *mnt_data;
>> +
>> +	const char *min_kver;
>>   };
>>   
>>   /**
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index 192fee309..fe07c4d98 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -950,20 +950,29 @@ static void do_exit(int ret)
>>   	exit(ret);
>>   }
>>   
>> -void check_kver(void)
>> +int check_kver(const char *min_kver, const int brk_nosupp)
>>   {
>> +	char *msg;
>>   	int v1, v2, v3;
>>   
>> -	if (tst_parse_kver(tst_test->min_kver, &v1, &v2, &v3)) {
>> +	if (tst_parse_kver(min_kver, &v1, &v2, &v3)) {
>>   		tst_res(TWARN,
>>   			"Invalid kernel version %s, expected %%d.%%d.%%d",
>> -			tst_test->min_kver);
>> +			min_kver);
>>   	}
>>   
>>   	if (tst_kvercmp(v1, v2, v3) < 0) {
>> -		tst_brk(TCONF, "The test requires kernel %s or newer",
>> -			tst_test->min_kver);
>> +		msg = "The test requires kernel %s or newer";
>> +
>> +		if (brk_nosupp)
>> +			tst_brk(TCONF, msg, min_kver);
>> +		else
>> +			tst_res(TCONF, msg, min_kver);
>> +
>> +		return 1;
>>   	}
>> +
>> +	return 0;
>>   }
>>   
>>   static int results_equal(struct results *a, struct results *b)
>> @@ -1289,7 +1298,7 @@ static void do_setup(int argc, char *argv[])
>>   		tst_brk(TCONF, "Test needs to be run as root");
>>   
>>   	if (tst_test->min_kver)
>> -		check_kver();
>> +		check_kver(tst_test->min_kver, 1);
>>   
>>   	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
>>   		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
>> @@ -1420,6 +1429,9 @@ static void do_setup(int argc, char *argv[])
>>   			if (tst_test->filesystems->mkfs_ver)
>>   				ret = tst_check_cmd(tst_test->filesystems->mkfs_ver, 0);
>>   
>> +			if (tst_test->filesystems->min_kver)
>> +				ret = check_kver(tst_test->filesystems->min_kver, 0);
> Here as well, we should pass 1 as the last argument.
>
>>   			if (ret)
>>   				return;
>>   
>> @@ -1816,6 +1828,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>>   	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
>>   		return TCONF;
>>   
>> +	if (fs->min_kver && check_kver(fs->min_kver, 0))
>> +		return TCONF;
>> +
>>   	prepare_device(fs);
>>   
>>   	ret = fork_testrun();
>> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
>> index ee029b666..6b714c51c 100644
>> --- a/testcases/lib/tst_run_shell.c
>> +++ b/testcases/lib/tst_run_shell.c
>> @@ -156,6 +156,7 @@ enum fs_ids {
>>   	MKFS_VER,
>>   	MNT_FLAGS,
>>   	TYPE,
>> +	FS_MIN_KVER,
>>   };
>>   
>>   static ujson_obj_attr fs_attrs[] = {
>> @@ -164,6 +165,7 @@ static ujson_obj_attr fs_attrs[] = {
>>   	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
>>   	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
>>   	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
>> +	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),
> This is stil not sorted properly, the min_kver should go before the
> mkfs_ver.
>
This is not clear to me. The objects are sorted mirroring the tst_fs 
struct. Can you explain it better please?

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
