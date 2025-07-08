Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ADAC8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751975793; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=X3rjlzIGoJ/NYkJa8ncVo3sUDnuyJrz8QlAvs/zKUuY=;
 b=W6N0y1/5nIGzWUpH2mOAJGAaGF7rOu6jvx8M3alZKQ6B2P0ge/AzP0GbHbcVbbdzIOdTe
 jq33bm6YOVpLiAz51kMz7PNTsfW0kPolibtXvpsRmLIEE92plrHukzjMtILQdL7T7xbrDOO
 xuC/MeftCGUCtvWxykyifYpemb/3/EY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3D683CA403
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 13:56:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D01FE3CA066
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 13:56:11 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9ED9D680F0F
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 13:56:10 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so2654057f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751975770; x=1752580570; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqc4YAey6zmNeL+pBM9NtyYNs+kE0v2bUGM0nQdu9fk=;
 b=Q1EArTAW0CAtx6e2zO5FnrcyvC8axb17kCXWVIDoXLnGm+nQfRWjPhiIEdXctE/Tr5
 E1KwDLYykIhx7M8oCYIjrGGJTKYYyVWRcw25lvAKwzBLGUs5zkuCF7MUjnjiOfsP72WQ
 dv3Di6jMelYWFX95HHyKggMDdclNY4kM5VG0Cq6nCXYBSCOvwaAVgvnIfQPEA11JE/W5
 5CmNi+cIZmTxx6tGcymUZgF3QyRL6tF8++jKSm6lRjMurFFqfiDbeAZPhUW66yDIUmz7
 qzrNCM1JI2h4JE8qt0owenGtGRLxzbT00VkQNqoqLTL/aTQ+kSY1DxfVyJQVvq7BQgzd
 e+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751975770; x=1752580570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iqc4YAey6zmNeL+pBM9NtyYNs+kE0v2bUGM0nQdu9fk=;
 b=OEJO9GmQrFdEHknYg/1bNGepf5d9OXtbYe77MLTz0/nrBLxJ9CuSJ5yFi7ya9FHf7x
 U0HeeVduD1B1ON+SW81v0+dFa9zdQ/jzx4XTXBjvcjEX26In6m0NiBlf/rSK2XoD9MCk
 4wwkBo9+XjVruvfNpAfdDd7vZCcHqlWDuQjm5Yuf9SUBcUaLvTtcKCfX5OT7HcA2mHcl
 82bpTzNnAQa0gn+JZP1RyV0RyYi266bEMag9LOL38oIL8Jl+zqGkL+m/FtEm/56t49ha
 GYH5tpFNJfLs7KLaIubI0cksey0h7wGrtO/o2rqVrUDyRxG5bpxN4iBJ/YbflGYCIjsB
 7uRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpbG/1ZjjM+/wkO3brMTF/u8DFPyxV5rrRdt769TN/C5BjhYoJzPD1adAaxR3HaKi2qSU=@lists.linux.it
X-Gm-Message-State: AOJu0YyWQSadCMs6qNANtm2j3BOSJDboSMEmb6fCXv241RjCm6zvu36S
 905L3IOEGFyjN5DLAIvtuVAIZTKnRCSNJpwuX/ntj2A3mqYMd1KjMrD2Nk7+/oasDcc=
X-Gm-Gg: ASbGncsBOkmCFYQFDW99Chz2tTjgu9aIEjP+Oia4y7Izk7pYNNBxlFX7szWuuJOSSN5
 VUmMezzt72u9FLzpD/4gRJ0vR72Op2eFaJTFxg+9Lg1VDmAXXuasAlbIHQBv8cDgI0MEj2FFlcp
 788A47vrgafw1TdfcQHxbhubG8AM/8d12Uau+6Fzzv5c0VLztiimNeKnRrzwdGl4OEpp4Kixf0s
 x6OyuW1x17suUYQUCoBLDilj1OkfbStpCgS2HylFJTOKA4suhHZvfZ3qXdsRcH94JPTZJoJxFkT
 MZT/qrBfFRzAyxfZDA1y2IlO35U6zIWBXAqISyM4rBAZ69a+ddCYqiYPurRU0HpAPnPvF3EpqkV
 HlQUwR3+5qQgDEvldpu/e1/wQmSvAd0rZPNzXtc/EODSmuiOjrJP3T7SeX9Fk27sQHguRoUY87l
 LFP64YHT82MJqUdMIGhu6n+YazmQ==
X-Google-Smtp-Source: AGHT+IEhjLf9tuICckYmAvxntI+wn8lT6QJa1AkIfggPOK9eGUf0A0N5lwJBX/tNjHaPuzKQa73Eyw==
X-Received: by 2002:a05:6000:18a5:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3b4964c0a9fmr15304558f8f.17.1751975769888; 
 Tue, 08 Jul 2025 04:56:09 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b38ee4510a6sm11442245a12.16.2025.07.08.04.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 04:56:09 -0700 (PDT)
Message-ID: <ee61b370-13cd-4467-80d1-c38645592e69@suse.com>
Date: Tue, 8 Jul 2025 13:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-new-munmap04-v4-1-884f774179b1@suse.com>
Content-Language: en-US
In-Reply-To: <20250708-new-munmap04-v4-1-884f774179b1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls: munmap: Add munmap04 to check ENOMEM
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

SGkhCgpPbiA3LzgvMjUgMTI6MjcgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3Jv
dGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IFRoZSBF
UlJPUlMgc2VjdGlvbiBvZiB0aGUgbW1hcCgyKSBtYW5wYWdlIHNheXM6Cj4KPiBFTk9NRU06IFRo
ZSBwcm9jZXNzJ3MgbWF4aW11bSBudW1iZXIgb2YgbWFwcGluZ3Mgd291bGQgaGF2ZSBiZWVuIGV4
Y2VlZGVkLgo+IFRoaXMgZXJyb3IgY2FuIGFsc28gb2NjdXIgZm9yIG11bm1hcCgpLCB3aGVuIHVu
bWFwcGluZyBhIHJlZ2lvbiBpbiB0aGUKPiBtaWRkbGUgb2YgYW4gZXhpc3RpbmcgbWFwcGluZywg
c2luY2UgdGhpcyByZXN1bHRzIGluIHR3byBzbWFsbGVyIG1hcHBpbmdzCj4gb24gZWl0aGVyIHNp
ZGUgb2YgdGhlIHJlZ2lvbiBiZWluZyB1bm1hcHBlZC4KPgo+IEFkZCBhIG5ldyB0ZXN0IG11bm1h
cDA0IHRvIGFkZHJlc3MgdGhpcyBzY2VuYXJpby4KPgo+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8g
Qi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2NDoKPiAtIFJl
YmFzZWQgYWZ0ZXIgbXVubWFwIGNvbnZlcnNpb24gdG8gbmV3IEFQSQo+IC0gTGluayB0byB2Mzog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcwNy1uZXctbXVubWFwMDQtdjMtMS1lM2Vm
ZGE4ZTdkMmJAc3VzZS5jb20KPgo+IENoYW5nZXMgaW4gdjM6Cj4gLSBBZGRlZCBtaXNzaW5nIGlu
Y2x1ZGUgdG8gImxhcGkvbW1hcC5oIgo+IC0gTWFkZSBtYXhfbWFwX2NvdW50IGEgdGVzdCBvcHRp
b24KPiAtIEtlZXAgdGhlIG1hcHBlZCByZWdpb25zIGluIHRoZSBoZWFwCj4gLSBSZXF1aXJlZCBt
aW4uIGtlcm5lbCB2NC4xNwo+IC0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI1MDcwNC1uZXctbXVubWFwMDQtdjItMS00MzZjODBkZjk2NDZAc3VzZS5jb20KPgo+IENo
YW5nZXMgaW4gdjI6Cj4gLSBDb3JyZWN0ZWQgdGhlIGNvbW1pdCBtZXNzYWdlCj4gLSBMaW5rIHRv
IHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwNzA0LW5ldy1tdW5tYXAwNC12MS0x
LTZlZjk2MTM4YjA5MkBzdXNlLmNvbQo+IC0tLQo+ICAgcnVudGVzdC9zeXNjYWxscyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bXVubWFwLy5naXRpZ25vcmUgfCAgMSArCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211
bm1hcC9tdW5tYXAwNC5jIHwgOTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qv
c3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4gaW5kZXggOWM4MGJjY2IwOTExNGQ4Yjk3MzBm
ZGVlMDVlM2UyOGY1Y2M0NGFmYy4uMDExMjY4NzlkMmQ2NzliZDUyOWVlMzY1N2Y2NTg1OTg3Mjg5
MDBmMSAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNj
YWxscwo+IEBAIC05NTAsNiArOTUwLDcgQEAgbXVubG9ja2FsbDAxIG11bmxvY2thbGwwMQo+ICAg
Cj4gICBtdW5tYXAwMSBtdW5tYXAwMQo+ICAgbXVubWFwMDMgbXVubWFwMDMKPiArbXVubWFwMDQg
bXVubWFwMDQKPiAgIAo+ICAgbmFub3NsZWVwMDEgbmFub3NsZWVwMDEKPiAgIG5hbm9zbGVlcDAy
IG5hbm9zbGVlcDAyCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVu
bWFwLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdu
b3JlCj4gaW5kZXggYWE2ZTE0YTY3MGU4NWRkMTdmOTY1YjRhNDY1OTk3YTAyMWY4YjRhYy4uN2Fk
ZTg2MzkwYTM0Y2Q2ZmJiZjY1MzAzODVlODkxZTAxZTJiOTEzNyAxMDA2NDQKPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC8uZ2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGlnbm9yZQo+IEBAIC0xLDIgKzEsMyBAQAo+ICAg
L211bm1hcDAxCj4gICAvbXVubWFwMDMKPiArL211bm1hcDA0Cj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRl
eCAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi5lMzI2ZDI0YTVmYjky
N2IxYmI3YzdkNTE0MzhmNWEzZDc2OTY5NmMyCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKPiBAQCAtMCwwICsxLDk0IEBA
Cj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4g
KyAqIENvcHlyaWdodCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPgo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKiBWZXJpZnkgdGhhdCBtdW5tYXAoKSBm
YWlscyB3aXRoIEVOT01FTSBhZnRlciBwYXJ0aWFsbHkgdW5tYXBwaW5nIGFuCj4gKyAqIGV4aXN0
aW5nIG1hcCwgd2hpbGUgaGF2aW5nIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBtYXBzIGFscmVhZHkg
YWxsb2NhdGVkLgo+ICsgKi8KPiArCj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICsjaW5jbHVk
ZSAibGFwaS9tbWFwLmgiCj4gKwo+ICsjZGVmaW5lIFBBRCAyIC8qIGF2b2lkIGFkamFjZW50IG1h
cHBpbmcgbWVyZ2VzICovCj4gKyNkZWZpbmUgUEFHRVMgMwo+ICsjZGVmaW5lIE1BWF9NQVBfQ09V
TlRfRklMRSAiL3Byb2Mvc3lzL3ZtL21heF9tYXBfY291bnQiCj4gKwo+ICtzdGF0aWMgY2hhciAq
c3RyX21heF9tYXBfY291bnQ7Cj4gK3N0YXRpYyBpbnQgbWF4X21hcF9jb3VudCA9IDUwMDsKPiAr
Cj4gK3N0YXRpYyB1aW50cHRyX3QgYmFzZSA9IDB4MTAwMDAwMDAwVUw7Cj4gK3N0YXRpYyBzaXpl
X3QgcGFnZV9zejsKPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgdm1hX3NpemU7Cj4gK3N0YXRpYyB1
bnNpZ25lZCBsb25nIG1heF9tYXBfY291bnRfb3JpZzsKPiArc3RhdGljIGludCBtYXBfY291bnQ7
Cj4gK3N0YXRpYyB2b2lkICoqbWFwczsKPiArCj4gK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICt7
Cj4gKwlUU1RfRVhQX0ZBSUwobXVubWFwKG1hcHNbMl0gKyBwYWdlX3N6LCBwYWdlX3N6KSwgRU5P
TUVNKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgc2V0X21heF9tYXBfY291bnQoc2l6ZV90IG1h
eCkKPiArewo+ICsJdHN0X3JlcyhUSU5GTywgIlNldHRpbmcgbWF4X21hcF9jb3VudCA9ICV6dSIs
IG1heCk7Cj4gKwlTQUZFX0ZJTEVfUFJJTlRGKE1BWF9NQVBfQ09VTlRfRklMRSwgIiV6dSIsIG1h
eCk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gK3sKPiArCXBhZ2Vfc3og
PSBTQUZFX1NZU0NPTkYoX1NDX1BBR0VTSVpFKTsKPiArCXZtYV9zaXplID0gUEFHRVMgKiBwYWdl
X3N6Owo+ICsKPiArCWlmICh0c3RfcGFyc2VfaW50KHN0cl9tYXhfbWFwX2NvdW50LCAmbWF4X21h
cF9jb3VudCwgMTAwLCBJTlRfTUFYKSkKPiArCQl0c3RfYnJrKFRCUk9LLCAiSW52YWxpZCBtYXgu
IG1hcCBjb3VudCAnJXMnIiwKPiArCQkJc3RyX21heF9tYXBfY291bnQpOwo+ICsKPiArCVNBRkVf
RklMRV9TQ0FORihNQVhfTUFQX0NPVU5UX0ZJTEUsICIlbHUiLCAmbWF4X21hcF9jb3VudF9vcmln
KTsKPiArCXRzdF9yZXMoVElORk8sICJPcmlnaW5hbCBtYXhfbWFwX2NvdW50ID0gJWx1IiwgbWF4
X21hcF9jb3VudF9vcmlnKTsKPiArCXNldF9tYXhfbWFwX2NvdW50KG1heF9tYXBfY291bnQpOwo+
ICsKPiArCW1hcHMgPSBTQUZFX01BTExPQyhtYXhfbWFwX2NvdW50ICogc2l6ZW9mKGNoYXIgKikp
Owo+ICsJZm9yIChpbnQgaSA9IDA7IGkgPCBtYXhfbWFwX2NvdW50OyBpKyspCj4gKwkJbWFwc1tp
XSA9IE5VTEw7Cj4gKwo+ICsJd2hpbGUgKDEpIHsKPiArCQl2b2lkICpwID0KPiArCQkJbW1hcCgo
dm9pZCAqKShiYXNlICsgUEFEICogdm1hX3NpemUgKiBtYXBfY291bnQpLApXZWlyZCBmb3JtYXR0
aW5nLCB3ZSBuZWVkIHRvIHJlbW92ZSB0aGUgbmV3bGluZS4KPiArCQkJICAgICB2bWFfc2l6ZSwg
UFJPVF9OT05FLAo+ICsJCQkgICAgIE1BUF9QUklWQVRFIHwgTUFQX0FOT05ZTU9VUyB8IE1BUF9G
SVhFRF9OT1JFUExBQ0UsCj4gKwkJCSAgICAgLTEsIDApOwo+ICsJCWlmIChwID09IE1BUF9GQUlM
RUQpCj4gKwkJCWJyZWFrOwo+ICsJCW1hcHNbbWFwX2NvdW50KytdID0gcDsKPiArCX0KPiArCj4g
KwlpZiAobWFwX2NvdW50ID09IG1heF9tYXBfY291bnQpCj4gKwkJdHN0X2JyayhUQlJPSywgIk1h
cHBlZCBhbGwgJWQgcmVnaW9ucywgZXhwZWN0ZWQgbGVzcyIsCj4gKwkJCW1hcF9jb3VudCk7Cj4g
Kwo+ICsJdHN0X3JlcyhUSU5GTywgIk1hcHBlZCAlZCByZWdpb25zIiwgbWFwX2NvdW50KTsKPiAr
fQo+ICsKPiArc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ICt7Cj4gKwlzZXRfbWF4X21hcF9j
b3VudChtYXhfbWFwX2NvdW50X29yaWcpOwo+ICsJZm9yIChpbnQgaSA9IDA7IGkgPCBtYXBfY291
bnQ7IGkrKykgewo+ICsJCWlmIChtYXBzW2ldID09IE5VTEwpCj4gKwkJCWJyZWFrOwo+ICsJCVNB
RkVfTVVOTUFQKCh2b2lkICopKG1hcHNbaV0pLCB2bWFfc2l6ZSk7Cj4gKwl9Cj4gKwlmcmVlKG1h
cHMpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gKwkudGVz
dF9hbGwgPSBydW4sCj4gKwkuc2V0dXAgPSBzZXR1cCwKPiArCS5jbGVhbnVwID0gY2xlYW51cCwK
PiArCS5uZWVkc19yb290ID0gMSwKPiArCS5taW5fa3ZlciA9ICI0LjE3IiwKPiArCS5vcHRpb25z
ID0gKHN0cnVjdCB0c3Rfb3B0aW9uW10peyB7ICJuOiIsICZzdHJfbWF4X21hcF9jb3VudCwKPiAr
CQkJCQkgICAgIk1heC4gbWFwIGNvdW50IChkZWZhdWx0OiA1MDApIiB9LAo+ICsJCQkJCSAge30g
fSwKIi9wcm9jL3N5cy92bS9tYXhfbWFwX2NvdW50IiBzZXR1cCB3aWxsIGFmZmVjdCB0aGUgcnVu
bmluZyBzeXN0ZW0gYW5kIApydW5uaW5nIGFwcGxpY2F0aW9ucy4gSSB0aGluayB3ZSBjYW4ganVz
dCB1c2UgdGhlIGRlZmF1bHQgdmFsdWUgd2hpY2ggaXMgCnRha2VuIGZyb20gdGhlIGZpbGUuCj4g
K307Cj4KPiAtLS0KPiBiYXNlLWNvbW1pdDogMGM3MzQ2Y2IwOTc0NDA5MDI1Njg4NTY1MjdiZTcx
NjJmNTk1MDQ5Nwo+IGNoYW5nZS1pZDogMjAyNTA3MDQtbmV3LW11bm1hcDA0LWE1OWNhMjBhZTAw
Ywo+Cj4gQmVzdCByZWdhcmRzLAotIEFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
