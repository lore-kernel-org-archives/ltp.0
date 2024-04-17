Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFAFC001CC
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 08:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34A463CFB5F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 10:43:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 692953CFAB6
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 10:43:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 157781A0BC21
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 10:43:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713343387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eCn18cAnWF+qzwPDqwzfq+GetGtKXGeYuVF44T9v1i4=;
 b=Q1Nws+96O9GL6bp6gw9rhDGBw6CPL92aSL0q+lfJNiEwWXB5Zzjl82Zmg76+0q923I+ZcL
 MU01YV1HeQIyleIKxT7OKl1z25Ijg3xsNRLldORKOML5MVboTj3GemgDoN68r9l3rWTg6/
 6imWSxDldKlbMnc0AtirekIJb5gWUgU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-I48IilXQOY6B0xROb5j3hw-1; Wed, 17 Apr 2024 04:43:05 -0400
X-MC-Unique: I48IilXQOY6B0xROb5j3hw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1e41c665b99so50967745ad.1
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713343383; x=1713948183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eCn18cAnWF+qzwPDqwzfq+GetGtKXGeYuVF44T9v1i4=;
 b=Bxw9X/vRUl1Fotn8P7GjflPwDH26EIqY9lKN3+1IOer3FuTZldWia8AnLbQhtrtl+M
 gZb6drikaQ/lPaCIWa8gu/vaJ7ZspeyyAIeX6syqsHarA9JamaHSuoTkFBWU/3idcvGE
 pkGBpPKeT0YXdfyEqLhlCmTV5kumkxvVXLlqrV61f0aExxAIRI+6G8uiRGYUCIspMNJK
 k/4LDVjMz3nDtEzQDMTPFPEoN235QGt8Ku/O2amRLsxvEPaFj3qiSyGgkQUKxd3UguNz
 0u/jtodW/FY6TY9u1p1GyxkWm3cjIU2tWzT4FtOegLxeeX7ww3YOxmVSnKShPUd9D41o
 yzQg==
X-Gm-Message-State: AOJu0YzwYIYL3GozfuKdHmN7+OvtYQBtMoJ2sXeuYp1pJifJQW/ZrW22
 2vz1ZJwfJJUIVhy1BDpZTI5P3GZ+19pgfyMcEFeyQZAjFaQcqLqUqaZk9FMZKxkKoa6DdeJ1TIr
 X+DfwGMwnT/oPc0kqxsGLkW7QKOfohr6EJrb/vzMi820Xc5vlS71fEeoAXpW8w/AgaDo/Y7o54x
 +PQHcKyEFNZCODgqKDiUpR2YMK4l6MxUv1Xz28
X-Received: by 2002:a17:90a:fe8d:b0:2a6:e5d0:d42b with SMTP id
 co13-20020a17090afe8d00b002a6e5d0d42bmr11997748pjb.2.1713343383397; 
 Wed, 17 Apr 2024 01:43:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkT6GyF0PsSNzlB2Hqf1hql1xDeSBaNwm8BYYSMA+czY0WFSmJrY+3OTg1OOfssdjjvMChkAEFRv++3+qGd40=
X-Received: by 2002:a17:90a:fe8d:b0:2a6:e5d0:d42b with SMTP id
 co13-20020a17090afe8d00b002a6e5d0d42bmr11997741pjb.2.1713343382974; Wed, 17
 Apr 2024 01:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAE3MqZyt47uc=h1P2tryBJsXeoEEzNnHSX5A02hM=RR0goxJKg@mail.gmail.com>
 <e2966eda-b250-4033-a7ff-0ec8dce9d333@suse.com>
In-Reply-To: <e2966eda-b250-4033-a7ff-0ec8dce9d333@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Apr 2024 16:42:49 +0800
Message-ID: <CAEemH2eZAZDWKqJ6fDwDTWQk_3FBDxLiNW0z62O5dgXkreU1PQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Identify current test coverage and clarify contribution
 opportunities
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

T24gV2VkLCBBcHIgMTcsIDIwMjQgYXQgMzo0M+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gSGkgTHVpZ2ksCj4KPiBPbiA0LzE3LzI0
IDA4OjMyLCBMdWlnaSBQZWxsZWNjaGlhIHdyb3RlOgo+ID4gSGkgYWxsLAo+ID4gSSdtIEx1aWdp
IFBlbGxlY2NoaWEsIGEgUHJpbmNpcGFsIFNXIFF1YWxpdHkgRW5naW5lZXIgYXQgUmVkIEhhdC4K
PiA+IEkgZGV2ZWxvcGVkIGFuIE9wZW4gU291cmNlIFNvZnR3YXJlIFF1YWxpdHkgTWFuYWdlbWVu
dCBUb29sLCBuYW1lZCAiQkFTSUwKPiA+IFRoZSBGdVNhIFNwaWNlIiB0aGF0IGNhbiBoZWxwIHRo
ZSBMVFAga2VlcCB0cmFjayBvZiB0aGUgdGVzdCBjYXNlCj4gY292ZXJhZ2UKPiA+IGFnYWluc3Qg
bWFuIHBhZ2VzIGFuZCB0byBjbGFyaWZ5IGNvbnRyaWJ1dGlvbiBvcHBvcnR1bml0aWVzIHRvIG5l
dwo+IG1lbWJlcnMuCj4gPiBJIHByZXBhcmVkIGFuIGluaXRpYWwgZGVtbyBJIHNoYXJlZCBvbiBM
aW5rZWRJbiBhdAo+ID4KPiBodHRwczovL3d3dy5saW5rZWRpbi5jb20vcG9zdHMvbHVpZ2ktcGVs
bGVjY2hpYV9ob3ctYmFzaWwtY2FuLWhlbHAtbGludXgtdGVzdC1wcm9qZWN0LXRvLWFjdGl2aXR5
LTcxODYyNDgwOTAxMjk5NTY4NjQtZC12Qz91dG1fc291cmNlPXNoYXJlJnV0bV9tZWRpdW09bWVt
YmVyX2Rlc2t0b3AKPiBUaGFua3MgZm9yIHNoYXJpbmcuIEkgd2F0Y2hlZCB0aGUgZGVtbyBhbmQg
aXQgY2FuIGJlIHVzZWZ1bCBpbiBjZXJ0YWluCj4gY2lyY3Vtc3RhbmNlcywgYnV0IGluIG90aGVy
cyBpdCBjb3VsZCBiZSB0cmlja3kuIEkgd2lsbCBleHBsYWluIG15c2VsZgo+IGF0IHRoZSBlbmQg
b2YgdGhlIGVtYWlsLgo+ID4gVGhpcyB0b29sIGlzIHVuZGVyIHRoZSBob29kIG9mIEVMSVNBIChM
aW51eCBGb3VuZGF0aW9uKSBnaXRodWIgYXQKPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9lbGlzYS10
ZWNoL0JBU0lMCj4gPgo+ID4gQW55IGZlZWRiYWNrIHdpbGwgYmUgZ3JlYXRseSBhcHByZWNpYXRl
ZAo+ID4KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgcXVlc3Rpb25zLCBv
ciBpZiB5b3UnZCBsaWtlIHRvIHNlZSBhCj4gPiBsaXZlIGRlbW8gb2YgdGhlIHRvb2wuCj4gPgo+
ID4gUmVnYXJkcwo+ID4KPiA+IC0tCj4gPiBMdWlnaQo+ID4KPiBPbmUgb2YgdGhlIHRoaW5ncyB3
ZSBub3RpY2VkIGlzIHRoYXQgbWFuIHBhZ2VzIGFyZSBub3QgdXBkYXRlZCB0b28gb2Z0ZW4KPiBh
bmQgc29tZSBrZXJuZWwgZmVhdHVyZXMgYXJlIG5vdCBjb3ZlcmVkIGJ5IHRoZSBtYW51YWxzLiBU
aGlzIHdvdWxkIGJlCj4gYW4gaXNzdWUgd2hlbiBpdCBjb21lcyB0byBjYWxjdWxhdGUgdGVzdHMg
Y292ZXJhZ2UgYW5kIHNvbWUgb2YgdXMgdGhpbmsKPiB0aGF0IHRoaXMgYXBwcm9hY2ggY291bGQg
YmUgaGFyZCB0byBmb2xsb3cuCj4KPiBBbHNvLCBMVFAgaGFzIGEgbGFjayBvZiBtZW4gcG93ZXIg
bm93YWRheXMgKGVzcGVjaWFsbHkgd2hlbiBpdCBjb21lcyB0bwo+IHJldmlld3MpIHdoaWNoIG1l
YW5zIGNvdmVyYWdlIHJlcG9ydCBpcyBnb29kIHRvIHRyYWNrIExUUCBzdGF0dXMsIGJ1dCB3ZQo+
IHdvdWxkIHRha2UgYWdlcyB0byBpbXBsZW1lbnQgcmVtYWluaW5nIGtlcm5lbCB0ZXN0cy4gVGhl
cmUncyBhbiBpbnRlcm5hbAo+IGRpc2N1c3Npb24gaW4gTFRQIGFib3V0IGJyaW5naW5nIG1vcmUg
cGVvcGxlIGluc2lkZSB0aGUgcHJvamVjdCBhbmQgd2UKPiBhcmUgdHJ5aW5nIHRvIG1vdmUgZm9y
d2FyZCB0byBhY2hpZXZlIHRoaXMgZ29hbCAoc2VlIG5ldyBkb2N1bWVudGF0aW9uKS4KPiBUaGF0
IHdvdWxkIGhlbHAgdGhlIHdob2xlIHByb2plY3QuCj4KClNvIG1heWJlIGdpdmluZyBhICdjb3Zl
cmFnZSByZXBvcnQnIHRvIExUUCBpcyBtb3JlIHZhbHVhYmxlIHRoYW4gdGhlIHRvb2wKaXRzZWxm
PwoKQXQgbGVhc3QgaXQgY2FuIHJlZmxlY3Qgc29tZXRoaW5nIHdlIHdlcmVuJ3QgYXdhcmUgb2Ys
IHdlIHdvbid0IGZvbGxvdyB1cAp0aGUgcmVwb3J0IG9uZSBieSBvbmUgZG9nbWF0aWNhbGx5LCBi
dXQgcGljayB1cCBzb21ldGhpbmcgdXNlZnVsLgoKCgo+Cj4gV2UgaGF2ZSBhIG1vbnRobHkgTFRQ
IG1lZXRpbmcuIFRoZSBuZXh0IHdpbGwgcHJvYmFibHkgYmUgdGhlIDh0aCBvZiBtYXkKPiAoSSBu
ZWVkIHRvIHNlbmQgdGhlIGVtYWlsIHlldCkuIEl0J3MgcHVibGljLCBzbyBmZWVsIGZyZWUgdG8g
am9pbiBpZiB5b3UKPiB3YW50Lgo+Cj4gQmVzdCByZWdhcmRzLAo+IEFuZHJlYSBDZXJ2ZXNhdG8K
Pgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
