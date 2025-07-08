Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55910C83F0F
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751968549; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=m2sBNgg1/6N+nbJsRWXv/kIYTVUEYHmMnhYNYXE9j3Y=;
 b=DEKzzQYYQSob8yAh6rJgebmKZZeNZqLz9nr+80xD8Xhk5qYNPPKLyxoLxMVMQL3udhhs3
 6J/yeDVInjtS/V7oXk66C/rCwCzQH21wPHnIwu+6DHfo3i5JNqA0gckPjNLGEfENm7KgpQM
 DRtCB6n4eBoSWzfNnAJlasOmLAZR2mk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB4D13CA2FC
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:55:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FE933C65DA
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:55:27 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B4D171AB96AD
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:55:24 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so2589067f8f.1
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751968524; x=1752573324; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+Qz5E2POq08YSevojLf7UziT9SBEqHdSpRopA2v1nE=;
 b=Xvjg5MVMGFpaVkuqbe0q9kY1YFDitnlGe+bJY9SWAzpgiiKc4aOSETJAoBghqlJXjU
 RxnU4eF13oWwwVEHqNqqHm8bCNTHJRBOETdA+0ssLWhIJPOhWA2UKXJRVBSnRyOqgpwn
 piuWTHQZdu8QrkcH1wDU3rzSwKCiXa2cYIaDJ5372CCc+UG7SKD3EPAM801Yyd3Zdlys
 QXbKUFLK+V7iXuPjvw4cQ99cJIniFedALNvO4arJJMinskfLH3Fn/EUhCVP3D0S9wkeT
 kXfRNhsnwpzKVjqc9r+3NT6X1RRo3t5XPvUNVitEUMLZ86sCfgu1DL4ww4C6nhFQYBBQ
 VmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968524; x=1752573324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+Qz5E2POq08YSevojLf7UziT9SBEqHdSpRopA2v1nE=;
 b=TAYRGT73VI7Z3OKxymjA8fCU8ws3cTXajTpu8/WwRTak0yjfu9C5OaNnowkeIvnrO6
 Nqn3ZopZXdhDfpnDGMROs9Pe8+sWy7wJWDT4NLVH3lXw6NYnwi8I4f0yLd5oPf+BgzlC
 G8/f52AwuS4qM4U6vzgzQbOYb4OVwDbg6rNwVyT8i1xdh9KoRIx/PtfuXf4/cYbCs3zx
 mHpUHQnI95tBeU6409UvuEn90Unc5My2/A/1qKe8Hk25noXfosU9ISE9luiBWqIqW/2a
 WOOpy9dLbeWJ2sBxl9VCzzmWEWNiqJH0iMQCV1/ieY8aAl/VJU702aDM1tkolFYf/U+o
 z7WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYWHQLVjbOrxkOoak7vgzGjPazy9NaJvObJLjP4knlrbIifamISvZu7KYBxQ0a2OfMbqc=@lists.linux.it
X-Gm-Message-State: AOJu0YwNmXV3kSevmPdfG3w8DhpVZv3vznNezbti6hcv5BQ1e9cWpwqk
 D6HalZFmTZdgR7BLOtgstNel0AavrFqhldvLwzjRpqO5ZRa2WKXW6te7ruE3Mp1HQzk=
X-Gm-Gg: ASbGncu1HX0vDEFwQvVVgKHHJZAOGqfRtmIGIWfWZyWLQbIMBsmUyJ9AIpM2k4prXdr
 d7w5EHIdS9ofXUuice3nysnA5Toj8heThljr5hQPlmycWSke4m2IcfktWNFZs+wmRsvD6+gvje+
 sQJOu3V9uVqJ8fy/Gb5ieFFfQTcYTdysT8hR4GmrLwBfxuk5CWBMng5gUjQpQj1EKnm3L22F7N8
 J4x0o+s0z5RlKtHnspjOpLqJinFK/yue3zXt6S8jcDiS7vCHA4AYTWkr3Qvppb6ytMjnklvb8s/
 DaHBbLRoi9KJf7ajjmLEQG1wqhqrM2CtkrwfQYva1eJIqP9d9cgpPTXsam44W6goy51ySG8fF0e
 /05meT3FRdfozTS6LarI3qo6NMx6qIALw/R5tafa0BF5EAPOn2kzAk7TCH++fNRVMiqgZEoP+qu
 WmPQLb1hDImyJsg7UN2JCzgLaffg==
X-Google-Smtp-Source: AGHT+IE9YU/Di3tRJSywLpVECn6ogtcm3XX4CxgN03ZtQLh2ovMHgknLihPaVrgjhx20rh5u19mocA==
X-Received: by 2002:a05:6000:4a14:b0:3a4:f435:5801 with SMTP id
 ffacd0b85a97d-3b49701cb56mr13201348f8f.17.1751968523974; 
 Tue, 08 Jul 2025 02:55:23 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8459899fsm110131665ad.194.2025.07.08.02.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:55:23 -0700 (PDT)
Message-ID: <4b8040d8-cde7-4052-854b-c78701ed6094@suse.com>
Date: Tue, 8 Jul 2025 11:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-conversions-munmap-v6-0-e6b02f57ac29@suse.com>
Content-Language: en-US
In-Reply-To: <20250708-conversions-munmap-v6-0-e6b02f57ac29@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/3] syscalls: munmap: Convert to new API
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

UmV2aWV3ZWQtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
CgpPbiA3LzgvMjUgMTE6NDcgQU0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3RlOgo+IFNpZ25l
ZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gQ2hh
bmdlcyBpbiB2NjoKPiAtIG11bm1hcDAxOiBTaW1wbGlmaWVkIGNsZWFudXAgdW5tYXAgbG9naWMg
KHN1Z2dlc3RlZCBieSBBbmRyZWEpCj4gLSBMaW5rIHRvIHY1OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUwNzA3LWNvbnZlcnNpb25zLW11bm1hcC12NS0wLWYyNzNlYzg2ZTUwZkBzdXNl
LmNvbQo+Cj4gQ2hhbmdlcyBpbiB2NToKPiAtIG11bm1hcDAxOiBGaXhlZCBjbGVhbnVwIHVubWFw
IGxvZ2ljCj4gLSBMaW5rIHRvIHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA3
LWNvbnZlcnNpb25zLW11bm1hcC12NC0wLTA5NzdiMjMzODU1MEBzdXNlLmNvbQo+Cj4gQ2hhbmdl
cyBpbiB2NDoKPiAtIG11bm1hcDAxOiBTZXQgbWFwX2FkZHIgdG8gTlVMTCBhZnRlciB1bm1hcHBp
bmcKPiAtIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDctY29u
dmVyc2lvbnMtbXVubWFwLXYzLTAtMDYzMjUzN2E2YzhkQHN1c2UuY29tCj4KPiBDaGFuZ2VzIGlu
IHYzOgo+IC0gU3RvcHBlZCB1c2luZyAibWFwcGVkIiB2YXJpYWJsZQo+IC0gU2ltcGxpZmllZCBj
bGVhbnVwKCkgaW4gbXVubWFwMDEKPiAtIFJlbW92ZWQgdW5uZWNlc3NhcnkgY29tbWVudHMKPiAt
IExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MDQtY29udmVyc2lv
bnMtbXVubWFwLXYyLTAtYmFjM2EwYWExMTdiQHN1c2UuY29tCj4KPiBDaGFuZ2VzIGluIHYyOgo+
IC0gbXVubWFwMDM6IFVzZSBzdGF0aWMgdmFyaWFibGVzIGZvciBzcGVjaWZpYyB0ZXN0IGNhc2Vz
Cj4gLSBtdW5tYXAwMTogVXNlIGZvcmsoKSBpbnN0ZWFkIG9mIHNpZ25hbHMKPiAtIE92ZXJhbGwg
Y29tbWVudCBjbGVhbnVwCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjUwNzAzLWNvbnZlcnNpb25zLW11bm1hcC12MS0wLTMwZGU4MmQ1OTAwNEBzdXNlLmNvbQo+
Cj4gLS0tCj4gUmljYXJkbyBCLiBNYXJsacOocmUgKDMpOgo+ICAgICAgICBzeXNjYWxsczogbXVu
bWFwMDE6IENvbnZlcnQgdG8gbmV3IEFQSQo+ICAgICAgICBzeXNjYWxsczogbXVubWFwMDI6IE1h
a2UgaXQgYSB2YXJpYW50IG9mIG11bm1hcDAxCj4gICAgICAgIHN5c2NhbGxzOiBtdW5tYXAwMzog
Q29udmVydCB0byBuZXcgQVBJCj4KPiAgIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEgLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAv
LmdpdGlnbm9yZSB8ICAgMSAtCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9t
dW5tYXAwMS5jIHwgMjc5ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDAyLmMgfCAyNTIgLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDMu
YyB8IDE2OSArKysrKy0tLS0tLS0tLS0tLQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxMTcgaW5zZXJ0
aW9ucygrKSwgNTg1IGRlbGV0aW9ucygtKQo+IC0tLQo+IGJhc2UtY29tbWl0OiAxNmNkNjdlZjFm
ODVlNmIxNGMxODJmYTQ5NjMyYTUwMTQ1NjBlZGZhCj4gY2hhbmdlLWlkOiAyMDI1MDcwMy1jb252
ZXJzaW9ucy1tdW5tYXAtM2I2YTI5ZmFhMjY4Cj4KPiBCZXN0IHJlZ2FyZHMsCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
