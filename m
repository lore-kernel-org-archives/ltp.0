Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946F2C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783668919; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=G5iRSkGxAM+MtYsbipQwvTa8VJpRGwLJDCDZtZIjHs8=;
 b=m/8Hx76WsjULahW9TmgQZKIQ54SM4a7DS2erzzsx7i2lgmxrQxxYBFEjZqueLy8yUQv9K
 k79qj/F2biMNi0us+kKNU7h6C9ZKachOIkXAx6rPKIl1/eKP66hvfHuCe1wRLMezwWuRhcZ
 etgJptUo+iABPXDNunOwi0lAXfZKvNI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A2843E2795
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 09:35:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ACAD3E1EA0
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:34:58 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9824C6003C8
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 09:34:57 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so514905e9.3
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783668897; x=1784273697; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wXz5w+Vjw23tsG++VEgWIQR/Z1zeYk+F6Fm385dSYn0=;
 b=KPbwuokQrPdQIV/5GhCLFEVXUexIp2i8cMUp8tPrzupyncqYwq6fFgfHcfGKS9CHU6
 jHSga86rtFK/lDpSWX4mt1dQkfBBz6YctQPPhOa8tBw0uZDpyKu76+j5LLoaweffRUKc
 b64SN+TAhyBx78I2rSKkgjaNTOXr1EJNe71o0lK5KbmUi42mWx2Lo1na2dPReTEECTQE
 1z28knaOaAdhxySDkRnpnbOzY5bi50ANeuTvLTTCjT3GjPZoru+YQz8HJkLrN6qNKeLN
 qIw3oQXnhKLx9MU60ZojOC8HWMJ+HHBpMBnBhVb6xlgwg2nOVqWX4cOj5uep7frk/xKs
 iklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668897; x=1784273697;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wXz5w+Vjw23tsG++VEgWIQR/Z1zeYk+F6Fm385dSYn0=;
 b=S3SkjpisZ/EgF61yB1eSMV0Xz2g6WjWsKdi42UGnfCVuH5FWE/xQaH29jTB8Ywil5J
 nZBRA+/IOhJIVnBlW0kQoSUacfwVumWb1Hxbf7FZDfuRHkbNUtph4ZOZfHvy4i0QSnol
 goMA5fxDB9dGBmrrYTEIUkccEimop3VNJo7ZCBhfaygtBqwZPm9LBBXictQD61jwrcp8
 KGQpNm8iRHhIVrp5wADOsLC7RBZEnR0zRLsLB2vEGeqOYrbwCQwtHtnf3WvwyVy20Eee
 KMs9JcK8IuMU44bsmKOxYuNcm5a7UHt3UerXSi+kM9+KAsVnZ83ndkRbKom7cQ4CiDlX
 akLw==
X-Gm-Message-State: AOJu0YzpuUAeaThWkGQNFHMW/3VQSC8wttCX7q/LIejsz+aCI0G75kDz
 nc06bflbexPEQKS9ieHbLM+EMJhl7+Y/qFABftppa1KRD3iydmMrhzp3+71qK1EYSykMBohzFYq
 WqiHN01c=
X-Gm-Gg: AfdE7clqcmSnr+L/lfSz/t/iXla+6+BSQBtlU75p+EgYUxFjokANM1rON3tEXIHxN3Q
 e7VY0CYszlhfKb9S41xLXh3Ks7DZdHDkP76CUuuwESczT4CElDtcPnmwueeItNPGnxxHeQZBaKi
 ZskibBczK6GMe9gA1GFBISQMTrSvzFOZq3lLxD75810J8Mi0Gg8r3uak/WQdbHVqR72c94U76+g
 rzxYs/R3WaYpXo7OJvR+ucEEDf6mbVW02jFHrpVJeajeKuGAPBgiYSkebD/2FRNxpBq8DgISMKe
 a+e3qLiJTKoFP0He4p4JfdmRcm5pKw71kJ09FASx/N7alIWMsd6mU/e96cu6Q2yWFMi6x9Fs6A4
 TNaEUkEcztyCTjyIHD7Udj6uuct+739S8jn6XQNtjU5DySk81URwC5pR+paJ108VbpGn3iBfwnF
 GbmwLvdpr7irVNYX4exbL1rWeFKk/rNQ==
X-Received: by 2002:a05:600c:6287:b0:493:df47:8d9f with SMTP id
 5b1f17b1804b1-493f44262efmr14182945e9.10.1783668896899; 
 Fri, 10 Jul 2026 00:34:56 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm197730515e9.14.2026.07.10.00.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 00:34:56 -0700 (PDT)
Message-ID: <2241dfd8-b2f6-431f-9ced-604e7533a791@suse.com>
Date: Fri, 10 Jul 2026 09:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260704085703.618290-1-avinesh.kumar@suse.com>
 <20260708140154.GC125128@pevik>
Content-Language: en-US
In-Reply-To: <20260708140154.GC125128@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test.sh: TCONF on xfrm algorithms rejected
 via netlink extack
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

Thank for the review.


>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>> index 2a83c17a5efb..8701bb390388 100644
>> --- a/testcases/lib/tst_test.sh
>> +++ b/testcases/lib/tst_test.sh
>> @@ -266,13 +266,18 @@ TST_RTNL_CHK()
>>   	local msg1="RTNETLINK answers: Function not implemented"
>>   	local msg2="RTNETLINK answers: Operation not supported"
>>   	local msg3="RTNETLINK answers: Protocol not supported"
>> +	# Since v6.1 the kernel reports an unknown/removed xfrm algorithm via
>> +	# netlink extack (-ENOSYS + NL_SET_ERR_MSG), which iproute2 prints as
>> +	# "Error: Requested AUTH algorithm not found."
>> +	local msg4="Requested .* algorithm not found"
>>   	local output="$($@ 2>&1 || echo 'LTP_ERR')"
> nit: we have in $output also "LTP_ERR" in the end (on error)...
> 
>> -	local msg
>> +	local msg match
> 
>>   	echo "$output" | grep -q "LTP_ERR" || return 0
> 
>> -	for msg in "$msg1" "$msg2" "$msg3"; do
>> -		echo "$output" | grep -q "$msg" && tst_brk TCONF "'$@': $msg"
>> +	for msg in "$msg1" "$msg2" "$msg3" "$msg4"; do
>> +		match=$(echo "$output" | grep "$msg") && \
>> +				tst_brk TCONF "'$@': $match"
> ... now we print error message also with "LTP_ERR" in the end.
> I wonder if we should bother with removing it, e.g. with sed:
> 
> -		match=$(echo "$output" | grep "$msg") && \
> +		match=$(echo "$output" | grep "$msg" | sed 's/LTP_ERR$//') && \
I tested my patch, and I see atleast the TCONF path is fine, it does not 
print 'LTP_ERR' -

tcp_ipsec 1 TCONF: 'ip xfrm state add src 10.0.0.2 dst 10.0.0.1 spi 
0x1000 proto esp enc serpent 
0x5a78724d91fbdab8873e6bc7933816f9bb58b3da90ec2a6e0346ba41c6c18c63 auth 
hmac(rmd160) 0x4b53e65cb2e928d34c0db747782dda0457a3e4ed mode transport 
sel src 10.0.0.2 dst 10.0.0.1': Error: Requested AUTH algorithm not found.

but we will have it printed in TRBOK cases, as it was before this patch 
also:
tcp_ipsec 1 TBROK: ip xfrm state add src 10.0.0.2 dst 10.0.0.1 spi 
0x1000 proto esp enc serpent 
0x40e68502109572c1014d131358bcc38b45ae02e5bbdae35752de32c2b6c68a6e auth 
hmac(rmd160) 0x87658785bf2ffc586ce49e4d31318246429063ef mode tunnel sel 
src 10.0.0.2 dst 10.0.0.1 failed: Error: Requested AUTH algorithm not found.
LTP_ERR


> 
> (untested)
> 
> Both w/a this change (can be done before merge).
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr


Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
