Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABDCC021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739797772; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=1mo5VYLUjrOba00LCn32raa3wfyF5psdtF3Qk8Xsn/M=;
 b=qjRbEsEJ5Fee9H0G/M4+Tmz4NzmDDsdQfM0PxUGKyAQnF1wyUWGZW2zqUT5hwUAky4wL4
 wl/TgO3dcJCEvruN8j8BLAfb42HypyhHgKVGzWH+nkoLllMDFTdaUUzYpxJgPCe5H2LrxaN
 WiKRXfO80KuJMANFnDJXdoJ8VDfVHuU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EED3A3C9C5A
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:09:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 752473C4C99
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:09:10 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 016DD6BFB3D
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:09:10 +0100 (CET)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7483b9bf7so551834066b.3
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 05:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739797749; x=1740402549; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5HBxqCkRaiT4g0PptgAPXoxKOvsLSAkmbqRGD+cFlDs=;
 b=EVtAWPU0AqUaXaAHD3Sk+LR+udcj2iOZouyg5WVlIgZVzphFR1+nYUwQLHg9Nepf6M
 mmQVzGicnyGWcnKjuHAxmAwa3ASGlkpMd2gb6/PIrpZEOEjubudD7BYAGg/QXaAESpGj
 Q14BhNiJINfYQO+2ILQUu0kjBrTRVRuLjP3IEge/LpcE2lRNJs/l+BFdgjEwCiosT3Ng
 doxkznwh8UrbrD28CPhFPXz3a/yy5MpEek6fyqS2GfIu0xgmhIIF5ODV+PLNP+ESwsB1
 UHoa/fykZat2bPt5sWe/EuY3ifwRHqcrgC1Va9kzeYUpbY+Tt/wfvRgb3F6i+5e1JcU2
 AYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797749; x=1740402549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5HBxqCkRaiT4g0PptgAPXoxKOvsLSAkmbqRGD+cFlDs=;
 b=gtgxp4JtaZbcfRqbSeRRPqprh/lFXexhBD7dLQQ0p4Eh5MctoVo0wFAQa17znpN3Ei
 W9e5HaQfVBga1sg3Ty7By8Nq2K5SuLM4aZpVZbnwon0oSxCQfNMoMzkv1fh0M1uzNraH
 7IvE2CxNkMhokDdQnSdmiICSrnZg/RS+dzjbkBzOJM5Z7wn2HNCJ41fFqJ05L9oojRHS
 xlojk77t5QOsoW9RvH+D6inZ4ik7X24hfUZ+czSccGz2sjvJz6en8KpBGWbp1QMT8Mka
 xhXLBbJLboymg6DBreKnK9xbizcTTz4lEdocTOS5imFbxVmRuPYGtdcYAc5gE6jOSH7H
 xXWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh8eABcPYIMElOEPaaXSy/B4RbNuoaRE6dzDnub/IvtYdMtdwcJTjG57hz+wbqlK2jfrM=@lists.linux.it
X-Gm-Message-State: AOJu0YwprXY+U2U4ocyhyFFjSOv5u6ffu0H2OpSVaGq4YFBO71mY6boo
 KXpD8khasf9jqbcCorY3NBhxlpKD/S8eGJ+kQxzyOpu7jU7V8FTfz88WyLzdCEk=
X-Gm-Gg: ASbGncuofER4ASM95cZk0LsZ77qA1hcazKB1WBpaiM+57kIjLScOiG4xg+QQ79DPX77
 nfSxA7aAdd90frqhHJknTs7vkaMJiKtlhaJ3S/vLmtxWtGCEWupZRqjwedENgsQofUYkUsgo2jW
 oVW9koWcesaKHEHX3QoJMliOmvavHWWglwm6nJB7Zf7mGM3HItvXuPlwqPD+DKaJpN6jKoGPTHk
 O+yG6Fht9cIGrsZxI/4K7h11kGeORZUpoiOZqfTG584IwEwKmfxMQ0hkdTlNIRpvq33txAPmS0V
 n74/mMPY28RbzmHEW9Xw/8b5alfu9sIHS2ZtMzYbJRID5Dcsp4JaYoUWOt0fn69T5Di5HZ2Uh8D
 e/PbIMZe0bjCO6GrxZmrUPU/Nl7J6Dmmq2YtBb5t0NbEdpCfHCaU=
X-Google-Smtp-Source: AGHT+IFao7FuQLf+s1gTi0XSu+B5gF9YwIbFV79KG8lFPt8mZjw3VikDnheRkBTa0M92WZ1I2h7gng==
X-Received: by 2002:a17:907:9494:b0:ab7:d537:91cb with SMTP id
 a640c23a62f3a-abb70aa6217mr1022429766b.7.1739797749351; 
 Mon, 17 Feb 2025 05:09:09 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba316dc67sm127040366b.43.2025.02.17.05.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:09:08 -0800 (PST)
Message-ID: <ec5c8dc6-1d3b-4005-8d0c-78b879dc00ad@suse.com>
Date: Mon, 17 Feb 2025 14:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <ricardo@marliere.net>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250217-clear_descriptions-v1-0-90e8229d52b4@marliere.net>
Content-Language: en-US
In-Reply-To: <20250217-clear_descriptions-v1-0-90e8229d52b4@marliere.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Clean [Description] leftovers
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

TWVyZ2VkLCB0aGFua3MhCgpBbmRyZWEKCk9uIDIvMTcvMjUgMTM6NTksIFJpY2FyZG8gQi4gTWFy
bGnDqHJlIHdyb3RlOgo+IEhpLCBwbGVhc2UgY29uc2lkZXIgcHVsbGluZyB0aGlzIHNtYWxsIGNs
ZWFudXAgc2VyaWVzLgo+Cj4gVGhhbmsgeW91LAo+IC0JUmljYXJkby4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyaWNhcmRvQG1hcmxpZXJlLm5ldD4KPiAtLS0KPiBS
aWNhcmRvIEIuIE1hcmxpw6hyZSAoMik6Cj4gICAgICAgIGRvYzogUmVtb3ZlIFtEZXNjcmlwdGlv
bl0gdGl0bGUKPiAgICAgICAgc3lzY2FsbHMvZm9yazAxOiBJbXByb3ZlIHRlc3QgZGVzY3JpcHRp
b24KPgo+ICAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDE3
LmMgfCAyIC0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2Vt
bWFwMTkuYyB8IDIgLS0KPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDEu
YyAgICAgICAgICAgIHwgNiArKy0tLS0KPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9y
ay9mb3JrMDMuYyAgICAgICAgICAgIHwgMiAtLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mb3JrL2ZvcmswNC5jICAgICAgICAgICAgfCAyIC0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2ZvcmsvZm9ya19wcm9jcy5jICAgICAgICB8IDIgLS0KPiAgIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDEuYyAgICAgIHwgMiAtLQo+ICAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9nZXRldWlkL2dldGV1aWQwMi5jICAgICAgfCAyIC0tCj4gICA4IGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gLS0tCj4gYmFz
ZS1jb21taXQ6IGEzZTI3ZGYzNGQ2Y2I0OTQ3N2M5YmQ2ZjliYmFhMWNlNGRlMTU1ZjkKPiBjaGFu
Z2UtaWQ6IDIwMjUwMjE3LWNsZWFyX2Rlc2NyaXB0aW9ucy0wOGY4MDAwZTcwODIKPgo+IEJlc3Qg
cmVnYXJkcywKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
