Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAB7C8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751646413; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Bj/chdjeSvulLlox04qgTJJP4uN1uKO8e4Bsqyv4yCQ=;
 b=dyPssBpb41KF/csz/eaMkAJEfmbaLA6kcy1WEipaPecchkft0sV7wz2okYyUgX2SA4YG5
 YMoa5mWkWG3reHVtzwlAHnsFRdJzffGsJ637o+QjAhvDsM1QcHu0Qm3i7oWbU7jF6sJ1qzS
 WX+e9SdElhEEgB4AcFMqfglXetSbQKw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1319D3C9E3F
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 18:26:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEBE83C6633
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 18:26:31 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE86D60004C
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 18:26:30 +0200 (CEST)
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-ae3cd8fdd77so233136966b.1
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751646390; x=1752251190; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1wuY5dCHPBsaTAw9vL/mD4Xf2+FBfZ3Fhtl2eeFHpg=;
 b=PAUnbZ47vsViSwk+4tBlNVaLPNobDJJ2GlonZIQfL9Q8PaMkUFiB0nxIkHVnHG/mNC
 AvhhxRGrLzztfb8nqhapSPlCbLk8U6GOKTqPzkNmvCdOs6ELPQAFncu464NmLkzUHvZV
 pHCTFYsssYZootACXkBeiHobOF1aNjxpSNuZUMaNfAUoSdKoUPKzQSvh0l3BHBgnj934
 BkRebtIRXKIXYFVUJLH4fNY+1y2xz99jqGkTUqa7by7Zhx5vmIgYTEJPjH3/cdtWdvSE
 +hzUHWJunNDZN+pfoGTT4LjwonchM3RRqZ/DtPcb/b/xUkqPBUShpQI8bL1IBnoYScWB
 NZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646390; x=1752251190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L1wuY5dCHPBsaTAw9vL/mD4Xf2+FBfZ3Fhtl2eeFHpg=;
 b=ezl0H9oZbRL/NrYXh/5NL1IZkwhTRWWzj7RHHEuBr92qOsmzjf1RaDFFON+nr8ViFp
 KcQHEwFZiHeeMBzRUL9dxkVJYkmNABUyR6SP2AsUzaW6JjOfookNFu3Py1cesaju8+mI
 HUbdYa3BJkeQz/xpaf7wgkK5ZSHUhYwBMSBtQHk5C5LJhQZ6OBqNnkDSN87c4nL1D0y7
 TjR10DLw5SDcpFLAMEvdVcHrqcE1KB4Eu98vSNKDOHNGmcPYofT6jYRX5zEZh5pY8nYg
 JRjtB/Qlr87WqSetgUHyzoh5+Rghqj1oP6kVkmkOdl1ax8Q+BDWx1SOPaAMx6OQVn0LT
 B/tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTp2CdUk6YztcAA6Bg0W+xY5TRrnoDcyvE9Ebm9rOk9/O7xVanasKccvR9aMY216pJmkw=@lists.linux.it
X-Gm-Message-State: AOJu0Ywpl4WEfZDJHM3vyxHlf1fruhN+tYLHsChQiVQXgVmmL6e6rI4q
 I945lpyoNAoGsCBOEzNOzT4qV5vPvlCtgy7/XnaMsveOm1UTPr8SMke/HaPdcbmDBPq3PuC/pQW
 ZfxhqaAZbtxRt
X-Gm-Gg: ASbGncvNuLQ7t6MTaay0tJh9UakSFwjJNE5MGcTsSprFfl96dXdADtUggIi1OSgq7Lr
 QlRORFQZXTHxNKu2GQTIU/G1ZV4YIywev/L2dkfBeX/oRmuwkw5bGSRlmgAMirrMRGsi08ojeX5
 E9G3UZHC09yl2CSpmuKL4z5tq7yecEqNzG4pcsUBSi/wqFcp00v8Tmj0w/jMP1w+c9ASjlUhGmI
 EfalxBMlTWAydhIGcBaETDBtS+7s4EqHhGpr90iZteXIA1IiCFCiF/ap7S3No/0ylcOUzivWkrm
 ztA8LdSSSp5PSDxSuoympCm2GuFfVZ3kynraowHNzyWZOFUwC6WOhJsd7Rd82CguCgRi2KctohB
 jjffYt1mB0d4X8JInGRyxfGwDLL+MPX/e
X-Google-Smtp-Source: AGHT+IHua9Q/pI/BcFC3LaoFmXObeG0uQwfbDa0Vp5RSEjE9d24W2tNXFBcjlYbGE0xtD96FeokMjw==
X-Received: by 2002:a17:906:d54d:b0:ae3:6659:180b with SMTP id
 a640c23a62f3a-ae3fe6fe810mr299344166b.29.1751646390073; 
 Fri, 04 Jul 2025 09:26:30 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-179-193.web.vodafone.de.
 [109.40.179.193]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b5e839sm197399166b.157.2025.07.04.09.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 09:26:29 -0700 (PDT)
Message-ID: <3598e02d-bb1c-45cb-8f17-6a5e47b46e91@suse.com>
Date: Fri, 4 Jul 2025 18:26:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250703-conversions-munmap-v1-0-30de82d59004@suse.com>
 <20250703-conversions-munmap-v1-3-30de82d59004@suse.com>
 <54c64003-9dbe-435c-a647-90ec20fc16f1@suse.com>
 <DB3DH6Q3K9NY.MNT7YCB2EZI9@suse.com>
Content-Language: en-US
In-Reply-To: <DB3DH6Q3K9NY.MNT7YCB2EZI9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] syscalls: munmap03: Convert to new API
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

T24gNy80LzI1IDU6MjMgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3RlOgo+IE1vc3Qgb2Yg
dGhvc2UgYXJlIGZvciBtbWFwLiBUaGUgb25seSBvbmUgbGVmdCBzZWVtcyB0byBiZSBFTk9NRU0s
IHdoaWNoCj4gSSBkb24ndCB0aGluayBpdCdzIHZpYWJsZSB0byB0ZXN0LiBXRFlUPwpJIGd1ZXNz
IHlvdSBtZWFuOgoKIMKgwqDCoMKgwqDCoCBFTk9NRU0gVGhlwqAgcHJvY2VzcydzwqAgbWF4aW11
bSBudW1iZXIgb2YgbWFwcGluZ3Mgd291bGQgaGF2ZSBiZWVuCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBleGNlZWRlZC7CoCBUaGlzIGVycm9yIGNhbiBhbHNvIG9jY3VywqAgZm9ywqAgbXVu
bWFwKCksIHdoZW4KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVubWFwcGluZ8KgIGHCoCBy
ZWdpb24gaW4gdGhlIG1pZGRsZSBvZiBhbiBleGlzdGluZyBtYXBwaW5nLAogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2luY2UgdGhpcyByZXN1bHRzIGluIHR3byBzbWFsbGVyIG1hcHBpbmdz
IG9uIGVpdGhlciBzaWRlCgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2YgdGhlIHJlZ2lv
biBiZWluZyB1bm1hcHBlZC4KCkx1Y2tpbHkgaXQgaXMgdGVzdGFibGUsIGJ1dCB3ZSBuZWVkIGEg
bmV3IHRlc3QgZm9yIHRoYXQuIFdoYXQgd2UgY2FuIGRvIAppcyB0byByZWFkIApodHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9hZG1pbi1ndWlkZS9zeXNjdGwvdm0uaHRtbCNtYXgtbWFwLWNvdW50IGFu
ZCB0byAKbWFwIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBtZW1vcnkgbWFwIGFyZWFzLiBUaGVuIHdl
IG11bm1hcCgpIGluIHRoZSAKbWlkZGxlIG9mIG9uZSBvZiB0aGVtLCByZXN1bHRpbmcgaW4gKzEg
bWFwcGVkIGFyZWFzIGFuZCBvYnRhaW5pbmcgRU5PTUVNIApmcm9tIHRoZSBzeXNjYWxsLiBGZWVs
IGZyZWUgdG8gZXhwbG9yZSBpdC4KCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
