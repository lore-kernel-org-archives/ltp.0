Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE237CCF9E9
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 07:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727334468; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=wR8XEj9q8x3ltejeCaFOJpExQwhY6/4QWmN+gch0xo8=;
 b=R5rYADQ+CD9mw9twLbpNIawICEBVqjOuSgIxnOz6kA6tTLcgFcHwlcxmRnGZaRkHKsLBG
 CVdmNCwsNTt79rjU+CoMbEvqTDZPVOnA8oJrFvvMT/aKc/kLM1kDN2YTB+eH2WVaxC+FaWi
 Zo9fHmqjGZ7731mlb6sBq13+rLVjbn0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D243C4E49
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 09:07:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852B33C238A
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 09:07:28 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A17891B61043
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 09:07:27 +0200 (CEST)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so91451866b.0
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727334447; x=1727939247; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1M3Gfxalu/Fd6r4AAoPd6G6OWZsl0rf9V7B96UXNHcA=;
 b=FEA7a7/wW8kyvRPYiWeYpeVqEfM4+DcVkZIYJycg/nAbgVWX4u21NHmy7UjgOFVBPg
 qqUlEt1S0j1DMO3RkFo8AX/KU/97EFUWvcYLtKlpHwEVXiFFBWS6aT+hcDHmE6fkOX5y
 QopSeD32O2LdbyU3w0VMdS7kWRdflpg7HZ2zVvAv0yRcU0b3MjiAclidNXcDufrb3Hp9
 wBXuSZet6AeQLXSH2nGP7uSdRrCn3YxY9HHoatCDPwW+btOqrr/x7WJNqtRPy3LeRLOv
 kj6zkJbCij5sY5ilv0crAVoyxT5XqbKSRn6cJgNfC/Pj4CAwhJJBW6L1g2FhY1FV4aSy
 UnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727334447; x=1727939247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1M3Gfxalu/Fd6r4AAoPd6G6OWZsl0rf9V7B96UXNHcA=;
 b=UKaUZosDGZqZNClZS6Km2WEFUjmeT/fPcPpNk2TObnK7w9229fIxQv8TasOgEgvVlx
 tCoBwZfk7P/rKF5iD22RJ77q5/aiB8xtcrAiAUxzqqUXsPmW4H6rMZS4Ni3S0xmV8o+K
 1lb548XqiTemJVbdlDqX9WRQVoTGDKu4HTi0bRCsFdyB8UBahsvzJkn64AruVoaYoQ7k
 JvGMaLHZT+3Nx/2eGDf3sGd4qg9QlSQo7jfxq4LDNuqvVxggapUKxaI+fq4z1CViinF9
 xhlRKeZVvIxABrMb0Xx4zZtwc8z5YNfGtPllngsOheQzWmr+LHdbogH4Vemh6SjyjsZw
 lN9w==
X-Gm-Message-State: AOJu0YxVwCBjjSFYRkvHhfmmQ4IIhI930buuNwn5rCgkEMXUmNyJqAxg
 3ouwGNfnhwluuntr7iZe4qDh9fsqwUwX1zC3Uwrcb6/5QoflqtFmwuGvDkHSWi8=
X-Google-Smtp-Source: AGHT+IGwiM85mu7SR2j5/jK0CAdbq7J3tkdiaSGhKVhzhJLM3tV6RFT9mjz51Nex7zm2FOCPWpw79g==
X-Received: by 2002:a17:907:7b8f:b0:a91:1592:f5cf with SMTP id
 a640c23a62f3a-a93a035ce12mr479629866b.15.1727334446972; 
 Thu, 26 Sep 2024 00:07:26 -0700 (PDT)
Received: from [192.168.178.49] ([79.140.112.18])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a939313462dsm309998166b.201.2024.09.26.00.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 00:07:26 -0700 (PDT)
Message-ID: <5e157a19-8832-4531-b1b5-617f2a1044d5@suse.com>
Date: Thu, 26 Sep 2024 09:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
 <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
 <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
 <98bdc518-be50-47d9-a6f9-5718217317c9@suse.com>
 <CAASaF6wYYSfjxgg2byVBDhqCpQs9-8ngJZv8LrrJiytPR2=+ag@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAASaF6wYYSfjxgg2byVBDhqCpQs9-8ngJZv8LrrJiytPR2=+ag@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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

Ck9uIDkvMjUvMjQgMjI6MDEsIEphbiBTdGFuY2VrIHdyb3RlOgo+IE9uIFR1ZSwgU2VwIDI0LCAy
MDI0IGF0IDM6MjTigK9QTSBBbmRyZWEgQ2VydmVzYXRvCj4gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5jb20+IHdyb3RlOgo+Pgo+PiBPbiA5LzI0LzI0IDE1OjE2LCBKYW4gU3RhbmNlayB3cm90ZToK
Pj4+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDEwOjQ24oCvQU0gQW5kcmVhIENlcnZlc2F0byB2
aWEgbHRwCj4+PiA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPj4+PiBIaSEKPj4+Pgo+Pj4+
IFBsZWFzZSBjb25zaWRlciB0aGlzIHBhdGNoc2V0IGFzIGEgZHJhZnQgb3BlbiBmb3IgZGlzY3Vz
c2lvbi4KPj4+IEhhdmUgeW91IGNvbXBhcmVkIG9sZCBhbmQgbmV3IGRlZmluZXM/IEFyZSB0aGVy
ZSBhbnkgZGlmZmVyZW5jZXMKPj4+IChvdGhlciB0aGFuIGFkZGl0aW9ucyk/Cj4+Pgo+PiBPbmx5
IGFkZGl0aW9ucywgYnV0IHRoaXMgaXMgYSBkcmFmdCB3b3JrIGFuZCBJJ20gc2VhcmNoaW5nIGZv
cgo+PiBhbHRlcm5hdGl2ZSBpZGVhcyBhcyB3ZWxsLgo+PiBGb3IgZXhhbXBsZSwgdGhlIGxpbWl0
YXRpb24gb2YgdGhpcyBhcHByb2FjaCBpcyB0aGF0IHN5c2NhbGxzLmggaGFzIHRvCj4+IGJlIGdl
bmVyYXRlZCBhbnl3YXkuCj4gSSBndWVzcyBpdCB3b3VsZG4ndCBiZSB0b28gZGlmZmljdWx0IHRv
IGNoYW5nZSBzY3JpcHQgdG8gZ2VuZXJhdGUgLmluCj4gZmlsZXMgaW5zdGVhZCwgcmlnaHQ/Ckkn
bSBhbHJlYWR5IGRvaW5nIGl0IGluIHRoZSBnZW5lcmF0ZV9zeXNjYWxscy5zaCBzY3JpcHQsIHNv
IGl0J3MgcXVpdGUgCmVhc3kuIFRoZSBwb2ludCBpcyBpZiB3ZSB3YW50IHRvIG1ha2UgdGhpcyBl
eHRyYSBzdGVwLCBiZWNhdXNlIG1heWJlIHdlIApjYW4ganVzdCBkb3dubG9hZCB0aGUgdGFibGVz
IGFscmVhZHkgY3JlYXRlZCBieSB0aGUgc3lzY2FsbHMtdGFibGUgCnByb2plY3QgYW5kIHdlIGhh
dmUgLmluIGZpbGVzIGZvciBmcmVlLiBCdXQgdGhhdCBhcHByb2FjaCBoYXMgZG93bnNpZGVzIApv
ZiBjb3Vyc2UuCj4+IEF0IHRoZSBzYW1lIHRpbWUsIHdlIGhhdmUgcHJvamVjdHMgbGlrZQo+PiBo
dHRwczovL2dpdGh1Yi5jb20vaHJ3L3N5c2NhbGxzLXRhYmxlICh0aGF0IGluc3BpcmVkIG15IHNj
cmlwdCkKPj4gcHJvdmlkaW5nIHB5dGhvbiBiaW5kaW5ncyBhbmQgKm1heWJlKiBpdCBjb3VsZCBi
ZSB1c2VkIHRvIGNyZWF0ZSBhCj4+IHB5dGhvbiBzY3JpcHQgd2hpY2ggZ2VuZXJhdGUgLmluIGZp
bGVzIHdoZW4gdGhleSBuZWVkIHRvIGJlIHVwZGF0ZWQuCj4gcHl0aG9uIGZlZWxzIGxpa2UgYW4g
ZXh0cmEgc3RlcCwgc2luY2Ugd2UgY291bGQgZG8gaXQgaW4gZXhpc3Rpbmcgc2hlbGwgc2NyaXB0
Lgo+IE1heWJlIHN0b3JlIGEgY29weSBvZiB1cGRhdGUtdGFibGVzLnNoIGluIExUUCByZXBvLCBh
bmQgYWRkIHNvbWUgd3JhcHBlcgo+IHRvIHByb3ZpZGUgY3JlYXRlX3RhYmxlc19mb3JfTFRQKCkg
ZnVuY3Rpb24gYW5kIGEgY2hlY2sgdG8gcHJpbnQgd2FybmluZyBpZgo+IG9yaWdpbmFsIGdpdGh1
YiBwcm9qZWN0IGNoYW5nZXMgdXBkYXRlLXRhYmxlcy5zaC4KPgo+IGNyZWF0ZV90YWJsZXNfZm9y
X0xUUCgpIHdvdWxkIGdlbmVyYXRlIC5pbiBmaWxlcyBhbmQgcmVzdCBjYW4gc3RheSBhcyBpdCBp
cy4KCkkgd2FzIGFsc28gdGhpbmtpbmcgdGhhdCBtYXliZSBpdCdzIGVub3VnaCB0byBoYXZlIDIg
c2NyaXB0czogb25lIGZvciAKdXBkYXRpbmcgc3lzY2FsbHMgLmluIGZpbGVzIHdoZW4gbmVlZGVk
IGFuZCBvbmUgZm9yIG1lcmdpbmcgdGhlbS4KClRoZSBvbmx5IHByb2JsZW0gSSBzZWUgaW4gdGhp
cyBhcHByb2FjaCBpczogd2hlbiBkbyB3ZSB3YW50IHRvIHVwZGF0ZSAKdGFibGVzPyBJdCB3b3Vs
ZCBiZSBuaWNlIHRvIGRvIHRoYXQgZXZlcnkgLi9jb25maWd1cmUgLCBidXQgdGhhdCB3b3VsZCAK
YmUgdG9vIG11Y2ggYmVjYXVzZSBvZiBnaXQvY3VybCBkZXBlbmRlbmN5LgoKPj4gRXRjLi4KPj4K
Pj4+PiBBbmRyZWEKPj4+Pgo+Pj4+IE9uIDkvMjQvMjQgMTA6MDYsIEFuZHJlYSBDZXJ2ZXNhdG8g
d3JvdGU6Cj4+Pj4+IFRoZSBwcm9ibGVtIHdlIGhhdmUgYXQgdGhlIG1vbWVudCBpcyB0aGF0IGFs
bCBzeXNjYWxscyBpbnB1dCBmaWxlcyBtdXN0Cj4+Pj4+IGJlIGNoYW5nZWQgYnkgaGFuZCBlYWNo
IHRpbWUgd2UgbmVlZCB0byB0ZXN0IGEgbmV3IHN5c2NhbGwuIFRoZSBpZGVhIGlzCj4+Pj4+IHRv
IHNpbXBsaWZ5IHRoaXMgcHJvY2VzcywgcHJvdmlkaW5nIGEgc2NyaXB0IHRoYXQgaXMgYWJsZSB0
byByZWFkIGZyb20KPj4+Pj4ga2VybmVsIHNvdXJjZXMgYW5kIHRvIGdlbmVyYXRlIGFsbCBzeXNj
YWxscyBmaWxlcyB3ZSBuZWVkLgo+Pj4+Pgo+Pj4+PiBUaGlzIGlzIGRvbmUgYnkgdGhlIGdlbmVy
YXRlX3N5c2NhbGxzLnNoIHNjcmlwdCB0aGF0IGNhbiBiZSB1c2VkIGFzCj4+Pj4+IGZvbGxvd2lu
ZzoKPj4+Pj4KPj4+Pj4gLi9nZW5lcmF0ZV9zeXNjYWxscy5zaCBwYXRoL3RvL2tlcm5lbC9zb3Vy
Y2UgcGF0aC90by9zeXNjYWxscy5oCj4+Pj4+Cj4+Pj4+IFRoaXMgYXBwcm9hY2ggcmVxdWlyZXMg
YSBjZXJ0YWluIHR5cGUgb2YgYXR0ZW50aW9uLCBkdWUgdG8gdGhlIGZhY3QgdGhhdAo+Pj4+PiB3
ZSBuZWVkIHRvIGdlbmVyYXRlIHN5c2NhbGxzLmggYXQgZWFjaCBrZXJuZWwgdmVyc2lvbiwgb3Ig
d2hlbiBuZXcKPj4+Pj4gc3lzY2FsbHMgaGF2ZSBiZWVuIGFkZGVkIGluIHRoZSBrZXJuZWwuCj4+
Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNh
dG9Ac3VzZS5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiBBbmRyZWEgQ2VydmVzYXRvICg0KToKPj4+Pj4g
ICAgICAgICAgUmVuYW1lIHN5c2NhbGxzIG9yZGVyIGZpbGUgdG8gc3VwcG9ydGVkLWFyY2gudHh0
Cj4+Pj4+ICAgICAgICAgIEFkZCBzY3JpcHQgdG8gZ2VuZXJhdGUgc3lzY2FsbHMuaAo+Pj4+PiAg
ICAgICAgICBEZXByZWNhdGUgb2xkIHN5c2NhbGxzIGlucHV0IGZpbGVzCj4+Pj4+ICAgICAgICAg
IFNhdmUgc3lzY2FsbHMuaCBpbnNpZGUgcmVwbwo+Pj4+Pgo+Pj4+PiAgICAgaW5jbHVkZS9sYXBp
Ly5naXRpZ25vcmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgMSAtCj4+Pj4+ICAg
ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDM0
MjcyICsrKysrKysrKysrKysrKysrKysKPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9h
YXJjaDY0LmluICAgICAgICAgICAgICAgICAgIHwgICAzMDYgLQo+Pj4+PiAgICAgaW5jbHVkZS9s
YXBpL3N5c2NhbGxzL2FyYy5pbiAgICAgICAgICAgICAgICAgICAgICAgfCAgIDMyNSAtCj4+Pj4+
ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtLmluICAgICAgICAgICAgICAgICAgICAgICB8
ICAgNDA0IC0KPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9ibGFja2xpc3Qtc3lzY2Fs
bHMudHh0ICAgICAgIHwgICAgIDYgKwo+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2dl
bmVyYXRlX3N5c2NhbGxzLnNoICAgICAgICAgfCAgIDI5MiArCj4+Pj4+ICAgICBpbmNsdWRlL2xh
cGkvc3lzY2FsbHMvaHBwYS5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgIDUyIC0KPj4+Pj4g
ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9pMzg2LmluICAgICAgICAgICAgICAgICAgICAgIHwg
ICA0MzkgLQo+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2lhNjQuaW4gICAgICAgICAg
ICAgICAgICAgICAgfCAgIDk1NiArLQo+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2xv
b25nYXJjaC5pbiAgICAgICAgICAgICAgICAgfCAgIDMxMCAtCj4+Pj4+ICAgICBpbmNsdWRlL2xh
cGkvc3lzY2FsbHMvbWlwc19uMzIuaW4gICAgICAgICAgICAgICAgICB8ICAgMzc5IC0KPj4+Pj4g
ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9taXBzX242NC5pbiAgICAgICAgICAgICAgICAgIHwg
ICAzNTUgLQo+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL21pcHNfbzMyLmluICAgICAg
ICAgICAgICAgICAgfCAgIDQyNSAtCj4+Pj4+ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvcG93
ZXJwYy5pbiAgICAgICAgICAgICAgICAgICB8ICAgNDMyIC0KPj4+Pj4gICAgIGluY2x1ZGUvbGFw
aS9zeXNjYWxscy9wb3dlcnBjNjQuaW4gICAgICAgICAgICAgICAgIHwgICA0MzIgLQo+Pj4+PiAg
ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3JlZ2VuLnNoICAgICAgICAgICAgICAgICAgICAgfCAg
IDEyOSAtCj4+Pj4+ICAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvczM5MC5pbiAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNDE5IC0KPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zMzkw
eC5pbiAgICAgICAgICAgICAgICAgICAgIHwgICAzNjcgLQo+Pj4+PiAgICAgaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL3NoLmluICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQxMyAtCj4+Pj4+ICAg
ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvc3BhcmMuaW4gICAgICAgICAgICAgICAgICAgICB8ICAg
NDE4IC0KPj4+Pj4gICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zcGFyYzY0LmluICAgICAgICAg
ICAgICAgICAgIHwgICAzODMgLQo+Pj4+PiAgICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3N0cmlw
X3N5c2NhbGwuYXdrICAgICAgICAgICAgfCAgICAxOSAtCj4+Pj4+ICAgICAuLi4vbGFwaS9zeXNj
YWxscy97b3JkZXIgPT4gc3VwcG9ydGVkLWFyY2gudHh0fSAgICB8ICAgICAxIC0KPj4+Pj4gICAg
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy94ODZfNjQuaW4gICAgICAgICAgICAgICAgICAgIHwgICAz
OTYgLQo+Pj4+PiAgICAgMjUgZmlsZXMgY2hhbmdlZCwgMzUxNzQgaW5zZXJ0aW9ucygrKSwgNjc1
NyBkZWxldGlvbnMoLSkKPj4+Pj4gLS0tCj4+Pj4+IGJhc2UtY29tbWl0OiA5NjhlNjI0NWQ5M2Jj
OTE3MjNlNzIwODZhNzFlNmJjNTBmNDk1ZDBiCj4+Pj4+IGNoYW5nZS1pZDogMjAyNDA5MjMtZ2Vu
ZXJhdGVfc3lzY2FsbHMtNzgwZGMyMjI3YmRiCj4+Pj4+Cj4+Pj4+IEJlc3QgcmVnYXJkcywKPj4+
PiAtLQo+Pj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo+Pj4+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
