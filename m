Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371FBD2B924
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730812536; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=zoumbE1tA62/5T7CQIsXy3tL77rCO3lTYIr8/OKgDAc=;
 b=mIKOJDoU+/2tKQStXyZ5+0gGvP41aWO3vMfEi2FGyRLblvSUYrwhOIpCPfGHSzANwoHyQ
 Pj222du+RB6h544P5TuKC5QR88KsgK9h+SlRsQx5n3cxkabIXr8bnRrxvM3dnbzoBxSUel2
 RCYw7Y2J5L1Z3CQCzVcWXHxYV0ask9Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C292A3D2221
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 14:15:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62F703D1FDA
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 14:15:16 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B28E91033AAF
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 14:15:14 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so44478145e9.3
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 05:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730812514; x=1731417314; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXZBPBxTMb5xNaOhM4fGG6i9xET8XVkCFgabTklr8+o=;
 b=O6vSgAy6rtBw1FKXFMKmypxMyAx0/J26FaU8dmATGgj1Dy2VsuuEH77xrbR1cUx1Yl
 jCHnviaLaC2sUFHpb30JCyw0Qm81hVk6OcI6fZEiLbU6VTH8+6RyfAQAIQmT8pyjsKg1
 WFyiqsJO5dHZ/+MHmil8eOrosj4oXr9k7rbF/D7aqwD1AhsIbIXSsI4vcQ9g69YHD0FY
 Dk0eQ3sI5OZgiyXQTOM/85bVAyb7UZ1BE/tx+tzdEvzUEVvk/iHE4kkXRdtzXXmsqkgI
 6Eta2qPz7nxF2wGeZWMARQlD0gYfWrwfgZTQhdAc0k/KkHg14/l7joYlkGG6SQfOtTo6
 kwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812514; x=1731417314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXZBPBxTMb5xNaOhM4fGG6i9xET8XVkCFgabTklr8+o=;
 b=dF55LiLGSZgAWv0i2cJ2oIFtz+/gC+/hRQCKyED5xaWuF9UVLqyJsoU+OoYc6SrNF1
 OZrZTYXUDyZ8DjKHFKv1FXMrJ4c+1viZ2t5ztunTfJA7ZJTDmGIDkG8A7+xXIf3Hkh8n
 hMgeoxncfVJXTXxc0s3VwmDJySyvUrEp3bKzYLLrqgoe902iPxbZbHMB4cLqDIEixGO8
 KBW8ZrT54IotaFkSYpxHIa6SaYEZVTy7pQVCauKhhUOCzcKO4mLoRGaCkprMry4rEqM4
 nsSKNJJrbP5aiIIsD6JhXd9X3oNSmHq8ldPr+XZytwk3Q2MvWhvf7ufF9W/PSYsBaro9
 TxDw==
X-Gm-Message-State: AOJu0YzoTzZveir7bNnenqtz8sp7dwLTENt8MBBP8s2ozrTaJYbhaTxx
 bS7QzEisM6AzpsEz0ojDfIdsMaHYbdVKkeK8+Zg2c8EQP6cnhIdcLTDADdIt7hw=
X-Google-Smtp-Source: AGHT+IFRDRUQdUtrlFc3kz8DGDuD4EfuLKkssLVjZd/sVGxIx+mbPPLFhbZocpWnO68lkXlJa5uN7A==
X-Received: by 2002:a05:600c:3c8c:b0:431:4fa0:2e0b with SMTP id
 5b1f17b1804b1-4319ad146b1mr293462805e9.28.1730812514030; 
 Tue, 05 Nov 2024 05:15:14 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf429sm185017965e9.12.2024.11.05.05.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:15:13 -0800 (PST)
Message-ID: <db283ab2-2514-42a1-a249-a71861e5d4f4@suse.com>
Date: Tue, 5 Nov 2024 14:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
 <ZyoYxqE423FxFuPc@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZyoYxqE423FxFuPc@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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

Hi Cyril,

On 11/5/24 14:08, Cyril Hrubis wrote:
> Hi!
>> Landlock network support has been added in the ABI v4, adding features
>> for bind() and connect() syscalls. It also defined one more member in
>> the landlock_ruleset_attr struct, breaking our LTP fallbacks, used to
>> build landlock testing suite. For this reason, we introduce
>> tst_landlock_ruleset_attr_abi[14] struct(s) which fallback ABI v1 and v4
>> ruleset_attr definitions.
>>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   configure.ac                                       |  3 ++-
>>   include/lapi/capability.h                          |  4 ++++
>>   include/lapi/landlock.h                            | 28 ++++++++++++----------
>>   testcases/kernel/syscalls/landlock/landlock01.c    | 15 ++++--------
>>   testcases/kernel/syscalls/landlock/landlock02.c    |  8 +++----
>>   testcases/kernel/syscalls/landlock/landlock03.c    |  6 ++---
>>   testcases/kernel/syscalls/landlock/landlock04.c    |  6 ++---
>>   testcases/kernel/syscalls/landlock/landlock05.c    | 10 ++++----
>>   testcases/kernel/syscalls/landlock/landlock06.c    | 14 ++++-------
>>   testcases/kernel/syscalls/landlock/landlock07.c    |  6 ++---
>>   .../kernel/syscalls/landlock/landlock_common.h     | 12 ++++------
>>   11 files changed, 53 insertions(+), 59 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index d327974efa71f263d7f7f5aec9d2c5831d53dd0e..e2e4fd18daa54dbf2034fa9bcc4f2383b53392f4 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -34,6 +34,8 @@ m4_ifndef([PKG_CHECK_EXISTS],
>>   AC_PREFIX_DEFAULT(/opt/ltp)
>>   
>>   AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
>> +AC_CHECK_DECLS([LANDLOCK_RULE_PATH_BENEATH],,,[#include <linux/landlock.h>])
>> +AC_CHECK_DECLS([LANDLOCK_RULE_NET_PORT],,,[#include <linux/landlock.h>])
>>   AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
>>   AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
>>   AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
>> @@ -172,7 +174,6 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
>>   ])
>>   
>>   AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
>> -AC_CHECK_TYPES([enum landlock_rule_type],,,[#include <linux/landlock.h>])
>>   AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>>   AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
>>   AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_error,
>> diff --git a/include/lapi/capability.h b/include/lapi/capability.h
>> index 0f317d6d770e86b399f0fed2de04c1dce6723eae..14d2d3c12c051006875f1f864ec58a88a3870ec0 100644
>> --- a/include/lapi/capability.h
>> +++ b/include/lapi/capability.h
>> @@ -20,6 +20,10 @@
>>   # endif
>>   #endif
>>   
>> +#ifndef CAP_NET_BIND_SERVICE
>> +# define CAP_NET_BIND_SERVICE 10
>> +#endif
>> +
>>   #ifndef CAP_NET_RAW
>>   # define CAP_NET_RAW          13
>>   #endif
>> diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
>> index 211d171ebecd92d75224369dc7f1d5c5903c9ce7..b3c8c548e661680541cdf6e4a8fb68a3f5029fec 100644
>> --- a/include/lapi/landlock.h
>> +++ b/include/lapi/landlock.h
>> @@ -7,6 +7,7 @@
>>   #define LAPI_LANDLOCK_H__
>>   
>>   #include "config.h"
>> +#include <stdint.h>
>>   
>>   #ifdef HAVE_LINUX_LANDLOCK_H
>>   # include <linux/landlock.h>
>> @@ -14,13 +15,16 @@
>>   
>>   #include "lapi/syscalls.h"
>>   
>> -#ifndef HAVE_STRUCT_LANDLOCK_RULESET_ATTR
>> -struct landlock_ruleset_attr
>> +struct tst_landlock_ruleset_attr_abi1
>> +{
>> +	uint64_t handled_access_fs;
>> +};
>> +
>> +struct tst_landlock_ruleset_attr_abi4
>>   {
>>   	uint64_t handled_access_fs;
>>   	uint64_t handled_access_net;
>>   };
>> -#endif
>>   
>>   #ifndef HAVE_STRUCT_LANDLOCK_PATH_BENEATH_ATTR
>>   struct landlock_path_beneath_attr
>> @@ -30,12 +34,12 @@ struct landlock_path_beneath_attr
>>   } __attribute__((packed));
>>   #endif
>>   
>> -#ifndef HAVE_ENUM_LANDLOCK_RULE_TYPE
>> -enum landlock_rule_type
>> -{
>> -	LANDLOCK_RULE_PATH_BENEATH = 1,
>> -	LANDLOCK_RULE_NET_PORT,
>> -};
>> +#if !HAVE_DECL_LANDLOCK_RULE_PATH_BENEATH
> These are more usually ifndef at least it's more readable.
>
We can't use #ifndef because HAVE_DECL_LANDLOCK_RULE_PATH_BENEATH is 
always defined, but it can be 0 or 1 if it's present or not (this is 
what I seen using autoconf). You can check in config.h as well. 
Apparently this is how autoconf handles symbols.
>> +# define LANDLOCK_RULE_PATH_BENEATH 1
>> +#endif
>> +
>> +#if !HAVE_DECL_LANDLOCK_RULE_NET_PORT
> Here as well.
>
>> +# define LANDLOCK_RULE_NET_PORT 2
>>   #endif
>>   
>>   #ifndef HAVE_STRUCT_LANDLOCK_NET_PORT_ATTR
>> @@ -123,8 +127,7 @@ struct landlock_net_port_attr
>>   #endif
>>   
>>   static inline int safe_landlock_create_ruleset(const char *file, const int lineno,
>> -	const struct landlock_ruleset_attr *attr,
>> -	size_t size , uint32_t flags)
>> +	const void *attr, size_t size , uint32_t flags)
>>   {
>>   	int rval;
>>   
>> @@ -143,8 +146,7 @@ static inline int safe_landlock_create_ruleset(const char *file, const int linen
>>   }
>>   
>>   static inline int safe_landlock_add_rule(const char *file, const int lineno,
>> -	int ruleset_fd, enum landlock_rule_type rule_type,
>> -	const void *rule_attr, uint32_t flags)
>> +	int ruleset_fd, int rule_type, const void *rule_attr, uint32_t flags)
>>   {
>>   	int rval;
>>   
>> diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
>> index 083685c64fa6d1c0caab887ee03594ea1426f62f..bd3a37153449b8d75b9671f5c3b3838c701b05ae 100644
>> --- a/testcases/kernel/syscalls/landlock/landlock01.c
>> +++ b/testcases/kernel/syscalls/landlock/landlock01.c
>> @@ -17,14 +17,14 @@
>>   
>>   #include "landlock_common.h"
>>   
>> -static struct landlock_ruleset_attr *ruleset_attr;
>> -static struct landlock_ruleset_attr *null_attr;
>> +static struct tst_landlock_ruleset_attr_abi4 *ruleset_attr;
>> +static struct tst_landlock_ruleset_attr_abi4 *null_attr;
>>   static size_t rule_size;
>>   static size_t rule_small_size;
>>   static size_t rule_big_size;
>>   
>>   static struct tcase {
>> -	struct landlock_ruleset_attr **attr;
>> +	struct tst_landlock_ruleset_attr_abi4 **attr;
>>   	uint64_t access_fs;
>>   	size_t *size;
>>   	uint32_t flags;
>> @@ -60,13 +60,8 @@ static void setup(void)
>>   {
>>   	verify_landlock_is_enabled();
>>   
>> -	rule_size = sizeof(struct landlock_ruleset_attr);
>> -
>> -#ifdef HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET
>> +	rule_size = sizeof(struct tst_landlock_ruleset_attr_abi4);
>>   	rule_small_size = rule_size - sizeof(uint64_t) - 1;
> I guess that the safest bet here would be:
>
> sizeof(struct tst_landlock_ruleset_attr_abi1) - 1
+1
>
> That is by definition one byte less than the smallest size, this will
> also in 99.99% cases evaluate to 7 since structure with single 64 bit
> number will not need padding so hardcoding 7 should be safe as well.
>
> Also I guess that we can use the v1 ABI for the whole invalid inputs
> tests, all we need here is to pass a size that is valid in most cases,
> which is v1 I suppose.
>
>
> The rest looks fine to me:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
