Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F60C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784640776; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=2pdGxxCvVx8HV4EKdlaBJ9MS0MQLLMYpbM+buPwil24=;
 b=bkF82IAU82mtsV1Pe/TQ0e9WDLUqvzuLz6ZDv2myg//PnAQB6IDepWgeLBdjZvZdozmcs
 KCoImt0Qg+XBWtoOmZmNUw2a1fRnlXdWRBo4iuXkY2aw2PXst7goPxIZ5+7Km7RRp4YkT6k
 rBZxoA3qvDropWw9dpNrpS1YlVXe3+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8DA13CEC21
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 15:32:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AAB03C2603
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:32:35 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D1F25100094F
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 15:32:34 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490d6730461so11585485e9.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784640754; x=1785245554; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y++n0yWQwaSEeBUdzDVNC7sljp555hshLgwlB7V+W0k=;
 b=TsomTHHeF+LBFXSaPwHv7TDnrWldYTjyPWXiQ/ZkAkHJoeL1NSyEZV8bpptJhsOOdJ
 peQ4GElzBPJhUbb2r+KIuh92okRT8qDoiMSEFgzptLUPK87mv8gNqnIrqLiONNWP0YM8
 UEK18cr2KteShwC7tIc/PXuFrM11YKvsqJqTUFtC4BpJVxghVpG9Fm3G8PJXeVoSP7vf
 YA7oIWJQYG5yy4nFNVqWKV0paWL3IMdvKFrgfYY45WBTf/sipHdE+4sBfGX0pZwUSbk6
 4lt1ZSd6VPv9wFQPO+YAdSXkm0U4HoB01Bl3gcDC8Yg5KrqaXg+nq4p4nZHNPmZ+uSjq
 ry9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784640754; x=1785245554;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :references:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y++n0yWQwaSEeBUdzDVNC7sljp555hshLgwlB7V+W0k=;
 b=M0wM6RlcV5pEJDVqAnHPzqVDMaUZ2UcHtiwsmdhmogEGOVsUBqUgz0eZ1JFXo2iJS4
 utbeBjHg39coIhpSwakFCca6pO5EiF7s4DN8/vO6yG2IfObULHGwHMmoxvxD4E1JhCtP
 zoH8lf3t8E83lZJvtAlGfN919fGrcmEvpLyv5q9ZMh1AulkuV9tlbxpauSdJauYDqL9d
 qHj1LkvjqO0iHRdNqa8R63J6koRbbPjfYWSXvPjLpHyW51BRoAJg4iL0rDakJucr7N+s
 OwC5i8yJVJxScjn1u0S9ZOOclu3Zx9sQEasPd1UknZLmntAsvO4r02pEj30iJCuyZSo3
 oVPA==
X-Gm-Message-State: AOJu0YxnPCqYkjsN9QNaJ/PdqqOY3IIPGXFsRGZ1bF8w6wdNZUu7h7gP
 U8j3bZ9dm5TA2gSIcrkqQk0XTnjB2yHT8S3L7NoyBSGbWjnnuGbF9tuvz+kMuYEZyeqIt5tv4iZ
 5xrlzrYc=
X-Gm-Gg: AfdE7cl3EPp74FE5ncXilF02ecrwmipiusJrhJ8BcmaWhc66oNoQW6xTO7XFfvzTazz
 pkBSX1eWNOKVPBf+mi49/QwDee9FuxfDLwOKWMvaP/K7cWZ23HkSFgJluifE1fUYii3EbEdiWMs
 JBWuUE+zJHUuomlxNWIHDM5kozg7loJfqbgQYODisV0o102ow6tydrnyuj4qxcoSEmlwdaZdVHZ
 PQK1GbmKgjjIDrbsWb5OAZx8+1DViI8p+guxBpDGW1sC15bkBlGG+B0P8BBhN2k70hPfw6IJzi8
 unvHP3JuNvhA9RvpsCfRMRqkPGcLrfN+oQ0m8m7kNnfQ7NWNcUchnadmiJOcU6wiqslT/mocUly
 SathSmTsHuxzO9q3PRgVw0EsNTVuDK2HjWVY46WF5NCKV6DWn1iE+xtErsAldvF+fWlRV61KZ
X-Received: by 2002:a05:600c:b8d:b0:493:b6a2:858d with SMTP id
 5b1f17b1804b1-4954a51321cmr121795205e9.6.1784640754013; 
 Tue, 21 Jul 2026 06:32:34 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653687b2sm81529635e9.1.2026.07.21.06.32.33
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 06:32:33 -0700 (PDT)
Message-ID: <033819ee-29f1-4132-b64b-6fea09629c99@suse.com>
Date: Tue, 21 Jul 2026 15:32:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20260714111307.166205-1-yizhou.tang@shopee.com>
Autocrypt: addr=vbabka@suse.com; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSFWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmNvbT7CwZcEEwEKAEECGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4ACGQEWIQSpQNQ0mSwujpkQPVAiT6fnzIKmZAUCZ8ga5gUJGtCBUAAKCRAiT6fnzIKm
 ZLljEACddSH94E+dD+XU0h0o3OgLczf/MeMYW00ZaK5FsnIPbxf/VdQHXd7KcvIFTdpc7X6O
 53MlUbUoymNLhhJdEa8EEaH9F9FEGD6fL7DRoE35gxwxSnCGlvffktvD2oeKH0NKPMam1vNu
 3Imq5RA5n4Nfw3hMQzmi7JXI8eFyy9h7GVcyjhDnb2WsLGAQIAKSGqlfdmrkEelhaIoTEMQ9
 cDIZPGhmDGcdHXuEwRWk5qZGOGoH8AsJz5SXEWe00PB4qyKnhzhkD6c20eFL9qBC/54IVFvS
 qk1rZGON2NnNQtGwR9i5ghThKo9ALgbS1ha7IsnsyElpnM4Xa5VcFxNTQZlNqWch57lkFihA
 LATi0USes50huWtgjTMGbaVgud5w5ScGEexVQKc7uGUK6TiCKxmp209VcWqH6NoM3gbekYad
 XQzw3ykgIgJzTQNPffw56kIwJLOzooglFujThxw3w8+SN8k1znU5X4vpJCkoIB24rGevPTMd
 f8uf/6lA7o2O1HbDnOAwDIkUdZqurRU1YBHRFf2Me7z/DyMPbkUNcaGFQ/hZopC4ch7j12GM
 smzuUQ/3WkwHGeuzGHJZqZyVAX+86gXXx16OURuwrfsbWMkDAo9nTVQzl5UsWrCYE/N9dhkl
 uAge7mIix4uRKlIYHfSA6o7N+cXY16V+zFHlmd6LOM7ATQRbGTU1AQgAn0H6UrFiWcovkh6E
 XVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQLa1PQDUi6j00ChlcR66g9/V0sPIcSutacPKf
 dKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMhFmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCT
 sTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sfbAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZO
 rIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq+aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahK
 tQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4njQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJks
 Lo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8ACgkQIk+n58yCpmS2PA//bqN1LfcotmArgEls
 a+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKYHR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4
 Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVdSXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94
 wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi4U9F/trLten/x7bpphDSnDMKJtITbtzATT1D
 q7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O40PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwg
 BF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9Yplav
 CMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/PwIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1
 pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dqNcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudL
 vPA/SK8sKoM01IRxSihev/S/5WLazXB1PGemOCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR
 22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLVjXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4
 pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260714111307.166205-1-yizhou.tang@shopee.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] perf_event_open03: Track SUnreclaim growth
 instead of MemAvailable
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
From: Vlastimil Babka via ltp <ltp@lists.linux.it>
Reply-To: Vlastimil Babka <vbabka@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/14/26 13:13, Tang Yizhou via ltp wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> CVE-2020-25704 leaks a small kmalloc() allocation (the filter's file
> name string) on every failed PERF_EVENT_IOC_SET_FILTER call. The test
> detected this by watching MemAvailable in /proc/meminfo drop by more
> than 100MB over 12M iterations.
> 
> MemAvailable is a global, system-wide estimate. It is heavily influenced
> by other memory activities of unrelated processes. This produces
> intermittent false positives: the test passes when run alone but
> occasionally fails when run with other tasks.
> 
> An improvement is to track the growth of SUnreclaim instead. It is less
> sensitive to other kinds of memory activities.

Right.

> Also note in the failure output that unreclaimable slab can still grow
> due to unrelated slab activities, so a failure should be confirmed on an
> idle system or with kmemleak before being treated as a regression.

That's true as well.

> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  .../perf_event_open/perf_event_open03.c       | 32 ++++++++++++-------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> index 389cc3511..0cc1c27f0 100644
> --- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> +++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
> @@ -77,13 +77,13 @@ static void check_progress(int i)
>  
>  static void run(void)
>  {
> -	long diff, diff_total, mem_avail, mem_avail_prev;
> +	long diff, diff_total, slab, slab_prev;
>  	int i, sample;
>  
>  	sample = 0;
>  	diff_total = 0;
>  
> -	mem_avail_prev = SAFE_READ_MEMINFO("MemAvailable:");
> +	slab_prev = SAFE_READ_MEMINFO("SUnreclaim:");
>  	tst_timer_start(CLOCK_MONOTONIC);
>  
>  	/* leak about 100MB of RAM */
> @@ -92,28 +92,36 @@ static void run(void)
>  		check_progress(i);
>  
>  		/*
> -		 * Every 1200000 iterations, calculate the difference in memory
> -		 * availability. If the difference is greater than 20 * 1024 (20MB),
> -		 * increment the sample counter and log the event.
> +		 * Every 1200000 iterations, calculate how much the unreclaimable
> +		 * slab has grown. If the increase is greater than 20 * 1024
> +		 * (20MB), increment the sample counter and log the event.
>  		 */
>  		if ((i % 1200000) == 0) {
> -			mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
> -			diff = mem_avail_prev - mem_avail;
> +			slab = SAFE_READ_MEMINFO("SUnreclaim:");
> +			diff = slab - slab_prev;
>  			diff_total += diff;
>  
>  			if (diff > 20 * 1024) {
>  				sample++;
> -				tst_res(TINFO, "MemAvailable decreased by %ld kB at iteration %d", diff, i);
> +				tst_res(TINFO, "SUnreclaim increased by %ld kB at iteration %d", diff, i);
>  			}
>  
> -			mem_avail_prev = mem_avail;
> +			slab_prev = slab;
>  		}
>  	}
>  
> -	if ((sample > 5) || (diff_total > 100 * 1024))
> -		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
> -	else
> +	if ((sample > 5) || (diff_total > 100 * 1024)) {
> +		tst_res(TFAIL,
> +			"Likely kernel memory leak detected, SUnreclaim increased by %ld kB total",
> +			diff_total);
> +		tst_res(TINFO,
> +			"Unreclaimable slab can also grow due to memory activity from "
> +			"any other unrelated process. If this test fails, re-run it on "
> +			"an otherwise idle system and/or confirm with kmemleak "
> +			"(CONFIG_DEBUG_KMEMLEAK) before treating it as a real regression.");
> +	} else {
>  		tst_res(TPASS, "No memory leak found");
> +	}
>  }
>  
>  static void cleanup(void)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
