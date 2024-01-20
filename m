Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF18C47258
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 18:53:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 037B63CE506
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 19:53:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E13B3CB172
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 19:53:03 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E1CAD60070F
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 19:53:02 +0100 (CET)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bd562d17dcso1572907b6e.3
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 10:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705776781; x=1706381581; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LO9ZHGqQECZ2D07fi8yVhBKcMzIVRK89BtUg0hDmYvo=;
 b=Kq40KWzPY0/K7HDdhrMv1OR6X769xsgPNYUoXoD7X68CBc+OkcsdwkG79BFlzwHdbc
 MoZw3jnOKBAtmDu4fyJs74RsW93TkVaPQwXspbXHMcjyngg4qwpNlYdWlDw7mFIJMmmP
 4aC80D7rTVD2R/kQoLJSV/z0s/XLFrSi7z9364zmvN0fQbIkgPfWBf4VakPC27In6lpi
 d34jCFgzGSLNCE6+9n8yb0ZClzIp2vAnzdPIlzsfqM/OmIrXorRonjQWRBn7FPlwGqO2
 jjgYtTafkInoQjnHxFYRutAv7TSTIbDeZiNXHujB3ECXzKJM2ydW27eDPAQV+2sui3T8
 NKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705776781; x=1706381581;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LO9ZHGqQECZ2D07fi8yVhBKcMzIVRK89BtUg0hDmYvo=;
 b=GJDTnOhaJmrdQ9HC8ek54y/zPKPkh1QFgitQC7mvwgHVr1mCqjakpzm0p/PYmrXSt7
 T4rdrVLtEofoY6/ARmhgrIqOaErtreTg6Nh0BxcbpwTmld1ceY1GhbwarfjyPYTISa3z
 HHpB7Coh32egQvcBEyq223OUROGLtyJ3CSReHDcni8cvWZ/Ygw/d9YFgb8ZF741dE7hL
 2k/L1Caa1M4ez7MybT3epHWNamrmXqINE91hq33qhOeNVnKobE2hZ70jSVEhpRnVOJ6g
 hIf7deh0xd2gcpQLiitrH+A/X2tlJkHhDJNn2D8FMGe0BZn9UQFoalBzLqG+CmdVqUh2
 7mmA==
X-Gm-Message-State: AOJu0Yz7LTp8CFb4YztsFinCNqrfKqFyHTZnBJhXfscvCm2wX4cJ6LtN
 OeyYomRshWkCsrP9iS3Lr+sry+Yf82Pii/0BzywJsakRktNJFmJ5
X-Google-Smtp-Source: AGHT+IEnEWTd31E8lOZ5HEL/S3JgQckCViuzHuUWjvD4nyHhM742WsRI7AvTiM2XbAX+gKwmfES19Q==
X-Received: by 2002:a05:6808:220d:b0:3bd:a87a:bcbd with SMTP id
 bd13-20020a056808220d00b003bda87abcbdmr2108193oib.39.1705776781374; 
 Sat, 20 Jan 2024 10:53:01 -0800 (PST)
Received: from ?IPV6:2406:7400:94:ee42:e61e:cfc5:9906:904b?
 ([2406:7400:94:ee42:e61e:cfc5:9906:904b])
 by smtp.gmail.com with ESMTPSA id
 nc15-20020a17090b37cf00b0028feef1f7adsm6316068pjb.50.2024.01.20.10.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jan 2024 10:53:00 -0800 (PST)
Message-ID: <13597a4e-fdf8-4897-a167-28e2ef0a5ad3@gmail.com>
Date: Sun, 21 Jan 2024 00:22:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
References: <20240115155936.3235-1-subramanya.swamy.linux@gmail.com>
 <20240116162822.GB2606232@pevik>
Content-Language: en-US
In-Reply-To: <20240116162822.GB2606232@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] isofs.sh:Use genisoimage/xorrisofs instead of
 mkisofs
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUaGFuayB5b3UgZm9yIHJldmlld2luZyB0
aGUgcGF0Y2guCgpPbiAxNi8wMS8yNCAyMTo1OCwgUGV0ciBWb3JlbCB3cm90ZToKPiBIaSBTdWJy
YW1hbnlhLAo+Cj4+IERlYmFpbiB1c2VzIGdlbmlzb2ltYWdlL3hvcnJpc29mcyBhbmQgQ2VudG9z
IHVzZXMgeG9ycmlzb2ZzCj4+IGJvdGggZ2VuaXNvaW1hZ2UgJiB4b3JyaXNvZnMgaGF2ZSBzeW1s
aW5rcyB0byBta2lzb2ZzCj4+IHhvcnJpc29mcyBkb2Vzbid0IHN1cHBvcnQgLWhmcyBvcHRpb24g
JiBzdXBwb3J0cyBvbmx5IC1oZnNwbHVzIG9wdGlvbgo+PiBnZW5pc29pbWFnZSBzdXBwb3J0cyBi
b3RoIC1oZnMgJiAtaGZzcGx1cyBvcHRpb25zCj4gV2VsbCwgdGhlcmUgYXJlIDMgdG9vbHMgKGFs
dGhvdWdoIG5vdCBhbGwgaW4gYWxsIGRpc3Ryb3MpOgo+Cj4gKiBEZWJpYW4KPiBmb3IgaSBpbiBt
a2lzb2ZzIGdlbmlzb2ltYWdlIHhvcnJpc287IGRvIGVjaG8gIj09PSAkaSA9PT0iOyAkaTsgZWNo
bzsgZG9uZQo+ID09PSBta2lzb2ZzID09PQo+IGdlbmlzb2ltYWdlOiBNaXNzaW5nIHBhdGhzcGVj
Lgo+IFVzYWdlOiBnZW5pc29pbWFnZSBbb3B0aW9uc10gLW8gZmlsZSBkaXJlY3RvcnkgLi4uCj4K
PiBVc2UgZ2VuaXNvaW1hZ2UgLWhlbHAKPiB0byBnZXQgYSBsaXN0IG9mIHZhbGlkIG9wdGlvbnMu
Cj4KPiBSZXBvcnQgcHJvYmxlbXMgdG9kZWJidXJuLWRldmVsQGxpc3RzLmFsaW90aC5kZWJpYW4u
b3JnLgo+Cj4gPT09IGdlbmlzb2ltYWdlID09PQo+IGdlbmlzb2ltYWdlOiBNaXNzaW5nIHBhdGhz
cGVjLgo+IFVzYWdlOiBnZW5pc29pbWFnZSBbb3B0aW9uc10gLW8gZmlsZSBkaXJlY3RvcnkgLi4u
Cj4KPiBVc2UgZ2VuaXNvaW1hZ2UgLWhlbHAKPiB0byBnZXQgYSBsaXN0IG9mIHZhbGlkIG9wdGlv
bnMuCj4KPiBSZXBvcnQgcHJvYmxlbXMgdG9kZWJidXJuLWRldmVsQGxpc3RzLmFsaW90aC5kZWJp
YW4ub3JnLgo+Cj4gPT09IHhvcnJpc28gPT09Cj4geG9ycmlzbyAxLjUuMiA6IFJvY2tSaWRnZSBm
aWxlc3lzdGVtIG1hbmlwdWxhdG9yLCBsaWJidXJuaWEgcHJvamVjdC4KPgo+IHVzYWdlIDogeG9y
cmlzbyBbY29tbWFuZHNdCj4gICAgICAgICAgTW9yZSBpcyB0b2xkIGJ5IGNvbW1hbmQgLWhlbHAK
PiA9PiBEZWJpYW4gaGFzIGdlbmlzb2ltYWdlIGFuZCB4b3JyaXNvCj4KPiAqIG9wZW5TVVNFIFR1
bWJsZXdlZWQKPgo+ICQgZm9yIGkgaW4gbWtpc29mcyBnZW5pc29pbWFnZSB4b3JyaXNvOyBkbyBl
Y2hvICI9PT0gJGkgPT09IjsgJGk7IGVjaG87IGRvbmUKPiA9PT0gbWtpc29mcyA9PT0KPiBta2lz
b2ZzOiBNaXNzaW5nIHBhdGhzcGVjLgo+IFVzYWdlOiBta2lzb2ZzIFtvcHRpb25zXSBbLWZpbmRd
IGZpbGUuLi4gW2ZpbmQgZXhwcmVzc2lvbl0KPgo+IFVzZSBta2lzb2ZzIC1oZWxwCj4gdG8gZ2V0
IGEgbGlzdCBhbGwgb2YgdmFsaWQgb3B0aW9ucy4KPgo+IFVzZSBta2lzb2ZzIC1maW5kIC1oZWxw
Cj4gdG8gZ2V0IGEgbGlzdCBvZiBhbGwgdmFsaWQgLWZpbmQgb3B0aW9ucy4KPgo+IE1vc3QgaW1w
b3J0YW50IE9wdGlvbnM6Cj4gCS1wb3NpeC1ICQlGb2xsb3cgc3lsaW5rcyBlbmNvdW50ZXJlZCBv
biBjb21tYW5kIGxpbmUKPiAJLXBvc2l4LUwJCUZvbGxvdyBhbGwgc3ltbGlua3MKPiAJLXBvc2l4
LVAJCURvIG5vdCBmb2xsb3cgc3ltbGlua3MgKGRlZmF1bHQpCj4gCS1vIEZJTEUsIC1vdXRwdXQg
RklMRQlTZXQgb3V0cHV0IGZpbGUgbmFtZQo+IAktUiwgLXJvY2sJCUdlbmVyYXRlIFJvY2sgUmlk
Z2UgZGlyZWN0b3J5IGluZm9ybWF0aW9uCj4gCS1yLCAtcmF0aW9uYWwtcm9jawlHZW5lcmF0ZSBy
YXRpb25hbGl6ZWQgUm9jayBSaWRnZSBkaXJlY3RvcnkgaW5mbwo+IAktSiwgLWpvbGlldAkJR2Vu
ZXJhdGUgSm9saWV0IGRpcmVjdG9yeSBpbmZvcm1hdGlvbgo+IAktcHJpbnQtc2l6ZQkJUHJpbnQg
ZXN0aW1hdGVkIGZpbGVzeXN0ZW0gc2l6ZSBhbmQgZXhpdAo+IAktVURGCQkJR2VuZXJhdGUgVURG
IGZpbGUgc3lzdGVtCj4gCS1kdmQtYXVkaW8JCUdlbmVyYXRlIERWRC1BdWRpbyBjb21wbGlhbnQg
VURGIGZpbGUgc3lzdGVtCj4gCS1kdmQtdmlkZW8JCUdlbmVyYXRlIERWRC1WaWRlbyBjb21wbGlh
bnQgVURGIGZpbGUgc3lzdGVtCj4gCS1kdmQtaHlicmlkCQlHZW5lcmF0ZSBhIGh5YnJpZCAoRFZE
LUF1ZGlvL0RWRC1WaWRlbykgY29tcGxpYW50IFVERiBmaWxlIHN5c3RlbQo+IAktaXNvLWxldmVs
IExFVkVMCVNldCBJU085NjYwIGxldmVsICgxLi4zKSBvciA0IGZvciBJU085NjYwIHYgMgo+IAkt
ViBJRCwgLXZvbGlkIElECVNldCBWb2x1bWUgSUQKPiAJLWdyYWZ0LXBvaW50cwkJQWxsb3cgdG8g
dXNlIGdyYWZ0IHBvaW50cyBmb3IgZmlsZW5hbWVzCj4gCS1NIEZJTEUsIC1wcmV2LXNlc3Npb24g
RklMRQlTZXQgcGF0aCB0byBwcmV2aW91cyBzZXNzaW9uIHRvIG1lcmdlCj4KPiA9PT0gZ2VuaXNv
aW1hZ2UgPT09Cj4gICBnZW5pc29pbWFnZTogY29tbWFuZCBub3QgZm91bmQKPgo+ID09PSB4b3Jy
aXNvID09PQo+IHhvcnJpc28gMS41LjYgOiBSb2NrUmlkZ2UgZmlsZXN5c3RlbSBtYW5pcHVsYXRv
ciwgbGliYnVybmlhIHByb2plY3QuCj4KPiB1c2FnZSA6IHhvcnJpc28gW2NvbW1hbmRzXQo+ICAg
ICAgICAgIE1vcmUgaXMgdG9sZCBieSBjb21tYW5kIC1oZWxwCj4KPiA9PiBvcGVuU1VTRSBUdW1i
bGV3ZWVkIGhhcyBta2lzb2ZzIGFuZCB4b3JyaXNvIChnZW5pc29pbWFnZSBpcyBub3Qgb2ZmaWNp
YWxseQo+IHN1cHBvcnRlZCkKPgo+IEhvdyBhYm91dCB0byBydW4gdGVzdCAzeCAtIGZvciBta2lz
b2ZzLCBnZW5pc29pbWFnZSBhbmQgeG9ycmlzby4gVGhlcmUgd291bGQgYmUKPiBUQ09ORiB3aGVu
IGZpbGUgZG9lcyBub3QgZXhpc3QuIEFuZCBhbHNvIGRldGVjdGlvbiBpZiB0aGUgYmluYXJ5IGlz
IHRoZSBleHBlY3RlZAo+IG9uZT8gU29tZXRoaW5nIGxpa2UgdGhpczoKPgo+IFRTVF9URVNURlVO
Qz1kb190ZXN0Cj4gVFNUX0NOVD0zCj4KPiBkb190ZXN0KCkKPiB7Cj4gCWNhc2UgJDEgaW4KPiAJ
MSkgTUtJU09GU19DTUQ9Im1raXNvZnMiOzsKPiAJMikgTUtJU09GU19DTUQ9Imdlbmlzb2ltYWdl
Igo+IAkgICBIRlNPUFQ9Ii1oZnNwbHVzIC1EIC1oZnMgLUQiOzsKPiAJMykgTUtJU09GU19DTUQ9
InhvcnJpc28iCj4gCSAgIEhGU09QVD0iLWhmc3BsdXMgLUQiOzsKPiAJZXNhYwo+Cj4gCWlmICEg
dHN0X2NtZF9hdmFpbGFibGUgJE1LSVNPRlNfQ01EOyB0aGVuCj4gCQl0c3RfcmVzIFRDT05GICJN
aXNzaW5nICckTUtJU09GU19DTUQnIgo+IAkJcmV0dXJuCj4gCWZpCj4KPiAJaWYgISAkQ01EIDI+
JjEgfCBncmVwIC1xICIkTUtJU09GU19DTUQiOyB0aGVuCj4gCQl0c3RfcmVzIFRDT05GICInJE1L
SVNPRlNfQ01EJyBpcyBhIHN5bWxpbmsgdG8gYW5vdGhlciB0b29sIgo+IAkJcmV0dXJuCj4gCWZp
Cj4KPgo+IAkKPiAJCj4gCQo+IAkKPgo+IAkuLi4gKHJlc3Qgb2Ygb3JpZ2luYWwgZG9fdGVzdCAr
ICRIRlNPUFQgdXNlKQo+IH0KPgo+IERvZXMgaXQgbWFrZSBzZW5zZSB0byB5b3U/CgpZZXMgeW91
J3JlIHJpZ2h0IHRoaXMgY292ZXJzIGRpc3RybydzIHdoaWNoIHN1cHBvcnRzIGFsbCAzIHRvb2xz
ICYgc2tpcHMgCm9uIHN5bWxpbmtzIGZvciBta2lzb2ZzIGluIGNhc2Ugb2YgeG9ycmlzbyAmIGdl
bmlzb2ltYWdlICwgd2lsbCBjcmVhdGUgCnYyIHdpdGggY2hhbmdlcwoKSnVzdCBhIHRob3VnaHQg
LCBpcyBpdCBnb29kIHRvIGhhdmUgdGhlc2VzIGxpbmVzIGluIGNvbnRyaWJ1dGlvbiAKZ3VpZGVs
aW5lID8KCiDCoHBrZ3MgcmVxdWlyZWQgYnkgdGVzdHMgc2hvdWxkIGJlIHRlc3RlZCBvbiBvcGVu
U1VTRSxkZWJpYW4sY2VudG9zIGV0Yy4KClNpbmNlIGkgYmVsaWV2ZcKgIExUUMKgIGlzIHN1cHBv
cnRlZCBvbiBhbGwgd2lkZWx5IHVzZWQgZGlzdHJvcwoKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgoK
LS0gCkJlc3QgUmVnYXJkcwpTdWJyYW1hbnlhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
