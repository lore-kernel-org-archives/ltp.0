Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3450CF9C6F
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727184258; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=a785IYE96ixLxoiNf0wnfE6KPudqOtcm5vK8g/XdMRE=;
 b=KaKlmf3dw6U87RZIzboLmEzTyRFj2vaNHzzqOeZOuhQSuAu9s0LikwtS8cog2yUK4ExpC
 BMcGZ2bA8fbwf6lSe0FfJmCGP/OFEZnUOt2DuXBmt8ds70ERlhOl/zQfvqbVwdgkXAgF3bN
 BtjxkDooE6qzG/LbNOKf2qROk9tnyrw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 569A33C4CAB
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 15:24:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71A863C30BB
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 15:23:56 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8AD8E1409192
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 15:23:46 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3d2f9f896so7690428a12.1
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727184226; x=1727789026; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVVeIg9oSl0yIHcZQUzZWG57ycMZhQbcP4BmnLSTFBI=;
 b=Oz2gpG4eZ0EqOcn0/SNJzm9GuePG88nXi112KGa2vusq23Q4Xf3XI/SYHJoe8VbxhA
 x5Ai6py59OrxULH/E8q0gvdA4CU0vNVtVuDedQOhmrV28RHFMfX7q26Rm7207bJJ10On
 h/mqnMEGaajuJPkd2ZyT+XHbox8lj7fKeCm2iGLewX0qmk5zQ4IjdveQzc381VdCVTKJ
 OPgcIlY7yjd00M7ladSmthx01VdEJPtVVHD4UgyusXxcFAnZ8sRN2Pz7R7RFBs6Rnam+
 g7wnVw/+HCuEuE/O2lWlRNmQoycipc8lLrAh3ee09i/9kEqARH5kcHkcRKTzM8/Wwohu
 +prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727184226; x=1727789026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KVVeIg9oSl0yIHcZQUzZWG57ycMZhQbcP4BmnLSTFBI=;
 b=SJB8Yctn2zQ8KcE++3QWkKYsheJopOknBdq1Z51gGZXfRPV6WL7cLakNb9hhmi7A4/
 J2MtHFIG13FQZ41tksNpqh81j34ZkokdoULSk/P+I7GiTuoxNPQ+PfGAy5l3h6AkygPJ
 yyFg49k7tdBnI1yzrnzm0EixBBCpm8q6IeWnHqZlZePIRTZgI3KAuqd2D6bdIxNJNlzb
 +FzXNj6cs/Wlw6fGaJkAlik1GQ1eTZIsc2jpyL+uh4JIqGRXKVAPDFreHezW/Avcz218
 j6AbgVR7LNIKAC/HjoK2BX/xKXKBAaK+Uyy7xO+5wsJwB/8OzBAmT13/1FgGA1JYLTn1
 /02A==
X-Gm-Message-State: AOJu0Yxda6A3LHpDOercLEHO+q5Z+CYq8KhFKJWjw9j+pYizJ0nPOzvZ
 yMaMmSdID81A6hLHZM0WtXzxvyllg6qR9xQ5fpbiPEoV7PG0k8sAEh5Oihrvx24=
X-Google-Smtp-Source: AGHT+IFxb3R1/waB7es0X1m9jFykEGQCvV52DsyrtGlTUiQiuzx8KJagF3GbLFnf5jeuK5txSzMR0Q==
X-Received: by 2002:a05:6402:3548:b0:5c4:4e15:872b with SMTP id
 4fb4d7f45d1cf-5c464a584bemr11511777a12.28.1727184225800; 
 Tue, 24 Sep 2024 06:23:45 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c5069sm731604a12.67.2024.09.24.06.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 06:23:45 -0700 (PDT)
Message-ID: <98bdc518-be50-47d9-a6f9-5718217317c9@suse.com>
Date: Tue, 24 Sep 2024 15:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
 <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
 <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

Ck9uIDkvMjQvMjQgMTU6MTYsIEphbiBTdGFuY2VrIHdyb3RlOgo+IE9uIFR1ZSwgU2VwIDI0LCAy
MDI0IGF0IDEwOjQ24oCvQU0gQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwCj4gPGx0cEBsaXN0cy5s
aW51eC5pdD4gd3JvdGU6Cj4+IEhpIQo+Pgo+PiBQbGVhc2UgY29uc2lkZXIgdGhpcyBwYXRjaHNl
dCBhcyBhIGRyYWZ0IG9wZW4gZm9yIGRpc2N1c3Npb24uCj4gSGF2ZSB5b3UgY29tcGFyZWQgb2xk
IGFuZCBuZXcgZGVmaW5lcz8gQXJlIHRoZXJlIGFueSBkaWZmZXJlbmNlcwo+IChvdGhlciB0aGFu
IGFkZGl0aW9ucyk/Cj4KT25seSBhZGRpdGlvbnMsIGJ1dCB0aGlzIGlzIGEgZHJhZnQgd29yayBh
bmQgSSdtIHNlYXJjaGluZyBmb3IgCmFsdGVybmF0aXZlIGlkZWFzIGFzIHdlbGwuCkZvciBleGFt
cGxlLCB0aGUgbGltaXRhdGlvbiBvZiB0aGlzIGFwcHJvYWNoIGlzIHRoYXQgc3lzY2FsbHMuaCBo
YXMgdG8gCmJlIGdlbmVyYXRlZCBhbnl3YXkuCgpBdCB0aGUgc2FtZSB0aW1lLCB3ZSBoYXZlIHBy
b2plY3RzIGxpa2UgCmh0dHBzOi8vZ2l0aHViLmNvbS9ocncvc3lzY2FsbHMtdGFibGUgKHRoYXQg
aW5zcGlyZWQgbXkgc2NyaXB0KSAKcHJvdmlkaW5nIHB5dGhvbiBiaW5kaW5ncyBhbmQgKm1heWJl
KiBpdCBjb3VsZCBiZSB1c2VkIHRvIGNyZWF0ZSBhIApweXRob24gc2NyaXB0IHdoaWNoIGdlbmVy
YXRlIC5pbiBmaWxlcyB3aGVuIHRoZXkgbmVlZCB0byBiZSB1cGRhdGVkLgoKRXRjLi4KCj4+IEFu
ZHJlYQo+Pgo+PiBPbiA5LzI0LzI0IDEwOjA2LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+Pj4g
VGhlIHByb2JsZW0gd2UgaGF2ZSBhdCB0aGUgbW9tZW50IGlzIHRoYXQgYWxsIHN5c2NhbGxzIGlu
cHV0IGZpbGVzIG11c3QKPj4+IGJlIGNoYW5nZWQgYnkgaGFuZCBlYWNoIHRpbWUgd2UgbmVlZCB0
byB0ZXN0IGEgbmV3IHN5c2NhbGwuIFRoZSBpZGVhIGlzCj4+PiB0byBzaW1wbGlmeSB0aGlzIHBy
b2Nlc3MsIHByb3ZpZGluZyBhIHNjcmlwdCB0aGF0IGlzIGFibGUgdG8gcmVhZCBmcm9tCj4+PiBr
ZXJuZWwgc291cmNlcyBhbmQgdG8gZ2VuZXJhdGUgYWxsIHN5c2NhbGxzIGZpbGVzIHdlIG5lZWQu
Cj4+Pgo+Pj4gVGhpcyBpcyBkb25lIGJ5IHRoZSBnZW5lcmF0ZV9zeXNjYWxscy5zaCBzY3JpcHQg
dGhhdCBjYW4gYmUgdXNlZCBhcwo+Pj4gZm9sbG93aW5nOgo+Pj4KPj4+IC4vZ2VuZXJhdGVfc3lz
Y2FsbHMuc2ggcGF0aC90by9rZXJuZWwvc291cmNlIHBhdGgvdG8vc3lzY2FsbHMuaAo+Pj4KPj4+
IFRoaXMgYXBwcm9hY2ggcmVxdWlyZXMgYSBjZXJ0YWluIHR5cGUgb2YgYXR0ZW50aW9uLCBkdWUg
dG8gdGhlIGZhY3QgdGhhdAo+Pj4gd2UgbmVlZCB0byBnZW5lcmF0ZSBzeXNjYWxscy5oIGF0IGVh
Y2gga2VybmVsIHZlcnNpb24sIG9yIHdoZW4gbmV3Cj4+PiBzeXNjYWxscyBoYXZlIGJlZW4gYWRk
ZWQgaW4gdGhlIGtlcm5lbC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRv
IDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Pj4gLS0tCj4+PiBBbmRyZWEgQ2VydmVzYXRv
ICg0KToKPj4+ICAgICAgICAgUmVuYW1lIHN5c2NhbGxzIG9yZGVyIGZpbGUgdG8gc3VwcG9ydGVk
LWFyY2gudHh0Cj4+PiAgICAgICAgIEFkZCBzY3JpcHQgdG8gZ2VuZXJhdGUgc3lzY2FsbHMuaAo+
Pj4gICAgICAgICBEZXByZWNhdGUgb2xkIHN5c2NhbGxzIGlucHV0IGZpbGVzCj4+PiAgICAgICAg
IFNhdmUgc3lzY2FsbHMuaCBpbnNpZGUgcmVwbwo+Pj4KPj4+ICAgIGluY2x1ZGUvbGFwaS8uZ2l0
aWdub3JlICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgIDEgLQo+Pj4gICAgaW5jbHVk
ZS9sYXBpL3N5c2NhbGxzLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzNDI3MiArKysr
KysrKysrKysrKysrKysrCj4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYWFyY2g2NC5pbiAg
ICAgICAgICAgICAgICAgICB8ICAgMzA2IC0KPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9h
cmMuaW4gICAgICAgICAgICAgICAgICAgICAgIHwgICAzMjUgLQo+Pj4gICAgaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL2FybS5pbiAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQwNCAtCj4+PiAgICBp
bmNsdWRlL2xhcGkvc3lzY2FsbHMvYmxhY2tsaXN0LXN5c2NhbGxzLnR4dCAgICAgICB8ICAgICA2
ICsKPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9nZW5lcmF0ZV9zeXNjYWxscy5zaCAgICAg
ICAgIHwgICAyOTIgKwo+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2hwcGEuaW4gICAgICAg
ICAgICAgICAgICAgICAgfCAgICA1MiAtCj4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvaTM4
Ni5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgNDM5IC0KPj4+ICAgIGluY2x1ZGUvbGFwaS9z
eXNjYWxscy9pYTY0LmluICAgICAgICAgICAgICAgICAgICAgIHwgICA5NTYgKy0KPj4+ICAgIGlu
Y2x1ZGUvbGFwaS9zeXNjYWxscy9sb29uZ2FyY2guaW4gICAgICAgICAgICAgICAgIHwgICAzMTAg
LQo+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL21pcHNfbjMyLmluICAgICAgICAgICAgICAg
ICAgfCAgIDM3OSAtCj4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvbWlwc19uNjQuaW4gICAg
ICAgICAgICAgICAgICB8ICAgMzU1IC0KPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9taXBz
X28zMi5pbiAgICAgICAgICAgICAgICAgIHwgICA0MjUgLQo+Pj4gICAgaW5jbHVkZS9sYXBpL3N5
c2NhbGxzL3Bvd2VycGMuaW4gICAgICAgICAgICAgICAgICAgfCAgIDQzMiAtCj4+PiAgICBpbmNs
dWRlL2xhcGkvc3lzY2FsbHMvcG93ZXJwYzY0LmluICAgICAgICAgICAgICAgICB8ICAgNDMyIC0K
Pj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9yZWdlbi5zaCAgICAgICAgICAgICAgICAgICAg
IHwgICAxMjkgLQo+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3MzOTAuaW4gICAgICAgICAg
ICAgICAgICAgICAgfCAgIDQxOSAtCj4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvczM5MHgu
aW4gICAgICAgICAgICAgICAgICAgICB8ICAgMzY3IC0KPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNj
YWxscy9zaC5pbiAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0MTMgLQo+Pj4gICAgaW5jbHVk
ZS9sYXBpL3N5c2NhbGxzL3NwYXJjLmluICAgICAgICAgICAgICAgICAgICAgfCAgIDQxOCAtCj4+
PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvc3BhcmM2NC5pbiAgICAgICAgICAgICAgICAgICB8
ICAgMzgzIC0KPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zdHJpcF9zeXNjYWxsLmF3ayAg
ICAgICAgICAgIHwgICAgMTkgLQo+Pj4gICAgLi4uL2xhcGkvc3lzY2FsbHMve29yZGVyID0+IHN1
cHBvcnRlZC1hcmNoLnR4dH0gICAgfCAgICAgMSAtCj4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2Fs
bHMveDg2XzY0LmluICAgICAgICAgICAgICAgICAgICB8ICAgMzk2IC0KPj4+ICAgIDI1IGZpbGVz
IGNoYW5nZWQsIDM1MTc0IGluc2VydGlvbnMoKyksIDY3NTcgZGVsZXRpb25zKC0pCj4+PiAtLS0K
Pj4+IGJhc2UtY29tbWl0OiA5NjhlNjI0NWQ5M2JjOTE3MjNlNzIwODZhNzFlNmJjNTBmNDk1ZDBi
Cj4+PiBjaGFuZ2UtaWQ6IDIwMjQwOTIzLWdlbmVyYXRlX3N5c2NhbGxzLTc4MGRjMjIyN2JkYgo+
Pj4KPj4+IEJlc3QgcmVnYXJkcywKPj4gLS0KPj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
