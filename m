Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4E3CAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758873542; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=jp0iedGGqGCWcJRScx3l4uJFybSRxi4ZZLgHnrIDkAw=;
 b=BE7cSlCHJoMlqOo4SVbwpXvfFmbp8GbRtdZsY6tv5ZAynEZCSDU/tvfGNFk2MPZv6mmTO
 2FQPLyBSODeiDzP21oravdpicuXQV1OBmbN29skefx4y8mlg7NlaVgjBp5A+vGlyGwskY7n
 txjJUKSHlq3ucjVb8cBXIHs99Swg/dk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E632E3CE07D
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 09:59:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5275F3CA9B9
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:58:41 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3ABB7600633
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:58:40 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso1126288f8f.2
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758873519; x=1759478319; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aFbA+amqByTs5H1I31Nw5uvOIZ1jEPHJAdtX2xl979c=;
 b=EpzbC6NwW9AXfurmUpxiiYf2BpGJOIVSAMDTSaUxlpN8QfyGjxbl0Tj5z2xHJezvrZ
 onfyfDdcKb84Kpx0AjiRAjlDgpFTGfeKehyy1ZKFTxnNY0Y0fwhyVsxs6OfH2XwSL34f
 XhgIOHSr/X5uBhqS417z1pQYHhNZPcZ17QqODajQOeDeE3HiEnApdPOzkpbIF0Ips0tY
 Su1/FmQuy3QFTFUfGLN2v4tnydM1xpJp9tbyAbil3FctM8qIJB5OZmoIV5EgJ5YcgUiG
 s3fcexUNRhqlN5R3l3GzEBRZS7GP0mEJVVMiJ6GVMSUYEFsj+qUY8ZacoSqm3LbvoMO0
 A7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758873519; x=1759478319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aFbA+amqByTs5H1I31Nw5uvOIZ1jEPHJAdtX2xl979c=;
 b=tnkxzFyPaTgBb523rOxaq5Fmei6Cgd6ZCTGxXMyzXx08jn2oEDt3op6lz6Kt1Wdxvg
 H6jgKQ1VNTV7+ZhXv5RXqtxEjWixArBljW9S9DfGrwZnRMhglEo+hTanyYF+30ZMrtXs
 GLgCT/MAxR0LHeNj2/9i/KpN7yLK5nYcApVvqGolMrFBb6F4yqqueLl/7csJiqqcPZ1E
 UaGNxMfa93eejxu6hDUfXF3JPxClNisyu88IFb0OrlCMckkzDRDywCkr5p4uJ4RNsU3i
 Xjg5LAfYTZ1rZhpE4tTunkUZbSVHNwoaglfk8B8ql6JZ5h/EXdIRGSxU/Dm7Wy3JHyNW
 FXXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCLO6gwoo5FkxozdwepE+9Qgoj4ZoQBXP0KtE+RAzDUnhJyTSYh1mJHREDy47VhDmzUgE=@lists.linux.it
X-Gm-Message-State: AOJu0YzJ0I7+U4G1VqsVTQQ0n2kc7O7q8JzB+UlTLhiN36/8h79ruBHA
 IZBBWhtPQWQp/EM++R22WYonpF9ch6GlwHqx9q38Xar8qa9AbASw5HznZAby61Vb+2g=
X-Gm-Gg: ASbGncuo5WtRZ0EGJFf2PatUOvCxt6MnQeiousMNlDDqQ5aVPkIZdSaWTI2QdTpcgIX
 /VDECIJbPNESTa+JKA1xK0LbQauvR50weJePpHfkbHpkXayWvj9oVJpKqcg4tIiCTxZyXSEyXPL
 vonMPDEWAN2RJ/+T9KEXNosPnars3WEa+y757ezapxg3kA6VjFrXQzBTfxffGY0wboYCPKd0Rgh
 cuzjj6l/3KYja5K8CZzJ2qysiOa1NE0kRzRdZ8fe+w85r4L6Y3gswmjNenpW7Tffd2ix2AfCqCz
 hML4eqHKj6DeKiFr8H7LlzhSK77MM1+KFJn7Uk8XZgP4BL/DpkJHQ88S1LHnpZZ9nQWjM3+uYCo
 zGQ7Kwef5VYURR8rokQH7t4ngY+RxxJ2C2wlYvO7/tWdhyPwZKjyYuQ3+3+9YFippD2cggeQf8g
 TuyEf7V4EFE1HxeCq2bL4+p3alsRbSeSSpaGpScrbNLtL2qipsRk5oVzPfneZcSbw=
X-Google-Smtp-Source: AGHT+IHSKUK94ng+GXXoX5OqJxxONk55g10kOdB7ssQ5d9APc6I13X7FrgbVNzOJkhzHrackZnH7FA==
X-Received: by 2002:a05:6000:220b:b0:3ec:df2b:14c8 with SMTP id
 ffacd0b85a97d-40e4458ce98mr5862296f8f.20.1758873519539; 
 Fri, 26 Sep 2025 00:58:39 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33fede76sm61455945e9.14.2025.09.26.00.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:58:39 -0700 (PDT)
Message-ID: <470b0b8b-c3b1-4a38-9570-1102e4f6f55d@suse.com>
Date: Fri, 26 Sep 2025 09:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <metan@ucw.cz>, ltp@lists.linux.it
References: <20250925135448.19818-1-metan@ucw.cz>
Content-Language: en-US
In-Reply-To: <20250925135448.19818-1-metan@ucw.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] realtime: Fix removal of autotools
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ups?

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 9/25/25 3:54 PM, Cyril Hrubis wrote:
> From: Cyril Hrubis <chrubis@suse.cz>
>
> When we removed the autotools from the realtime subdirectory we failed
> to remove the HAS_PRIORITY_INHERIT ifdefs from the source code.
>
> Closes: https://github.com/linux-test-project/ltp/issues/1264
>
> Fixes: a05298ec4494 ("testcases: realtime: Get rid of autotools")
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   testcases/realtime/func/pi-tests/testpi-5.c   | 5 -----
>   testcases/realtime/lib/librttest.c            | 4 ----
>   testcases/realtime/stress/pi-tests/testpi-3.c | 2 --
>   3 files changed, 11 deletions(-)
>
> diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
> index 24bbb334c..80c83fa69 100644
> --- a/testcases/realtime/func/pi-tests/testpi-5.c
> +++ b/testcases/realtime/func/pi-tests/testpi-5.c
> @@ -69,8 +69,6 @@ int do_test(int argc, char **argv)
>   	pthread_mutexattr_t mutexattr;
>   	int retc, protocol;
>   
> -#if HAS_PRIORITY_INHERIT
> -
>   	if (pthread_mutexattr_init(&mutexattr) != 0)
>   		printf("Failed to init mutexattr\n");
>   
> @@ -91,9 +89,6 @@ int do_test(int argc, char **argv)
>   	join_threads();
>   
>   	return 0;
> -#else
> -	return 1;
> -#endif
>   }
>   
>   #include "test-skeleton.c"
> diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
> index 99ce78b33..21ea57dec 100644
> --- a/testcases/realtime/lib/librttest.c
> +++ b/testcases/realtime/lib/librttest.c
> @@ -591,7 +591,6 @@ void *busy_work_us(int us)
>   
>   void init_pi_mutex(pthread_mutex_t * m)
>   {
> -#if HAS_PRIORITY_INHERIT
>   	pthread_mutexattr_t attr;
>   	int ret;
>   	int protocol;
> @@ -614,9 +613,6 @@ void init_pi_mutex(pthread_mutex_t * m)
>   	if ((ret = pthread_mutex_init(m, &attr)) != 0) {
>   		printf("Failed to init mutex: %d (%s)\n", ret, strerror(ret));
>   	}
> -#endif
> -
> -	/* FIXME: does any of this need to be destroyed ? */
>   }
>   
>   /* Write the entirety of data.  Complain if unable to do so. */
> diff --git a/testcases/realtime/stress/pi-tests/testpi-3.c b/testcases/realtime/stress/pi-tests/testpi-3.c
> index 70ec94513..8a3e7c731 100644
> --- a/testcases/realtime/stress/pi-tests/testpi-3.c
> +++ b/testcases/realtime/stress/pi-tests/testpi-3.c
> @@ -365,7 +365,6 @@ int main(int argc, char *argv[])
>   
>   	printf("Start %s\n", argv[0]);
>   
> -#if HAS_PRIORITY_INHERIT
>   	if (!nopi) {
>   		pthread_mutexattr_t mutexattr;
>   		int protocol;
> @@ -386,7 +385,6 @@ int main(int argc, char *argv[])
>   			printf("Failed to init mutex: %d\n", retc);
>   		}
>   	}
> -#endif
>   
>   	startThread(&arg1);
>   	startThread(&arg2);
>
---
Andrea Cervesato

andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
