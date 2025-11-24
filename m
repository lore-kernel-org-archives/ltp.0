Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF695CFA466
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763975713; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kNRzGWH6VZwQ3l3L+0bsLIPeD/rKPrsDp/kHk671E+w=;
 b=qUcj4LijreQ8T92PIFCtJ+Ql8ONglMgFAcUxbEec1GyNhtC9Lm1LzagY/8+Cao/K5jBut
 3PrI+/aP72j6lfGxGpxMc2+o34xFsyUWIIcBxMP2QuQXlLXYbgSjE6iTMNVMy1T+qUFB/KL
 4AQ0jEs/m01131fbzMgV80msWOV3h+Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1FEF3C81BB
	for <ltp@archiver.kernel.org>; Mon, 24 Nov 2025 10:15:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB1DA3C7426
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 10:14:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B3BCD2002AD
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 10:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763975689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=87NjY9knmo729rL4OxY9MWFEwB3PgJ/edxiR7HS2lLA=;
 b=YDWCJEvhdBZ5k+YNan1YGCgtxICaW2+jrB+5Khfz8bxs7duvgMeYEZ++yAuKBXbPAErUDg
 sfIrOPR41HFHXFhdPQ4DUz1JZkbzicdPPMu7+MjTh2xyLh61fq7GDzBnaQK/lZnU0r5MVA
 BNkDTw5XGbIwTPxgg072ULs8GoFBe4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-pEuqOsSXM5yndurYyRl_JA-1; Mon, 24 Nov 2025 04:14:48 -0500
X-MC-Unique: pEuqOsSXM5yndurYyRl_JA-1
X-Mimecast-MFC-AGG-ID: pEuqOsSXM5yndurYyRl_JA_1763975687
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47106720618so43147595e9.1
 for <ltp@lists.linux.it>; Mon, 24 Nov 2025 01:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763975687; x=1764580487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=87NjY9knmo729rL4OxY9MWFEwB3PgJ/edxiR7HS2lLA=;
 b=h80WSETRRXyOJ+LcaY8jBNDF6op8IsekLRjx6QZSgD4SEK9Kur6tjOMCAJPeWINkWh
 uACx0ovvPMnylRR1icg+KAiA/aydDjWZ/Goyg3Ci2sACXy57iTxuO/l/pwGVubfqQ8KJ
 ZMEJkJDT/bbQST+Kep9guG0pDVdrtF2ncgi4N/c4UeoNgr/66UhXDyiZiMS9a2PiG6js
 jqQ/dyJBE8czVyJRGY0DSiC4TIzdE3aSV0Z/PHrsF8D9Cd6+bGz5VT4wsUc5Le+Py3Ih
 K1xBTYtvJnTkOL0BYevwvP7hBgRzQaswkTwcgDyUftUTb+kvoSUSCywhnhSVoeDtm+9u
 IW4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAN37qYKx3MQIkpkhAaFOEMWRzvPbkLNhw+1D0n8IMKnLnZNOOq25PLBA57QUXrOPq9I4=@lists.linux.it
X-Gm-Message-State: AOJu0YyRqiX36o5b8DpnZKMkBGqLT+/SiTLvUlmTm138WgXY8JbqZ2Cw
 4rC2FjLuJA5az9EGuyZodc2BLdJFz8orJQWIS/OoHFkW4v+KWbU67n5eJqTjHd9zlO0zxHjDeEB
 pgoYbBecxsn2Cm8g7fusZ1XHX8euhZhPfpM04KvB9/1U98p7i+7F1ZMPflmEPikqvHKOvEZ2MKs
 RDjBzspFoXrD2J+zZ+YIGu3k8Hsjo=
X-Gm-Gg: ASbGncsBHGnlSdc3fE3er+7+z3dOlkn+UhJanyfsomYkKmj9IUYrpDEokMj2WU2RNad
 shnaAr3buDdg3kd94V+np5MfBZsSonkZEZgFeNWxsh9/JVvty0XclDJVL/5kE+ogRQ3sEJW0uvf
 nNQ9ArxeKllQAArMuSaiC3mhJV3MUYjg8eFmtN3YM/4HCtSLRzz3lPQ2T02VLe9I6J
X-Received: by 2002:a05:600c:314d:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-477c0175164mr110154545e9.3.1763975686633; 
 Mon, 24 Nov 2025 01:14:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4nNOwWMURsoJSz/FwEl70swoQXKSFd5/DrELJg5febPgKbiGOGx/5cIFFH7kNTGWT9QvU6DH+KjEZ629cGPY=
X-Received: by 2002:a05:600c:314d:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-477c0175164mr110154265e9.3.1763975686140; Mon, 24 Nov 2025
 01:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20251120163550.333241-1-pvorel@suse.cz>
 <aSBBzVaq4gJ6JfrK@yuki.lan>
 <20251121104506.GA25561@pevik> <aSBQDg8PRXFK8GxB@yuki.lan>
In-Reply-To: <aSBQDg8PRXFK8GxB@yuki.lan>
Date: Mon, 24 Nov 2025 10:14:28 +0100
X-Gm-Features: AWmQ_bkTW6klxbovNylM4Kwzhgt4DPqojU-zo60lAvhPa8z7vbdSHAiN_cBjQO8
Message-ID: <CAASaF6x+U0V52-=YVTRj__C7-nTzx-ScfQUCTwPzEmdP=7b1Kg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dPs2ge6k0Gic4ex_nvAL6ofxGH7xTvL0LobehADuqNE_1763975687
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] readahead02: Sleep 1.5 msec to fix problem on
 bare metal
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBOb3YgMjEsIDIwMjUgYXQgMTI6NDHigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiA+ID4gQWRkaW5nIGEgc2hvcnQgc2xlZXAgaXMgYSBn
b29kIHN0YXJ0LiBIb3dldmVyIEknbSBhZnJhaWQgdGhhdCB3ZSB3aWxsCj4gPiA+IG5lZWQgYSBi
aXQgbW9yZSBjb21wbGV4IHNvbHV0aW9uIHRvIHRoaXMgcHJvYmxlbS4gTWF5YmUgZG8gYSBzaG9y
dAo+ID4gPiBzbGVlcCwgY2hlY2sgdGhlIGNhY2hlIHNpemUgYW5kIGlmIGl0IGluY3JlYXNlZCBt
b3JlIHRoYW4gc29tZQo+ID4gPiB0aHJlc2hvbGQsIHNsZWVwIGFnYWluLgo+ID4KPiA+ID4gU29t
ZXRoaW5nIGFzOgo+ID4KPiA+ID4gICAgIGludCByZXRyaWVzID0gTUFYX1JFVFJJRVM7Cj4gPiA+
ICAgICB1bnNpZ25lZCBsb25nIGNhY2hlZF9wcmV2LCBjYWNoZWRfY3VyID0gZ2V0X2NhY2hlZF9z
aXplKCk7Cj4gPgo+ID4gPiAgICAgZG8gewo+ID4gPiAgICAgICAgICAgICB1c2xlZXAoU0hPUlRf
U0xFRVApOwo+ID4KPiA+ID4gICAgICAgICAgICAgY2FjaGVkX3ByZXYgPSBjYWNoZWRfY3VyOwo+
ID4gPiAgICAgICAgICAgICBjYWNoZWRfY3VyID0gZ2V0X2NhY2hlZF9zaXplKCk7Cj4gPgo+ID4g
PiAgICAgICAgICAgICBpZiAoY2FjaGVkX2N1ciA8IGNhY2hlZF9wcmV2KQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOwo+ID4KPiA+ID4gICAgICAgICAgICAgaWYgKGNhY2hlZF9jdXIt
Y2FjaGVkX3ByZXYgPCBDQUNIRV9JTkNfVEhSRVNIT0xEKQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ID4KPiA+ID4gICAgIH0gd2hpbGUgKHJldHJpZXMtLSA+IDApOwo+ID4KPiA+
IFllYWgsIGZldyBsb29wcyB3aXRoIHNob3J0ZXIgdXNsZWVwKCkgYW5kIHByb2FjdGl2ZSBjaGVj
a2luZyBpcyBmb3Igc3VyZSB3YXkKPiA+IGJldHRlciB0aGFuIHNpbmdsZSB1c2xlZXAoKS4gV2ls
bCB5b3UgcGxlYXNlIGhhdmUgdGltZSB0byBzZW5kIHRoZSBhYm92ZSBhcyBhCj4gPiBwYXRjaD8g
SSdsbCB0ZXN0IGl0IGZvciB5b3UuCj4KPiBUaGUgaGFyZCBwYXJ0IGlzIHR1bmluZyB0aGUgY29u
c3RhbnRzIHJpZ2h0Lgo+Cj4gSWYgd2UgYXNzdW1lIHRoYXQgb24gdGhlIHNsb3dlc3QgbG93IGVu
ZCBkZXZpY2Ugd2Ugd291bGQgZ2V0IGFyb3VuZAo+IDVNQi9zICh0aGF0J3MgaG93IHNsb3cgU0Qg
Y2FyZCBpbiBSUGkgY2FuIGFwcGFyZW50bHkgYmUKPiBodHRwczovL2VsaW51eC5vcmcvUlBpX1NE
X2NhcmRzI1NEX2NhcmRfcGVyZm9ybWFuY2UpCj4gSWYgd2UgYWxsb3cgdGhpcyB0byBiZSBhIGJp
dCBsZXNzIHByZWNpc2Ugd2UgY2FuIGFzc3VtZSB0aGF0IHRoZSBzcGVlZCBpcwo+IDUgYnl0ZXMg
cGVyIDEgdXMgKHNpbmNlIFVTRUNfUEVSX1NFQyAvIEJZVEVTX0lOX01CIGlzIHJvdWdodGx5IDEp
Lgo+Cj4gRnJvbSB0aGF0IHRoZSBudW1iZXIgb2YgcmV0cmllcyBzaG91bGQgYmUgdGhlIHJlYWRh
aGVhZF9zaXplIC8gKDUqU0hPUlRfU0xFRVApCj4gYW5kIEkgd291bGQgcHV0IHRoZSBzaG9ydCBz
bGVlcCBzb21ld2hlcmUgYXJvdW5kIHRoZQo+IGEgZmV3IG1pbGlzZWNvbmRzIHJhbmdlLCB0aGF0
IHdvdWxkIG1lYW4gdGhhdCB0aGUgbnVtYmVyIG9mIHJldHJpZXMKPiB3b3VsZCBlbmQgdXAgYmV0
d2VlbiB0aG91c2FuZCBhbmQgaHVuZHJlZCB3aGVuIHJlYWRhaGVhZF9zaXplIGlzIGluCj4gbWVn
YWJ5dGVzLiBUaGlzIGFsc28gbWVhbnMgdGhhdCB3ZSBjYW4gYXNzdW1lIHRoYXQgdGhlIG1pbmlt
YWwgc2l6ZSB0bwo+IGJlIHJlYWQgaW4gb25lIGxvb3AgaXMgNSAqIFNMRUVQX1NJWkUgYnl0ZXMu
IEhvd2V2ZXIgd2l0aCBTTEVFUF9USU1FIGluCj4gYSBmZXcgbWlsaXNlY29uZCByYW5nZSB0aGUg
bWluaW1hbCBudW1iZXIgb2YgYnl0ZXMgaXMgaW4gdGhlIHJhbmdlIG9mIGEKPiBmZXcgcGFnZXMg
c28gSSBndWVzcyB0aGF0IHdlIGNhbiBzZXR0bGUgZm9yIHJ1bm5pbmcgdGhlIGxvb3AgZm9yIGFz
IGxvbmcKPiBhcyB0aGUgY2FjaGUgaW5jcmVhc2VzLgo+Cj4gU28gSSBzdXBwb3NlIHRoYXQgd2Ug
d2FudCBzb21ldGhpbmcgYXM6Cj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cmVhZGFoZWFkL3JlYWRhaGVhZDAyLmMKPiBpbmRleCBmMDA3ZGIxODcuLmEyMTE4YzVhYiAxMDA2
NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQw
Mi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFk
MDIuYwo+IEBAIC0zOSw2ICszOSw3IEBAIHN0YXRpYyBjaGFyIHRlc3RmaWxlW1BBVEhfTUFYXSA9
ICJ0ZXN0ZmlsZSI7Cj4gICNkZWZpbmUgTUVNSU5GT19GTkFNRSAiL3Byb2MvbWVtaW5mbyIKPiAg
I2RlZmluZSBQUk9DX0lPX0ZOQU1FICIvcHJvYy9zZWxmL2lvIgo+ICAjZGVmaW5lIERFRkFVTFRf
RklMRVNJWkUgKDY0ICogMTAyNCAqIDEwMjQpCj4gKyNkZWZpbmUgU0hPUlRfU0xFRVBfVVMgNTAw
MAo+Cj4gIHN0YXRpYyBzaXplX3QgdGVzdGZpbGVfc2l6ZSA9IERFRkFVTFRfRklMRVNJWkU7Cj4g
IHN0YXRpYyBjaGFyICpvcHRfZnNpemVzdHI7Cj4gQEAgLTE3Myw2ICsxNzQsMzggQEAgc3RhdGlj
IGludCByZWFkX3Rlc3RmaWxlKHN0cnVjdCB0Y2FzZSAqdGMsIGludCBkb19yZWFkYWhlYWQsCj4K
PiAgICAgICAgICAgICAgICAgICAgICAgICBpKys7Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0ICs9IHJlYWRhaGVhZF9sZW5ndGg7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IC8qCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogV2UgYXNzdW1lIHRoYXQgdGhlIHdvcnN0
IGNhc2UgSS9PIHNwZWVkIGlzIGFyb3VuZAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIDVN
Qi9zIHdoaWNoIGlzIHJvdWdobHkgNSBieXRlcyBwZXIgMSB1cywgd2hpY2ggZ2l2ZXMKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgKiB1cyB1cHBlciBib3VuZCBmb3IgcmV0cmllcyB0aGF0IGlz
IHJlYWRhaGVhZF9zaXplLyg1Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogU0hPUlRfU0xF
RVBfVVMpLgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICogV2UgYWxzbyBtb25pdG9yIHRoZSBjYWNoZSBzaXplIGluY3JlYXNlcyBiZWZvcmUg
YW5kCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogYWZ0ZXIgdGhlIHNsZWVwLiBXaXRoIHRo
ZSBzYW1lIGFzc3VtcHRpb24gYWJvdXQgdGhlCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICog
c3BlZWQgd2UgYXJlIHN1cHBvc2VkIHRvIHJlYWQgYXQgbGVhc3QgNSAqIFNIT1JUX1NMRUVQX1VT
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogZHVyaW5nIHRoYXQgdGltZS4gVGhhdCBhbW91
bmQgaXMgZ2VucmVhbGx5IHF1aXRlIGNsb3NlCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICog
YSBwYWdlIHNpemUgc28gdGhhdCB3ZSBqdXN0IGFzc3VtZQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAqCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogT2YgY291cnNlIGFsbCBvZiB0aGlz
IGlzIGlucHJlY2lzZSBvbiBtdWx0aXRhc2tpbmcKPiArICAgICAgICAgICAgICAgICAgICAgICAg
KiBPUyBob3dldmVyIGV2ZW4gb24gYSBzeXN0ZW0gd2hlcmUgdGhlcmUgYXJlIHNldmVyYWwKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgKiBwcm9jZXNzZXMgZmlndGhpbmcgZm9yIEkvTyB0aGlz
IGxvb3Agd2lsbCB3YWl0IGFzCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogbG9uZyBhIGNh
Y2hlIGlzIGluY3JlYXNpbmcgd2hpY2ggd2lsbCBnaXZlcyB1cyBoaWdoCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICogY2hhbmNlIG9mIHdhaXRpbmcgZm9yIHRoZSByZWFkYWhlYWQgdG8gaGFw
cGVuLgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqLwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGludCByZXRyaWVzID0gcmVhZGFoZWFkX3NpemUgLyAoNSAqIFNIT1JUX1NMRUVQX1VTKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGNhY2hlZF9wcmV2LCBjYWNo
ZWRfY3VyID0gZ2V0X2NhY2hlZF9zaXplKCk7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGRvIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVzbGVlcChTSE9SVF9TTEVF
UF9VUyk7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2FjaGVkX3ByZXYg
PSBjYWNoZWRfY3VyOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2FjaGVkX2N1
ciA9IGdldF9jYWNoZWRfc2l6ZSgpOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmIChjYWNoZWRfY3VyIDw9IGNhY2hlZF9wcmV2KQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsKCklmIHJlYWRhaGVhZCBkb2Vzbid0IGluaXRpYXRl
IHdpdGhpbiB0aG9zZSBmaXJzdCA1bXMsIHRoaXMgYWJvcnRzCmltbWVkaWF0ZWx5LCByaWdodD8K
SSdkIHVzZSBoaWdoZXIgdmFsdWUgZm9yIFNIT1JUX1NMRUVQLCBzYXkgNTBtcyBvciBtb3JlLiBU
aGF0J3Mgc3RpbGwgc21hbGwKb3ZlcmhlYWQgZm9yIHRoZSB0ZXN0LgoKCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgfSB3aGlsZSAocmV0cmllcy0tID4gMCk7Cj4gKwo+ICAgICAgICAgICAgICAg
ICB9IHdoaWxlICgoc2l6ZV90KW9mZnNldCA8IGZzaXplKTsKPiAgICAgICAgICAgICAgICAgdHN0
X3JlcyhUSU5GTywgInJlYWRhaGVhZCBjYWxscyBtYWRlOiAlenUiLCBpKTsKPiAgICAgICAgICAg
ICAgICAgKmNhY2hlZCA9IGdldF9jYWNoZWRfc2l6ZSgpOwo+Cj4KPiBMaSwgSmFuIHdoYXQgZG8g
eW91IHRoaW5rPwo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
