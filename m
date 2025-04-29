Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E982C369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745921147; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=eBLik49LFFBu2Tox8rt3mnBKsR5otdO7A2P0CDR4r3I=;
 b=g6G9dGF9O3FEOed3wucKitYbFhqJHG9xhGURqqpmwBmBQIL67kewkiqdsftGD4Ofdf+Ne
 jEyabwobg9g92EVfqZ2rwmYOvcpmWWDfDPZKz0bgYGB9+cFqtiXMSgq9o0zcZXYZzNoSHEd
 4tYMFFUTBi3XdUl4zzqySJFThpNk9mM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF0C73C2B3A
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 12:05:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53FCC3CBBA6
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 12:05:26 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B46DD14002D0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 12:05:25 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso65596465e9.3
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745921125; x=1746525925; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3KiohfCStOySxV76NEkdq31/J5kb8n3yr47C1PQhGg=;
 b=Y51D6u68b1PSKQuxbl5w0PzSTngSyMpkWhVKfLQnVWf3RLM89a39u7ZiEBUlaZb1hS
 zNklz1aTBN7G075GcjPEb+PoOvczwu1eoP15O5HjzuldP+oxvULQkTuQUVV3Fh6lRRex
 jgqOuxbZXV2EZzsRSs5tjnFNreVMBXCY5W/tWm5UzwZTrjqPDrPLrZbIY0gYNh963Qq7
 IoNlFJEK+l8BXn9qCDbcyFitcMpFyKmMM/6UVDgYNgRgV2bBWY2AXaS9iz81gI28v4Ww
 IHQw5OpDEdo98JAeOR8HMtehcO7TVp08JMy0TVxgXcJGrvkuzWTpvJQFUN4X1qv5k6nt
 Xzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745921125; x=1746525925;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3KiohfCStOySxV76NEkdq31/J5kb8n3yr47C1PQhGg=;
 b=uAf8bk9OUI5xZNf6Hi7Fsg1dGNR/X/wEG4pqdQrYUscxWbojur27WiFL4ahpVPO8KP
 KJnkUobhKdufBpC84mg7JHID1yySWI3wjY3286PtgGKX1rb3wghC+LR4KnXectMqqD8E
 +2p5ZET+36f77176JqXxc8LpgGpKT1Euot2fgEKTjVOl6OlYOWtoqovUp4OMoA+12QU1
 RT2Re+rxB2E2Wt3WNlgpwWWeXG+m7ZjcRzb41dFzQIyxDQpkKwJe3ZRbOzHnZ3ntbtLm
 hoDHcfP0zyJOTygJcKVBLOs2a6fYGi7FyG7ckMxiLBCGea42MfQx2i8ZRFGmLZB9mVD2
 4xIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdo74yUoDtkgg9LkcneaWzCvzNNa7njAXFslaUNz+VJC2XCOLp2CF70EU+BAWNp7Z2/48=@lists.linux.it
X-Gm-Message-State: AOJu0Yz14elrZclRSGFjynlhF/fmhCIfBxAd2e0YsZ7dGHuX0o4hDkFN
 YdUUbjM+bE1VtJBGY9IMXN4DKAeuycWMAFn9AKoLAGeOufk3b77rk6ZUk/qq8BM=
X-Gm-Gg: ASbGncvSMQgAwZhdmlzGQ4/9/GgyzOWqWf9UXrir9+yzYzIu52N1jtDDmlx4ZZQ5kWL
 NOhrMFKWCXElrIA8IL/KvKFEQnTANn4ClI4UJ6WUzwpXBCvThvzk4sz1/j76zQtmXALGeUjy/uD
 QXbK7CQXMohCMJ/mUMQcvVMDfVugs5VnqeQPrYje/WiBJzZTq9SIB0ntXZbAVZTtsUvv3af+Zg0
 VwgdptimUKfgkMTKxY4cQ7Ng2uVzj6QdMKYhXsUfBFsgzMWLAjYSemaM0pPZ5143m03dRnobUkF
 WXWrK2X+SBWu9zX8uj8cNW97CgYzZPWytCXwDjc8KxUM2O6EQxK2KCFNhcUDAFzj0/qZtjtrqHB
 pKcXy9Z341plUDhKJlAVV34y92xcoeznal1FIGEDBviJl3ctlR59u1odrffhQGOyCYFzDmgz0Uv
 u8uEs=
X-Google-Smtp-Source: AGHT+IHXIhcmE7yN5c/sOpFIq7nLbiJkjLDglHm9IEcoDUbO7rfSEJg5n/PQKgKSJKJecKEJeeqXyA==
X-Received: by 2002:a05:600c:548a:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-441ac85ccfbmr24455085e9.17.1745921125046; 
 Tue, 29 Apr 2025 03:05:25 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d633sm13795996f8f.16.2025.04.29.03.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 03:05:24 -0700 (PDT)
Message-ID: <e2d43d92-3440-41f8-8861-784e52d59782@suse.com>
Date: Tue, 29 Apr 2025 12:05:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250408-conversions-modify_ldt-v8-0-7bdba108f64a@suse.com>
 <20250408-conversions-modify_ldt-v8-1-7bdba108f64a@suse.com>
 <9f41e34d-3bfe-4baf-84e0-bce28e39091b@suse.com>
 <D9J1AZYGUQJH.1COS1CN0FO9QB@suse.com>
Content-Language: en-US
In-Reply-To: <D9J1AZYGUQJH.1COS1CN0FO9QB@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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

SGkgUmljYXJkbywKCk9uIDQvMjkvMjUgMTI6MDEsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3Rl
Ogo+IEkgdGhvdWdodCBicmFjZXMgd2VyZSBub3QgbmVjZXNzYXJ5IGZvciBzaW5nbGUgc3RhdGVt
ZW50cyBibG9ja3MsIGl0Cj4gZG9lcyBub3QgbWVudGlvbiBtdWx0aS1saW5lIHNpbmdsZSBzdGF0
ZW1lbnRzLiBDaGVja3BhdGNoLnBsIGRvZXMgbm90Cj4gc2F5IGFueXRoaW5nOgo+Cj4gJCBiNCBw
cmVwIC0tY2hlY2sKPiBDaGVja2luZyBwYXRjaGVzIHVzaW5nOgo+ICAgIC9tbnQvZXh0L3NyYy9s
aW51eC9sdHAvY29udmVyc2lvbnMvbW9kaWZ5X2xkdC9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLXEg
LS10ZXJzZSAtLW5vLXN1bW1hcnkgLS1tYWlsYmFjawo+ICAgLS1zaG93ZmlsZSAtLW5vLXRyZWUg
LS1pZ25vcmUgQ09OU1RfU1RSVUNULFZPTEFUSUxFLFNQTElUX1NUUklORyxGSUxFX1BBVEhfQ0hB
TkdFUwo+IC0tLQo+IOKXjyAyM2U3ODQzMTkyN2Q6IHN5c2NhbGxzL21vZGlmeV9sZHQ6IEFkZCBs
YXBpL2xkdC5oCj4gICAg4pePIGNoZWNrcGF0Y2gucGw6IGluY2x1ZGUvbGFwaS9sZHQuaDoxOiBX
QVJOSU5HOiBJbXByb3BlciBTUERYIGNvbW1lbnQgc3R5bGUgZm9yICdpbmNsdWRlL2xhcGkvbGR0
LmgnLAo+IHBsZWFzZSB1c2UgJy8qJyBpbnN0ZWFkCj4gICAg4pePIGNoZWNrcGF0Y2gucGw6IGlu
Y2x1ZGUvbGFwaS9sZHQuaDoxOiBXQVJOSU5HOiBNaXNzaW5nIG9yIG1hbGZvcm1lZCBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllciB0YWcgaW4gbGkKPiBuZSAxCj4g4pePIDI2MDE2ODEwZTE3Zjogc3lz
Y2FsbHMvbW9kaWZ5X2xkdDAyOiBSZWZhY3RvciBpbnRvIG5ldyBBUEkKPiAgICDil48gY2hlY2tw
YXRjaC5wbDogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L2NvbW1vbi5oOjE6
IFdBUk5JTkc6IEltcHJvcGVyIFNQRFggY29tbWVudCBzdHlsZQo+ICAgZm9yICd0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21vZGlmeV9sZHQvY29tbW9uLmgnLCBwbGVhc2UgdXNlICcvKicgaW5z
dGVhZAo+ICAgIOKXjyBjaGVja3BhdGNoLnBsOiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21v
ZGlmeV9sZHQvY29tbW9uLmg6MTogV0FSTklORzogTWlzc2luZyBvciBtYWxmb3JtZWQgU1BEWC1M
Cj4gaWNlbnNlLUlkZW50aWZpZXIgdGFnIGluIGxpbmUgMQo+IOKXjyA5ZDMzZGIyOWU0M2I6IHN5
c2NhbGxzL21vZGlmeV9sZHQwMTogUmVmYWN0b3IgaW50byBuZXcgQVBJCj4gLS0tCj4gU3VjY2Vz
czogMSwgV2FybmluZzogNCwgRXJyb3I6IDAKIEZyb20gdGhlIHBvaW50IG9mIHZpZXcgb2YgdGhl
IHRzdF9icmtfIGNhbGwsIGl0J3MgIm9uZSBsaW5lIiwgYnV0IHRoZSAKYmxvY2sgaXRzZWxmIGlz
IDIvMyBsaW5lcyBhZnRlciB0aGUgY29uZGl0aW9uLCBzbyB3ZSBuZWVkIGJyYWNlcy4KUGxlYXNl
IGZpeCBhbHNvIHRoZSB3YXJuaW5nIHJlbGF0ZWQgdG8gdGhlIGxpY2Vuc2UgY29tbWVudC4gSSBt
aXNzZWQgCnRoYXQsIHdlIG5lZWQgdG8gdXNlOgoKLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXIgKi8KCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
