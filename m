Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC849CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755850381; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9ciRIyb+3tn5tSVulXPQTK14go51RXFW1spT/52w8Gw=;
 b=gsIpzG5wH6xcpF+qxjB8KhMKn/74Im4Br0oBUhiVKWMHe0SBlSmniZWfXNLMgbd4pY3Lr
 O46ohuqH9QDSpQOEqkcXqDE0NgvnZnHkwGcKP2WUtCQLLneUwUlAYI3qcJ+biS7J0JILjIU
 k/1B+94fqazD2pIqjY3gq2Ma93Kg98Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90C833CCE66
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 10:13:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B01013CCE1A
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 10:12:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C07B100044B
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 10:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755850357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ZSZOhW+6kjJlUF9pSMUk+dd0H99A/PF5CUjqJwfOZo=;
 b=NfqWkNu0dYc2g4ShJ/HNwL6b4YBOppV17z4RKYoyXzj4Ch+sz3iWnqzsiuR+A/H2t2NKtL
 foQcJEDQ/IVB1XaXnReIskx/vjCnQH7zquWMOTo0qqiChAM136kP+/lKNbNc/duRSbXLYd
 OdJ4nUfGkKi59u5WO8041rY0NueteBU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-mTe10MB6PD2k7SRsKrJFog-1; Fri, 22 Aug 2025 04:12:34 -0400
X-MC-Unique: mTe10MB6PD2k7SRsKrJFog-1
X-Mimecast-MFC-AGG-ID: mTe10MB6PD2k7SRsKrJFog_1755850354
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2445805d386so23025985ad.1
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 01:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755850352; x=1756455152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZSZOhW+6kjJlUF9pSMUk+dd0H99A/PF5CUjqJwfOZo=;
 b=lhAy3lOxxjuU/x/y690qHsNwS8fqKncbt2ES84oRvjbrkKPVuTJwrgAZo1WiX9cQeo
 v7aaLKyv/TtQ/pyBXzfa5v3q6eVUvOvyDZ5GiJspp1lqxscKLK5PydmjEfG92foD1GdM
 or6hEYeV6dW90i547rbYyeiFsraQrpDXtOlGz4wWg8iyR8Yn+N5OIDQhtojws61hYAQu
 5rwuiGeYXdfMrCfB2hY/aCWP9QKzk6nVKxtGjge/ylYjGE2W/DWXjPvp1GvMGK+gaXAf
 PdAkhUF7EJnCH8gyJg3jDTFmHCI12+Z+sGep2vXVkjDMMup2tt9aiERDZ6Qez7KQ25ho
 7WnQ==
X-Gm-Message-State: AOJu0YyYLkTVyuFnZYcL92EFJum0t/5eXciqrdu2Sw9AR/68npxVdOwf
 dJKp78cU1ub3bctqTCjqxLd0fN6a0HXc5tOOcWxAe7B5ehjrWi7/JcSCfjS8KXo0L/JgydVhqGG
 E5w/telGH7d+D9J7p0Zy0MTylj2Spy3IiNRdrfh178HBdzo0Xkk9913LAvO3kxUsSC9kq433+68
 B1JvQzWUdNOGRkV874BNURsN5J7XN0YLuju+z/ue6x
X-Gm-Gg: ASbGnctV//JX1Kv0X/H2mycOnWgE1dYdU41MeV3Aym7KxuZ/IFsF38pQQBGzFDf8FNi
 blVfqvVmcOxd1TmnHoLifmqNAXFo9ORNIj9pPtVcm0R0LDjU5P48WdggZVyfre9T2gtL6fzEoSy
 IxR0fq2Yyn8+selRScgMh4Dw==
X-Received: by 2002:a17:902:d4cd:b0:23f:d903:d867 with SMTP id
 d9443c01a7336-2462ef1fd23mr33746195ad.35.1755850352356; 
 Fri, 22 Aug 2025 01:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2e5GDIECQTow5Ldc5kbJ16VrOMISuzML14LT44n633M763zRzvv+EKlr3/sih9XcAgmzsgr1AR5Vl0S0Z6DA=
X-Received: by 2002:a17:902:d4cd:b0:23f:d903:d867 with SMTP id
 d9443c01a7336-2462ef1fd23mr33745915ad.35.1755850351961; Fri, 22 Aug 2025
 01:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2fM4vHRdgHh62krquK5CFuHvpKdJtj--S6Vvt_i0xRBFw@mail.gmail.com>
 <20250822074811.2192404-1-liwang@redhat.com> <aKgkLd9SIJc3YcHZ@localhost>
In-Reply-To: <aKgkLd9SIJc3YcHZ@localhost>
Date: Fri, 22 Aug 2025 16:12:20 +0800
X-Gm-Features: Ac12FXyeS-Mlfla5WSWrfJxQSI8ngc8_INunABFMLrTSwEPNHqDXJuLoFtKfMq8
Message-ID: <CAEemH2dzFP75VXDLu=ZynXML9EfK-zY10Sd_+0g34zT=ywCkVw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S0j3Liq39Gdg1OtR2tGTduUHPWkFln2cn6xaeGhULBI_1755850354
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] mount: check path exists before
 tst_is_mounted in cleanup
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgNDowM+KAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCj4gT24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMDM6NDg6MTFQTSArMDgwMCwgTGkg
V2FuZyB2aWEgbHRwIHdyb3RlOgo+ID4gdHN0X2lzX21vdW50ZWQoKSBub3cgaW50ZXJuYWxseSBy
ZXNvbHZlcyB0aGUgbW91bnQgcGF0aCB2aWEgcmVhbHBhdGgoKSwKPiA+IHdoaWNoIHdpbGwgZmFp
bCBpZiB0aGUgcGF0aCBkb2VzIG5vdCBleGlzdC4gSW4gc29tZXRlc3QgKGUuZy4gbW91bnQwNSks
Cj4gPiBNTlRQT0lOVDIgbWF5IG5vdCBleGlzdCB5ZXQgZHVyaW5nIGNsZWFudXAsIGNhbGxpbmcg
dHN0X2lzX21vdW50ZWQoKQo+ID4gZGlyZWN0bHkgY291bGQgcHJvZHVjZSBtaXNsZWFkaW5nIHdh
cm5pbmdzIG9yIGVycm9ycy4KPiA+Cj4gPiBBZGQgYW4gZXhwbGljaXQgYWNjZXNzKFBBVEgsIEZf
T0spIGNoZWNrIGJlZm9yZSBjYWxsaW5nIHRzdF9pc19tb3VudGVkKCkKPiA+IGluIHRoZSBjbGVh
bnVwLCBlbnN1cmluZyB3ZSBvbmx5IHF1ZXJ5IG1vdW50cyBmb3IgZXhpc3RpbmcgcGF0aHMuCj4g
Pgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0K
PiA+Cj4gPiBOb3RlczoKPiA+ICAgICB2MSAtLT4gdjI6Cj4gPiAgICAgICAgICAgICBwYXRjaCAx
LzIsIGtlZXAgbm8gY2hhbmdlLCBkbyBub3Qgc2VuZCB2Mi4KPiA+ICAgICAgICAgICAgIHBhdGNo
IDIvMiwgYWRkaW5nIHR3byBtb3JlIGZpbGVzIGZvciBwYXRoIGV4aXN0IGNoZWNrCj4gPgo+ID4g
IHRlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9tcW5zL21xbnNfMDMuYyB8IDIgKy0KPiA+ICB0
ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy9tcW5zXzA0LmMgfCAyICstCj4gPiAgdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDA1LmMgIHwgMiArLQo+ID4gIDMgZmls
ZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+IFN0aWxsIG1vcmUg
dGVzdCBjYXNlIG5lZWQgdXBkYXRlIHN1Y2ggYXMgZm9sbG93aW5nPwo+ICAgMTMgICAgMTExICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDIuYyA8PGNsZWFudXA+Pgo+ICAg
ICAgICAgICAgICBpZiAodHN0X2lzX21vdW50ZWQoTU5UUE9JTlQpKQo+ICAgMTQgICAgMjAyICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYyA8PGNsZWFudXA+Pgo+ICAg
ICAgICAgICAgICBpZiAodHN0X2lzX21vdW50ZWQoTU5UUE9JTlQpKQo+ICAgMTUgICAgIDIxICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDQuYyA8PGNsZWFudXA+Pgo+ICAg
ICAgICAgICAgICBpZiAodHN0X2lzX21vdW50ZWQoTU5UUE9JTlQpKQo+CgpJIHdhc24ndCBlbmNv
dW50ZXJpbmcgdGhlc2UgdGVzdCBmYWlsdXJlcyBvbiB0aGF0LCB0aGUgcHJvYmxlbQpvbmx5IGFw
cGVhcnMgd2hlbiB0aGUgbW91bnRlZCBwYXRoIGlzIGRlbGV0ZWQgYnkgdGVzdC4KCkRpZCB5b3Ug
dGVzdCBhbmQgZ2V0IGFueXRoaW5nIGFibm9ybWFsIG9uIHlvdXIgc2lkZT8KCgo+Cj4gTWF5YmUg
d2UgY2FuIGp1c3QgcmVwb3J0IHdhcm5pbmcgaW5zdGVhZCBvZiBlcnJvcj8KPgoKSXQgaXMgV2Fy
bmluZyBidXQgbm90IGFuIGVycm9yLCB0aGUgJ1RFUlJOTycgaXMgb25seSB1c2UgdG8Kc2hvdyB0
aGUgZXJybm8gZm9yIGJldHRlciBkZWJ1Z2dpbmcuCgogIHRzdF9kZXZpY2UuYzo0NDA6IFRXQVJO
OiByZWFscGF0aChtbnRwb2ludDIpIGZhaWxlZDogRU5PRU5UICgyKQoKCgo+Cj4gLS0tIGEvbGli
L3RzdF9kZXZpY2UuYwo+ICsrKyBiL2xpYi90c3RfZGV2aWNlLmMKPiBAQCAtNDgxLDcgKzQ4MSw3
IEBAIHN0YXRpYyBpbnQgdHN0X21vdW50X2hhc19vcHQoY29uc3QgY2hhciAqcGF0aCwgY29uc3QK
PiBjaGFyICpvcHQpCj4gICAgICAgICBjaGFyIGFic3BhdGhbUEFUSF9NQVhdOwo+Cj4gICAgICAg
ICBpZiAoIXJlYWxwYXRoKHBhdGgsIGFic3BhdGgpKSB7Cj4gLSAgICAgICAgICAgICAgIHRzdF9y
ZXNtKFRXQVJOIHwgVEVSUk5PLCAicmVhbHBhdGgoJXMpIGZhaWxlZCIsIHBhdGgpOwo+ICsgICAg
ICAgICAgICAgICB0c3RfcmVzbShUV0FSTiwgInJlYWxwYXRoKCVzKSBmYWlsZWQiLCBwYXRoKTsK
PiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gICAgICAgICB9Cj4KPiA+Cj4gPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21xbnMvbXFuc18wMy5jCj4gYi90ZXN0
Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy9tcW5zXzAzLmMKPiA+IGluZGV4IDRkM2JmYzUy
Zi4uYWM4MzExNTU5IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJz
L21xbnMvbXFuc18wMy5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFu
cy9tcW5zXzAzLmMKPiA+IEBAIC0xMzAsNyArMTMwLDcgQEAgc3RhdGljIHZvaWQgY2xlYW51cCh2
b2lkKQo+ID4gICAgICAgaWYgKCFhY2Nlc3MoTVFVRVVFMiwgRl9PSykpCj4gPiAgICAgICAgICAg
ICAgIFNBRkVfTVFfVU5MSU5LKE1RTkFNRTIpOwo+ID4KPiA+IC0gICAgIGlmICh0c3RfaXNfbW91
bnRlZChERVZESVIpKQo+ID4gKyAgICAgaWYgKCFhY2Nlc3MoREVWRElSLCBGX09LKSAmJiB0c3Rf
aXNfbW91bnRlZChERVZESVIpKQo+ID4gICAgICAgICAgICAgICBTQUZFX1VNT1VOVChERVZESVIp
Owo+ID4gIH0KPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJz
L21xbnMvbXFuc18wNC5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy9tcW5z
XzA0LmMKPiA+IGluZGV4IGQyOGMzMzBjNC4uNzkwNjA3ZWNkIDEwMDY0NAo+ID4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9jb250YWluZXJzL21xbnMvbXFuc18wNC5jCj4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRhaW5lcnMvbXFucy9tcW5zXzA0LmMKPiA+IEBAIC0xMjMsNyArMTIzLDcg
QEAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ID4gICAgICAgaWYgKCFhY2Nlc3MoTVFVRVVF
MiwgRl9PSykpCj4gPiAgICAgICAgICAgICAgIFNBRkVfTVFfVU5MSU5LKE1RTkFNRTIpOwo+ID4K
PiA+IC0gICAgIGlmICh0c3RfaXNfbW91bnRlZChERVZESVIpKQo+ID4gKyAgICAgaWYgKCFhY2Nl
c3MoREVWRElSLCBGX09LKSAmJiB0c3RfaXNfbW91bnRlZChERVZESVIpKQo+ID4gICAgICAgICAg
ICAgICBTQUZFX1VNT1VOVChERVZESVIpOwo+ID4gIH0KPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDA1LmMKPiBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwNS5jCj4gPiBpbmRleCA2NmUxMDJhMzIuLjU1ODVlMjMw
ZSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQw
NS5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDUuYwo+
ID4gQEAgLTM1LDcgKzM1LDcgQEAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ID4gICAgICAg
aWYgKHRzdF9pc19tb3VudGVkKE1OVFBPSU5UMSkpCj4gPiAgICAgICAgICAgICAgIFNBRkVfVU1P
VU5UKE1OVFBPSU5UMSk7Cj4gPgo+ID4gLSAgICAgaWYgKHRzdF9pc19tb3VudGVkKE1OVFBPSU5U
MikpCj4gPiArICAgICBpZiAoIWFjY2VzcyhNTlRQT0lOVDIsIEZfT0spICYmIHRzdF9pc19tb3Vu
dGVkKE1OVFBPSU5UMikpCj4gPiAgICAgICAgICAgICAgIFNBRkVfVU1PVU5UKE1OVFBPSU5UMik7
Cj4gPiAgfQo+ID4KPiA+IC0tCj4gPiAyLjQ5LjAKPiA+Cj4gPgo+ID4gLS0KPiA+IE1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
