Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3BCC83F1B
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752494250; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=lNVEf7CInDTvFx1nXGjHeDFqOmeqRkvjcPd4HkIV7XM=;
 b=c0g6f7hmW2LUiQjYc4hwhuxGbCLBtucmhzTp5TBxFrRtu0OEVgXgFDLpzk53qqgJ7AOgj
 9xxuhRSDiB3Nk8L5J76jmmnN7SjIPWIFH0nHGRBKJrlYZ0eohihSF6wO13uFFimqcjbnSli
 lUKdnyQsfdZqAe/G1NWtLNLT/iXn3+k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36BD33CB5AE
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 13:57:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13FB03C06E9
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 13:57:09 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 73E00600BFA
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 13:57:08 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso3469040f8f.1
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752494228; x=1753099028; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jfO5iOB5ueFC3z1rPczlfl0PEyJelzdBKGoTdAHAv6A=;
 b=d6tl2xmQSOug1TykgbfD2S4YXas0YmlMxtPi5Q/ia5Gh1e1sVHQdDOKwf7u399ScBe
 YJLV5z0VgKFUttjs+zPXFvCZM3nu+9wMkGAvEKArFNqGv0+CnxMFW/cy0njCbE+N2Xoz
 eqcBrvJErKEZUQILbnBgwwAo1qLVxxJ4HMX6MJoCL4/Mj2vx56VCDCm5ksYS8VJE6ymK
 WsE6FyJtA/9cUVQeU/QLYdoKILq2VIkAOgw59u6z821niqkDUCYETewDK92CQRxkuWIA
 AGAPv1EQ860YCwKP3ybGz/O0ohNWNPdvdqmyOOa573gpziGIy0BDAcXeGqam0SWqX5d7
 D/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494228; x=1753099028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfO5iOB5ueFC3z1rPczlfl0PEyJelzdBKGoTdAHAv6A=;
 b=blxzZ9TXZVLv5coblXxJJipebhoeKi23UIG25JcvXod351gc7SKTRhPO0RBW9laOb/
 8Pg25BYhHp8cwhxGTRnMcwTiSxD359YEYS8yKUuDgOcSbUHKxyCFTJ7Jj86ysXIpHI1s
 t98kziIV0AnLEKoh45q6i+lxJLy1dHwr/m8k3W3WldyEOruYPwgL7q4aoZ64Q1wOeqJ+
 MxFPMwXRvH2dbKAM5KMrkcSueNDxJfe2jBiLdY4OjmW3rtVUkmG/Dfde8FBAzX578hoh
 RwOmFqdUNYTuDGr8sU9Ns0JjerBrcwiVchJ0FXSKSkx2kbKpTijyneYyQ7gcznhIKPIL
 06vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjejf1/0uMWIrDpdmovII//nsMVQuvKSvHLWDRVLk++++pIrSQISjlX4PzndKktF7P4f8=@lists.linux.it
X-Gm-Message-State: AOJu0YyQSJN/1GBmQRyak9ev7mwVgIsC4Pm3jkWc3fTB+ulIAui/1p8o
 M+75IuSkkzqycx1G4HoBXDaLEcpmN9mt8cM6V7e/noE9YReLBd/nKIKCosIlphZp1fY=
X-Gm-Gg: ASbGncugKrJEWbh/EUHFBk8oybAXSd71dxlIqua703KiIDjL3W2Ll/nim3MgCXY7reG
 1AB2m5TphhsurJWLpicnCAPISJaiK+/742Q3e+TO1U/JMBnU2BREWRdtin7RoihahxtAUplNFY7
 OsSntZl+swlATGYs/yOg1UrExSx+SwwiypQS6Pg2jNbnsmf+hbMlJJ1xY1j/OToz2mUQsaqvc4x
 e2KI77TaFBWk6byoEnQ7Q51iSBzh5843bSRs6xOD6jpsRMbaE+4rdh1/5/KKuLZDstDJm8RjMNH
 0pUWQGYLASXd9HTvfn6c/b6jJ5ZsAygX/QZFliOAuZxttm0XacKP2Fti07mu0HC5TWCZJQNw+F2
 JujYQGArTgoZ7wkqI0wSQCF/x9FmRc5iL
X-Google-Smtp-Source: AGHT+IFBdJK2Cdyq7K+J7puHF7DAsuRCcsujmaLhNRaWeevXcELPNzYivi0y6KOWDtZok+hQR1LFEw==
X-Received: by 2002:a05:6000:2c0f:b0:3b3:a6c2:1d1b with SMTP id
 ffacd0b85a97d-3b5f2dfd809mr9015225f8f.28.1752494227804; 
 Mon, 14 Jul 2025 04:57:07 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032fcbsm171317255e9.6.2025.07.14.04.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 04:57:07 -0700 (PDT)
Message-ID: <a019aba3-eaa1-4dd9-973b-c4bb8f3d4973@suse.com>
Date: Mon, 14 Jul 2025 13:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250710082000.11641-1-akumar@suse.de>
 <12708664.O9o76ZdvQC@thinkpad>
 <581805f2-0633-4e94-9252-b1be2bd47112@suse.com> <aG-BOM0OEKrp-GHm@yuki.lan>
 <2dbfe780-40b6-4b8a-9cb4-1517f3a8be7b@suse.com>
 <mqkxe24qlrcpb5jxgigbiarxxgemqjw3rmgnsprn55ubghrrda@etaozcz2nemy>
 <8810f8e2-af71-44f4-9163-3eb888a99f84@suse.com>
 <svs6pl6jmibp7uylvofkia5smvu2cuezfvnawlgkmjiulbrpfm@w7s7dlxxltap>
Content-Language: en-US
In-Reply-To: <svs6pl6jmibp7uylvofkia5smvu2cuezfvnawlgkmjiulbrpfm@w7s7dlxxltap>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_regression_test: Use unique names for
 hierarchies in each test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNy8xMS8yNSAzOjE1IFBNLCBNaWNoYWwgS291dG7DvSB3cm90ZToKPiBPbiBGcmksIEp1bCAx
MSwgMjAyNSBhdCAwMjo0MToxOFBNICswMjAwLCBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPj4gVGhpcyBnaXQgY29tbWl0IGlzIHBhcnQgb2YgY2dy
b3VwIHYxIGNvZGUgYW5kIG5vdyBpbgo+PiBrZXJuZWwvY2dyb3VwL2Nncm91cC12MS5jOmNncm91
cDFfcm9vdF90b191c2UsIGJ1dCBJIGRvbid0IHNlZSB0aGUgc2FtZQo+PiBtZWNoYW5pc20gdXNl
ZCBieSBjZ3JvdXAgdjIsIHdoaWNoIGlzIG91ciBtYWluIHZlcnNpb24uCj4gVGhlIHBhdGNoZWQg
dGVzdHMgdXNlIGNncm91cCB2MS4KPgo+PiBJcyB0aGF0IHNvbWV0aGluZyB3aGljaCBtaWdodCBh
ZmZlY3Qgb3VyIHN5c3RlbT8KPiBTaW5jZSB0aGVyZSdzIG9ubHkgb25lIGNncm91cCB2MiAodW5p
ZmllZCkgaGllcmFyY2h5LCBpdCBzb3J0IG9mIGxpdmVzCj4gZm9yZXZlciAoc3RhdGljYWxseSBh
bGxvYydkKSwgc28gSSB3b3VsZG4ndCBleHBlY3Qgc3VjaCByZXNpZHVhbHMgb24gdjIKPiAod2l0
aCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbikuCj4KPiBNaWNoYWwKCkkgYmlzZWN0ZWQgdXRp
bC1saW51eCwgYnV0IGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSB0aGUgcHJvYmxlbS4gT24gbXkgCnN5
c3RlbSAoVHVtYmxld2VlZCksIHdlIGFyZSBmYWNpbmcgdGhlIHNhbWUgZmFpbHVyZSwgbm8gbWF0
dGVyIHRoZSAKY29tbWl0IHRoYXQgaXMgdGVzdGVkIGluIHV0aWwtbGludXggYmV0d2VlbiAyLjM5
IGFuZCAyLjQxIHZlcnNpb25zLgoKSSBndWVzcyB0aGlzIGlzc3VlIG1pZ2h0IGJlIGNhdXNlZCBi
eSBhIHNwZWNpZmljIHNldHVwIG9mIHRoZSBMaW51eCAKa2VybmVsIGFuZCBpdHMgYXN5bmMgbmF0
dXJlLCBtaXhlZCB3aXRoIHNvbWUgc2VydmljZXMgd2hpY2ggYXJlIHNsb3dpbmcgCmRvd24gdGhl
IHVtb3VudCBwcm9jZXNzLgoKSSdtIHdvbmRlcmluZyBob3cgdG8gcHJvY2VlZCwgc2luY2UgdGhp
cyBpcyBhY3R1YWxseSBhIHNvZnQtZmFpbHVyZSBhbmQgCmFueSBmaXggdG8gdGhlIHRlc3QgbWln
aHQgaGlkZSBmdXR1cmUgYnVncy4KCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
