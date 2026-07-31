Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2F9C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785498517; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RSJBm+5giQHldVUbu8GBl0yNO6otjchluVHXhpfkWXI=;
 b=HKXJxo1DlejipxkoYWl1YYONx6uVLOgGbKf/jPkkvlZTbC/+tcDBaOy0FPDt7YyKKq6/p
 HkVjIcMwywiXhp45CNy06XldTL2D4eNjTVMQh1CaNF7SM9NK+/oE7cu3c64z9ee0fpAe3Bw
 17RqjB5Z3YRy6gF5DRGuHjuiidouwIo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D331B3E62F0
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:48:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBE623E25FB
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:48:17 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 12D7D600AAB
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:48:17 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so136700666b.0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785498496; x=1786103296; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P/vAoso4bha0Me0lUGuaHV4H49YG7EQ9FBgTWn42rRc=;
 b=fGJOO1MJnQ9VOUereQfR0ahTLP2HCyJTwZue52g81CKuveR/biAnL0rZCvTxyUQqzW
 UUc1zT9CC1bjwbXZnIwR1wKrD+ZGsWMfBXeOh/wMYYTAUneuYyDAleTPX3gvecBeLIGF
 BKlSCLpCqD6QdkwkDRt/svQ0rxiZ8oLrs7IipCaGfdRJFFNa1ZsdAQJtYwYxcZ31Mjxx
 qXFkZosYhzbkSPLhdn4x3SvpXArk3KXvRtGNTc86l9iwGoHkkxdzIZk4p9nyzJLh5oRU
 7oFlHh5l6qQf6xaTItn1dwoz9+VCrFHoL16ekZ3gDTOoXbNn5cCh5dKX4HdYID05i0oC
 /5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785498496; x=1786103296;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/vAoso4bha0Me0lUGuaHV4H49YG7EQ9FBgTWn42rRc=;
 b=AXtXQkE2umS63EGsNdtFPdtwnb0Bzz0vCx9Fvz6BZ1ExENUW8ghMUJE5ZMMRn3I1tS
 YQ7qSAWuOvw5RzfdTrR4iz4w0nLwnFh9fI7EBIF55y7Iiw0GG0LEYusnOF20aHOMsoDS
 rvTZom4hPCBj+u5ACpJkUhDCwyBRUk9ritL5BxAEUdxxcpj32hfGL32HgdLzZbSnbqSy
 Ny9N+EWQxORrV0c3vshBsh7Y3mNOb6VHhHucUr2rdXbfb8hvg0zzRcRhMkfSqMLmm3N3
 EG7i8w0K1UQIIPLnxwX3G0pa+S4i/lUaMCTjVrNMydr7nl4xWD/onESZk5QKFPZIfRxh
 IfXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhEpBMI0d7OH+52lAyb345FbmEQeq4Qs6xDwTsfb69qVG1tJFnic/XnAXt/IsImf4Nzlo=@lists.linux.it
X-Gm-Message-State: AOJu0YzhZNrXayGWTMgBxOPSBoUeOY6ZBfpnAWLME7DaDPs2zFoN1TA8
 bJEE7+JDTh3i3Koi9HGnjyOifqG8oIwesu+hKCiXmqQc4pb251kbZUuikoF/9FLzLH8Z3sRloX2
 nKLRuUMoz9w==
X-Gm-Gg: AR+sD12XTZO6PKn6R+MBC5WmHS/Jy6hcFM+O77OoygeWck113iuJALK0NCVVHPZR07J
 u6rNg9Lgej4QeyB37subFqYl7k7wAsLKiCEGyIK2AkddAAiQGdSF0AUVSx6FXbSaK4/ZDqMKjrL
 vhUuWzSbjrC0F8fhMFNdVyNjfR9E7pmhZa1EesomxPnophTSTtP3HOYZfuinhxDKxbshkkf7Bx6
 jXR7D7AUG5A3hXYY8iGt/LtWW1N11TPhtJm56iGO1E9/OKcqWpsqtGpFrShszXo1zxENrCynvN+
 xBVdZZlfCPIdStU0kI9SqtJPRwU4WZVgVUmInV74hKqKd1+8sPp4GX61iHtqqCdC+2NyJbJGXAP
 yPCOk0zJI/K/hoWS5VX9LYjtvTQ2gXeZOAnlPPbBQREP5GlbfKfjIi+O0UrTBhTafa7pCL6hyK3
 tEdNkUI8konab8zXgLpUhhHFpNw1l3L9FA/y95L/myALKvMMvn4lqkeTpU/7hZIG6HkqOVcgrEH
 s8MBA==
X-Received: by 2002:a17:907:1b1a:b0:c1f:9e0b:e029 with SMTP id
 a640c23a62f3a-c1fd25384c5mr102788766b.39.1785498496389; 
 Fri, 31 Jul 2026 04:48:16 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd452d93dsm129882366b.49.2026.07.31.04.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 04:48:15 -0700 (PDT)
Message-ID: <31966d61-11a4-40ac-870b-0b9d2066ade5@suse.com>
Date: Fri, 31 Jul 2026 13:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260731105132.187177-1-pvorel@suse.cz>
 <20260731105132.187177-3-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260731105132.187177-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] lib: Add support for max_kver to struct
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



On 7/31/26 12:51 PM, Petr Vorel wrote:
> max_kver adds a support to require a maximal kernel version the test can
> run on. e.g. "7.2" (mainline release) or "6.1.180" (stable release).
> 
> NOTE: Mainline release is sufficient on any stable release (test with
> .min_kver = "7.1" runs also on kernel 7.1.5). Stable releases are
> compared as expected.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * Allow to pass mainline release (e.g. max_version = "7.1") on any stable
>    release (e.g. 7.1.5). Stable releases (e.g. 7.1.5) are compared as
>    expected. For this I'd like an explicit ack.
> 
>   include/tst_test.h | 13 ++++++++++++-
>   lib/tst_test.c     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index c69362485e..318b2f79b7 100644
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
> @@ -301,7 +305,13 @@ struct tst_fs {
>    *        and each time passed an increasing counter value.
>    * @options: An NULL optstr terminated array of struct tst_option.
>    *
> - * @min_kver: A minimal kernel version the test can run on. e.g. "3.10".
> + * @min_kver: A minimal kernel version the test can run on. e.g. "4.4" (mainline
> + * release) or "6.1.180" (stable release).
> + *
> + * @max_kver: A maximal kernel version the test can run on. e.g. "7.2" (mainline
> + * release) or "6.1.180" (stable release). NOTE: Mainline release is sufficient
> + * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
> + * 7.1.5). Stable releases are compared as expected.
>    *
>    * @supported_archs: A NULL terminated array of architectures the test runs on
>    *                   e.g. {"x86_64, "x86", NULL}. Calls tst_is_on_arch() to
> @@ -551,6 +561,7 @@ struct tst_fs {
>   	struct tst_option *options;
>   
>   	const char *min_kver;
> +	const char *max_kver;
>   
>   	const char *const *supported_archs;
>   
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 778a1fed40..8b9abe716a 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1087,6 +1087,44 @@ static bool check_min_kver(const char *min_kver, const int brk_nosupp)
>   	return true;
>   }
>   
> +/*
> + * Check for the maximal required kernel version.
> + *
> + * return: true if the kernel version is low enough, false otherwise.
> + */
> +static bool check_max_kver(const char *max_kver, const int brk_nosupp)
> +{
> +	char *msg;
> +	int dots, i, v1, v2, v3;
> +
> +	if (tst_parse_kver(max_kver, &v1, &v2, &v3)) {
> +		tst_res(TWARN,
> +			"Invalid kernel version %s, expected %%d.%%d.%%d",
> +			max_kver);
> +	}
> +
> +	for (i=0, dots=0; max_kver[i]; i++)
> +		dots += (max_kver[i] == '.');
> +
> +	/*
> +	 * For mainline kernel release without patch level (single dot e.g. "7.1")
> +	 * ignore v3 (the sublevel): 7.1.x is always ok.
> +	 * Do *not* ignore v3 on stable kernel release (2 dots, e.g. 7.1.5).
> +	 */
> +	if (tst_kvercmp(v1, v2, v3) > (dots == 1 ? 1023 : 0)) {
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

Hi Petr,
This looks good. I tested it (and other patches) as well.

on my system, test runs fine -
tst_test.c:2097: TINFO: Tested kernel: 7.1.4-1-default
...

and
on >=7.2

# ./fanotify20
tst_test.c:1118: TCONF: The test requires kernel 7.1 or older


so feel free to add
Tested-by: Avinesh Kumar <avinesh.kumar@suse.com>
Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

for whole series.

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
