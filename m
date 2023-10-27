Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94554C25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 09:49:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B76753CEB86
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 11:49:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10D173CCA86
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 11:48:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A7D96005C5
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 11:48:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698400127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55uOaJR5QAhL1jDWT4DMpb8gMHV8aCbLwGxRNqFH930=;
 b=Zp5audrxEoUxoE04knmKDEaNSTw0/b9+Md22CQYEGqN/ebGwPOIQh8Im8TwrRH/QsES+a+
 JFY+e6v6B5BF7F7exC+vw5s49yzM04jmBtzsfRK3JlNI7QgNCS9TdCvp9MTE1cY8ChH7ST
 TD98JRLGxVN+jMnWllWG4brzdGqVtwM=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-9MhtSxp_Ph-gH5VRJI597g-1; Fri, 27 Oct 2023 05:48:46 -0400
X-MC-Unique: 9MhtSxp_Ph-gH5VRJI597g-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-457d04cb75cso831363137.1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 02:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400126; x=1699004926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55uOaJR5QAhL1jDWT4DMpb8gMHV8aCbLwGxRNqFH930=;
 b=XzdJPf/pnTcSc1R72zDgpJsgnS+VT6LPadg5neEOLPQp5sUYP3+6p/lRchR2JMaulD
 imGJeyCIiawkIX0l+H8KkQ+/qtvtlmKTcTPgOYuzoKblMXKw9Qd0IVQGgM4pelZe2gYk
 J/PddCGUgRj8rThTNYXEgNtAfwINBZixDw8RYEF0Ek/wSVBxttnSWeuXgJVNa5NzWMs1
 T4dSwhNDRBNeaT79iw0sWfRCZYiKkQ9bBkCMXvlCEP7DS9zebwbCfeyT3sHnETKRhw+M
 7Zgwi44nsi/0bfZ4RM/yWhKPWfa8nJIXAhqO90j6UFxliHUZjRROdkFNW6IHBMa99Fak
 +7Dg==
X-Gm-Message-State: AOJu0YxylpZEBJz6CVNPgkYj/VKNzk7JoQfMpEVsdlg2NfJD597xaCm4
 yUfFa031CQCR5axZWSRjdA66bZ3UKeNSTboso6tf5oNuRXRPqizv+592t3qUHN5MEix+6F1+RWk
 cd5+a7k7V6L2wqQhiYZqmR+binJPEkRBWK0U=
X-Received: by 2002:a67:e186:0:b0:458:3bc1:8941 with SMTP id
 e6-20020a67e186000000b004583bc18941mr2008040vsl.22.1698400125843; 
 Fri, 27 Oct 2023 02:48:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBETqf3PKm4ShnAjtqPEHSl6ZjDwTdCEkG1UB6kLukqH+ZXg7H11dPhfYrn5Hb163AP2mYGAeZstf2pIbe8aI=
X-Received: by 2002:a67:e186:0:b0:458:3bc1:8941 with SMTP id
 e6-20020a67e186000000b004583bc18941mr2008033vsl.22.1698400125596; Fri, 27 Oct
 2023 02:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <272dd7b41f4e1049c7428d2de2ac97814ed900ba.1697705468.git.jstancek@redhat.com>
 <1f088ac0-fac1-40c4-91eb-accf629daaee@suse.com>
 <CAASaF6zYqm+ct9C0unRHZfg0z74xyeSu6hOrXzyKNV1peWZcwg@mail.gmail.com>
 <55b7a1e5-698a-4a0f-91c8-c0bb5e6423e1@suse.com>
In-Reply-To: <55b7a1e5-698a-4a0f-91c8-c0bb5e6423e1@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Oct 2023 11:49:17 +0200
Message-ID: <CAASaF6x8csBAW8a78VgUWrf+SKAjVh6WNmvTBT8eeNQeSJQ=QA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/process_madvise01: fix smaps scan and
 min_swap_avail
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

T24gRnJpLCBPY3QgMjcsIDIwMjMgYXQgMTA6NTXigK9BTSBBbmRyZWEgQ2VydmVzYXRvCjxhbmRy
ZWEuY2VydmVzYXRvQHN1c2UuY29tPiB3cm90ZToKPgo+IEhpLAo+Cj4gT24gMTAvMjcvMjMgMTA6
NTAsIEphbiBTdGFuY2VrIHdyb3RlOgo+ID4gT24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMTA6NTji
gK9BTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBsdHAKPiA+IDxsdHBAbGlzdHMubGludXguaXQ+IHdy
b3RlOgo+ID4+IEhpIQo+ID4+Cj4gPj4gT24gMTAvMTkvMjMgMTA6NTEsIEphbiBTdGFuY2VrIHdy
b3RlOgo+ID4+PiBzbWFwcyBtYXRjaGluZyBjYW4gcHJlbWF0dXJlbHkgZW5kLCBiZWNhdXNlIHRo
ZSBjb21wYXJpc29uIHRvICJWbUZsYWdzIgo+ID4+PiBzdHJpbmcgaXMgbm90IGV4YWN0LiBTbyBk
ZXBlbmRpbmcgb24gYWRkcmVzcyBvbiBsaW5lLCBpdCBjYW4gYnJlYWsKPiA+Pj4gYmVmb3JlIGl0
IGZpbmRzIFN3YXAgbGluZS4gVGhpcyBtYWtlcyB0aGUgdGVzdCBmYWlsIG9uIHJlY2VudCBhYXJj
aDY0Cj4gPj4+IGtlcm5lbHMuCj4gPj4+Cj4gPj4+IG1pbl9zd2FwX2F2YWlsIHBlciBkb2N1bWVu
dGF0aW9uIGlzIGluIE1CIG5vdCBLQi4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSmFuIFN0
YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPj4+IC0tLQo+ID4+PiAgICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3Byb2Nlc3NfbWFkdmlzZS9wcm9jZXNzX21hZHZpc2UuaCAgIHwgMiAr
LQo+ID4+PiAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Byb2Nlc3NfbWFkdmlzZS9wcm9j
ZXNzX21hZHZpc2UwMS5jIHwgMiArLQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZS5oIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlLmgK
PiA+Pj4gaW5kZXggYzQ1NzBlNTMwOWRlLi41YjIyN2FkYTA5OWUgMTAwNjQ0Cj4gPj4+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlz
ZS5oCj4gPj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNl
L3Byb2Nlc3NfbWFkdmlzZS5oCj4gPj4+IEBAIC01NCw3ICs1NCw3IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCByZWFkX2FkZHJlc3NfbWFwcGluZyh1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHN0cnVjdCBh
ZGRyX21hcHBpCj4gPj4+ICAgICAgICAgICAgICAgIGlmICghZm91bmQpCj4gPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7Cj4gPj4+Cj4gPj4+IC0gICAgICAgICAgICAgaWYgKGZv
dW5kICYmIHN0cmNtcChsaW5lLCAiVm1GbGFncyIpID49IDApCj4gPj4+ICsgICAgICAgICAgICAg
aWYgKGZvdW5kICYmIHN0cm5jbXAobGluZSwgIlZtRmxhZ3MiLCA3KSA9PSAwKQo+ID4+PiAgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4+Pgo+ID4+PiAgICAgICAgICAgICAgICBpZiAo
c3NjYW5mKGxpbmUsICIlMzFbXjpdOiAlZCIsIGxhYmVsLCAmdmFsdWUpID4gMCkgewo+ID4+PiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJv
Y2Vzc19tYWR2aXNlMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2
aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMKPiA+Pj4gaW5kZXggMzIyYjRjZjYwMzUzLi4wZmQzYzFl
ZjRmODAgMTAwNjQ0Cj4gPj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vz
c19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMKPiA+Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlMDEuYwo+ID4+PiBAQCAt
MTIzLDcgKzEyMyw3IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+Pj4gICAg
ICAgIC5taW5fa3ZlciA9ICI1LjEwIiwKPiA+Pj4gICAgICAgIC5uZWVkc19jaGVja3BvaW50cyA9
IDEsCj4gPj4+ICAgICAgICAubmVlZHNfcm9vdCA9IDEsCj4gPj4+IC0gICAgIC5taW5fc3dhcF9h
dmFpbCA9IE1FTV9DSElMRCAvIFRTVF9LQiwKPiA+Pj4gKyAgICAgLm1pbl9zd2FwX2F2YWlsID0g
TUVNX0NISUxEIC8gVFNUX01CLAo+ID4+PiAgICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0
IGNoYXIgKltdKSB7Cj4gPj4+ICAgICAgICAgICAgICAgICJDT05GSUdfU1dBUD15IiwKPiA+Pj4g
ICAgICAgICAgICAgICAgTlVMTAo+ID4+IFRoYW5rcyBmb3IgZml4aW5nIHRoaXMuCj4gPiBDb3Vs
ZCBJIGFkZCB5b3VyIFJldmlld2VkL0Fja2VkLWJ5IHRvIHRoZSBwYXRjaD8KPgo+IFllcyBwbGVh
c2UuCj4KPiBBY2tlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BtYWls
Ym94Lm9yZz4KClB1c2hlZC4KCj4gPgo+ID4+IEFuZHJlYSBDZXJ2ZXNhdG8KPiA+Pgo+ID4+Cj4g
Pj4gLS0KPiA+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAKPiA+Pgo+IEFuZHJlYSBDZXJ2ZXNhdG8KPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
