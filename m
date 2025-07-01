Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5A5C83038
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751374450; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=6LgEOJtx37+vMEnvu+cUFqzigk+AYjlMA2KLoX2AJvM=;
 b=qcoii+pBn9NgQl1fBeOt6RnPwRfMcANlgp3O3BQAfZOMJkPj4pobWmEJOJdWRvuQn2L9U
 +vx42uXDej0tjbdRQhnoW+IO612wg255HjDYLSX64KK1MM2q8Vz+l5Sf30VH/LPBpR4ENFV
 oRz7n4XqzDZcbTXB5CeDUjHMewfFr0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91D523C75EF
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 14:54:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD62E3C7113
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 14:53:48 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A9F001000A3A
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 14:53:47 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so23847675e9.2
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751374427; x=1751979227; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=puIPuC52dBgtVz2WsAA2hPJigGYR8ZM+qOn5TQ8GfiA=;
 b=eOSEPj1xgwhcygDSY8ViYqgjKTaH4YGG4qtwkxCXzrhcJnjtzPObPEITLmmmUBzvkJ
 oSp48sk3ivzvrs2d4+PcEd7796vitRLrPn6IqzyIvJEMJ5mUBpFYAKU6PSisaBbmeMnt
 N/jvNj5lmtP0jdWqRi2krT1BGoPnjc5/0r3hpIQK+DiJ7xpAGvbXb3VBADNCJkbMAqzN
 TC1GvpXZr6tkb5DJ7BD0P/h/fmJs6Q0j2UAK2PNsVaY0iG8LTXBkXYPe8R9qoXkfkXV+
 4bQrkU+urGhInH0aMgP6I6fZFZFUYTIEmZebj/GRarPi4vCF29RygTr92u3DfCg6Gq3J
 f++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751374427; x=1751979227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=puIPuC52dBgtVz2WsAA2hPJigGYR8ZM+qOn5TQ8GfiA=;
 b=t9R2PnEMuLcR/7SVjOa8Ejqgm4r4g1pkUqvIM9b45n5b9SyC5YY9RcX1P5EfA5vVVz
 Dd3dXEG4s988dI5Y8H9Gv9PLKrUuWhXhf1Kkt8wF6G+Rx9o8mGngurcTv1QciqCJ8Sn3
 TO3iXyzAfYlBcsFNkSrhSU42iL6EvtZOXoY9iJNEqBi10OtkJqMipC7RF5ChoWkvlZp1
 ukdtCQ6xETkL34G0JlY+lhidtLcDmooGmw3rx5s0yINe3BNC714aUwmUmdneJO2wRgaG
 WaT8B8Qnj8lOUs7thKt4hDXcyCelm4g1H7xQBwj3AkPbr1NjwUcjHjW16Tna/efnLgTr
 l3qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjUbqORYMKAWzwWGq05OWgEHrv6GbUyk8M0AUSotvlyYKSwck9dLAn0cro0oIeTYEl9UY=@lists.linux.it
X-Gm-Message-State: AOJu0Yx71fMEtVXQf3qtlp/yKXq1ZPZTvdztuGWg7zrN1VrdYwcOdMWp
 XdkT1BxiFvgIuKrHooF430wRGRGI3p6+UDBUkLZX3gSWDDxC+oTOBvrq1G9Lw+Si+8L+ahZgymo
 Ma0kysCY=
X-Gm-Gg: ASbGncu6C7iBZKZ5f6WpBnB2TFQyE7VH2FLqoqUl1fKdkJe2SlVIjpbnCfz/jKSj09+
 TuzKzXikraFib2XPqQD5cRLCxsbvhNfCa3vofZaGo0YGQB21NRvNtGi6Dtf3BT3FDCESxrO8I1a
 osMxesLhgjd6j8a27NNbJ6nSMnHIK0m04RtAUxorEttgq8qqZ2hnHWI8gpFAGyge0XxkOhxIS6i
 LM7J7FTQIJI94O7nGNKjfkOQdpq6M5xupXcFDz8rFNzqEZgaE1ogVQWKuFSXnjT1tN4ZEWDFdTG
 eQa8vHMoXLVCXdgEa/Qvnck0KLQTQLKmi8LQUY05nQ5yrfBt8/59RPZ/lcvYtzb2rVKdHqG2Ghl
 OBdcemMlGgkHSSI4dEpyRxkZaqO0dfiKUTCN0yeFSUD5VuOztQ2XMk9zys8rPDHEt8koUIDQhPR
 inrwuL4QLxdKExRzZqc3HHYe7FFQ==
X-Google-Smtp-Source: AGHT+IHQgY0eW1vQXi8/R7J+Z31Rkguhw/xOR/fwgYcnqeix+WzM0A532Eu+oUyDqfKBDLwBRGk27w==
X-Received: by 2002:a05:6000:4109:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3a8f4ee1d85mr14049799f8f.20.1751374426976; 
 Tue, 01 Jul 2025 05:53:46 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52b9esm13347558f8f.61.2025.07.01.05.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 05:53:46 -0700 (PDT)
Message-ID: <bec71130-b780-4dcd-ac51-f1cf93d664f6@suse.com>
Date: Tue, 1 Jul 2025 14:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250624-crash02_rewrite-v2-1-c4eaeee8598f@suse.com>
 <39406791-8bbd-4447-bbcd-0b25710a55e8@suse.cz>
 <c4dc4603-3adf-4da6-b0b2-a464ad453eb6@suse.com>
 <fec0312d-ddfc-4664-9f8d-1c0fb2e68b8d@suse.cz>
Content-Language: en-US
In-Reply-To: <fec0312d-ddfc-4664-9f8d-1c0fb2e68b8d@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] misc: rewrite crash02 test
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

T24gNy8xLzI1IDI6MTUgUE0sIE1hcnRpbiBEb3VjaGEgd3JvdGU6Cj4KPiBObywgdGhpcyBpcyBo
b3cgdG8gZml4IHRoZSBhbGdvcml0aG06Cj4KPiBzdGF0aWMgbG9uZyByYW5kX251bWJlcih2b2lk
KQo+IHsKPiDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgcmV0ID0gMDsKPgo+IMKgwqDCoMKgZm9yIChp
bnQgaSA9IDA7IGkgPCBzaXplb2YodW5zaWduZWQgbG9uZyk7IGkrKykKPiDCoMKgwqDCoMKgwqDC
oCBudW0gfD0gKChyYW5kKCkgJiAweGZmVUwpIDw8IChpICogOCkpOwo+Cj4gwqDCoMKgwqByZXR1
cm4gcmV0Owo+IH0KPgo+IFRoaXMgd2lsbCBnZW5lcmF0ZSByYW5kb20gbnVtYmVycyBpbiB0aGUg
ZnVsbCByYW5nZSBmcm9tIExPTkdfTUlOIHRvIAo+IExPTkdfTUFYIGFuZCB3aXRob3V0IGFueSB1
bmRlZmluZWQgYmVoYXZpb3IuIAoKV2h5IG1peGluZyB1cCB1bnNpZ25lZCBhbmQgc2lnbmVkPyBB
bHNvLCBhcyBJIG1lbnRpb25lZCBpbiB0aGUgcHJldmlvdXMgCmNvbW1lbnQsIHRoZSBtb3JlIHdl
IHVzZSByYW5kKCkgYW5kIHRoZSBoaWdoZXIgaXMgdGhlIGNoYW5jZSB3ZSB3aWxsIAptb3ZlIHNv
bWUgZGF0YSB3aGljaCBpcyBub3QgZ29pbmcgdG8gYmUgMCBvciBjbG9zZSB0byAwIG5laXRoZXIs
IHNpbmNlIApldmVyeSBjYWxsIHdpbGwgYWRkIGEgc2VxdWVuY2Ugb2YgYml0cyB3aGljaCBoYXJk
bHkgd2lsbCBiZSBzb21ldGhpbmcgCnJlYWxseSBjbG9zZSB0byB0aGF0IHZhbHVlLgoKLSBBbmRy
ZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
