Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5000CC021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739797509; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=GlEVge0xOZvhA6ppf4fZV4xMuDp+Y/bDdc072KGOmbA=;
 b=S0OTWKCocknRAL06NUMM6Ecw+ikhsuZh8HmqBkifdz6rS/mXbxNOty8ZqS+HLZE+g/+mD
 qx7ATG0HqHauEsrvT6m9fnqMhcAFiXfX/iqjdTBctzL0lanD6sjvWD7M8cfltJ2kpboeaxI
 4nPx4eQhOJOLXaSghPiiE3STF417u3E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE8C73C9BD7
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:05:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08A8A3C4C99
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:04:24 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81D25611240
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:04:23 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f378498c9so1596761f8f.1
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739797463; x=1740402263; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4rA76Uh318+g69suXBsJjT/9v+5789jwqMrYMKQ1m1U=;
 b=QCYRunWsLhAvQ/br0z65r0DIZUWlfvyFrp9H0NoSA6KpnfqatVFHApNqLOabNqVCPD
 63mB8+svvyqIgR48yza4jE/OFwp7DVdun5ml3blSK7iurzs7BrHumI0Y7KmOboefn5Ic
 gJAVSID0o+95HiUPAZ2z1Qx38g3QM37IFqrehhEsJoGNnUEpdk2Ao7oTJK2qI6bKEswK
 aw66MzymqPijFJ/CHsIct1DzlIiCHMLD/L8Fz/s2p12JS3lbhawagq8cICHaJWgXwD6k
 RmaZ8yPJKo8hLvnSmygG99P23v+VpjVG6/eJM7riRG2ciFiFxRdqx7dS8pcN7RYfvEOY
 O2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797463; x=1740402263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4rA76Uh318+g69suXBsJjT/9v+5789jwqMrYMKQ1m1U=;
 b=kWKjwHLw6AIVxtm3JMXLld1YqnXOPuq1xcT191QiKWicyqRpgL3otSSjR2gQ0aPhaD
 EX2fsce0VES7ZNZ4lVK+mmUpXPIwBQE5hqb9yS87d7QouXBMIQBgUirl8l6ujSOWetMh
 yhbiXK52r2UrU5gbZgcx9w727yEISvH+gIcuIMVzQdUDZkgD86VbtJP2WbNgZL+bfj2X
 d4hy3EwHB19VyYgxDwC16FebEpUNgVHeNSltfsi0XeNYewGabp7ce/L5kfEPMg/hu2CQ
 jgI8RQevx2A3DmJKTY5jbbnenqskHuERW74fgU1wNZb1nJmOo6Y5wuSlvG0vT6U2S9Sy
 iwwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvdcp8NR9eAxxRp/pw5ZxrZIw8oN97Fo7ThRxRaIVFFClsNfByP34C5Tg+HCpcxcIs1+M=@lists.linux.it
X-Gm-Message-State: AOJu0YyMRXco7YU+fgvVjeEfPyOAVe1FGI9elcGNAtMa36X6hohWEocg
 qCzjbhWK8q3IqqQpes2zUc1wTOIpK8KzoezdPJLTWCE2LZeKzNDV3LIRFd9IYzNa2N1dcIzc4EX
 G
X-Gm-Gg: ASbGnctkUwTnyb3AP2WsuEQj1z1V5BUeIdb7UTHK2kYIO05OEeAx5TM8lSGBTyQDe0A
 hf5rZ+LwQllYA4NSEsCWWa1EckWSDgQ63yqPiI6Jv8daTzq8gTSqYWANseEXVC9xY4KbAS6fb0e
 FNo6QXSHBlQQkYExAD44TwGsmPXzBq5CzsFhgqNcQdW5N40uzeN+ZuHmC7Rvn7dUIv6xayuNr9U
 Yv+tjo0GQ+w0TBlMJzJh22nyF+Dx5zvYabIZJBCynUUBflbpTZI6u5ycvIQLTdsN3eyM0rJSbvj
 UMiH2aCfPoxQw5nC8fQ3aooEf1u4v0FuUh5ePHxLUf/bN7KW/h8Xk2wE/stgQVVW8rtWvbRdAhx
 i5rLbi0LnBTzZzZwQEd7tUEyiAIQl4ZODbNrnrRMp76Op8CDpBwQ=
X-Google-Smtp-Source: AGHT+IHWsFcuUprYqMNkEzGfhplv0MmRXIUhCN4nbI6IVOoBnOxv/uXnCMwt+Lu68LzYRnjoI/scEQ==
X-Received: by 2002:a05:6000:4010:b0:38d:d93b:5899 with SMTP id
 ffacd0b85a97d-38f33f3013cmr11918615f8f.21.1739797462821; 
 Mon, 17 Feb 2025 05:04:22 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53376adcsm888512766b.95.2025.02.17.05.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:04:22 -0800 (PST)
Message-ID: <2993f7f6-5473-4c99-bf33-764d0295433f@suse.com>
Date: Mon, 17 Feb 2025 14:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <ricardo@marliere.net>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250217-clear_descriptions-v1-0-90e8229d52b4@marliere.net>
 <20250217-clear_descriptions-v1-1-90e8229d52b4@marliere.net>
Content-Language: en-US
In-Reply-To: <20250217-clear_descriptions-v1-1-90e8229d52b4@marliere.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] doc: Remove [Description] title
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

SGksCgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbT4KCk9uIDIvMTcvMjUgMTM6NTksIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3RlOgo+IEFz
IGEgZm9sbG93IHVwIG9mIGNvbW1pdCBhM2UyN2RmMzRkNmMgKCJkb2M6IFJlbW92ZSBbRGVzY3Jp
cHRpb25dIHRpdGxlIiksCj4gcmVtb3ZlIHNvbWUgbGVmdCBvdmVycyB3aGljaCB3ZXJlIG5vdCBk
ZXRlY3RlZCB3aXRoIHRoZSBvcmlnaW5hbCBSZWdFeC4KPgo+IFNpZ25lZC1vZmYtYnk6IFJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyaWNhcmRvQG1hcmxpZXJlLm5ldD4KPiAtLS0KPiAgIHRlc3RjYXNl
cy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAxNy5jIHwgMiAtLQo+ICAgdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDE5LmMgfCAyIC0tCj4g
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAxLmMgICAgICAgICAgICB8IDIg
LS0KPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDMuYyAgICAgICAgICAg
IHwgMiAtLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswNC5jICAgICAg
ICAgICAgfCAyIC0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9ya19wcm9j
cy5jICAgICAgICB8IDIgLS0KPiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9n
ZXRldWlkMDEuYyAgICAgIHwgMiAtLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRl
dWlkL2dldGV1aWQwMi5jICAgICAgfCAyIC0tCj4gICA4IGZpbGVzIGNoYW5nZWQsIDE2IGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZW1tYXAvaHVnZW1tYXAxNy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDE3LmMKPiBpbmRleCBjY2EwMjkxYWQ5ZDhmM2RiYTNhNzkxZWY0MDQwODhiZDIy
NzRlMWE0Li5iNzg0MDA1YWYwMzA5ZjI3MjhhMDA2ZWMwNDVjZjUyZDU5Mjc3ZGZjIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAxNy5j
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDE3
LmMKPiBAQCAtNSw4ICs1LDYgQEAKPiAgICAqLwo+ICAgCj4gICAvKlwKPiAtICogW0Rlc2NyaXB0
aW9tXQo+IC0gKgo+ICAgICogQXQgb25lIHN0YWdlLCBhIG1pc2NvbnZlcnNpb24gb2YgaHVnZXRs
Yl92bXRydW5jYXRlX2xpc3QgdG8gYSBwcmlvX3RyZWUKPiAgICAqIG1lYW50IHRoYXQgb24gMzIt
Yml0IG1hY2hpbmVzLCBjZXJ0YWluIGNvbWJpbmF0aW9ucyBvZiBtYXBwaW5nIGFuZAo+ICAgICog
dHJ1bmNhdGlvbnMgY291bGQgdHJ1bmNhdGUgaW5jb3JyZWN0IHBhZ2VzLCBvciBvdmVyd3JpdGUg
cG1kcyBmcm9tCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZW1tYXAvaHVnZW1tYXAxOS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDE5LmMKPiBpbmRleCBjMGU0MWRmYTMxMjg5MzI2NDk0NGI2Mjg1MmFmYzlmZDc3
NjgyMDJkLi4xM2MzYzdhYzYzZGY1YTEzOGNmZDYwODc4NzVkYWZkNmRjOTI0OTc4IDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAxOS5j
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDE5
LmMKPiBAQCAtNiw4ICs2LDYgQEAKPiAgICAqLwo+ICAgCj4gICAvKlwKPiAtICogW0Rlc2NyaXBp
dG9uXQo+IC0gKgo+ICAgICogQXQgb25lIHN0YWdlLCBhIG1pc2NvbnZlcnNpb24gb2YgaHVnZXRs
Yl92bXRydW5jYXRlX2xpc3QgdG8gYQo+ICAgICogcHJpb190cmVlIG1lYW50IHRoYXQgb24gMzIt
Yml0IG1hY2hpbmVzLCB0cnVuY2F0ZXMgYXQgb3IgYWJvdmUgNEdCCj4gICAgKiBjb3VsZCB0cnVu
Y2F0ZSBsb3dlciBwYWdlcywgcmVzdWx0aW5nIGluIEJVR19PTigpcy4KPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMS5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mb3JrL2ZvcmswMS5jCj4gaW5kZXggMzFlYzVkNGMxZjk1NmNkOGYxOTk1NGNj
ZGI2YTg5M2M2NjRlZjJkMS4uZDZmNmJjZmI3YmM1YWIwMjRiY2MwM2QyNGM1MWM5NThjNTg3Y2Ex
ZCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAxLmMK
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAxLmMKPiBAQCAtNiw4
ICs2LDYgQEAKPiAgICAqLwo+ICAgCj4gICAvKlwKPiAtICpbRGVzY3JpcHRpb25dCj4gLSAqCj4g
ICAgKiAtIGZvcmsgcmV0dXJucyB3aXRob3V0IGVycm9yCj4gICAgKiAtIGZvcmsgcmV0dXJucyB0
aGUgcGlkIG9mIHRoZSBjaGlsZAo+ICAgICovCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZm9yay9mb3JrMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9y
ay9mb3JrMDMuYwo+IGluZGV4IGM2MzgxZGQ2NzM3NjUzYjAyNWQ2NTZlNGI0MjU1ZDI3MDA3ZWE2
YmUuLmRhYmUwZDQ5OGY2MzNlOWE4MzI2ZDEwNDg3M2Y3ZDgwYzgwOWYwMTYgMTAwNjQ0Cj4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMy5jCj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMy5jCj4gQEAgLTYsOCArNiw2IEBACj4gICAg
Ki8KPiAgIAo+ICAgLypcCj4gLSAqW0Rlc2NyaXB0aW9uXQo+IC0gKgo+ICAgICogQ2hlY2sgdGhh
dCBjaGlsZCBwcm9jZXNzIGNhbiB1c2UgYSBsYXJnZSB0ZXh0IHNwYWNlIGFuZCBkbyBhIGxhcmdl
IG51bWJlcgo+ICAgICogb2Ygb3BlcmF0aW9ucy4gSW4gdGhpcyBzaXR1YXRpb24sIGNoZWNrIGZv
ciBwaWQgPT0gMCBpbiBjaGlsZCBhbmQgY2hlY2sKPiAgICAqIGZvciBwaWQgPiAwIGluIHBhcmVu
dCBhZnRlciB3YWl0Lgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zv
cmsvZm9yazA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazA0LmMKPiBp
bmRleCA0MTNjZDVlYjQ1YzUyOThjZDdhNThlMDMwMGM1ZjUxNTVmMGY2ODg2Li5lY2JiYzQ3ZmIx
NzEwMTdjYWE2NDFjNDc4ZTE4OGI2NmFmZTg5YzA0IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDQuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZm9yay9mb3JrMDQuYwo+IEBAIC02LDggKzYsNiBAQAo+ICAgICovCj4gICAKPiAgIC8q
XAo+IC0gKltEZXNjcmlwdGlvbl0KPiAtICoKPiAgICAqIFRoaXMgdGVzdCB2ZXJpZmllcyB0aGF0
IHBhcmVudCBwcm9jZXNzIHNoYXJlcyBlbnZpcm9uIHZhcmlhYmxlcyB3aXRoIHRoZQo+ICAgICog
Y2hpbGQgYW5kIHRoYXQgY2hpbGQgZG9lc24ndCBjaGFuZ2UgcGFyZW50J3MgZW52aXJvbiB2YXJp
YWJsZXMuCj4gICAgKi8KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
b3JrL2ZvcmtfcHJvY3MuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrX3By
b2NzLmMKPiBpbmRleCBjMzViYjQ4MGNlOWU5ZGNiY2RhNTYxNTA1ZTIxMzhjM2U0NzdmMTBlLi45
ZTA4NGVkNmMwZDliNDZhYWFiZWVjMGYwZjZlYTIyMjU5NmY0NDY4IDEwMDY0NAo+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrX3Byb2NzLmMKPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9ya19wcm9jcy5jCj4gQEAgLTQsOCArNCw2IEBACj4g
ICAgKi8KPiAgIAo+ICAgLypcCj4gLSAqW0Rlc2NyaXB0aW9uXQo+IC0gKgo+ICAgICogVGhpcyB0
ZXN0IHNwYXducyBtdWx0aXBsZSBwcm9jZXNzZXMgdXNpbmcgZm9yaygpIGFuZCBpdCBjaGVja3Mg
aWYgd2FpdCgpCj4gICAgKiByZXR1cm5zIHRoZSByaWdodCBQSUQgb25jZSB0aGV5IGVuZCB1cC4K
PiAgICAqLwo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGV1aWQv
Z2V0ZXVpZDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGV1aWQvZ2V0ZXVpZDAx
LmMKPiBpbmRleCA2NmZiODkzNmMyNzU3OTY3MGRmMjFiNDQzNDZmODgwNTQ0ZTlmZmFkLi4xZmUz
OGY2YzZmZmQ0OTU0ZDBlZjJjZDY3MzY0ZTAzNDJjZGQ1YzUyIDEwMDY0NAo+IC0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDEuYwo+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDEuYwo+IEBAIC04LDggKzgsNiBAQAo+
ICAgICovCj4gICAKPiAgIC8qXAo+IC0gKltEZXNjcmlwdGlvbl0KPiAtICoKPiAgICAqIENoZWNr
IHRoZSBiYXNpYyBmdW5jdGlvbmFsaXR5IG9mIHRoZSBnZXRldWlkKCkgc3lzdGVtIGNhbGwuCj4g
ICAgKi8KPiAgIAo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGV1
aWQvZ2V0ZXVpZDAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGV1aWQvZ2V0ZXVp
ZDAyLmMKPiBpbmRleCBlYjIyNzJiZmYzNDAyM2NhYTU2YTJhNTNlM2EzODE4NDQzNjQyZDg0Li4w
OWNiODE2ZjQ0NjcyMzc5MDg5M2ZhYzEwOGYwNDFkODJlMjUxNmEwIDEwMDY0NAo+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDIuYwo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZXVpZC9nZXRldWlkMDIuYwo+IEBAIC02LDggKzYsNiBA
QAo+ICAgICovCj4gICAKPiAgIC8qXAo+IC0gKltEZXNjcmlwdGlvbl0KPiAtICoKPiAgICAqIENo
ZWNrIHRoYXQgZ2V0ZXVpZCgpIHJldHVybiB2YWx1ZSBtYXRjaGVzIHZhbHVlIGZyb20gL3Byb2Mv
c2VsZi9zdGF0dXMuCj4gICAgKi8KPiAgIAo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
