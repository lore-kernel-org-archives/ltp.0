Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78C4C54F51
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 10:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785321668; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=h70Sd9UvBc4WMFAHWm9S7gBRPsgo0UuJHnOyK87uSz8=;
 b=V5r08+i4Wm2yIHJhNS9p6TYpM24RqpOcxu1AKjTfdptpm/6a3PrwbZeCM/09vq8W8GzGz
 fqas5mZIM67KM5lX0w0Xc855rcJo0fL1HoarBvvZme1xmzpAAN+ffq+fcwbjmDTzO5FtS7S
 mAbohC+f8f4JBt9m/XyVp+yy9uwz2Sw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4F63E4ADC
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 12:41:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32BB13D0FDB
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 12:40:46 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1AB4C1400BFD
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 12:40:46 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso3474165e9.3
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785321645; x=1785926445; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K+LHRWzXp7Dq/d+c/ViBIaROgCtsFg30eev3co0orHo=;
 b=WWz5CabDusWTWwVGXmlclChNNgqRtA19DOdJFSOS643c2XjZIkiDVS1TeZJh0VaBpo
 j1wUn0cbE7vl/aGyKBwuvK3ug2F43MieSA7DSwzYw+xXOtKdSLaDhEM/YZQ11nYad+3w
 FXKsOCCU/RrtajA6Pyb6Tmr7HWxEpgfcUieEY56Vw6hOJUlwmFW6I5EqqMVDlidOUnaU
 2fi0tSfP6NDPX91czZM3UXeosInuzU82UAxihyge8TL5D60W/Y2sjRPyQOcA0KXmCZxJ
 vl//N5HdNCDHtRpNMy2KQ0ADJ/6fTLigl8MjKg8ANl7B1uFIuUR2/fpH7wWki8VwGoBx
 3ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785321645; x=1785926445;
 h=content-transfer-encoding:content-type:in-reply-to:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K+LHRWzXp7Dq/d+c/ViBIaROgCtsFg30eev3co0orHo=;
 b=ikd1yjiYhA7Aw/hGXhiIMN4cOfahfA/TrI2KfrHdexA/rhZlsDkcez4Joel/yxH4HH
 I4RFTe1cFOKY6gBgzVZE6613maRDOaajI38SQJO8D5r7DLr1DYHkgKzq47hht+2ovy4N
 inCpwpPdwXLr2Aepz+mU1rI6MLILSXbtdeKEKvWW0/7zGFZCogElai24Cjoo3qfb8sFi
 y5FEARSq0M1wiGqzX0BO8j3BFS7E4iN6RB6S1n7jjPcXI2V6+sWxGXlgOBShOJLMkmRl
 HtqnIoQ3EL4i1U3OucA57Z0DdnEZSbNCFMcpGnat+IpEo6mcEoH+ttgV7UF/XUfUuVSK
 N9iw==
X-Gm-Message-State: AOJu0YxQu68EgLcGOdokGm25+ae3D8Z9lAh91e6rrKpakkerhAxBw6E+
 9g7tkZ+uEn5WJqTYucfV0BiKjcN4NJq/Khm+CbuWtoWUQkzreIgMghbBvGBdeLhR54Q=
X-Gm-Gg: AR+sD12X8mK/2CtoL0nfaBJVgJo5VqstfHWtfKEo57HHXfdjeLCMJnuQ810xWhElKbq
 gdOa8fKuBNlEs26yvO/pgcAW/pxREMzRqDRuVNpy4W8kWLTmiDbOPAxpsq4EkxDyQ2dasJoR30O
 yP4dwVEs3ozgoQpx3248dB/a0LuvMKNhN7IY7EZslAqD43qEst9TdpqHZ21VmyCZrBkQ7Ql2fAq
 GFDkVSu3rrsticoIasnlFWjEkGuvQNuqO1smmmPNx/x6+A4p1vkBmoO+pwXtQY9rJ0LZI1BFW4k
 1dEipqv/6RTOPuYvckYhApk1yrenfmfELFIzptW3fn2EkMIEF/ivLQuRuwUx2lTq4siyrQxKMSf
 Ba01XhHlp+ooaVjpXtl/eFZM1FKcZ7ugZSscvAL6WffmzZXAPu14T8GpdBtZ29oj2wybJ5Ccpvc
 7OpOqTiz7xp+/mR83g2p8Wi8tjby/csezQiKY0e1veYuG5O3FyIUOsdoTj/r+vR0RPClRyBAgqQ
 wlO/W07zNzEXIJBTQ==
X-Received: by 2002:a05:600c:b85:b0:495:6934:414c with SMTP id
 5b1f17b1804b1-496c656e6d8mr76157645e9.19.1785321645243; 
 Wed, 29 Jul 2026 03:40:45 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0ef25sm6783335f8f.24.2026.07.29.03.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 03:40:44 -0700 (PDT)
Message-ID: <56ad6458-25b4-4eee-ab1e-8d3c6d489aa8@suse.com>
Date: Wed, 29 Jul 2026 12:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
 <20260729095730.29185-3-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260729095730.29185-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

few comments below

On 7/29/26 11:57 AM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same as v1.
> 
>   include/tst_test.h |  9 ++++++++-
>   lib/tst_test.c     | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index c69362485e..0910660827 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -280,6 +280,9 @@ struct tst_ulimit_val {
>    *
>    * @min_kver: A minimum kernel version supporting the filesystem which has been
>    *            created with mkfs.
> + *
> + * @max_kver: A maximum kernel version supporting the filesystem which has been
> + *            created with mkfs.
>    */
>   struct tst_fs {
>   	const char *type;
> @@ -292,6 +295,7 @@ struct tst_fs {
>   	const void *mnt_data;
>   
>   	const char *min_kver;
> +	const char *max_kver;
>   };
>   
>   /**
> @@ -301,7 +305,9 @@ struct tst_fs {
>    *        and each time passed an increasing counter value.
>    * @options: An NULL optstr terminated array of struct tst_option.
>    *
> - * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
> + * @min_kver: A minimal kernel version the test can run on. e.g. "4.4".
s/minimal/minimum
> + *
> + * @max_kver: A maximal kernel version the test can run on. e.g. "7.2".
s/maximal/maximum

Also, I assume test will *not be skipped* on kernel versions
7.1.1, 7.1.2 etc just with
.max_kver="7.1"

maybe we should clarify.

>    *
>    * @supported_archs: A NULL terminated array of architectures the test runs on
>    *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
> @@ -551,6 +557,7 @@ struct tst_fs {
>   	struct tst_option *options;
>   
>   	const char *min_kver;
> +	const char *max_kver;
>   
>   	const char *const *supported_archs;
>   
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 778a1fed40..fa38b3a7a3 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1087,6 +1087,36 @@ static bool check_min_kver(const char *min_kver, const int brk_nosupp)
>   	return true;
>   }
>   
> +/*
> + * Check for the maximal required kernel version.
> + *
> + * return: true if the kernel version is low enough, false otherwise.

This sounds a bit confusing. How about-

Check the running kernel against the last version the test applies to.

return: true if the kernel is old enough, false otherwise.

> + */
> +static bool check_max_kver(const char *max_kver, const int brk_nosupp)
> +{
> +	char *msg;
> +	int v1, v2, v3;
> +
> +	if (tst_parse_kver(max_kver, &v1, &v2, &v3)) {
> +		tst_res(TWARN,
> +			"Invalid kernel version %s, expected %%d.%%d.%%d",
I wouldn't say 'kernel version is invalid'. maybe test isn't
supported/applicable on..

> +			max_kver);
> +	}
> +
> +	if (tst_kvercmp(v1, v2, v3) > 0) {
> +		msg = "The test requires kernel %s or older";
> +
> +		if (brk_nosupp)
> +			tst_brk(TCONF, msg, max_kver);
> +		else
> +			tst_res(TCONF, msg, max_kver);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>   /*
>    * Checks if the struct results values are equal.
>    *
> @@ -1463,6 +1493,9 @@ static void do_setup(int argc, char *argv[])
>   	if (tst_test->min_kver)
>   		check_min_kver(tst_test->min_kver, 1);
>   
> +	if (tst_test->max_kver)
> +		check_max_kver(tst_test->max_kver, 1);
> +
>   	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
>   		tst_brk(TCONF, "Kernel is locked down, skipping test");
>   
> @@ -1586,6 +1619,9 @@ static void do_setup(int argc, char *argv[])
>   			if (tst_test->filesystems && tst_test->filesystems->min_kver)
>   				check_min_kver(tst_test->filesystems->min_kver, 1);
>   
> +			if (tst_test->filesystems && tst_test->filesystems->max_kver)
> +				check_max_kver(tst_test->filesystems->max_kver, 1);
> +
>   			prepare_device(tst_test->filesystems);
>   		}
>   	}
> @@ -1991,6 +2027,9 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>   	if (fs->min_kver && !check_min_kver(fs->min_kver, 0))
>   		return;
>   
> +	if (fs->max_kver && !check_max_kver(fs->max_kver, 0))
> +		return;
> +
>   	prepare_device(fs);
>   
>   	fork_testrun();

Thanks,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
