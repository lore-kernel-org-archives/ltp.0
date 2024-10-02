Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7621ACF31AF
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727867224; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=CKkDvk6xE8sYDORpiicM7vcrzM4R4Epn1eUrAoOR/m4=;
 b=TTvUcsQgJulc9+tL7Qm2Co42J1kekaCf4mMUBP/ErHWwyOWFYmP1HSOMFtkK72QlCl86Y
 1AhZtCAW40xQ7aWUqwwVfRvag2EuQX4nCbXnpGR9P9xLhRqTxKvGZm6Levnjq7Bdn9qDZXb
 gdrXksX7Z4BP5ohi4xId3WL0S0Eeg7Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A40E63C5A6C
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 13:07:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B793F3C59AC
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 13:06:42 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C6F411BB876C
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 13:06:41 +0200 (CEST)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5398939d29eso5910342e87.0
 for <ltp@lists.linux.it>; Wed, 02 Oct 2024 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727867201; x=1728472001; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFiSZLmBqrsBi6wRRx2PF9VpVddVSN5Wfv/J5sdUZFM=;
 b=FIHUHvvhlDavUqSzO080VHUEfpZtANua8bzze98AZ7YtM4IBeLOMiGpVp5ChrE08hS
 oxgzFUi/XAxjj4S+/GmruYlgAqxC08zpT0Iwk0Ia0VifxObp76Xietj0DSBgYZXS6QLe
 G8CD+hWxw4p2U3dPGFFdSI2AD+XUclS+QvKXa3QEwuZMnMIWnDNE7IgxQNE3k9BcerqH
 FK75FAPbq7x2WHQXxLHy7dHTnxV4hZ09nQ5za732mVCrp3jmB87lqNwmiYLNGUHT/8sJ
 iTP/KARFrHJ2iycqDCTN8xduozTXjQmiJ90yFRo3V9Slb0rcyzfCTLV1qr5RaxracQXE
 1b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727867201; x=1728472001;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFiSZLmBqrsBi6wRRx2PF9VpVddVSN5Wfv/J5sdUZFM=;
 b=NIQz7207Q2Nk5jCej0QLM0+QYzr4PWYw6eTI1uYwPd4RiDVPghAv3T6JSjMKy2ugUK
 EtbPFMfT18QFpmAnJYqRo5tZppYI1DIP4acm36TPdbv+ze6LA2D4OIwDFDioPlB/4i4k
 ZlNy3gNi+e5UvmN6znrMhTn0fFVRfTv7tSWNuK3IYEKIj/exhZyRpbnFzK33FztjQAOa
 wdrvLYc1Ahh1k4ktM5cZyLE+BTJIQ8b7Z+ISc6PLZW++GoY5CyOe+64opUlglCtQPCk1
 WRr5h37anyQMFlklj1tA4NlZE5RvQzPBFVne7UX+ZkHIi3OqyBLwxLae3MkTYlwMcQXZ
 VwKQ==
X-Gm-Message-State: AOJu0YxKXj3mI0y/3dFmHsaxCUUMQFD8andh58EKzbYzetzjVEKQVmre
 1H3vcJm01JWA8lGvKE0y0GSm9bhNpKGH95JLynPBvhTFS4D8N4ECcJCTla0+x/8=
X-Google-Smtp-Source: AGHT+IEuh1rCUIfhIwwNXrGGkW5ob2JGrFC3dy1CcNo1BiHRiIK2bihjfSb2GmQt337GJkSuYs6DTw==
X-Received: by 2002:a05:6512:1090:b0:539:8a9a:4e56 with SMTP id
 2adb3069b0e04-539a07a8298mr1550026e87.53.1727867200615; 
 Wed, 02 Oct 2024 04:06:40 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.40])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be2esm859092766b.174.2024.10.02.04.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 04:06:40 -0700 (PDT)
Message-ID: <998c91c2-e967-4423-aab4-41c28164d63f@suse.com>
Date: Wed, 2 Oct 2024 13:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
 <20241001-ioctl_ficlone01_fix-v2-1-dd0b021dd31d@suse.com>
 <ZvwRRaNplhsVy3Hu@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZvwRRaNplhsVy3Hu@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Filter mkfs version in tst_fs
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

On 10/1/24 17:12, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   include/tst_private.h         |   6 +-
>>   include/tst_test.h            |   4 ++
>>   lib/tst_cmd.c                 | 130 +++++++++++++++++++++++++++++++++---------
>>   lib/tst_test.c                |   5 +-
>>   testcases/lib/tst_run_shell.c |   5 ++
>>   5 files changed, 119 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/tst_private.h b/include/tst_private.h
>> index 6f4f39b15..a29f2d1c1 100644
>> --- a/include/tst_private.h
>> +++ b/include/tst_private.h
>> @@ -40,11 +40,11 @@ char tst_kconfig_get(const char *confname);
>>   
>>   /*
>>    * If cmd argument is a single command, this function just checks command
>> - * whether exists. If not, case skips.
>> + * whether exists. If not, case breaks unless skip_on_error is defined.
>>    * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
>>    * function checks command version whether meets this requirement.
>> - * If not, case skips.
>> + * If not, case breaks unless skip_on_error is defined.
>>    */
>> -void tst_check_cmd(const char *cmd);
>> +void tst_check_cmd(const char *cmd, const int skip_on_error);
>>   
>>   #endif
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index d0fa84a71..38d24f48c 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -262,6 +262,9 @@ struct tst_ulimit_val {
>>    *                 passed to mkfs after the device path and can be used to
>>    *                 limit the file system not to use the whole block device.
>>    *
>> + * @mkfs_ver: mkfs tool version. The string format supports relational
>> + *            operators such as < > <= >= ==.
>> + *
>>    * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
>>    *             device in the case of 'tst_test.mount_device'.
>>    *
>> @@ -273,6 +276,7 @@ struct tst_fs {
>>   
>>   	const char *const *mkfs_opts;
>>   	const char *mkfs_size_opt;
>> +	const char *mkfs_ver;
>>   
>>   	unsigned int mnt_flags;
>>   	const void *mnt_data;
>> diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
>> index b3f8a95ab..35dd71253 100644
>> --- a/lib/tst_cmd.c
>> +++ b/lib/tst_cmd.c
>> @@ -210,7 +210,7 @@ static int mkfs_ext4_version_parser(void)
>>   	return major * 10000 +  minor * 100 + patch;
>>   }
>>   
>> -static int mkfs_ext4_version_table_get(char *version)
>> +static int mkfs_generic_version_table_get(char *version)
>>   {
>>   	int major, minor, patch;
>>   	int len;
>> @@ -228,19 +228,42 @@ static int mkfs_ext4_version_table_get(char *version)
>>   	return major * 10000 + minor * 100 + patch;
>>   }
>>   
>> +static int mkfs_xfs_version_parser(void)
>> +{
>> +	FILE *f;
>> +	int rc, major, minor, patch;
>> +
>> +	f = popen("mkfs.xfs -V 2>&1", "r");
>> +	if (!f) {
>> +		tst_resm(TWARN, "Could not run mkfs.xfs -V 2>&1 cmd");
>> +		return -1;
>> +	}
>> +
>> +	rc = fscanf(f, "mkfs.xfs version %d.%d.%d", &major, &minor, &patch);
>> +	pclose(f);
>> +	if (rc != 3) {
>> +		tst_resm(TWARN, "Unable to parse mkfs.xfs version");
>> +		return -1;
>> +	}
>> +
>> +	return major * 10000 +  minor * 100 + patch;
>> +}
>> +
>>   static struct version_parser {
>>   	const char *cmd;
>>   	int (*parser)(void);
>>   	int (*table_get)(char *version);
>>   } version_parsers[] = {
>> -	{"mkfs.ext4", mkfs_ext4_version_parser, mkfs_ext4_version_table_get},
>> +	{"mkfs.ext4", mkfs_ext4_version_parser, mkfs_generic_version_table_get},
>> +	{"mkfs.xfs", mkfs_xfs_version_parser, mkfs_generic_version_table_get},
>>   	{},
>>   };
>>   
>> -void tst_check_cmd(const char *cmd)
>> +void tst_check_cmd(const char *cmd, const int skip_on_error)
> Technically it's not error, so maybe the flag should be called
> brk_on_unsuitable or something along these lines.
>
>>   {
>>   	struct version_parser *p;
>>   	char *cmd_token, *op_token, *version_token, *next, *str;
>> +	char *check_msg;
>>   	char path[PATH_MAX];
>>   	char parser_cmd[100];
>>   	int ver_parser, ver_get;
>> @@ -302,45 +325,98 @@ void tst_check_cmd(const char *cmd)
>>   
>>   	switch (op_flag) {
>>   	case OP_GE:
>> -		if (ver_parser < ver_get) {
>> -			tst_brkm(TCONF, NULL, "%s required >= %d, but got %d, "
>> -				"the version is required in order run the test.",
>> -				cmd, ver_get, ver_parser);
>> +		if (ver_parser >= ver_get)
>> +			break;
>> +
>> +		check_msg = "%s required >= %d, but got %d, "
>> +			"the version is required in order run the test.";
>> +
>> +		if (skip_on_error) {
>> +			tst_resm(TCONF, check_msg, cmd, ver_get,
>> +				ver_parser);
>> +		} else {
>> +			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
>> +				ver_parser);
>>   		}
>>   		break;
>>   	case OP_GT:
>> -		if (ver_parser <= ver_get) {
>> -			tst_brkm(TCONF, NULL, "%s required > %d, but got %d, "
>> -				"the version is required in order run the test.",
>> -				cmd, ver_get, ver_parser);
>> +		if (ver_parser > ver_get)
>> +			break;
>> +
>> +		check_msg = "%s required > %d, but got %d, "
>> +			"the version is required in order run the "
>> +			"test.";
>> +
>> +		if (skip_on_error) {
>> +			tst_resm(TCONF, check_msg, cmd, ver_get,
>> +				ver_parser);
>> +		} else {
>> +			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
>> +				ver_parser);
>>   		}
>>   		break;
>>   	case OP_LE:
>> -		if (ver_parser > ver_get) {
>> -			tst_brkm(TCONF, NULL, "%s required <= %d, but got %d, "
>> -				"the version is required in order run the test.",
>> -				cmd, ver_get, ver_parser);
>> +		if (ver_parser <= ver_get)
>> +			break;
>> +
>> +		check_msg = "%s required <= %d, but got %d, "
>> +			"the version is required in order run the "
>> +			"test.";
>> +
>> +		if (skip_on_error) {
>> +			tst_resm(TCONF, check_msg, cmd, ver_get,
>> +				ver_parser);
>> +		} else {
>> +			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
>> +				ver_parser);
>>   		}
>>   		break;
>>   	case OP_LT:
>> -		if (ver_parser >= ver_get) {
>> -			tst_brkm(TCONF, NULL, "%s required < %d, but got %d, "
>> -				"the version is required in order run the test.",
>> -				cmd, ver_get, ver_parser);
>> +		if (ver_parser < ver_get)
>> +			break;
>> +
>> +		check_msg = "%s required < %d, but got %d, "
>> +			"the version is required in order run the "
>> +			"test.";
>> +
>> +		if (skip_on_error) {
>> +			tst_resm(TCONF, check_msg, cmd, ver_get,
>> +				ver_parser);
>> +		} else {
>> +			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
>> +				ver_parser);
>>   		}
>>   		break;
>>   	case OP_EQ:
>> -		if (ver_parser != ver_get) {
>> -			tst_brkm(TCONF, NULL, "%s required == %d, but got %d, "
>> -				"the version is required in order run the test.",
>> -				cmd, ver_get, ver_parser);
>> +		if (ver_parser == ver_get)
>> +			break;
>> +
>> +		check_msg = "%s required == %d, but got %d, "
>> +			"the version is required in order run the "
>> +			"test.";
>> +
>> +		if (skip_on_error) {
>> +			tst_resm(TCONF, check_msg, cmd, ver_get,
>> +				ver_parser);
>> +		} else {
>> +			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
>> +				ver_parser);
>>   		}
>>   		break;
>>   	case OP_NE:
>> -		if (ver_parser == ver_get) {
>> -			tst_brkm(TCONF, NULL, "%s required != %d, but got %d, "
>> -				"the version is required in order run the test.",
>> -				cmd, ver_get, ver_parser);
>> +		if (ver_parser != ver_get)
>> +			break;
>> +
>> +		check_msg = "%s required != %d, but got %d, "
>> +			"the version is required in order run the "
>> +			"test.";
>> +
>> +		if (skip_on_error) {
>> +			tst_resm(TCONF, check_msg, cmd, ver_get,
>> +				ver_parser);
>> +		} else {
>> +			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
>> +				ver_parser);
>>   		}
>>   		break;
>>   	}
>> diff --git a/lib/tst_test.c b/lib/tst_test.c
>> index 918bee2a1..7dfab4677 100644
>> --- a/lib/tst_test.c
>> +++ b/lib/tst_test.c
>> @@ -1154,6 +1154,9 @@ static void prepare_device(struct tst_fs *fs)
>>   
>>   	const char *const extra[] = {fs->mkfs_size_opt, NULL};
>>   
>> +	if (fs->mkfs_ver)
>> +		tst_check_cmd(fs->mkfs_ver, 1);
> So this prints tst_resm(TCONF, "...") but then proceeds with the mkfs?
>
> I suppose that both tst_check_cmd() and prepare_device() has to be
> changed to return a success/failure so that we can propagate the result
> fo the check and then we have to do:
>
> 	if (prepare_device(fs))
> 		return;
>
> in the run_tcase_on_fs()...
>
> Also there is a prepare_device(fs) in the do_setup() and I suppose that
> we have to actually do tst_brkm() if called from there, so we may need
> to add the brk_on_unsuitable flag to the prepare_device() as well.
>
> I'm wondering if there is an easier way around these things. Maybe
> putting the check to prepare_device is not the best solution. Maybe we
> should put it into the do_setup() and the all filesystems loop
> separatelly as:
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index d226157e0..55b01ea9c 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1415,8 +1415,12 @@ static void do_setup(int argc, char *argv[])
>
>                  tdev.fs_type = default_fs_type();
>
> -               if (!tst_test->all_filesystems && count_fs_descs() <= 1)
> +               if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
> +                       if (tst_test->filesystems->mkfs_ver)
> +                               tst_check_cmd(tst_test->filesystems->mkfs_ver, 0);
> +
>                          prepare_device(tst_test->filesystems);
> +               }
>          }
>
>          if (tst_test->needs_overlay && !tst_test->mount_device)
> @@ -1805,6 +1809,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>          tst_res(TINFO, "=== Testing on %s ===", fs_type);
>          tdev.fs_type = fs_type;
>
> +       if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 1))
> +               return TCONF;
> +
sounds good to me. Perhaps I just noticed that "ret" value is never used 
by run_tcases_per_fs method. that has to be fixed I guess..
>          prepare_device(fs);
>
>          ret = fork_testrun();
>
>
>>   	if (tst_test->format_device)
>>   		SAFE_MKFS(tdev.dev, tdev.fs_type, fs->mkfs_opts, extra);
>>   
>> @@ -1306,7 +1309,7 @@ static void do_setup(int argc, char *argv[])
>>   		int i;
>>   
>>   		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
>> -			tst_check_cmd(cmd);
>> +			tst_check_cmd(cmd, 0);
>>   	}
>>   
>>   	if (tst_test->needs_drivers) {
>> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
>> index 8ed0f21b6..fbfbe16a7 100644
>> --- a/testcases/lib/tst_run_shell.c
>> +++ b/testcases/lib/tst_run_shell.c
>> @@ -153,12 +153,14 @@ static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
>>   enum fs_ids {
>>   	MKFS_OPTS,
>>   	MKFS_SIZE_OPT,
>> +	MKFS_VER,
>>   	MNT_FLAGS,
>>   	TYPE,
>>   };
>>   
>>   static ujson_obj_attr fs_attrs[] = {
>>   	UJSON_OBJ_ATTR_IDX(MKFS_OPTS, "mkfs_opts", UJSON_ARR),
>> +	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
>>   	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
> These have to be sorted, so MKFS_VER has to go after MKFS_SIZE_OPT. As
> it is the parser would exit with a failure when passed these attributes.
>
>>   	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
>>   	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
>> @@ -224,6 +226,9 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
>>   			case MKFS_SIZE_OPT:
>>   				ret[i].mkfs_size_opt = strdup(val->val_str);
>>   			break;
>> +			case MKFS_VER:
>> +				ret[i].mkfs_ver = strdup(val->val_str);
>> +			break;
>>   			case MNT_FLAGS:
>>   				ret[i].mnt_flags = parse_mnt_flags(reader, val);
>>   			break;
>>
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
