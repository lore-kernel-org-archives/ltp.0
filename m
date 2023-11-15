Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2935AC47075
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 09:16:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B5DB3CE425
	for <ltp@archiver.kernel.org>; Wed, 15 Nov 2023 10:15:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 035593CE420
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 10:15:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B55C31402E38
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 10:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700039746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nFG+RLYFEQC+Xo9fHi26uk6PqvbrvOBx4K/FqbBbfU=;
 b=dwrsbVtSUT/apqJp8HoVk4xilpzgfwtT5NHfPGktRhKSbPZ2INfwiza/uzEBhxHJdr6igW
 +YaVmAW9railUcnTtsKjLgZf98JWEkC00u0+ByARB9s4t8USUO6325H0xAIQK79R/m6kRD
 qe/FmwmYFR/rbLgbyWO76kriKhsb5G4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-PPNcBk-zNVCG7vybs9S7bA-1; Wed, 15 Nov 2023 04:15:44 -0500
X-MC-Unique: PPNcBk-zNVCG7vybs9S7bA-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4abf7c93b14so3136585e0c.3
 for <ltp@lists.linux.it>; Wed, 15 Nov 2023 01:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700039744; x=1700644544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nFG+RLYFEQC+Xo9fHi26uk6PqvbrvOBx4K/FqbBbfU=;
 b=fYSWyia12jYSJ3dyJq3V0YU4dhU7ajwhbeVpe8qhLTGX4kI5HL/eGwjMenmt2pY39E
 bkq+CWboWRcv8RmSrf0zHmsmBAENgK9sVDz70bzuCGXxF22MZJu5qL4GpuyUGptfXQCk
 iI/yZCBT3MfBWGom5PNF0lMy8igCHPfLTVZbPzqO1JAarMPRGK/D0PeRpac2T+fUowEN
 6PUhTCtG7uhwPKpZRgmGFqDzVp9Ox0ZvpX/nmj5aNOu6IIZEpGLfrwiFtkBM2LUPyOXC
 mF1nttrR5lXzyB4eznvvKIqEakJ0BLz9i3Fvk+Q/i2eQqc/wk16YkJggAW0gx6xtJmpk
 SYhw==
X-Gm-Message-State: AOJu0Yy9O4vDZFlaeTYqv/ME7BFl+zcoTd39BPDUS8qO8U9qc0kgNsuI
 F1qkv3lrHWsNDn7zbd+4eQLFwc1yUYdz5+Ye1KFLWaimvGTRLwWP6XjFjFilFEl5l702/36jb+8
 Z6qCKC/Q9zbuhGc0j0Z2Ny7iRILM=
X-Received: by 2002:ac5:c96b:0:b0:4ab:f08d:2131 with SMTP id
 t11-20020ac5c96b000000b004abf08d2131mr12077276vkm.11.1700039744279; 
 Wed, 15 Nov 2023 01:15:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUt4poZZCEO3BDaO5wd2dvCqxA4B6IO4JuDWNHh0Y3bMOMMc8RZH+BGxci1glRHyHvDJpw3LhaDRTz4nxk/SQ=
X-Received: by 2002:ac5:c96b:0:b0:4ab:f08d:2131 with SMTP id
 t11-20020ac5c96b000000b004abf08d2131mr12077265vkm.11.1700039743948; Wed, 15
 Nov 2023 01:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20231114123140.1144-1-mdoucha@suse.cz>
 <20231114123140.1144-6-mdoucha@suse.cz>
 <20231114153907.GA2357693@pevik>
 <CAC+q_wXvSSgeXWQNk7pbmEU5SbmvBvKtumtFB9io1wwFnXjwHQ@mail.gmail.com>
 <20231115082319.GA2404362@pevik>
In-Reply-To: <20231115082319.GA2404362@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Nov 2023 10:16:16 +0100
Message-ID: <CAASaF6zTtdLZw0Vvy2YibnPkw9r3Rta2GF+MTc1CKnbzfVbtwg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] Add test for CVE 2023-31248
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMTUsIDIwMjMgYXQgOToyM+KAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+ID4gSGkgTWFydGluLCBQZXRyLgo+Cj4KPiA+IDIwMjPlubQxMeaciDE1
5pelKOawtCkgMDozOSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej46Cj4KPiA+ID4gSGkgTWFy
dGluLAo+Cj4gPiA+IC4uLgo+ID4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9uZXR3b3JrL2lwdGFibGVz
L25mdDAyLmMKPiA+ID4gLi4uCj4gPiA+ID4gKy8qIENoYWluIGNyZWF0aW9uIGFuZCBkZWxldGlv
biBjb25maWcgKi8KPiA+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCB0c3RfbmV0bGlua19hdHRy
X2xpc3QgbmV3Y2hhaW5fY29uZmlnW10gPSB7Cj4gPiA+ID4gKyAgICAge05GVEFfVEFCTEVfTkFN
RSwgVEFCTkFNRSwgc3RybGVuKFRBQk5BTUUpICsgMSwgTlVMTH0sCj4gPiA+ID4gKyAgICAge05G
VEFfQ0hBSU5fTkFNRSwgQ0hBSU5OQU1FLCBzdHJsZW4oQ0hBSU5OQU1FKSArIDEsIE5VTEx9LAo+
ID4gPiA+ICsgICAgIHtORlRBX0NIQUlOX0lELCAmY2hhaW5faWQsIHNpemVvZihjaGFpbl9pZCks
IE5VTEx9LAo+Cj4gPiA+IFVuZm9ydHVuYXRlbHkgdGhlIGN1cnJlbnQgb2xkZXN0IGRpc3Ryb3Mg
KExlYXAgNDIgYW5kIFVidW50dSBCaW9uaWMpIGFyZSB0b28gb2xkCj4gPiA+IGZvciBORlRBX0NI
QUlOX0lELCBORlRBX1JVTEVfQ0hBSU5fSUQsIGNvdWxkIHlvdSBwbGVhc2UgYWRkIHRoZW0gdG8g
TEFQST8KPgo+ID4gSXQgd2FzIHRoZSBzYW1lIG9uIFJIRUw4IChhbmQvb3Igb3RoZXIgY2xvbmUg
T1MpLgo+Cj4gPiBBbmQsIEkgd291bGQgbGlrZSB0byBzZWUgdGhpcyB0ZXN0IGFkZGVkIHRvIHJ1
bnRlc3QvY3ZlIGFuZCAuZ2l0aWdub3JlLgo+Cj4gR29vZCBwb2ludCwgdGhhbmtzLiBNYXliZSBp
dCBjb3VsZCBiZSBhbHNvIGluIHJ1bnRlc3QvbmV0LnRjcF9jbWRzLgo+Cj4gPiA+ICsgICAgICAg
aWYgKHRzdF90YWludF9jaGVjaygpKSB7Cj4gPiA+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRG
QUlMLCAiS2VybmVsIGlzIHZ1bG5lcmFibGUiKTsKPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVy
bjsKPiA+ID4gKyAgICAgICB9Cj4KPiA+IE5vdCBhIHByb2JsZW0gd2l0aCB0aGUgdGVzdCBpdHNl
bGYgYnV0LCBJZiBUQUlOVF9XIHdhcyBhbHJlYWR5IHNldCwKPiA+IHRoZSB0ZXN0IHJlcG9ydCBU
UEFTUyBieSBtaXNzdGFrZS4KPiA+IEJlbG93IHBhdGNoIG1hc2tzIFRBSU5UX1cgaWYgdGhhdCB0
YWludCBmbGFnIHdhcyBzZXQgYmVmb3JlIHRlc3Qgc3RhcnRlZC4KPgo+ID4gY29tbWl0IGRlOWI1
YzI2MzYyMDRhYjA2ZGJiM2M3ZGM1NzI5NmQ3M2FjNTcyYWMKPiA+IEF1dGhvcjogSmFuIFN0YW5j
ZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiBEYXRlOiAgIFR1ZSBBcHIgMjEgMTQ6MTU6NDgg
MjAyMCArMDIwMAo+Cj4gPiAgICAgbGliOiB0c3RfdGFpbnQ6IElnbm9yZSBXQVJOIHRhaW50IGZs
YWcgaWYgYWxyZWFkeSBzZXQKPgo+ID4gICAgIFRoaXMgY29tbWl0IGNoYW5nZXMgdGhlIGxpYnJh
cnkgc28gdGhhdCBpdCBpZ25vcmVzIHRoZSB0YWludCB3YXJuIGZsYWcKPiA+ICAgICBpZiBpdCB3
YXMgc2V0IHByaW9yIHRvIHRoZSB0ZXN0IHJ1bi4gSXQgdHVybnMgb3V0IHRoYXQgdGhlIHdhcm4g
dGFpbnQKPiA+ICAgICBmbGFnIGlzIG5vdCB3ZWxsIGRlZmluZWQgYW5kIGNvdWxkIGJlIGVhc2ls
eSBzZXQgb24gYSBmcmVzaGx5IGJvb3RlZAo+ID4gICAgIGtlcm5lbCBmb3IgZXhhbXBsZSB3aGVu
IGJ1Z2d5IEJJT1MgaXMgZGV0ZWN0ZWQuCj4KPiA+ICAgICBPdGhlciByZWNlbnQgZXhhbXBsZSBp
cyBkaXNhYmxpbmcgaXAgZm9yd2FyZCBvbiBrdm0gZ3Vlc3RzOgo+ID4gICAgICAgaHR0cHM6Ly9n
aXRodWIuY29tL2NvbnRhaW5lcnMvbGlicG9kL2lzc3Vlcy81ODE1Cj4gPiAgICAgICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9uZXRkZXYvYTQ3YjZhM2ItYzA2NC0yZjUzLTdjZjYtZDBkMDcyMGU5
ZDk5QHJlZGhhdC5jb20vCj4KPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4KPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5j
ZWtAcmVkaGF0LmNvbT4KPiA+ICAgICBDYzogQ2hhbmcgWWluIDxjeWluQHJlZGhhdC5jb20+Cj4g
PiAgICAgUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+Cj4gPiBkaWZm
IC0tZ2l0IGEvbGliL3RzdF90YWludC5jIGIvbGliL3RzdF90YWludC5jCj4gPiBpbmRleCBhNWRi
Zjc3ZDIuLjQ5MTQ2YWFjYiAxMDA2NDQKPiA+IC0tLSBhL2xpYi90c3RfdGFpbnQuYwo+ID4gKysr
IGIvbGliL3RzdF90YWludC5jCj4gPiBAQCAtODIsOSArODIsMTQgQEAgdm9pZCB0c3RfdGFpbnRf
aW5pdCh1bnNpZ25lZCBpbnQgbWFzaykKPiA+ICAgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05G
LCAiS2VybmVsIGlzIHRvbyBvbGQgZm9yIHJlcXVlc3RlZCBtYXNrIik7Cj4KPiA+ICAgICAgICAg
dGFpbnRfbWFzayA9IG1hc2s7Cj4gPiAtCj4gPiAgICAgICAgIHRhaW50ID0gdHN0X3RhaW50X3Jl
YWQoKTsKPiA+IC0gICAgICAgaWYgKCh0YWludCAmIG1hc2spICE9IDApCj4gPiArCj4gPiArICAg
ICAgIGlmICh0YWludCAmIFRTVF9UQUlOVF9XKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3Jl
cyhUQ09ORiwgIklnbm9yaW5nIGFscmVhZHkgc2V0IGtlcm5lbCB3YXJuaW5nIHRhaW50Iik7Cj4g
PiArICAgICAgICAgICAgICAgdGFpbnRfbWFzayAmPSB+VFNUX1RBSU5UX1c7Cj4gPiArICAgICAg
IH0KPiA+ICsKPiA+ICsgICAgICAgaWYgKCh0YWludCAmIHRhaW50X21hc2spICE9IDApCj4gPiAg
ICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgIktlcm5lbCBpcyBhbHJlYWR5IHRhaW50ZWQ6
ICV1IiwgdGFpbnQpOwo+ID4gIH0KPgo+ID4gT3RoZXIgdGVzdHMgcmVseSBvbiBUQUlOVF9XIHRv
IGRlY2lkZSB0aGUgcmVzdWx0IGFsc28gcmVwb3J0IFRQQVNTIGJ5Cj4gPiBtaXNzdGFrZSBpZiBU
QUlOVF9XIHdhcyBhbHJlYWR5IHNldC4KPiA+IEluIG15IHBhdGNoIHYxIGFib3V0IENWRS0yMDIz
LTMxMjQ4IGNoZWNrIGVycm9yID09IEVOT0VOVC4gSW4gdGhpcwo+ID4gY2FzZSwgdGVzdCByZXBv
cnRzIGNvcnJlY3QgcmVzdWx0Lgo+ID4gSXQgbWF5IGJlIGRpZmZpY3VsdCB0byBpbXBsZW1lbnQg
dGVzdCBsaWtlIHBhdGNoIHYxIHVzaW5nIHRoZSBpbnRlcm5hbAo+ID4gdHN0X25ldGxpbmsgQVBJ
LCBidXQgd2Ugc2hvdWxkIGJlIGF3YXJlIG9mIHRoaXMgaXNzdWUuCj4KPiBDYyBKYW4uIEJ1dCBp
ZiBJIHJlYWQgaXQgY29ycmVjdGx5IGlmIHRoZSBrZXJuZWwgaXMgYWxyZWFkeSB0YWludGVkIHdp
dGgKPiBUQUlOVF9XLCB0aGlzIGZsYWcgaXMgaW5kZWVkIHNraXBwZWQsIGJ1dCBpdCBjYW4gc3Rp
bGwgYmUgZGV0ZWN0ZWQgdmlhCj4gVFNUX1RBSU5UX0QgKG9vcHMpLgoKSWYgd2UgbWFzayBhbHJl
YWR5IHNldCBUQUlOVF9XLCB5b3UgY2FuIGdldCBQQVNTIGJ5IG1pc3Rha2UsCmlmIHdlIGRvbid0
IG1hc2sgaXQsIHlvdSBjYW4gZ2V0IEZBSUwgYnkgbWlzdGFrZSAtIHdoaWNoIG9uZSBpcyBiZXR0
ZXI/CgpJIGJlbGlldmUgYXQgdGhlIHRpbWUgd2Ugc2F3IG1hc2tpbmcgYXMgYmV0dGVyIGFsdGVy
bmF0aXZlLCBzaW5jZSBtYW55CkNJIHN5c3RlbXMgYWxzbyBsb29rIGF0IGRtZXNnL2pvdXJuYWwg
YW5kIHdvdWxkIGZpbmQgV0FSTklORyBtZXNzYWdlcwpldmVuIHdoZW4gdGVzdCByZXBvcnRzIFBB
U1MgYnkgbWlzdGFrZS4gU28gdGhlIGZhaWx1cmUgd291bGRuJ3QgZ28gdW5ub3RpY2VkLgoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
