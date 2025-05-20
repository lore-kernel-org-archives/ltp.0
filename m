Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC350C3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747746686; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Jim91zGmUmXMjmhfE37weVmFCFowwWpv7kV3pMjXIhA=;
 b=ghsTb0Dcm8gjDIIp+Lx5ApCCOJ3s7chLjP2dafVootjswd4yo6ZRD4SV82al+vV3E4ikM
 JAWnv4Ni6L+JBlf7W+mJLt8LaOSiNM0/8sqnjTvUdhCXpQnQVnpj4QlIg3aqNtd0d4AYx7/
 qAKozEWFeOBhVJ4A6M1FoMwkeEk3KTE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1387A3CC768
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 15:11:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472063CC6C2
 for <ltp@lists.linux.it>; Tue, 20 May 2025 15:11:04 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7A805200270
 for <ltp@lists.linux.it>; Tue, 20 May 2025 15:11:03 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so33359325e9.2
 for <ltp@lists.linux.it>; Tue, 20 May 2025 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747746663; x=1748351463; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YP7FFe9Fq4hRZv3gVaEcS6BMPXy8hUzsrL3fv2zWvFk=;
 b=g/T1pB/7Fb3hYaoDItbRoDsOPLA9r98V4SrkYadP7JTPaNMCVpZ7Nd52NvsgQ7Olq5
 PvmJWVo2eGY21PjsyuRiIo2m6uAdCBJwT+6M/ciByFor1MvCKyrnOS56l2xHEUyGDXSv
 M+5TiH2LzmSJDpvlsAli0096X1I+O167aib1MSB3nK+OH1x6WV6XrFJvY75j8U6QFtBM
 7B2rjsIyYqau+ymsgXfXUq8AsvoZsV/YxJ5llKE2ZBgQdk8nOFX1kLzysJ+c+79wMbuj
 Woo2k2eLGIh2ystiFuk6mNhZll7DWSVPxEXtjEQGtUpDhtJIYOs4T6GQsQ3mmXx+EfQN
 ot7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747746663; x=1748351463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YP7FFe9Fq4hRZv3gVaEcS6BMPXy8hUzsrL3fv2zWvFk=;
 b=uPQ3Azx07voYjOlJf31+ZIbIlXW3PGEa70ROwqJEB9BiidjjFlJIQP8SWJYP5RvJpN
 zhV/kUYuM61T/jG9Ql75bj8hxThLC2auGWUZdT+u5d8obdThWFFYAzpyEBZcYWlwZLVF
 zvnSNgWc4rNfJWEIVesklgoc61DwbkiRhPEWlcPxHttFavAzk8FVO2cIUOYlBnpO73b7
 8U/UTJV14SFBD/g3gsUtQcppf7Tduylnyq9UuwXSiZigbWYIW2UnFDlZj4pF6dEk9msQ
 O4QnZ+1Xr4oCV9lIW0xig455IJc+YOZ2d5kBXPzg4gwiNJXPE44O+r9X6qA9PoR+jom9
 A3Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6HSILeUbuScJusxETwa4drPXYehiKb6Oua4T2zS9CkGTEQSekMJI72UbvKYD9UdgLi1k=@lists.linux.it
X-Gm-Message-State: AOJu0YwotN41Tdf1y2ONIGNbCF9q+rkVJjt8Mp3J2+oMPPlF1ALsHQla
 IBHTcOB0xigQhv9T8Epe5xbHkA/uEdiUImQHq2kcoRYx55D4jB45uKVjzZsCKEYnazh9nYJmo+d
 BFu/L
X-Gm-Gg: ASbGnctKwNBm3MYVw/TkN28dnu5F1uSqBfz8x4OrCRABb8VwQDJA93c/W0IXgtVtBVE
 bV2CmjCixwcFBTvQTU5eCU1KxwPksGGan7n/MUWJM4sGJjtyWSEmSGdFzDyKJ7Syb4wx9FgWoV4
 R3P7RF+u6zU69fjBtX7gdWhYL4ZxMOQaYpTd1l5RIbkiGsP9uTHxOf+SqNpyhG5qPTt92Dj09Hq
 UkPpGDQ9mGD+hdATI1LLvAJ3oPhbjzQVlIKfBhgMGRpze6HITXLwzN34lgtIiuULajL0ldL1Z8k
 vfIjHIY8Bp5H9NkuOKTlcVgS+tCzYMJ3PRBLuVAlPsEytq2KK7uIMTj1k24aOji128FrB8Mf
X-Google-Smtp-Source: AGHT+IGyqnO0766riBt3nRRA3E4seBMguH6ojK/cZa14yEjfOTRVvmbh/k5b1/NWpGqeu3AcSC3Vlg==
X-Received: by 2002:a05:600c:4fcd:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-442fd625850mr127318195e9.8.1747746662789; 
 Tue, 20 May 2025 06:11:02 -0700 (PDT)
Received: from [10.232.133.20] ([88.128.90.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d25b8sm31754075e9.17.2025.05.20.06.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:11:02 -0700 (PDT)
Message-ID: <a9cf9949-3224-43c4-8493-e53cd608d85c@suse.com>
Date: Tue, 20 May 2025 15:11:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250512-fixes-msgstress01-v2-1-49df739d93ca@suse.com>
Content-Language: en-US
In-Reply-To: <20250512-fixes-msgstress01-v2-1-49df739d93ca@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/msgstress01: Set upper bound for
 num_messages
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA1LzEyLzI1IDE0OjEwLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB2aWEgbHRwIHdyb3Rl
Ogo+ICsJaWYgKG51bV9tZXNzYWdlcyA+IGF2YWlsX21zZykgewo+ICsJCWlmIChhdmFpbF9tc2cg
PCBudW1fbWVzc2FnZXMgLyAyKQo+ICsJCQl0c3RfcmVzKFRXQVJOLCAiTnVtYmVyIG9mIG1lc3Nh
Z2VzIHJlZHVjZWQgdG8gJWQiLCBhdmFpbF9tc2cpOwo+ICsJCWVsc2UKPiArCQkJdHN0X3JlcyhU
SU5GTywgIk51bWJlciBvZiBtZXNzYWdlcyByZWR1Y2VkIHRvICVkIiwgYXZhaWxfbXNnKTsKPiAr
CQludW1fbWVzc2FnZXMgPSBhdmFpbF9tc2c7Cj4gKwl9CgpXZSBjYW4gc2ltcGxpZnkgd2l0aDoK
CiDCoMKgwqAgdHN0X3JlcygKIMKgwqDCoCDCoMKgwqAgYXZhaWxfbXNnIDwgbnVtX21lc3NhZ2Vz
IC8gMiA/IFRXQVJOIDogVElORk8sCiDCoMKgwqAgwqDCoMKgICJOdW1iZXIgb2YgbWVzc2FnZXMg
cmVkdWNlZCB0byAlZCIsIGF2YWlsX21zZyk7CgotIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
