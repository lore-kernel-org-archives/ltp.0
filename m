Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F623C83F1A
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752237709; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=XsYdm14D3MSJvSli9Lo3rwNjpcdMj2vghSP2Ofynlec=;
 b=SFy1WJqLU9dpA31gqM9v78KDuxY8XW9hQxiWiIsXQLL4PxciTNV4TgDD5IVOg3HyJ0qXc
 kK5wV2fbwOHP/iVIFAqWpQsZrCllsk3Ntlo9vnl20m/PVNeocuSAfTKHor+dQujnSP3lZAt
 gemPrVTzBXW69MN62NfJKF0Wkz6NX4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEF0A3CB314
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 14:41:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C1913C06B5
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 14:41:27 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 489401A00701
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 14:41:26 +0200 (CEST)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-454ac069223so16792515e9.1
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752237686; x=1752842486; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ivCPcKSm+ucDGuP23tn+DddA/l2H6Il3PzG9fCys3Ho=;
 b=LEp/rv1gfRaP5XbFT/QSg2hffW6zNXqYW8CpB5I8/UZyLLjf6RUueYUWLNnBBqoVX2
 UUQIdPeeKzZNZItmclcRagbWQ/c50Qp0ETNHYhybYJwj0Kel0p1zwTwDMXv+OxtlIwCz
 ZVhID/mWxngznY53+7E0RMUNZx+y6IQHCkIWK1erkERmBHgpQGRusP1jEJlFibrNHN1Z
 TIcccQnSkwQYPYTB0/OPAqHepfV+3Z0/XgYFAfkxyWnUnFOLKwyQsQa6JzlZZoaVgTFC
 9lJ4h/SXeAxPcONLn09haQCNaBMu7PXH7MkL9vygogP3qTIaoj/fBVTnUs7Y+WIZfdFH
 ePVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752237686; x=1752842486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivCPcKSm+ucDGuP23tn+DddA/l2H6Il3PzG9fCys3Ho=;
 b=IoXQgnf9tRfn1AvzVK/oJW40pJ3D29XBQNmHTRn2W0wS+xz+fWBl2c5dk0lcdUXTRO
 gYtKa9mTYQ0cjkqx8jXX07JG0nB9q7tFTd8IjDxyrKKWvhjDqkBCWZYfyfXf2k456FcR
 OGhVoLN1oQ4rDHWHEmGuWU4jdMph/OWFBQab2NZr/ihpeTqcICuWJlefpQukF2N8Zoyz
 GRz3TsQnN7C3RVFk4OerberMu9lBQq+iDl70zN7AGkNDV7hmm1ILTIGAH2dcooWWv4lk
 xsOKWQf8ZF4aotG/jAUI/TSWmR1091cZVqfeUNYEUbj0xmFTBipmfjs3wBw0vhgYJlnr
 UOuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMGNEIxwmo6twRd3jt3NTLzf/zWGqkd1z+1sy2cPPk57rUPUR8CxzT+NdkmTUTSPFa97U=@lists.linux.it
X-Gm-Message-State: AOJu0YxT8gJySgfVrOQe+Sq9A5WZ+iWn8hsSnxsf5YkpLR3UgIOr3JeZ
 6t4HCJKdeqv0SOESVrvwsqRGxt2cxx5xSkwk5v4rvVuz17OnOzMfhDd2qBBTeAI6Xc/goKG7LnP
 o2cgLQ+ufZ6Nj
X-Gm-Gg: ASbGncsJmbzUp8U2QEUGT83JFXsHk3Lx7JXk/EgdksImTOlnUlNas1CEbC8sqc/0eMl
 MYcSTU1N33pP1L7zeM1K5HvNF5Ez05yxgaQu4wrhmTSFSPz0rv/B5i5CuJs+T06m+mUF/4a5mz7
 P6EUBJX2PWlN9wccGqjHhcaTHgc8q6vx3MlEfZtFcZ+7Ip7K4a165eMkBlQhjvG0t5EFqfrXzBH
 DD3+TAknzWlTIeLaQm3JSm2LHxPmSWoYwym0iV0epFSJo0d0IGoaGyOH1KlmjgREWOvm68HlBQA
 SYbSHYHdTb6wmGhOyZ9ZAoUu6pEx/LQRHcbZ6frGR3t95SxVhWh8c/yGj3Xn0QkAL/vVVSx0mvb
 YhqStnwlFD1dRsDTvcbDYrWWZCNgVtw16JtC+5IIh5n6/0tsDaxAQrVwfvV7IvQFteZqV8rnZ9r
 /OFXrlVDr/so4ArM1bq2xCGoI+NYgUAeIUXvN06l6+pz9lxmUqRHUAmAdp/RSZrA==
X-Google-Smtp-Source: AGHT+IESRJzKyBn0HSDI3+y6lsTdAIBZP+QZfOqEKsBniMosdAB8yMd2pPK2+k/DSyA5RLQecCFnrA==
X-Received: by 2002:a5d:5f51:0:b0:3b5:e6bf:f86b with SMTP id
 ffacd0b85a97d-3b5e7f11908mr7143065f8f.11.1752237685609; 
 Fri, 11 Jul 2025 05:41:25 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f1af40sm5473410b3a.72.2025.07.11.05.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 05:41:24 -0700 (PDT)
Message-ID: <8810f8e2-af71-44f4-9163-3eb888a99f84@suse.com>
Date: Fri, 11 Jul 2025 14:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20250710082000.11641-1-akumar@suse.de>
 <12708664.O9o76ZdvQC@thinkpad>
 <581805f2-0633-4e94-9252-b1be2bd47112@suse.com> <aG-BOM0OEKrp-GHm@yuki.lan>
 <2dbfe780-40b6-4b8a-9cb4-1517f3a8be7b@suse.com>
 <mqkxe24qlrcpb5jxgigbiarxxgemqjw3rmgnsprn55ubghrrda@etaozcz2nemy>
Content-Language: en-US
In-Reply-To: <mqkxe24qlrcpb5jxgigbiarxxgemqjw3rmgnsprn55ubghrrda@etaozcz2nemy>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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

T24gNy8xMS8yNSAyOjA4IFBNLCBNaWNoYWwgS291dG7DvSB3cm90ZToKPiBPbiBGcmksIEp1bCAx
MSwgMjAyNSBhdCAxMjozNjoxNVBNICswMjAwLCBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPj4gT24gNy8xMC8yNSAxMTowMCBBTSwgQ3lyaWwgSHJ1
YmlzIHdyb3RlOgo+IC4uLgo+Pj4gVGhpcyBpbmRlZWQgbG9va3MgbGlrZSBhIHdvcmthcm91bmQg
Zm9yIGEgYnVnIGVpdGhlciBpbiB0aGUgdGVzdCBvciBpbgo+Pj4gdGhlIHN5c3RlbS4KPj4+Cj4+
IFBlcmhhcHMsIGJ5IHBsYWNpbmcgc3luYyBiZWZvcmUgZXZlcnkgbmV3IHRlc3Qgd2hpY2ggaXMg
Z29pbmcgdG8gbW91bnQgYSBuZXcKPj4gY2dyb3VwIGZvbGRlciB3ZSBmaXggdGhlIGlzc3VlIGFz
IHdlbGwuCj4gVGhhdCBtYXkgb25seSBhIHdvcmthcm91bmQgdG9vLiBNeSBiZXQgaXMgeW91J2Qg
cmF0aGVyIG5lZWQgc29tZSBSQ1UKPiBiYXJyaWVycyBvciB3b3JrcXVldWUgZmx1c2hpbmcsIHRo
dXMgdGhlIHNpbXBsZSBzZXBhcmF0aW9uIGJ5IG5hbWUuIFRoZQo+IGNsZWFudXAgcGF0aCBpcyBq
dXN0IHNvIGFzeW5jaHJvbm91cyAodGhlIGNvZGUgaGFkIGFscmVhZHkgYXR0ZW1wdGVkCj4gc29t
ZSBuYXN0aW5lc3MgWzFdLCBob3dldmVyLCBJJ20gc3VzcGVjdGluZyBpdHMgZWZmaWNpZW5jeSBt
YXkgYmUKPiByZWR1Y2VkIHVuZGVyIGxheWVycyBvZiBWRlMgcmV3b3JrcyBzaW5jZSB0aGVuKS4K
Pgo+PiBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZCBkaWcgaW50byBpdCBhIGJpZyBkZWVwZXIu
Li4KPiBJdCBtYXkgYmUgd29ydGggY2hlY2tpbmcgdGhhdCB0aGVyZSdzIGEgY2hhbmdlIGluIHV0
aWwtbGludXggdGhhdCBoYXMKPiAocHJlc3VtYWJseSkgYWZmZWN0ZWQgdGltaW5ncy4KPiBOb3Rl
IHRoYXQgdW5tb3VudGluZyBhIGNncm91cCBoaWVyYXJjaHkgaXMgb3BlcmF0aW9uIHRoYXQgdHlw
aWNhbGx5Cj4gaGFwcGVucyBvbmNlIGR1cmluZyAibGlmZXRpbWUiIChpZiBhdCBhbGwpIC0tIHNv
IGl0J3MgeW91ciBjYWxsLgpJIHNlZSwgdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gSSB3aWxs
IHRha2UgYSBsb29rLgo+Cj4gSFRILAo+IE1pY2hhbAo+Cj4gWzFdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPTk3MDMxN2FhNDhjNmVmNjZjZDAyM2MwMzljMjY1MGM4OTdiYWQ5MjcKClRoaXMgZ2l0IGNv
bW1pdCBpcyBwYXJ0IG9mIGNncm91cCB2MSBjb2RlIGFuZCBub3cgaW4gCmtlcm5lbC9jZ3JvdXAv
Y2dyb3VwLXYxLmM6Y2dyb3VwMV9yb290X3RvX3VzZSwgYnV0IEkgZG9uJ3Qgc2VlIHRoZSBzYW1l
IAptZWNoYW5pc20gdXNlZCBieSBjZ3JvdXAgdjIsIHdoaWNoIGlzIG91ciBtYWluIHZlcnNpb24u
IElzIHRoYXQgCnNvbWV0aGluZyB3aGljaCBtaWdodCBhZmZlY3Qgb3VyIHN5c3RlbT8KCi0gQW5k
cmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
