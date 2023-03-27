Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945FBC76195
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 08:36:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E535E3CCB4E
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 10:36:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67053CA3A6
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 10:36:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F36831000676
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 10:36:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679906168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0di3gljzcebBoo17rf40TAtFnfXesBc5d2aSs5CXl5w=;
 b=ZfEVH3xJvJsJvoPDl9Bw2FyHZcvN1J6FhhU1jA5vdYmX/c4D83F2Gf5eErtaWHzFot2zjw
 TN3OcM7DOtzlSkvQv+liilIaE8P2oECk+xslGtjkZvDYUg6BKmcNMIN4vJXO4suyRNkwOv
 U/yFHl+7YSdZkDjlf4n3hCqJ9LzUDUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-LKSeJhETPJiOqAwssum5AA-1; Mon, 27 Mar 2023 04:36:07 -0400
X-MC-Unique: LKSeJhETPJiOqAwssum5AA-1
Received: by mail-wm1-f71.google.com with SMTP id
 m5-20020a05600c4f4500b003ee8db23ef9so5186686wmq.8
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 01:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679906165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0di3gljzcebBoo17rf40TAtFnfXesBc5d2aSs5CXl5w=;
 b=M2UanIlvwJLcFa5ZXK8VIQlULBrM0vZ189XrMkaDkhhEgt5HooGkoO5tK0tfLDunfh
 IWlQMN7BkGq1YUTCWvvK3J6agr1Yn7f3x1t5MVKUwqKCT99Xd0co9XBsUZUIihEHzQsT
 M6jaQCo/edXUyPvubtFHcbANABRRyM2FJqkcVY34daSenxJmXTtej4JjQtV6ETR3QFOr
 5JLO1AHaqhp0E4ozM/DyDCRgMSv86d36GsNj2SBkDQBuTCANsmpH4Y6KXRrSNGj72j9d
 N8uOxC+rCWQcn39+tX0m/jESU3xSr8vQjJpyQyxQ1jS03Nn9AFFS219nk3jvQo3eTMaC
 pmvA==
X-Gm-Message-State: AO0yUKUhLPCEJ9QtK3CRkLoimzvuaJtZkjO/5tRjab5kc7f0vK+X9OBa
 rrBItDVGhz8sO6KcgZPLVICRTMWsit1BIyPv5OpuVyygSuhlXhjnRg/kfZ+obpdyXmA7U8SebZs
 UMzF5jySeIOEDsL1efZRs496KE5Y=
X-Received: by 2002:a05:600c:5126:b0:3eb:3998:8bed with SMTP id
 o38-20020a05600c512600b003eb39988bedmr5793518wms.1.1679906165268; 
 Mon, 27 Mar 2023 01:36:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set9QeF+CzHH52g2/qyYPoMLAdyQ0ZqTYAiOUkajDUNOrLQG+LMdpLQlcJRob5f+gKx4cy49aNI1bq4NyBJdZuzE=
X-Received: by 2002:a05:600c:5126:b0:3eb:3998:8bed with SMTP id
 o38-20020a05600c512600b003eb39988bedmr5793511wms.1.1679906164990; Mon, 27 Mar
 2023 01:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230323160508.672397-2-teo.coupriediaz@arm.com>
 <ZB2PB6adFr+3sYI8@yuki> <76663541-e9bd-a17a-0ebd-ddd4d1eb68dd@arm.com>
In-Reply-To: <76663541-e9bd-a17a-0ebd-ddd4d1eb68dd@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 27 Mar 2023 16:35:53 +0800
Message-ID: <CAEemH2e9gbNOfm3Opc46Qh8FYmiYNtzrmyJy1hdbsVFVjyLk3w@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sockioctl: Align buffer to struct ifreq
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

SGkgVGVvLAoKT24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTA6MzXigK9QTSBUZW8gQ291cHJpZSBE
aWF6Cjx0ZW8uY291cHJpZWRpYXpAYXJtLmNvbT4gd3JvdGU6Cj4KPiBIaSBDeXJpbCwKPgo+IE9u
IDI0LzAzLzIwMjMgMTE6NTIsIEN5cmlsIEhydWJpcyB3cm90ZToKPiA+IEhpIQo+ID4+IEluIHNl
dHVwMywgdGhlIGZvbGxvd2luZyBsaW5lIGNhbiBsZWFkIHRvIGFuIHVuZGVmaW5lZCBiZWhhdmlv
cjoKPiA+PiAgICBpZnIgPSAqKHN0cnVjdCBpZnJlcSAqKWlmYy5pZmNfYnVmOwo+ID4+Cj4gPj4g
SW5kZWVkLCBhdCB0aGlzIHBvaW50IGl0IGNhbiBiZSBhc3N1bWVkIHRoYXQgaWZjLmlmY19idWYg
aXMgc3VpdGFibHkKPiA+PiBhbGlnbmVkIGZvciBzdHJ1Y3QgaWZyZXEuCj4gPj4gSG93ZXZlciwg
aWZjLmlmY19idWYgaXMgYXNzaWduZWQgdG8gYnVmIHdoaWNoIGhhcyBubyBhbGlnbm1lbnQKPiA+
PiBjb25zdHJhaW50cy4gVGhpcyBtZWFucyB0aGVyZSBleGlzdHMgY2FzZXMgd2hlcmUgYnVmIGlz
IG5vdCBzdWl0YWJseQo+ID4+IGFsaWduZWQgdG8gbG9hZCBhIHN0cnVjdCBpZnJlcSwgd2hpY2gg
Y2FuIGdlbmVyYXRlIGEgU0lHQlVTLgo+ID4+Cj4gPj4gRm9yY2UgdGhlIGFsaWdubWVudCBvZiBi
dWYgdG8gdGhhdCBvZiBzdHJ1Y3QgaWZyZXEuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBUZW8g
Q291cHJpZSBEaWF6IDx0ZW8uY291cHJpZWRpYXpAYXJtLmNvbT4KPiA+PiAtLS0KPiA+PiBDSSBC
dWlsZDogaHR0cHM6Ly9naXRodWIuY29tL1Rlby1DRC9sdHAvYWN0aW9ucy9ydW5zLzQ1MDIyMDQx
MzIKPiA+Pgo+ID4+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zb2NraW9jdGwvc29ja2lv
Y3RsMDEuYyB8IDggKysrKysrKy0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zb2NraW9jdGwvc29ja2lvY3RsMDEuYwo+ID4+IGluZGV4IDQ4NjIzNmFmOWQ2Yi4uZTYz
YWExOTIxODc3IDEwMDY0NAo+ID4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc29j
a2lvY3RsL3NvY2tpb2N0bDAxLmMKPiA+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4gPj4gQEAgLTUyLDcgKzUyLDEzIEBAIHN0YXRpYyBz
dHJ1Y3QgaWZyZXEgaWZyOwo+ID4+ICAgc3RhdGljIGludCBzaW5sZW47Cj4gPj4gICBzdGF0aWMg
aW50IG9wdHZhbDsKPiA+Pgo+ID4+IC1zdGF0aWMgY2hhciBidWZbODE5Ml07Cj4gPj4gKy8qCj4g
Pj4gKyAqIGJ1ZiBoYXMgbm8gYWxpZ25tZW50IGNvbnN0cmFpbnRzIGJ5IGRlZmF1bHQuIEhvd2V2
ZXIsIGl0IGlzIHVzZWQgdG8gbG9hZAo+ID4+ICsgKiBhIHN0cnVjdCBpZnJlcSBpbiBzZXR1cDMs
IHdoaWNoIHJlcXVpcmVzIGl0IHRvIGhhdmUgYW4gYXBwcm9wcmlhdGUgYWxpZ25tZW50Cj4gPj4g
KyAqIHRvIHByZXZlbnQgYSBwb3NzaWJsZSB1bmRlZmluZWQgYmVoYXZpb3IuCj4gPj4gKyAqLwo+
ID4+ICtzdGF0aWMgY2hhciBidWZbODE5Ml0KPiA+PiArICAgIF9fYXR0cmlidXRlX18oKGFsaWdu
ZWQoX19hbGlnbm9mX18oc3RydWN0IGlmcmVxKSkpKTsKPiA+Pgo+ID4+ICAgc3RhdGljIHZvaWQg
c2V0dXAodm9pZCk7Cj4gPj4gICBzdGF0aWMgdm9pZCBzZXR1cDAodm9pZCk7Cj4gPiBMb29raW5n
IGF0IHRoZSBjb2RlLCBzaG91bGRuJ3Qgd2UgcmF0aGVyIHRoYW4gdGhhdCBkZWNsYXJlIHRoZSBi
dWZmZXIgYXMKPiA+IGFuIHN0cnVjdCBpZnJlcSBhcnJheSwgdGhhdCB3b3VsZCBuYXR1cmFsbHkg
YWxpZ24gdGhlIGJ1ZmZlciB3aXRob3V0IGFueQo+ID4gbmVlZCBmb3IgdHJpY2t5IF9fYXR0cmli
dXRlX18uCj4gX19hdHRyaWJ1dGVfXytfX2FsaWdub2ZfXyBpcyBxdWl0ZSB1bndpZWxkeSBpbmRl
ZWQuIEkga2VwdCB0aGUgY2hhciogdG8KPiBtYXRjaCB0aGUgc3RydWN0IGRlZmluaXRpb24sCj4g
YnV0IGl0J3MgcmVhbGx5IGp1c3QgdG8gcmVwcmVzZW50IGEgcG9pbnRlciB0byBzb21ldGhpbmcu
IEl0J3Mgbm90IHVzZWQKPiBhcyBhbnl0aGluZyBlbHNlIGluIHRoZSB0ZXN0IGFueXdheS4KPgo+
IElmIHlvdSBmZWVsIHRoZXJlJ3Mgbm8gZ29vZCByZWFzb24gdG8ga2VlcCB0aGUgY2hhciogYnVm
ZiBhbmQgY2FzdCB0bwo+IHZvaWQqIGZvciB0aGUgc3lzY2FsbCwKPiBJIGFncmVlIHRoYXQgaXQg
d291bGQgYmUgYmV0dGVyLiBJIHRlc3RlZCBvbiBvdXIgc3lzdGVtIHdoaWNoIGdlbmVyYXRlZAo+
IHRoZSBmYXVsdCBpbml0aWFsbHkKPiBhbmQgaXQgd29ya3MgZmluZSBhcyBleHBlY3RlZC4KPgo+
IFdoYXQgd291bGQgYmUgdGhlIHByb2NlZHVyZSBpbiB0aGlzIGNhc2UgPyBTaGFsbCBJIHJlc2Vu
ZCB0aGUgcGF0Y2ggd2l0aAo+IHlvdXIgY2hhbmdlcyA/CgpZZXMsIHlvdSBuZWVkIHRvIHNlbmQg
YSBwYXRjaCB2MiB3aXRoIEN5cmlsJ3Mgc3VnZ2VzdGlvbi4KCj4gV291bGQgeW91IGp1c3QgYXBw
bHkgaXQgb3Igc2VuZCBpdCB5b3Vyc2VsZiA/IEhhcHB5IHRvIGZvbGxvdyB1cCBob3dldmVyCj4g
aXMgYmVzdC4KPgo+IFRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGxvb2sgaW50byBpdCwK
PiBCZXN0IHJlZ2FyZHMKPiBUw6lvCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc29ja2lvY3RsL3NvY2tpb2N0bDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL3NvY2tpb2N0bC9zb2NraW9jdGwwMS5jCj4gPiBpbmRleCA1MWRhYzljMTYuLjIwNmE0
OTk5ZSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc29ja2lvY3Rs
L3NvY2tpb2N0bDAxLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc29ja2lv
Y3RsL3NvY2tpb2N0bDAxLmMKPiA+IEBAIC01Miw3ICs1Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgaWZy
ZXEgaWZyOwo+ID4gICBzdGF0aWMgaW50IHNpbmxlbjsKPiA+ICAgc3RhdGljIGludCBvcHR2YWw7
Cj4gPgo+ID4gLXN0YXRpYyBjaGFyIGJ1Zls4MTkyXTsKPiA+ICtzdGF0aWMgc3RydWN0IGlmcmVx
IGJ1ZlsyMDBdOwo+ID4KPiA+ICAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7Cj4gPiAgIHN0YXRp
YyB2b2lkIHNldHVwMCh2b2lkKTsKPiA+IEBAIC0yMTgsNyArMjE4LDcgQEAgc3RhdGljIHZvaWQg
c2V0dXAyKHZvaWQpCj4gPiAgICAgICAgICBzID0gU0FGRV9TT0NLRVQoY2xlYW51cCwgdGRhdFt0
ZXN0bm9dLmRvbWFpbiwgdGRhdFt0ZXN0bm9dLnR5cGUsCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgdGRhdFt0ZXN0bm9dLnByb3RvKTsKPiA+ICAgICAgICAgIGlmYy5pZmNfbGVuID0gc2l6
ZW9mKGJ1Zik7Cj4gPiAtICAgICAgIGlmYy5pZmNfYnVmID0gYnVmOwo+ID4gKyAgICAgICBpZmMu
aWZjX2J1ZiA9ICh2b2lkKilidWY7Cj4gPiAgIH0KPiA+Cj4gPgo+Cj4gLS0KPiBNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
