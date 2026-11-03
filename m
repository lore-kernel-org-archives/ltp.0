Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA352606A324
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CxRc97A5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19C643C67A2
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 08:43:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E994C3C4F7B
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:43:28 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9334D1A00492
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 08:43:27 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b547d6c07bso86808a12.1
 for <ltp@lists.linux.it>; Mon, 02 Nov 2026 23:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793691807; cv=none;
 d=google.com; s=arc-20260327;
 b=P/Rd/OXWk+Ml/qk1VLWn6b+gJJrXbkuLhnHerRso54aiHaPus4XHo2jQv5XCNvrKT3
 d3NlYEjwPB5XjnjAf+J6/UebgDIwyrPTJoX2BUXoryoy7p97hr6VLajwvdET9zUWfrYj
 TW1TfUWGzVwKcH6H8q0uMaTfHUKuADskzJO3kF8iCywstvc7vifrp6EXF2KH4JLZMlHs
 gVxjcRF0/yCq08W6Fkiu3jJ84umiyU5zQkCowEDGnjwfiZBpy4ovi//XOHkmjR+lYnxA
 uRjSznpnLhYBYvB7BaUR0g90nFCeowd0ujPQsv37o4NulH+O/WqTKsniO9pL4tYvXHEj
 J+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ItnTgQiV+dbgOQqfZLyaMUcRiXHQM4rKjCL3fKksHBo=;
 fh=fdbP5C1Dg266RadhO7BzffCE0ZClzXSCX8VOkprraiU=;
 b=ZnPS0gu5Sho+NfnRMqUOoeqgZvgPz/E6Kr0o5AvdMyLwDmOzTlEzcoS/ppnZEW1t2T
 bl41VHIM5hGlmPc9afZi4ToC5fMHWP0yVZl+Pr2QQw3NAkrCOp0gAmTjQkbki8GPadZV
 bRPqOVBFgpQ2448xKDvidZL4vcSzr0ggmadxI6iBVT7G5M3/b1r+LhkurBrkj7QiZg6R
 z38wye5ZFY5pamRO/57Ws6u6q2JHe5iKTCCcaR3wWOSdIuvc1R1OxmQX1p4D+0ZtE6ZC
 s02Tu1VYJsyyf93qKEisfjlS70y7ajUILJBsxQRNFpfVcjR5E7cx5yi57j3wpCzWhCar
 tWEg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793691807; x=1794296607; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ItnTgQiV+dbgOQqfZLyaMUcRiXHQM4rKjCL3fKksHBo=;
 b=CxRc97A5jm63GItcs0VRW2qJ6d0Gci4XWN1OpGfW7kLjqOwabqzYauavLvgsn7dMfL
 uExFrbfJ0dTWk+kYwwJvEA5G51kwt8/NxqPBYRWLEPx7gRlxeRO/keVRIiMldgbUlaY7
 DU+T00RmnmzPk1TGBwIrqc0Ys2u3qgfSJL6ukPSOyhdYBjuggOh3/dQZf1lvBh44BaYY
 tdEsQ78nPOCuixbb/dKAx7qLe/JKl0Rv2WzXlF1HwkcPs3h2+EqdqyL9APsI3fFtcgCV
 bzF2s03AKowd2ERwaPbTf1UfeJWJTxti9Zmi0PkmqueNNQaTkaz2Gt8rEMWtFq3uljx1
 nRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691807; x=1794296607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ItnTgQiV+dbgOQqfZLyaMUcRiXHQM4rKjCL3fKksHBo=;
 b=Ia5UI87syY2+M+PDIPb4OpUBQGp/nmiK/H1JM+MRmvhtWCxTs6OvyXOG6Mm6+cJYK7
 fd5ar6NdxiwZ9H/KNPhiRntv8JDZMvNQeIs5mzadmgBr+Uu1uMyTyrxD/la6ECsEx8bE
 qk1y6fWMEnC9DaoP4DS0M8OsAxZPaLUlmTq5Nqn1jQOhN/hd03ZMI3wfQDuH9yXbQQsI
 aC6y5N8xqD/j1XnLKJbjp23+BvXsdBmgj57e5SZbLELteLSVqz8w7mQUEtZPTrSGFLL2
 PKA1gvQFlVhyM13hxQdEZuB2lhpJMJn8VTPl+VHZ5zAcTz3aZrx5HhaShRuHF/PnSEJm
 WARQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkROg9XXo8M7KmkF0IPq+7Qoi6VIv4BTkXAC408Wa7C+JbzSYKM7GMhx1eJkbFUHtyOt0=@lists.linux.it
X-Gm-Message-State: APuU4Z/AQ2KY9Wogs//D4UqZ6ji1FB3fODBjljOYFlBuXEWPnq3fWGr6
 rlaKHotJmqAv1q+6+M620KFbuNZDGCwCZKT8Jz8l30gbBrls/87VsFDoyjxDOaYmUaiNV26U7//
 d0K2xxNhANl8Ip+c3POxeLbV8RaRiFDU=
X-Gm-Gg: AYBFou2ac+XH/6LmYolZAwKpLWnB9FM8P2Wm6BuP4YkVN+5JAUUTBWMsf8NRuZ6jVr9
 5nGGx+L+jJs26gBkDpr9CZe2tcFUBmbzL9EJD5gDjSdektWl6MOCyYKezbWYClidkafxzw6t9e5
 GlPOsIaheTghZGJA3oxVq+K6gryU0tKSnrtKCqYENr8ObZY83LlsYN0Ozq77HbCA71FE4SgU0JZ
 g1Kd0RTxeJ2LK2c9DyhIxrjYMo4aRi/tWbBmYboU7KHQjVlXUK2mzW3JZHzGaNyNGw99FuziC6h
 lD3bpr/hHtNbjcGyybvx4HwzBjBPfJPvkr/uxNq/G8TVppC5PhzBb5HPOx8TeG1Dy2z3dBaA22F
 znRpiG1AzOytBYDzTZzkLyeW1RFKa+E9hGaySFZAVRqHPULstpipIu9f9oHo4Wa/NKSe77Q==
X-Received: by 2002:a05:6402:321c:b0:6b4:2f6c:799d with SMTP id
 4fb4d7f45d1cf-6b4d487e981mr9839403a12.28.1793691806704; Mon, 02 Nov 2026
 23:43:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <P5Iny41--F-9@tuta.io>
 <CAOQ4uxgqZANVT8wi_hCJX6Ym5Ea9XMCo3eSRwp-aujf767NbeA@mail.gmail.com>
 <20261103072455.GA35831@pevik>
In-Reply-To: <20261103072455.GA35831@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 08:43:14 +0100
X-Gm-Features: AclHuK9R3XFx7DHs3R63uJwLWtujoG8pQ9ImqPFBxBZoS80OJdZslOSjIZHfq2E
Message-ID: <CAOQ4uxiL2ZKcr-V=NsJX5A2zse0YFX+gSyi7Y5Yb51NPJ5s1+A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Add directory cases for the
 nested event
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBOb3YgMywgMjAyNiBhdCA4OjI04oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgQW1pciwgRWR2YXJkLAo+Cj4gPiBPbiBTYXQsIE9jdCAzMSwgMjAy
NiBhdCAxMDoxM+KAr1BNIEVkdmFyZCBDb25yYWQgPGVkdmFyZEB0dXRhLmlvPiB3cm90ZToKPgo+
ID4gPiBBIGRpcmVjdG9yeSBvbiBvdmVybGF5ZnMgcmVhY2hlcyBpdHMgcmVhbCBkaXJlY3Rvcnkg
dGhyb3VnaAo+ID4gPiBvdmxfZGlyX29wZW5fcmVhbGZpbGUoKSByYXRoZXIgdGhhbiBiYWNraW5n
X2ZpbGVfb3BlbigpLCBzbyB0aGUgZml4Cj4gPiA+IGZvciByZWd1bGFyIGZpbGVzLCBjb21taXQg
YzNkMzU1ZjQyN2NlICgiZnM6IGxldCBiYWNraW5nIGZpbGVzCj4gPiA+IGluaGVyaXQgRk1PREVf
Tk9OT1RJRlkgZnJvbSB0aGUgdXNlciBmaWxlIiksIGRvZXMgbm90IGNvdmVyIGl0OiBhCj4gPiA+
IGxpc3RlbmVyIHRoYXQgbWFya3MgdGhlIGJhY2tpbmcgZmlsZXN5c3RlbSB3aXRoIEZBTl9PUEVO
X1BFUk0gfAo+ID4gPiBGQU5fT05ESVIgaXMgc3RpbGwgc2VudCBhIG5lc3RlZCBwZXJtaXNzaW9u
IGV2ZW50IGZyb20gaXRzIG93bgo+ID4gPiByZWFkKDIpIHdoZW4gdGhlIHJlcG9ydGVkIHBhdGgg
aXMgYW4gb3ZlcmxheSBkaXJlY3RvcnkuCj4KPiA+ID4gQWRkIHRoZSBkaXJlY3RvcnkgY291bnRl
cnBhcnRzIG9mIHRoZSB0d28gZXhpc3RpbmcgY2FzZXMuIFRoZQo+ID4gPiBsaXN0ZW5lcidzIGV4
cGVjdGVkIGV2ZW50IG1hc2sgc3RheXMgRkFOX09QRU5fUEVSTTogRkFOX09ORElSIGlzIG5vdAo+
ID4gPiByZXBvcnRlZCB0byBhIGdyb3VwIHdpdGhvdXQgRkFOX1JFUE9SVF9GSUQuCj4KPiA+ID4g
VGhlIGZvdXJ0aCBjYXNlIGZhaWxzIG9uIGEga2VybmVsIHdpdGhvdXQgdGhlIHBlbmRpbmcgZml4
ICJvdmw6Cj4gPiA+IGluaGVyaXQgRk1PREVfTk9OT1RJRlkgd2hlbiBvcGVuaW5nIGRpcmVjdG9y
eSByZWFsZmlsZXMiLgo+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEVkdmFyZCBDb25yYWQgPGVkdmFy
ZEB0dXRhLmlvPgo+Cj4gPiBSZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdt
YWlsLmNvbT4KPgo+ID4gPiAtLS0KPiA+ID4gRGVwZW5kcyBvbiB0aGUgcGVuZGluZyBvdmVybGF5
ZnMgZml4LCBwb3N0ZWQgYnkgQW1pciBvbiB0aGUga2VybmVsCj4gPiA+IHRocmVhZDoKPiA+ID4g
ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FPUTR1eGptPWNHUG51ZzE4VnVoS3FpTXZr
V3dMUE5MT19URTNLeE84aUxaRyt2ZVlRQG1haWwuZ21haWwuY29tLwo+ID4gPiBXaXRob3V0IGl0
IHRoZSBmb3VydGggY2FzZSBmYWlscyBvbiBjdXJyZW50IG1haW5saW5lLCBzbyB0aGlzIHNob3Vs
ZAo+ID4gPiB3YWl0IGluIHRoZSBxdWV1ZSB1bnRpbCB0aGF0IGZpeCBpcyBpbiBMaW51cycgdHJl
ZTsgYSBsaW51eC1naXQgdGFnIGZvcgo+ID4gPiBpdCBjYW4gdGhlbiBiZSBhZGRlZC4gVGhlIGZp
cnN0IHRocmVlIGNhc2VzIHBhc3Mgb24gdjcuNC1yYzEgbWF0ZXJpYWwKPiA+ID4gdG9kYXkuCj4K
PiA+ID4gVGVzdGVkIGluIGEgVk0sIGVhY2gga2VybmVsIHJ1biBvbmNlIGFuZCB3aXRoIC1pIDI6
Cj4KPiA+ID4gICBrZXJuZWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmaWxlK2JhY2tp
bmcgIGRpcitiYWNraW5nCj4gPiA+ICAgdjYuMTMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgICAgICBGQUlMCj4gPiA+ICAgNmI0YjU0M2ZhMTggKG5vIGZpeCkgICAgICAg
ICAgICAgICAgRkFJTCAgICAgICAgICBGQUlMCj4gPiA+ICAgKyBjM2QzNTVmNDI3Y2UgKGZpbGVz
LCBpbiBMaW51cycpICAgUEFTUyAgICAgICAgICBGQUlMCj4gPiA+ICAgKyB0aGUgcGVuZGluZyBv
dmwgZml4ICAgICAgICAgICAgICAgUEFTUyAgICAgICAgICBQQVNTCj4KPiA+ID4gVGhlICJvdmVy
bGF5IG1hcmsgb25seSIgY2FzZXMgcGFzcyBldmVyeXdoZXJlLiBUaGUgZGlyZWN0b3J5IGNhc2UK
PiA+ID4gZmFpbHMgb24gdjYuMTMgdG9vOiBvdmVybGF5ZnMgbmV2ZXIgcGFzc2VkIHRoZSBub25v
dGlmeSBzdGF0ZSBvbiB0bwo+ID4gPiB0aGUgcmVhbCBkaXJlY3RvcnksIHNvIGl0IHByZWRhdGVz
IHRoZSA2LjE0IGNoYW5nZSB0aGF0IGJyb2tlIGZpbGVzLgo+Cj4gPiBBcyBmYXIgYXMgSSBjYW4g
dGVsbCBpdHMgYSByZWdyZXNzaW9uIGZyb20KPiA+IDEzMGZkYmMzZDFmOTkgKCJvdmw6IHBhc3Mg
Y29ycmVjdCBmbGFncyBmb3Igb3BlbmluZyByZWFsIGRpcmVjdG9yeSIpCj4KPiA+IFRoYW5rcyBm
b3IgYWRkaW5nIHRoaXMgdGVzdC4KPiA+IEkgYWRkZWQgeW91ciBUZXN0ZWQtYnkgdG8gdGhlIGZp
eCBwYXRjaC4KPgo+IEknbSBnb2luZyB0byBtZXJnZSB0b2RheS4gU28gdGhlcmUgd2lsbCBiZSBo
YXNoIGZvciBmaXhpbmcga2VybmVsIGNvbW1pdCwKPiB0aGFua3MgZm9yIGluZm8uCj4KCkZZSSwg
RWR2YXJkIGZvdW5kIGFub3RoZXIgYnVnIGFuZCBoYXMgd3JpdHRlbiBhbiBleHRyYSB0ZXN0IGNh
c2UgdG8gY292ZXIgaXQKdGhlIGV4cGVjdGVkIGtlcm5lbCBmaXggaXMgZ29pbmcgdG8gY292ZXIg
dGhlIGRpcmVjdG9yeSB0ZXN0IGNhc2VzIGluIHRoaXMgcGF0Y2gKYXMgd2VsbCBhcyB0aGUgZXh0
cmEgdGVzdCBjYXNlOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdW5pb25mcy9QNVF1
M2NvLS1OLTlAdHV0YS5pby8KClVwIHRvIHlvdSBpZiB5b3Ugd2FudCB0byBtZXJnZSBub3cgb3Ig
d2FpdCBmb3IgdGhlIGV4dHJhIHRlc3QgY2FzZS4KClRoYW5rcywKQW1pci4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
