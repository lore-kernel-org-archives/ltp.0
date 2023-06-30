Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B233EB64DA
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 20:00:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BD0A3CC3C6
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 22:00:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB76A3CC296
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 22:00:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98967100040F
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 22:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688155210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btg4XyF9SpDQDuDkKLJQfHCT5LRr0M/9JhY/7cb1AGE=;
 b=hP/Xq2qRZ3mZ42Vc+OukoJ0HfcWG6SvJLpRjGoybFdrejQFoCX03Ehuj0HCPBpaI8AyFSI
 dMCmJD4oJEwUTAViMk5dK38n3zhmbeh8Xx15j88M8vdtIaSQWaCLyKwBsNKmTX+6nMjixu
 Dx5P7CflTSG/N1wSE4pFktEcstePR1M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Y54YXzrnNWajqIXt1P5hyw-1; Fri, 30 Jun 2023 16:00:09 -0400
X-MC-Unique: Y54YXzrnNWajqIXt1P5hyw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-569e7aec37bso22170897b3.2
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 13:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688155209; x=1690747209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btg4XyF9SpDQDuDkKLJQfHCT5LRr0M/9JhY/7cb1AGE=;
 b=Qq4qMouKd6mpKGHsGRuUkCvL4akTBMrUKYjWUN/wNADGlhrDcPoyp/tjTORvXeso2G
 ofGRaBB5TDAb5pGSH9XNrWY10B2JhH0JKOqplVMVqrGnt3oYbA/qQGXM8MQjfBcSTpLr
 waCA/4C0ka6/akDk1xPv2VSFOjhiGjbEys2fead9aYIA/HpVhwi1ygfaQOM6UH8qsG62
 CDvCIUcaclHPDkHOksCzV8pBLoWJVFdm4nrwk8zHNCpcBSK5WtBP1mVzzR1Cm9omt35p
 q9jR1aXW+ikgLecUd5neNqM8eiT/kquBzq0vEXqmMIDrTb2xkRIb+RWSjDHF1UcvBjLT
 cA9w==
X-Gm-Message-State: ABy/qLZS2Nun6EB10pSGtU9xh2sRUw88DlKSHq2Z8H9gTI/hZkYclHc6
 y2QIZBQeWZZ7Bn060xKEUbMhDoaL853MRfDEA5kS/xfdXUqAbHOijzqsGITrB5KtafaxTUgzP1/
 EKZjfNsKKSC6f56k7t5oQtQkqKgA=
X-Received: by 2002:a81:8906:0:b0:570:63d3:9685 with SMTP id
 z6-20020a818906000000b0057063d39685mr2837273ywf.25.1688155208816; 
 Fri, 30 Jun 2023 13:00:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGXjWWwcTA093jTB2SqXLFke7D+GFMwH+xGdL9eCAPoebrGpJKKzqu8r4GGKM0jYRY+Be2uI2wG42QRZW1s2Cs=
X-Received: by 2002:a81:8906:0:b0:570:63d3:9685 with SMTP id
 z6-20020a818906000000b0057063d39685mr2837260ywf.25.1688155208534; Fri, 30 Jun
 2023 13:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
 <20230621090331.GA365741@pevik>
In-Reply-To: <20230621090331.GA365741@pevik>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 30 Jun 2023 15:59:57 -0400
Message-ID: <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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

SGksCgpPbiBXZWQsIEp1biAyMSwgMjAyMyBhdCA1OjEw4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+IHdyb3RlOgo+Cj4gSGkgQWxleGFuZGVyLAo+Cj4gPiBUaGlzIHBhdGNoIGFkZHMg
ZmNudGw0MCB0byB0ZXN0IHNpbWlsYXIgb3duZXIgdmFsdWVzIGZvciBjbGFzc2ljYWwgb3duZXIK
PiA+IGxvY2tzLiBUaGVyZSB3YXMgYW4gaXNzdWUgYmVlbiBmb3VuZCBpbiB0aGUgZ2ZzMiBmaWxl
c3lzdGVtIGJlY2F1c2UKPiA+IHRoZXJlIGNhbiBiZSBjb2xsaXNpb25zIHdpdGggaWRlbnRpY2Fs
IG93bmVyIHZhbHVlcy4KPgo+IFRoYW5rcyBmb3IgeW91ciB3b3JrIQo+Cj4gLi4uCj4gPiArKysg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjbnRsL2ZjbnRsNDAuYwo+ID4gQEAgLTAsMCAr
MSwxODggQEAKPiBUaGVyZSBpcyBubyBTUERYIGFuZCBjb3B5cmlnaHQsIHNlZSBvdGhlciBmaWxl
czoKPgo+IC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gLyoK
PiAgKiBDb3B5cmlnaHQgKGMpIDIwMjMgLi4uCj4gICovCj4KPiA+ICsvKgo+IE5PVEU6IHRoaXMg
c2hvdWxkIGJlIC8qXAo+IHRvIGJlIGFibGUgdG8gZ2V0IHRoZSBkZXNjcmlwdGlvbiBpbiBvdXIg
YXV0b21hdGljYWxseSBnZW5lcmF0ZWQgZG9jdW1lbnRhdGlvbgo+Cj4gaHR0cHM6Ly9naXRodWIu
Y29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvcmVsZWFzZXMvZG93bmxvYWQvMjAyMzA1MTYvbWV0
YWRhdGEuMjAyMzA1MTYuaHRtbAo+CgpvawoKPiA+ICsgKiBbRGVzY3JpcHRpb25dCj4gPiArICog
VGVzdHMgZ2ZzMiBkbG0gcG9zaXggb3AgcXVldWUgaGFuZGxpbmcgaW4gdGhlIGtlcm5lbC4KPiA+
ICsgKiBJdCBpcyByZWNvbW1lbmRlZCB0byBydW4gd2F0Y2ggLW4gMC4xICJkbG1fdG9vbCBwbG9j
a3MgJExTIgo+ID4gKyAqIGFzaWRlIHRvIG1vbml0b3IgZGxtIHBsb2NrIGhhbmRsaW5nLgo+ID4g
KyAqCj4gPiArICogW0hvdyB0byB1c2UgaXRdCj4gPiArICogQ2FsbCBpdCB3aXRoIFRNUERJUj0v
bW50IC4vZmNudGw0MCB3aGVyZSBUTVBESVIgaXMgYSBnZnMyIG1vdW50cG9pbnQuCj4gSSB3b25k
ZXIgaWYgd2UgY291bGQgY2hlY2sgZm9yIEdGUzJfTUFHSUMgKHdlJ2QgbmVlZCB0byBhZGQgaXQg
dG8KPiBpbmNsdWRlL3RzdF9mcy5oID0+IDB4MDExNjE5NzApIGFuZCBxdWl0IHRoZSB0ZXN0IHdp
dGggdHN0X2JyayhUQ09ORikgaWYgVE1QRElSCj4gaXMgbm90IG9uIGdmczIuCj4KPiBBVE0gd2Ug
ZG9uJ3QgaGF2ZSBhbnkgaGVscGVyIGluIHN0cnVjdCB0c3RfdGVzdCwgd2hpY2ggd291bGQgZG8g
aXQuCj4KCkkgd2lsbCBtZW50aW9uIHRoYXQgZ2ZzMiBpcyBvbmx5IGFuIGV4YW1wbGUgaGVyZS4g
SXQgYmVjb21lcwppbnRlcmVzdGluZyB3aGVuIGEgZmlsZSBzeXN0ZW0gaW1wbGVtZW50cyBpdHMg
b3duIC5sb2NrKCkgY2FsbGJhY2sgT1IKaWYgc29tZWJvZHkgd2FudHMgdG8gdGVzdCBmaWxlIHN5
c3RlbSBjb3JlLCB3aGVuIGEgZmlsZXN5c3RlbSBkb2VzIG5vdAppbXBsZW1lbnQgaXRzIG93biAu
bG9jaygpLgoKPiA+ICsgKiBUcnkgaXQgb24gb3RoZXIgZmlsZXN5c3RlbXMgdG8gY29tcGFyZSBy
ZXN1bHRzLgo+ID4gKyAqCj4gPiArICogW1doYXQncyBpdCBkb2luZ10KPiBuaXQ6IEknZCByZXBs
YWNlIHRoaXMgd2l0aCBbQWxnb3JpdGhtXS4KPgoKb2suCgo+IC4uLgo+ID4gK3ZvaWQgZG9fY2hp
bGQodm9pZCkKPiBUaGlzIHNob3VsZCBiZSBzdGF0aWMgKGluIGFsbCBmaWxlcykuCj4KPiBtYWtl
IGNoZWNrIChvciBtYWtlIGNoZWNrLWZjbnRsNDApIGlzIHlvdXIgZnJpZW5kLgo+Cgpvay4gVGhh
bmtzIGZvciB0ZWxsaW5nIG1lIGFib3V0IG1ha2UgY2hlY2suCgo+ID4gK3sKPiA+ICsgICAgIHB0
aHJlYWRfdCB0MSwgdDI7Cj4gPiArCj4gPiArICAgICBTQUZFX1BUSFJFQURfQ1JFQVRFKCZ0MSwg
TlVMTCwgZG9fdGhyZWFkMSwgTlVMTCk7Cj4gPiArICAgICBTQUZFX1BUSFJFQURfQ1JFQVRFKCZ0
MiwgTlVMTCwgZG9fdGhyZWFkMiwgTlVMTCk7Cj4gPiArCj4gPiArICAgICBTQUZFX1BUSFJFQURf
Sk9JTih0MSwgTlVMTCk7Cj4gPiArICAgICBTQUZFX1BUSFJFQURfSk9JTih0MiwgTlVMTCk7Cj4g
PiArCj4gPiArICAgICB0c3RfcmVzKFRQQVNTLCAiQ2hpbGQgcGFzc2VkISIpOwo+ID4gK30KPiA+
ICsKPiA+ICt2b2lkIGRvX3BhcmVudCh2b2lkKQo+IFRoaXMgc2hvdWxkIGFsc28gYmUgc3RhdGlj
Lgo+Cgpvay4KCj4gPiArewo+ID4gKyAgICAgc3RydWN0IGZsb2NrIGZsID0gewo+ID4gKyAgICAg
ICAgICAgICAubF93aGVuY2UgPSBTRUVLX1NFVCwKPiA+ICsgICAgIH07Cj4gPiArCj4gPiArICAg
ICAvKiB3YWl0IGZvciAxIHNlY29uZHMgc28gdGhyZWFkMiBsb2NrIDEtMSB0cmllcyB0byBhY3F1
aXJlcyBhdCBmaXJzdAo+ID4gKyAgICAgICogdGhhbiB0aHJlYWQxIGxvY2sgMC0wIHRyaWVzIHRv
IGFjcXVpcmVkIHRvIGhhdmUgYSBzcGVjaWZpYyB3YWl0aW5nCj4gPiArICAgICAgKiBvcmRlciBp
biBkbG0gcG9zaXggaGFuZGxpbmcuCj4gPiArICAgICAgKi8KPiA+ICsgICAgIHNsZWVwKDEpOwo+
Cj4gSSB3b25kZXIgaWYgdGhlcmUgY291bGQgYmUgc29tZSBwcm9hY3RpdmUgY2hlY2sgaW5zdGVh
ZCBvZiBzbGVlcC4KPiBGWUkgd2UgaGF2ZSB1bmRvY3VtZW50ZWQgVFNUX1JFVFJZX0ZVTkMoKSBp
biBDIEFQSS4KPgoKSSB0cnkgdG8gbG9vayBpbnRvIGl0LgoKPiA+ICsgICAgIC8qIHRlbGwgdGhy
ZWFkMiB0byBjYWxsIFNFVExLVyBmb3IgbG9jayAwLTAgKi8KPiA+ICsgICAgIFRTVF9DSEVDS1BP
SU5UX1dBS0UoMSk7Cj4gPiArICAgICAvKiB3YWl0IDMgc2Vjb25kcyBmb3IgdGhyZWFkIDEgYW5k
IDIgYmVpbmcgaW4gd2FpdGluZyBzdGF0ZSAqLwo+ID4gKyAgICAgc2xlZXAoMyk7Cj4gPiArCj4g
PiArICAgICAvKiB1bmxvY2sgMC0xLCBzaG91bGQgYmUgc3VjY2Vzc2Z1bCAqLwo+ID4gKyAgICAg
ZmwubF90eXBlID0gRl9VTkxDSzsKPiA+ICsgICAgIGZsLmxfc3RhcnQgPSAxOwo+ID4gKyAgICAg
ZmwubF9sZW4gPSAxOwo+ID4gKyAgICAgdHN0X3JlcyhUSU5GTywgInVubG9jayByZWdpb24gMS0x
IHRocmVhZDIiKTsKPiA+ICsgICAgIFNBRkVfRkNOVEwoZmQsIEZfU0VUTEssICZmbCk7Cj4gPiAr
Cj4gPiArICAgICAvKiB3YWl0IHVudGlsIHRocmVhZCAyIGdvdCBhY3F1aXJlZCBhbmQgbGVhdmUg
d2FpdGluZyAqLwo+ID4gKyAgICAgVFNUX0NIRUNLUE9JTlRfV0FJVCgyKTsKPiA+ICsKPiA+ICsg
ICAgIGZsLmxfc3RhcnQgPSAwOwo+ID4gKyAgICAgZmwubF9sZW4gPSAxOwo+ID4gKyAgICAgZmwu
bF90eXBlID0gRl9VTkxDSzsKPiA+ICsgICAgIHRzdF9yZXMoVElORk8sICJ1bmxvY2sgcmVnaW9u
IDAtMCB0aHJlYWQyIik7Cj4gPiArICAgICBTQUZFX0ZDTlRMKGZkLCBGX1NFVExLLCAmZmwpOwo+
ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBmY250bDQwX3Rlc3Qodm9pZCkKPiA+ICt7Cj4g
PiArICAgICBzdHJ1Y3QgZmxvY2sgZmwgPSB7Cj4gPiArICAgICAgICAgICAgIC5sX3R5cGUgPSBG
X1dSTENLLAo+ID4gKyAgICAgICAgICAgICAubF93aGVuY2UgPSBTRUVLX1NFVCwKPiA+ICsgICAg
ICAgICAgICAgLmxfc3RhcnQgPSAwTCwKPiA+ICsgICAgICAgICAgICAgLmxfbGVuID0gMkwsCj4g
PiArICAgICB9Owo+ID4gKyAgICAgcGlkX3QgcGlkOwo+ID4gKwo+ID4gKyAgICAgdHN0X3JlcyhU
SU5GTywgInBhcmVudCBsb2NrIHJlZ2lvbiAwLTEgLSBzaG91bGQgYmUgc3VjY2Vzc2Z1bCIpOwo+
ID4gKyAgICAgU0FGRV9GQ05UTChmZCwgRl9TRVRMSywgJmZsKTsKPiA+ICsgICAgIHRzdF9yZXMo
VElORk8sICJwYXJlbnQgcmVnaW9uIDAtMSBsb2NrZWQiKTsKPiA+ICsKPiA+ICsgICAgIHBpZCA9
IFNBRkVfRk9SSygpOwo+ID4gKyAgICAgaWYgKHBpZCA9PSAwKSB7Cj4gPiArICAgICAgICAgICAg
IGRvX2NoaWxkKCk7Cj4gPiArICAgICAgICAgICAgIHJldHVybjsKPiA+ICsgICAgIH0KPiA+ICsK
PiA+ICsgICAgIGRvX3BhcmVudCgpOwo+ID4gKyAgICAgd2FpdChOVUxMKTsKPgo+IHdhaXRwaWQo
KSBzaG91bGQgYmUgcmVwbGFjZWQgYnkgdHN0X3JlYXBfY2hpbGRyZW4oKSwgc2VlCj4gaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9DLVRlc3QtQVBJIzE4LWRv
aW5nLXRoZS10ZXN0LWluLXRoZS1jaGlsZC1wcm9jZXNzCj4KCm9rLiBUaGFua3MuCgo+ID4gKwo+
ID4gKyAgICAgdHN0X3JlcyhUUEFTUywgIlBhcmVudCBwYXNzZWQhIik7Cj4gVGhlcmUgaXMgVFBB
U1MgaW4gY2hpbGQsIGRvZXMgaXQgcmVhbGx5IG5lZWQgdG8gYmUgaW4gdGhlIHBhcmVudCBhcyB3
ZWxsPwoKbm8uCgotIEFsZXgKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
