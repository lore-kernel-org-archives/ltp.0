Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED0CCAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758872468; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=dVJ/scVQB0vil2clZsLvPZdQuw0ofqX+L58I+M1caeM=;
 b=SlL/kAb9LVPRfJ3u1BbKNHokXxQlRb4ocv4cyysjEwSXs+v1mSUOF4DoAjCqY1G7W3+Vn
 8nrJYpQhtn2bId5LUdwCmzolj4Wf3IB3i/kUTUFtbDKnVrOJ77WqQmscqmik/3VyPCz8bLy
 aR3RLSV4Am7tG1XUlq1hpj7zgr4uVXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7E223CE09C
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 09:41:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88B733CA9B9
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:40:47 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A6D701A00099
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:40:46 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so16970885e9.3
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758872446; x=1759477246; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xXfV854b5ao9xv/E3DMkOy79owmAG+WS/Kotk3FGd04=;
 b=J62u+zO++X01DWGY39Jb0V9MmIEev61ZEMc+JU131/daAsPCCqTvYBe1roJ/ykmq53
 VMo0qcOBzx4JnF/hNP+WmyTZWjhljlXSRDtxHu/bGTE9zTbkQHxRjm1lcBjFvf1pbTY7
 lmACQzCX4TCiMlnn26pRukxA47Gsgukl1829rbh61RPxepfQoGl53D1O0bEnTT4FBqJY
 DmXGmPIGgEPL+DKHiv0/dCz5AuBo+3B6z0CnqvLGLAtAXhUpNA4dI3T6iszoLzH6K106
 oDheg7emwqDufXCftRt5ZLXt2bQv5QCnz2PdcPnmaUg36y5bON20kwVFymQBWO7VvZbZ
 G4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758872446; x=1759477246;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xXfV854b5ao9xv/E3DMkOy79owmAG+WS/Kotk3FGd04=;
 b=sye43uWUCPztZqo+OMKb/l6FVzV6BM1dVIioieTMViToao8vYyTUTj0ADae+ARGjRB
 WkqeAhF3QHRGHBUVvKqCBhll821B4O4sxSP9FDlbj3uTX29+cL/Sm8lYT/pwl7nr1OQn
 74gLE7F1oyMMHseuzGZYOlxv+dhrt0T7eZqc2rG+zfXwZ6wDpTYIN+231QqJAnOesfoN
 JOBpySiSvjqXij8QFWyYNnNgzXsRt7nkOI2YbFBZalLkMKFCPBnDsIT+R/78xWD77RdM
 ZXXTgAsmreXwUfvziRJDnsNdPARlAj6OnP0rsAVtqFW12trvLAlYRLCF+9mFeGW8GQSj
 PuDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8RZmjoqpj3Oly41fpvxaES+20XZqZAKn/FfigR97ktqnGJKXc3OlfJqfMGXnXjuAW1wg=@lists.linux.it
X-Gm-Message-State: AOJu0YxEQgPuT8Ym7/RsSGLTnAJipnxlmHQdX/JaEFQNTwTLgXdcc/xE
 nOcoBQgScuAgVA0KLXW2l4OKatDa537XrrBK4GOdcRlnix29GC6jjimFy1m2Y2/alC0=
X-Gm-Gg: ASbGncv1YXiCgVV3gnAcBT4zw5n3imJqIkJ9OM8SRVuA49shvA62n9V5QiONRnCZlGc
 Cz7pTQpXESH2xnDmu3gbM7ppwKMM/epT4FprlFg75zuKSQmp/kVddBChCru1n0OmkpaFxqIGNy6
 OtX+QLMTrSo6tuHdRmb/AYHNg0AhfKwiQzg4nHXto7u1tG5XGJzvnCwqPTIZIbPlNxACn1ZvFuP
 2KECN6yVrEJ9zanXGLl19/3df+LTn7363tPD5TYkn5F1EI2CCoqnxaHFNO8dqa6w09wwxlxLgOI
 lvj7+n71LK46rylA20t7prApnEDcsy0RFdKzJPyavA2f5W0WajuS2PlwEWJUGEJN7Lp2BHAcc0l
 c1YZLWq44FMszWOcw1sh/isNtvkwbCfCU1AWIbPsiSSnXZefjP2fk7S6eMnEee62FaQHB35YFJV
 eifzwBGRrYObNLwbKtqo2rj5DQ/TKtacuAvJ2dWJG1mimLD7IF2zi6wQcr9nGw9q653SsuURZqY
 w==
X-Google-Smtp-Source: AGHT+IFhsbXvVbq9OORCXjNxJTzoz1Ip37/8h1SlKya3k9yjMnu3emjxm0i+U5yklDeiDVhCInfLJQ==
X-Received: by 2002:a05:600c:444d:b0:468:86e0:de40 with SMTP id
 5b1f17b1804b1-46e3299a5c0mr53413185e9.4.1758872445996; 
 Fri, 26 Sep 2025 00:40:45 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33be21casm32904385e9.2.2025.09.26.00.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:40:45 -0700 (PDT)
Message-ID: <ab2c81a0-2ae8-48c5-ac28-cdb6d4ed347f@suse.com>
Date: Fri, 26 Sep 2025 09:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jack Morgan <jmorgan@naotchy.com>, ltp@lists.linux.it
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <20250926040707.671282-2-jmorgan@naotchy.com>
 <4d514eb9-cf7e-430e-a0ad-dfffdf947fcc@suse.com>
Content-Language: en-US
In-Reply-To: <4d514eb9-cf7e-430e-a0ad-dfffdf947fcc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount09.c: Enable mnt_ns_id for
 STATMOUNT_MNT_NS_ID
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

SGkgQ3lyaWwKCk9uIDkvMjYvMjUgOTozMiBBTSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiBI
aSEKPgo+IE9uIDkvMjYvMjUgNjowNyBBTSwgSmFjayBNb3JnYW4gd3JvdGU6Cj4+ICsjaWZkZWYg
TFRQX0hBVkVfU1RSVUNUX1NUQVRNT1VOVF9NTlRfTlNfSUQKPj4gwqDCoMKgwqDCoCBUU1RfRVhQ
X0VRX0xJKHN0X21vdW50LT5tbnRfbnNfaWQsIG1udF9uc19pZCk7Cj4+ICsjZWxzZQo+PiArwqDC
oMKgIHRzdF9yZXMoVENPTkYsICJzdGF0bW91bnQubW50X25zX2lkIG5vdCBhdmFpbGFibGUgaW4g
Y3VycmVudCAKPj4gaGVhZGVycywgc2tpcHBpbmcgY2hlY2siKTsKPj4gKyNlbmRpZgo+Cj4gVGhl
IHN0YXRtb3VudDA5IGlzIHRlc3RpbmcgU1RBVE1PVU5UX01OVF9OU19JRCBmZWF0dXJlLCB3aGlj
aCBpcyAKPiBjYXJyeWluZyB0aGUgbW50X25zX2lkIGFzIHdlbGwsIHNvIHdlIGRvbid0IG5lZWQg
dG8gcnVuIHRoaXMgdGVzdCBpZiAKPiBIQVZFX1NUUlVDVF9TVEFUTU9VTlRfTU5UX05TX0lEIGlz
IG5vdCBkZWZpbmVkLgo+IFdlIGNhbiBkbyBzb21ldGhpbmcgbGlrZToKPgo+IGRpZmYgLS1naXQg
YS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBpbmRleCBkNGRkMTMwMzMuLjE4OWQ4Nzcx
ZSAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUuYWMKPiArKysgYi9jb25maWd1cmUuYWMKPiBAQCAt
MjY0LDYgKzI2NCw3IEBAIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgY2FjaGVzdGF0XSwsLFsjaW5j
bHVkZSAKPiA8c3lzL21tYW4uaD5dKQo+IMKgIyBEZWZpbmVkIGluIDxsaW51eC9tb3VudC5oPiwg
YnV0IGluY2x1ZGUvbGFwaS9tb3VudC5oIGluY2x1ZGVzIAo+IDxzeXMvbW91bnQuaD4gKi8KPiDC
oEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgbW50X2lkX3JlcV0sLCxbI2luY2x1ZGUgPHN5cy9tb3Vu
dC5oPl0pCj4gwqBBQ19DSEVDS19UWVBFUyhbc3RydWN0IHN0YXRtb3VudF0sLCxbI2luY2x1ZGUg
PHN5cy9tb3VudC5oPl0pCj4gK0FDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCBzdGF0bW91bnQubW50
X25zX2lkXSwsLFsjaW5jbHVkZSAKPiA8bGludXgvbW91bnQuaD5dKQo+Cj4gwqBBQ19DSEVDS19U
WVBFUyhbc3RydWN0IHBpZGZkX2luZm9dLCwsWyNpbmNsdWRlIDxzeXMvcGlkZmQuaD5dKQo+IMKg
QUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBmaWxlX2F0dHJdLCwsWyNpbmNsdWRlIDxsaW51eC9mcy5o
Pl0pCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdG1vdW50L3N0
YXRtb3VudDA5LmMgCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXRtb3VudC9zdGF0
bW91bnQwOS5jCj4gaW5kZXggMjBjNzZiYTI0Li5iNzhjZWM2YjQgMTAwNjQ0Cj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0bW91bnQvc3RhdG1vdW50MDkuYwo+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdG1vdW50L3N0YXRtb3VudDA5LmMKPiBAQCAtMTUs
NiArMTUsMTEgQEAKPiDCoCAqwqAgwqBuYW1lc3BhY2UKPiDCoCAqLwo+Cj4gKyNpbmNsdWRlICJj
b25maWcuaCIKPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gKwo+ICsjaWZkZWYgSEFWRV9TVFJV
Q1RfU1RBVE1PVU5UX01OVF9OU19JRAo+ICsKPiDCoCNkZWZpbmUgX0dOVV9TT1VSQ0UKPgo+IMKg
I2luY2x1ZGUgInN0YXRtb3VudC5oIgo+IEBAIC03MiwzICs3Nyw4IEBAIHN0YXRpYyBzdHJ1Y3Qg
dHN0X3Rlc3QgdGVzdCA9IHsKPiDCoCDCoCDCoCDCoCB9Cj4gwqB9Owo+Cj4gKyNlbHNlCj4gKwo+
ICtUU1RfVEVTVF9UQ09ORigiU1RBVE1PVU5UX01OVF9OU19JRCBzdXBwb3J0IGlzIHJlcXVpcmVk
Iik7Cj4gKwo+ICsjZW5kaWYKPgo+IFRoaXMgY291bGQgYmUgZG9uZSBieSBjaGVja2luZyBpZiBT
VEFUTU9VTlRfTU5UX05TX0lEIGV4aXN0cywgYnV0IAo+IHNpbmNlIG1udF9uc19pZCBhdHRyaWJ1
dGUgYW5kIFNUQVRNT1VOVF9NTlRfTlNfSUQgYXJlIGRlZmluZWQgaW4gdGhlIAo+IHNhbWUgY29t
bWl0ICgwOWIzMTI5NWY4MzMwMzFjODg0MTk1NTAxNzI3MDNkNDVjNTQwMWUzIC0gZnM6IGV4cG9y
dCB0aGUgCj4gbW91bnQgbnMgaWQgdmlhIHN0YXRtb3VudCksIHdlIGNhbiBzYWZlbHkgdXNlIGNv
bmZpZ3VyZS5hYy4KPgo+IC0gQW5kcmVhCj4KRllJIHRoaXMgcGF0Y2ggbWlnaHQgYmUgbmVlZGVk
IGZvciB0aGUgcmVsZWFzZSwgc2luY2UgaXQncyBicmVha2luZyB0aGUgCmJ1aWxkIG9uIG9sZCBr
ZXJuZWxzIGJlZm9yZSAwOWIzMTI5NWY4MzMwMzFjODg0MTk1NTAxNzI3MDNkNDVjNTQwMWUzIApj
b21taXQuIFdoYXQgZG8geW91IHRoaW5rPwoKLS0tCkFuZHJlYSBDZXJ2ZXNhdG8KCmFuZHJlYS5j
ZXJ2ZXNhdG9Ac3VzZS5jb20KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
