Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB3CEE49BC
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726065766; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=7lTneSl4AbJxBa8s3Cju02vguKtDO6r6lfm5NHMkNSw=;
 b=fJ6gFtI6HStHJ+PfYt8sVFBVSF1yUO/SiY5Fr5pbLTQNd/lyYFrcZgPJouZXD8dmhQG8p
 uf0LLLr5yo12EMHUQSOdELl/EBFFZ72CavIueKTwqYLE0GAULCB19Zds+ZhPCy5sNSWEv05
 SyH4iAx9zULlrEHvm/9OVM8mBqEoh8k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3F7D3C1D26
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:42:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30B783C03B0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:42:24 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98F4A600241
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:42:23 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso8883769a12.1
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726065743; x=1726670543; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x4kCBPcup/ZAZKy7srvFvRi6Pbyr0dEMu2t1A3lsht0=;
 b=KTjC5fks6hhUOuyz1wfAT3XDVjGpasRHFtKPCn/qyhxUc5+d7fsiCusG4XS27BtFod
 Py6ydmu+BZqGRU3MO+VOxBjQRbZDq0THBpp9slV61VDjemnlin+/7f1bId8jBuLPWRxy
 GTLq7gQ8uC9o18i4o8iWoEtMajz4DWfG1uT9WZ1tfEhFbDO+bzLue7VSqdyzo0PVF/3C
 Z2t3/YACamHgg53imbgF/cspLDJVAN7D1E7VpUjDf2sSZEqJsEXYZJ9j8IMjwHyaSUVZ
 5W6HyHHn8Kf5wx42sCA32JQeuguColFBr5YrN5YAAfr/9mT/Nj73aCJsXowzITeec5cP
 LRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726065743; x=1726670543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x4kCBPcup/ZAZKy7srvFvRi6Pbyr0dEMu2t1A3lsht0=;
 b=KWp1SmP9hKkVYordrHG4EQw2uTerh6CYmD/qd1KTbyoTs079KxWXqApf0ma/rugEOW
 K7yLdkFKZYw4rCoIdOA8g1n6WDjo07xkcVeJxiaWp/RaapM8hEsmE7n0Yu41W/mDAWP/
 BoJVbr2lHEVTJ20mdDAhBpUzUPX2UhNriIIKuu6MGPVGb5YJkKMaaiE+hzVPKxLH5Hux
 TRg21imkeXWdLbDJVSBhnuCKq85Lu8MAO6LU8nF27lyn9ghH5lsc8k1zP14hsmDHst+G
 j1t8ZzGVuzL7r10BF3QepZUKXISUVxmYxMOT5/rtFwxdsQpZVVAQoqCvm+vGf2eEGrIN
 qp6g==
X-Gm-Message-State: AOJu0YxwHGRBGMyUSDB0cuKetgdsq/ljhU7OMZjBYIUTSol2/5v8drQ3
 Iztton3BdH7YoQDc0Y4g7iwKoebPxOmzZ3g8ZoiQdGv0N3+5DDxm58PYn1Pki3k=
X-Google-Smtp-Source: AGHT+IEO20/8rMnbjcOUOif/EgiXyGG5PwE0rL8EjVH2V7D4Eym117uOfW2uKNYCBrbkzG/6k/dv7Q==
X-Received: by 2002:a17:907:1c20:b0:a8b:2604:1da3 with SMTP id
 a640c23a62f3a-a8ffab18797mr486718566b.17.1726065742330; 
 Wed, 11 Sep 2024 07:42:22 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d258354f7sm620064066b.2.2024.09.11.07.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 07:42:22 -0700 (PDT)
Message-ID: <55a1c18a-e3b4-4794-8f63-32042c823b58@suse.com>
Date: Wed, 11 Sep 2024 16:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240911-fcntl4_refactoring-v5-0-948401e7131c@suse.com>
 <20240911-fcntl4_refactoring-v5-1-948401e7131c@suse.com>
 <ZuGe2gxREw2kKVfJ@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuGe2gxREw2kKVfJ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] Add silent macros for TST_EXP_EQ_*
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

Pushed without the break.

Thanks,
Andrea

On 9/11/24 15:44, Cyril Hrubis wrote:
> Hi!
>> TST_EXP_EQ_LI_SILENT
>> TST_EXP_EQ_LU_SILENT
>> TST_EXP_EQ_SZ_SILENT
>> TST_EXP_EQ_SSI_SILENT
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   include/tst_test_macros.h | 81 ++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 62 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
>> index 7a443c803..4217700f3 100644
>> --- a/include/tst_test_macros.h
>> +++ b/include/tst_test_macros.h
>> @@ -344,29 +344,72 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
>>          tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "       \
>>                   TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__));
>>   
>> -#define TST_EXP_EQ_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {\
>> -	TYPE tst_tmp_a__ = VAL_A; \
>> -	TYPE tst_tmp_b__ = VAL_B; \
>> -	if (tst_tmp_a__ == tst_tmp_b__) { \
>> -		tst_res_(__FILE__, __LINE__, TPASS, \
>> -			SVAL_A " == " SVAL_B " (" PFS ")", tst_tmp_a__); \
>> -	} else { \
>> -		tst_res_(__FILE__, __LINE__, TFAIL, \
>> -			SVAL_A " (" PFS ") != " SVAL_B " (" PFS ")", \
>> -			tst_tmp_a__, tst_tmp_b__); \
>> -	} \
>> +#define TST_EXP_EQ_SILENT_(VAL_A, SVAL_A, VAL_B, SVAL_B, TYPE, PFS) do {       \
>> +	TYPE tst_tmp_a__ = VAL_A;                                              \
>> +	TYPE tst_tmp_b__ = VAL_B;                                              \
>> +                                                                               \
>> +	TST_PASS = 0;                                                          \
>> +                                                                               \
>> +	if (tst_tmp_a__ != tst_tmp_b__) {                                      \
>> +		tst_res_(__FILE__, __LINE__, TFAIL,                            \
>> +			SVAL_A " (" PFS ") != " SVAL_B " (" PFS ")",           \
>> +			tst_tmp_a__, tst_tmp_b__);                             \
>> +		break;                                                         \
> No need for the break here now.
>
> Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
