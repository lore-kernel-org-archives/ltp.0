Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0622AC3ABDD
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 08:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747212758; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=D8mYkTZ44SibU4Qij+6ks3qGH5t5/droaNK+T7t3wAo=;
 b=kNPWWS48Nhibdpte1aVkd7Q9rlI2hvKMRj6ax+ZQroSqa31AGcsM4kuRitBPpwqWeqklx
 JihKBA52xKD+pu2F171cNvynLEfu2BHPsCU1gpQ7ILbaQvtFWRcqBMTJnB3D0j2JOB+YBgA
 BDkbY6ozt+8Vpo44/D2GS/du0XPz+0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B96E3CC388
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:52:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E6393C9F55
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:52:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5ACB76001E6
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747212732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzsZFTtR2RGoEYfThsmIpzSAdvX2Uz8WzH2ULuqzz0k=;
 b=hvC3Q3+ptF5vX3PBO9XA8AlCUS0MmmwqXNAbxWQFkXUV1iwD5kvCSwNWfGTPblVEUD7mBE
 6PL0WpBXfRyaSrMh9QjL7XcC5A4JNH1VHVv/FC0aaoSx55f9rJumuCeejhbm+94xD1h9BU
 /Il+GvtitOyVF/dt5i5o2/ir19WD0sI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-2lF2J1E3M6OdPaeulxMyiQ-1; Wed, 14 May 2025 04:52:11 -0400
X-MC-Unique: 2lF2J1E3M6OdPaeulxMyiQ-1
X-Mimecast-MFC-AGG-ID: 2lF2J1E3M6OdPaeulxMyiQ_1747212730
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a344910d0dso316465f8f.0
 for <ltp@lists.linux.it>; Wed, 14 May 2025 01:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747212730; x=1747817530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzsZFTtR2RGoEYfThsmIpzSAdvX2Uz8WzH2ULuqzz0k=;
 b=N0sD7QlJj5myEJB9uukxcorXc/Qpo6yrf5PKmbUPznT95uhlh+tmAaVLGK9bCPqerN
 BJoylfVmwmAIev+5by2LWVn4wBi/rmiMZYvBCEYD3CMvuPlctB1KhxxdfSdaUw7DyaD+
 9nyM+1d74ztJLHuBUSeucRPGDTVvfXL+kUMy/5WAMt1UCufKkmklCuvtk6fVeI8l2ZO/
 zPMLAgY+daDZKVVWpgYxPPohts83hPeDzWLypLZMAFxhO8vjd6m5byOE4YM7Oknq+qcn
 qp6ovpQCfVWi/zCVwmibE/l/EvXOwqHaYjyQ9RhG/wUoRu8Dox6aBYFG+49l3UVAsytU
 rwDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ1eZVu0AxzXIL/iK2KrK0aWLiTeFcBG1WSiXG9jJiDkiEgOP8kp/LHzLP0wvU/5H6PQo=@lists.linux.it
X-Gm-Message-State: AOJu0Yz1zrTKJoBkdaeJy7uOs25F2Fl8nj0wjw9eojDT0xgpf0Igm90y
 c/oE7cQDeouGx4WevjOektEjFK5+4uJtusBEDNY3N2EfR9/DvpGhGKkSaysObg8Oj00fQtfTZll
 aUCIbClDQUg3noxrelZKvOsw+dzSD08TxPHcGLNZdMj30LTIBcOa0vJhEkLZKOGIKPjsQjiN+oa
 V7urLRJsN6ZmDIxpA1VWVVIfI=
X-Gm-Gg: ASbGnctSbkAel2CyfOqSBEJFMdp8B1DanWqc4Rcrp0V0pnjeQiWlputpBTCh2JeDHdT
 tBSCnl1to8w1+5FDlV8UdbPIXzvK/ETbXJVHcoIjpRJjYkJTtdgFkQHYrYvtkuil6uKvE
X-Received: by 2002:a5d:4948:0:b0:3a3:42f5:2260 with SMTP id
 ffacd0b85a97d-3a342f5226cmr4730969f8f.25.1747212729901; 
 Wed, 14 May 2025 01:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHclEsvgOuRxyhuT4MOu2TJirYOi/68nSS1jYLiUSrTwJVXqBOuZwoFQ8r7F8TLST6Y0hK1YomdAuS7ld6of8s=
X-Received: by 2002:a5d:4948:0:b0:3a3:42f5:2260 with SMTP id
 ffacd0b85a97d-3a342f5226cmr4730949f8f.25.1747212729486; Wed, 14 May 2025
 01:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
In-Reply-To: <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
Date: Wed, 14 May 2025 10:51:53 +0200
X-Gm-Features: AX0GCFt2JHQh7vxU6XEevaq3KAAdzWSxEmw6icSM1jposnHYGI7gq73ILwc8aMk
Message-ID: <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XwRIFo2yq67wPgxU5St4AqLl_gZBxSmh1ua35_cKzYU_1747212730
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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

T24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgNTo0NOKAr0FNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKPgo+IE9uIE1vbiwgTWF5IDEyLCAyMDI1IGF0IDEwOjQzOjU1QU0gKzAyMDAsIEph
biBTdGFuY2VrIHdyb3RlOgo+ID4gSXMgYW55b25lIGVsc2Ugc2VlaW5nIHRoaXMgdGVzdCBmYWls
aW5nIG9uIHJlY2VudCA2LjE1LXJjNSBrZXJuZWxzPwo+ID4KPiA+ID09PT0gbW1hcDIyID09PT0K
PiA+IGNvbW1hbmQ6IG1tYXAyMgo+ID4gdHN0X3RtcGRpci5jOjMxNjogVElORk86IFVzaW5nIC90
bXAvTFRQX21tYXpDVUxOTiBhcyB0bXBkaXIgKHRtcGZzIGZpbGVzeXN0ZW0pCj4gPiB0c3RfdGVz
dC5jOjE5Mzg6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMjUzLWc0YTBlM2E4ZmEKPiA+
IHRzdF90ZXN0LmM6MTk0MjogVElORk86IFRlc3RlZCBrZXJuZWw6Cj4gPiA2LjE1LjAtMC5yYzUu
MjUwNTA5ZzljNjlmODg4NDkwNC40Ny5lbG4xNDgueDg2XzY0ICMxIFNNUAo+ID4gUFJFRU1QVF9E
WU5BTUlDIEZyaSBNYXkgIDkgMTU6MTc6MzEgVVRDIDIwMjUgeDg2XzY0Cj4gPiB0c3Rfa2NvbmZp
Zy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnCj4gPiAnL2xpYi9tb2R1bGVzLzYu
MTUuMC0wLnJjNS4yNTA1MDlnOWM2OWY4ODg0OTA0LjQ3LmVsbjE0OC54ODZfNjQvYnVpbGQvLmNv
bmZpZycKPiA+IHRzdF90ZXN0LmM6MTc1ODogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVu
IGlzIDBoIDA1bSA1NHMKPiA+IG1tYXAyMi5jOjU1OiBURkFJTDogTUFQX0RST1BQQUJMRSBkaWQg
bm90IGRyb3AgbWVtb3J5IHdpdGhpbiB0aGUgdGltZW91dCBwZXJpb2QuCj4gPgo+Cj4gSSBoYXZl
IHRlc3RlZCByYzUvNiBhbmQgYm90aCBnaXZlIHBhc3MgcmVzdWx0LgoKSSBkbyBzZWUgaXQgZmFp
bCBhbG1vc3QgZGFpbHkgb24gbXVsdGlwbGUgYXJjaGVzIChWTXMgYW5kIGJhcmVtZXRhbCksCm1h
eWJlIHNvbWUgZGlmZmVyZW5jZSBpbiBvdXIgY29uZmlnLgoKY29tbWFuZDogbW1hcDIyCnRzdF90
bXBkaXIuYzozMTY6IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9tbWFZVTk1emIgYXMgdG1wZGlyICh0
bXBmcyBmaWxlc3lzdGVtKQp0c3RfdGVzdC5jOjE5NDE6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAy
NTAxMzAtMjU2LWdiOTg3YjhhYzUKdHN0X3Rlc3QuYzoxOTQ1OiBUSU5GTzogVGVzdGVkIGtlcm5l
bDogNi4xNS4wLTAucmM2LjQ5LmVsbjE0OC54ODZfNjQKIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBU
dWUgTWF5IDEzIDE0OjMwOjUzIFVUQyAyMDI1IHg4Nl82NAp0c3Rfa2NvbmZpZy5jOjg4OiBUSU5G
TzogUGFyc2luZyBrZXJuZWwgY29uZmlnCicvbGliL21vZHVsZXMvNi4xNS4wLTAucmM2LjQ5LmVs
bjE0OC54ODZfNjQvYnVpbGQvLmNvbmZpZycKdHN0X3Rlc3QuYzoxNzYxOiBUSU5GTzogT3ZlcmFs
bCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDVtIDU0cwptbWFwMjIuYzo1NTogVEZBSUw6IE1BUF9E
Uk9QUEFCTEUgZGlkIG5vdCBkcm9wIG1lbW9yeSB3aXRoaW4gdGhlIHRpbWVvdXQgcGVyaW9kLgoK
Cj4KPiB1bmFtZSAgLXIKPiA2LjE1LjAtcmM2LWc2MjcyNzdiYTdjMjMKPiAgLi9tbWFwMjIKPiB0
c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3RtcC9MVFBfbW1hTEhKSzRUIGFzIHRtcGRp
ciAodG1wZnMgZmlsZXN5c3RlbSkKPiB0c3RfdGVzdC5jOjE5NDE6IFRJTkZPOiBMVFAgdmVyc2lv
bjogMjAyNTAxMzAtMjU2LWdiOTg3YjhhYzUKPiB0c3RfdGVzdC5jOjE5NDU6IFRJTkZPOiBUZXN0
ZWQga2VybmVsOiA2LjE1LjAtcmM2LWc2MjcyNzdiYTdjMjMgIzMgU01QIFBSRUVNUFRfRFlOQU1J
QyBUdWUgTWF5IDEzIDExOjE1OjM5IEVEVCAyMDI1IHg4Nl82NAo+IHRzdF9rY29uZmlnLmM6NzE6
IFRJTkZPOiBDb3VsZG4ndCBsb2NhdGUga2VybmVsIGNvbmZpZyEKPiB0c3RfdGVzdC5jOjE3NjE6
IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMW0gMDBzCj4gbW1hcDIyLmM6
NTk6IFRQQVNTOiBNQVBfRFJPUFBBQkxFIHRlc3QgcGFzcy4KPgo+IFN1bW1hcnk6Cj4gcGFzc2Vk
ICAgMQo+IGZhaWxlZCAgIDAKPiBicm9rZW4gICAwCj4gc2tpcHBlZCAgMAo+IHdhcm5pbmdzIDAK
Pgo+Cj4KPiB1bmFtZSAgLXIKPiA2LjE1LjAtcmM1Cj4gIC4vbW1hcDIyCj4gdHN0X3RtcGRpci5j
OjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQX21tYXVMbHNtaSBhcyB0bXBkaXIgKHRtcGZzIGZp
bGVzeXN0ZW0pCj4gdHN0X3Rlc3QuYzoxOTQxOiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjUwMTMw
LTI1Ni1nYjk4N2I4YWM1Cj4gdHN0X3Rlc3QuYzoxOTQ1OiBUSU5GTzogVGVzdGVkIGtlcm5lbDog
Ni4xNS4wLXJjNSAjNCBTTVAgUFJFRU1QVF9EWU5BTUlDIFR1ZSBNYXkgMTMgMTE6Mzg6MTQgRURU
IDIwMjUgeDg2XzY0Cj4gdHN0X2tjb25maWcuYzo3MTogVElORk86IENvdWxkbid0IGxvY2F0ZSBr
ZXJuZWwgY29uZmlnIQo+IHRzdF90ZXN0LmM6MTc2MTogVElORk86IE92ZXJhbGwgdGltZW91dCBw
ZXIgcnVuIGlzIDBoIDAxbSAwMHMKPiBtbWFwMjIuYzo1OTogVFBBU1M6IE1BUF9EUk9QUEFCTEUg
dGVzdCBwYXNzLgo+Cj4KPiA+Cj4gPgo+ID4gT24gV2VkLCBNYXkgNywgMjAyNSBhdCA1OjI14oCv
UE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+ID4gPgo+ID4gPiBIaSEK
PiA+ID4gUHVzaGVkIHdpdGggYSBtaW5vciBjaGFuZ2UsIHRoYW5rcy4KPiA+ID4KPiA+ID4gV2Ug
c2hvdWxkIGNoZWNrIGlmIHRoZSBhZGRyIGlzIHZhbGlkIGJlZm9yZSB3ZSBhdHRlbXAgdG8gdW5t
YXAgaXQgaW4gdGhlCj4gPiA+IHNldHVwKCkgc28gSSd2ZSBhZGRlZDoKPiA+ID4KPiA+ID4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYwo+ID4gPiBpbmRleCBiZmVmNTU5ZTQu
LjBlNTg5ZGZhYiAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
bWFwL21tYXAyMi5jCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9t
bWFwMjIuYwo+ID4gPiBAQCAtNzIsOCArNzIsMTMgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkK
PiA+ID4gIHsKPiA+ID4gICAgICAgICB2b2lkICphZGRyID0gbW1hcCgwLCAxLCBQUk9UX1JFQUQg
fCBQUk9UX1dSSVRFLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBNQVBfQU5PTllNT1VT
IHwgTUFQX0RST1BQQUJMRSwgLTEsIDApOwo+ID4gPiArCj4gPiA+ICAgICAgICAgaWYgKGFkZHIg
PT0gTUFQX0ZBSUxFRCAmJiBlcnJubyA9PSBFSU5WQUwpCj4gPiA+IC0gICAgICAgICAgICAgICB0
c3RfYnJrKFRDT05GLCAiTUFQX0RST1BQQUJMRSBub3Qgc3VwcG9ydCIpOwo+ID4gPiArICAgICAg
ICAgICAgICAgdHN0X2JyayhUQ09ORiwgIk1BUF9EUk9QUEFCTEUgbm90IHN1cHBvcnRlZCIpOwo+
ID4gPiArCj4gPiA+ICsgICAgICAgaWYgKGFkZHIgPT0gTUFQX0ZBSUxFRCkKPiA+ID4gKyAgICAg
ICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJtbWFwKCkgTUFQX0RST1BQQUJMRSBm
YWlsZWQiKTsKPiA+ID4gKwo+ID4gPiAgICAgICAgIFNBRkVfTVVOTUFQKGFkZHIsIDEpOwo+ID4g
PiAgfQo+ID4gPgo+ID4gPgo+ID4gPiAtLQo+ID4gPiBDeXJpbCBIcnViaXMKPiA+ID4gY2hydWJp
c0BzdXNlLmN6Cj4gPiA+Cj4gPiA+IC0tCj4gPiA+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+ID4gPgo+ID4KPgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
