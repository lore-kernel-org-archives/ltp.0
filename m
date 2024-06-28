Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7372CC2BD09
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 18:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719599864; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vLXR3g2duLeqvXvkbjEn+lwq5kQQVSgJbRFKUWtUgaU=;
 b=h9kc9LWaRVROr7l1rsAWX0lrMpgF1givZJi+t2LIjZkGWizL1SO6P6HFiNQkdtkkSVv6J
 WG/6n2mHtudMkuE9aCJV1wslQR3zJiINPfxZKw7NpuUkDiY+WrOBtHLdbZ4aiW9W/1jaSZf
 KbCZC1dNKQJjGid092wxa/pigq406Yo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEBE63D4391
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 20:37:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4A263CF738
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 20:37:23 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BDEBE1A010B0
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 20:37:22 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d16251a07so1715a12.1
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719599842; x=1720204642; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoE2qoh1nb7qsstuKAodg4UJFjI9eyrkHzXOIg/VnGo=;
 b=qP+ca5Jpu9e1e6w9mh1Se7EkNzAuTMcxwn6Cn7xuCR+4e2fM8uBd4keOIWuMfvAM8d
 Shba1U7230bW/s8yy9h/NzWdII0+B6ItRXL7okk6PdJZRNpUunYoCwfR/5D4NGG4x1V4
 3JV9EdA4uxd/DmYOT9jHrkq0qZUmPNmWVTdhb+tFYXqJyiZN8NxnoLNHXx4p2lAWEejN
 kWAUZkYUpJiAauHeL8gizk8N5ZPYHI0J4ltPOXrhX11B8DNxZMd9vq4Th1GS2XIM9MqJ
 /4h6iXZxO7xpwLKgMDBKNY0oClcPnBWUFzeUTOvjwUqd6u8CmuB2k5QFPnhsRbeVwqwY
 Oy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719599842; x=1720204642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoE2qoh1nb7qsstuKAodg4UJFjI9eyrkHzXOIg/VnGo=;
 b=rgHkjt6H5eXENZj7F33YIsGZsxED8YgcHYhaTPw9p5fzsd3Cq0hDC47Wck6y/+9q39
 gGanPMi6PVfr3iNWaFBiJl+4x1ze2CakhlLMAJ2odqxI/tshuW/5kh4p8NiQkd3WqjxJ
 boGv8V/4Cydhz1cs5NgN6tKs/anIholjSMb/cBAdC1+hptl344mp7ZCfFniKdpUuOHkJ
 hzw/EiGyi8K5ImkBHSQag5x4TKDspvqXJcYT1zqTZOZVf4cc29WAe4O0wVZsVmoNWt4l
 XF2Gdg+rf8v9E2V/tonGU2qYYewjJrRcdhGBJUjNneeh3GzHs35wlbk2deJvU+SMnX6n
 4KPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/tx3C89ovMkV+b3CyjfT5u0IBYM+GN3A5yKGaeT1Xl4hC2z5EtIox3Nicpwwq+dfFfuX4NvC2eiaSKw7jPAXeSrc=
X-Gm-Message-State: AOJu0YzUeQv2ZLgm4otmakWgjeQV/4UPbWj+uqZHiZKr1jmQb3d54DkV
 bm/AH+SbKW2K4QSSSjKP8KhawP5N2qVRwkOKokwl8KsZWfkYbJdqVM5jLKyIe3aQucyxMlCx8yf
 UYe634Vs+afNn9FloJc1vJ/ynfVI3ONXuuKE=
X-Google-Smtp-Source: AGHT+IE/EvwfdFFWNSPteWw0p0m0wbz2/zhQcUE4WbT2QSZ+XHASDK71YQV6lrLymbpdNP+p4m0YCJ6412uD19il58Q=
X-Received: by 2002:a50:8ad0:0:b0:585:2d39:5ed9 with SMTP id
 4fb4d7f45d1cf-5872f77f481mr14718a12.6.1719599841924; Fri, 28 Jun 2024
 11:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
 <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
 <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
 <CANDhNCpYjncxr-fn8o5vDDYScf4zvVmH_w_Ms1Jhg9tsn-UgDQ@mail.gmail.com>
 <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
 <CANDhNCqWvQ9DCwXtdMW81OoZ0qULk8-6PCYwVeF_Ep+b4Kkg2A@mail.gmail.com>
 <Zn5wZIM7pKLRgT_Z@yuki>
In-Reply-To: <Zn5wZIM7pKLRgT_Z@yuki>
Date: Fri, 28 Jun 2024 11:37:09 -0700
Message-ID: <CANDhNCrTDsUH__+6bd4Ov8JcPf1bxjAGZr_vuWi3D41+zfOHbQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMjgsIDIwMjQgYXQgMToxMuKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPiA+IE9rLCBidXQgZXZlbiBhZnRlciBkb2luZyB0aGF0IGFzIHlvdSBz
dWdnZXN0ZWQsIGJ1aWxkaW5nIHdpdGggdGhlCj4gPiBmb2xsb3dpbmcgZmFpbHMgZm9yIG1lOgo+
ID4KPiA+IG1ha2UgYXV0b3Rvb2xzCj4gPiAuL2NvbmZpZ3VyZSAtQyB0ZXN0Y2FzZXMvcmVhbHRp
bWUvCj4gPiBtYWtlIC1qCj4gPiAuLi4KPiA+IG1ha2VbM106ICoqKiBObyBydWxlIHRvIG1ha2Ug
dGFyZ2V0ICdNYWtlZmlsZS5hbScsIG5lZWRlZCBieQo+ID4gJ01ha2VmaWxlLmluJy4gIFN0b3Au
Cj4gPiBtYWtlWzJdOiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvZ2VuZXJpY190cnVua190YXJnZXQu
aW5jOjEwODogYWxsXSBFcnJvciAyCj4gPiBtYWtlWzFdOiAqKiogWy4uL2luY2x1ZGUvbWsvZ2Vu
ZXJpY190cnVua190YXJnZXQuaW5jOjEwODogYWxsXSBFcnJvciAyCj4gPiBtYWtlOiAqKiogW01h
a2VmaWxlOjg1OiB0ZXN0Y2FzZXMtYWxsXSBFcnJvciAyCj4gPgo+ID4gU28gaXQgZG9lcyAqc2Vl
bSogbGlrZSBzb21ldGhpbmcgaXMgYnJva2VuLiA6KQo+Cj4gSSBjYW4ndCByZXByb2R1Y2UgdGhh
dCBhbmQgaXQgZGlkbid0IHNob3cgdXAgb24gb3VyIENJIHRoYXQgYnVpbGRzIExUUAo+IG9uIDE2
IGRpZmZlcmVudCBkaXN0cmlidXRpb25zLgoKSW50ZXJlc3RpbmcuIFRoYW5rcyBmb3IgY2hlY2tp
bmcgb24gdGhpcyEgSSBhcHByZWNpYXRlIHlvdXIgdGltZSBpbgp0cnlpbmcgdG8gcmVwcm9kdWNl
IGl0LgoKPiBBbmQgdGhlIGVycm9yIG1lc3NhZ2UgeW91IGdldCBkb2VzIG5vdCBtYWtlIG11Y2gg
c2Vuc2UgZWl0aGVyLiBUaGUKPiBNYWtlZmlsZS5hbSBmaWxlIGlzIG9ubHkgcmVmZXJlbmNlZCBp
biB0aGUgYXV0b21ha2UgdGFyZ2V0LiBJdCBzaG91bGRuJ3QKPiBiZSByZWZlcmVuY2VkIGZyb20g
dGhlIHRlc3RjYXNlcy1hbGwgdGFyZ2V0IGF0IGFsbC4KClNvIGRpZ2dpbmcgZnVydGhlciwgSSB0
aGluayB0aGlzIGhhcyB0byBkbyB3aXRoIHNvbWUgc29ydCBvZiBzdGF0ZQpmcm9tIHByaW9yIHRv
IGNvbW1pdCBhMDUyOThlYzQ0OTQgc3RpY2tpbmcgYXJvdW5kIGFuZCBjYXVzaW5nIHByb2JsZW1z
CmluIHRoZSBidWlsZC4KCkkgaGFkIGJlZW4gdXNpbmcgYm90aCBgbWFrZSBjbGVhbmAgYW5kIGBt
YWtlIGRpc3RjbGVhbmAgYW5kIGV2ZW4gYGdpdApjbGVhbiAtZiAtZGAgKGFzIEkgbm90aWNlZCB0
aGVyZSB3ZXJlIG9mdGVuIGBnaXQgc3RhdHVzYCBsZWZ0b3ZlciBiaXRzCmFmdGVyIHRoZSBkaXN0
Y2xlYW4pLCBidXQgZXZlbiB0aGVuIEkgd291bGQgdHJpcCB0aGUgcHJvYmxlbSBhYm92ZS4KCkJ1
dCByZS1jaGVja2luZyBvdXQgYSBjbGVhbiByZXBvLCBJIGluZGVlZCBkb24ndCBoaXQgdGhlIHBy
b2JsZW0uCgpBZnRlciBkaXN0Y2xlYW5pbmcgYW5kIGdpdCBjbGVhbidpbmcgYm90aCwgdGhlIGRp
ZmZzdGF0IGxvb2tzIGxpa2U6CgoqIEEgYnVuY2ggb2YgY29uZlhYWFhYWCBkaXJlY3RvcmllcyBs
aXR0ZXJpbmcgdGhlIG9sZCB0cmVlLgogaW5jbHVkZS9jb25maWcuaC5pbn4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2NTYKIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZGVsZXRlX21vZHVsZS8uZHVtbXlfZGVsX21vZC5vLmQgICAgICAgICAg
ICAgfCAgICAyCiB0ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvYXV0b200dGUuY2FjaGUv
cmVxdWVzdHMgICAgICAgICAgICAgICAgIHwgIDEwMgogdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVz
dHN1aXRlL2NvbmZvcm1hbmNlL2RlZmluaXRpb25zL21xdWV1ZV9oL251bGwubyB8YmluYXJ5CiB0
ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvZnVuY3Rpb25hbC90aW1lcnMvdGltZXJzL01h
a2VmaWxlICAgICAgIHwgICA5NAogdGVzdGNhc2VzL3JlYWx0aW1lL2FjbG9jYWwubTQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExNjUgLQogdGVzdGNhc2VzL3Jl
YWx0aW1lL2F1dG9tNHRlLmNhY2hlL291dHB1dC4wCiB8IDcwNTggLS0tLS0tCiB0ZXN0Y2FzZXMv
cmVhbHRpbWUvYXV0b200dGUuY2FjaGUvb3V0cHV0LjEKIHwgNzA1OSAtLS0tLS0KIHRlc3RjYXNl
cy9yZWFsdGltZS9hdXRvbTR0ZS5jYWNoZS9vdXRwdXQuMgogfCA3MDU4IC0tLS0tLQogdGVzdGNh
c2VzL3JlYWx0aW1lL2F1dG9tNHRlLmNhY2hlL3JlcXVlc3RzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyMzgKIHRlc3RjYXNlcy9yZWFsdGltZS9hdXRvbTR0ZS5jYWNoZS90cmFjZXMu
MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMDIwIC0KIHRlc3RjYXNlcy9yZWFsdGlt
ZS9hdXRvbTR0ZS5jYWNoZS90cmFjZXMuMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
NDkxCiB0ZXN0Y2FzZXMvcmVhbHRpbWUvYXV0b200dGUuY2FjaGUvdHJhY2VzLjIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDQ5MQogdGVzdGNhc2VzL3JlYWx0aW1lL2NvbXBpbGUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNDgKIHRlc3RjYXNl
cy9yZWFsdGltZS9jb25maWcuZ3Vlc3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxNzU0IC0KIHRlc3RjYXNlcy9yZWFsdGltZS9jb25maWcubG9nICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDc0CiB0ZXN0Y2FzZXMvcmVhbHRpbWUv
Y29uZmlnLnN0YXR1cyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTE5
NyAtCiB0ZXN0Y2FzZXMvcmVhbHRpbWUvY29uZmlnLnN1YiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTg5MCAtCiB0ZXN0Y2FzZXMvcmVhbHRpbWUvY29uZmlndXJl
CiB8IDcwNTkgLS0tLS0tCiB0ZXN0Y2FzZXMvcmVhbHRpbWUvaW5jbHVkZS9yZWFsdGltZV9jb25m
aWcuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3MAogdGVzdGNhc2VzL3JlYWx0aW1l
L2luY2x1ZGUvcmVhbHRpbWVfY29uZmlnLmguaW4gICAgICAgICAgICAgICAgICAgICAgICB8ICAg
NjkKIHRlc3RjYXNlcy9yZWFsdGltZS9pbmNsdWRlL3N0YW1wLWgxICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICAxCiB0ZXN0Y2FzZXMvcmVhbHRpbWUvaW5zdGFsbC1zaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDU0MQogdGVzdGNhc2Vz
L3JlYWx0aW1lL200L01ha2VmaWxlLmluICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA0MTEKIHRlc3RjYXNlcy9yZWFsdGltZS9taXNzaW5nICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjE1CgpTbyBJJ20gZ3Vlc3NpbmcgdGhhdCBs
ZWZ0b3ZlciB0ZXN0Y2FzZXMvcmVhbHRpbWUvbTQvTWFrZWZpbGUuaW4gaXMgdGhlIGlzc3VlLgpB
bmQgSSdtIGd1ZXNzaW5nIHRoZSBjaGFuZ2Ugd2hlcmUgSSBzYXcgdGhpbmdzIGJyZWFrIHJlbW92
ZWQgdGhlCnJlYWx0aW1lIGRpciBmcm9tIEFVVE9DT05GRURfU1VCRElSUyBzbyBpdCB3b3VsZG4n
dCBnZXQgY2xlYW5lZAphZnRlcndhcmRzIGlmIGl0IGhhZG4ndCBiZWVuIGJlZm9yZS4KCkkgZ3Vl
c3MgaW4gbXkgYmlzZWN0aW9uIEkgc2hvdWxkIGhhdmUgZG9uZSB0aGUgZGlzdGNsZWFuIHByaW9y
IHRvCnN3aXRjaGluZyBicmFuY2hlcywgbm90IGZpcnN0IHRoaW5nIGFmdGVyLiAgT3IgSSBndWVz
cyBJIHNob3VsZCBoYXZlCnRyaWVkIHdpdGggZ2l0IGNsZWFuIC14PwoKV2VsbCwgYXBvbG9naWVz
IGZvciB0aGUgbm9pc2UuIEkgZ3JlYXRseSBhcHByZWNpYXRlIHRoZSBoZWxwIHJlc29sdmluZyB0
aGlzIQoKdGhhbmtzCi1qb2huCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
