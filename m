Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B21EC30658
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 03:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058E93D3D12
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 05:31:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F2CF3D3CE9
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 05:30:45 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EFBD11A010CB
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 05:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720150243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hLCdPyiY0ap4XNTmP9oRA/Z8NDntuK1Fg2JebowNSSw=;
 b=JMKdPhQDfnEDY+FsVz5WmuBRXcCWZGakF0B9vdjq+FhfHezsOj37Wk4juB3VF/aMZCdTOy
 a/DQWSsxKbh7cQAIXQmxMVToKlAlyjHMVUNfNpabAr5l4UkMBMj3Y7nEYw5eUOrMSoMczV
 8FKt2wipSxyCSQeDWQ348xyJThBqBLE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-eceFbIsTP9mEadXWaQdZjg-1; Thu, 04 Jul 2024 23:30:41 -0400
X-MC-Unique: eceFbIsTP9mEadXWaQdZjg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c98c453912so1048526a91.2
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 20:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720150237; x=1720755037;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLCdPyiY0ap4XNTmP9oRA/Z8NDntuK1Fg2JebowNSSw=;
 b=kdqYh8ssFuJrSPqrEoV8rUphF8JUcf1c9kn/6iPoYLi5YMR6l9xXVFVECXf6PqU/Yo
 MQVDEXPOv1ktcRAwJr3iTR5IntlD0rDH2OAGQ4oR76NojCA+otk7+G04G6JpjRmoK0LH
 Z7zpQj4xclR6A3u0G77+VGBzHixUyx/s6rRQeW8HRgGexg7frc5HJhGmDpA6/RqLL4kc
 2DU/vcdndwtCjvqNJep9vqsieLpCB61jlE6En3RjvxYloHuysLV163+DYraE+PTkgFv5
 yS5/NEFl9gP2JxO4hzk3nkgwUNd6tyVmVp8o5auHjgtweX272uTKWW22+TWdLCFRWGGK
 gR5w==
X-Gm-Message-State: AOJu0YzFUDXxkMGiFPjmSApW1tafKbCIKPJY/NsVtFW4PARhqX0jPnCT
 ydsp6hVITmWUlNyzuepy9K2rriozuMQaBIU38xnAEP296+I0/OV/LPkqs+/yCSKiUStILyRu76E
 StzWHHB0kktLLflcw4TfgkgQXGi441mBXFm53NvNIRNxbL2HHTo/nUqEmwrysoNaehpVlloThiB
 kzlG+MGT9UY8AQMoY1G6zZM1OQPwfx+4scZMWD
X-Received: by 2002:a17:90a:3482:b0:2c4:aae7:e27 with SMTP id
 98e67ed59e1d1-2c99c6bb887mr2541900a91.23.1720150236834; 
 Thu, 04 Jul 2024 20:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZr1vPPIT4IilmEzjzppqT97ChQuu5/mLvPDA59mh4GicmErqshSc/G/XpZBmY9a1LjOy24i5Fzs73qlbBuw=
X-Received: by 2002:a17:90a:3482:b0:2c4:aae7:e27 with SMTP id
 98e67ed59e1d1-2c99c6bb887mr2541891a91.23.1720150236517; Thu, 04 Jul 2024
 20:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240705031502.9041-1-liwang@redhat.com>
In-Reply-To: <20240705031502.9041-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Jul 2024 11:30:23 +0800
Message-ID: <CAEemH2cjqBfoNtgn3yShTYW5uVCvgEN4tpDjotRgC8s2RFvhKw@mail.gmail.com>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] perf_event_open: improve the memory leak detection
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdWwgNSwgMjAyNCBhdCAxMToxNeKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gVGhlIGdvYWwgaXMgdG8gYWRkIG1vcmUgcm9idXN0IG1lbW9yeSBsZWFr
IGRldGVjdGlvbiBieSBwZXJpb2RpY2FsbHkKPiBzYW1wbGluZyBtZW1vcnkgYXZhaWxhYmlsaXR5
IGR1cmluZyB0aGUgdGVzdCBydW4gYW5kIGNoZWNraW5nIGZvcgo+IHNpZ25pZmljYW50IGRlY3Jl
YXNlcyBpbiBhdmFpbGFibGUgbWVtb3J5Lgo+Cj4gVG8gYXZvaWQgZmFsc2UgcG9zdGl2ZToKPiAg
IHBlcmZfZXZlbnRfb3BlbjAzLmM6OTU6IFRGQUlMOiBMaWtlbHkga2VybmVsIG1lbW9yeSBsZWFr
IGRldGVjdGVkCj4KPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4K
PiAtLS0KPiAgLi4uL3BlcmZfZXZlbnRfb3Blbi9wZXJmX2V2ZW50X29wZW4wMy5jICAgICAgIHwg
MzIgKysrKysrKysrKysrKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3BlcmZfZXZlbnRfb3Blbi9wZXJmX2V2ZW50X29wZW4wMy5jCj4gYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3BlcmZfZXZlbnRfb3Blbi9wZXJmX2V2ZW50X29wZW4wMy5jCj4gaW5kZXgg
N2RkMzFkM2QyLi4xYWFiNDNlODIgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9wZXJmX2V2ZW50X29wZW4vcGVyZl9ldmVudF9vcGVuMDMuYwo+ICsrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvcGVyZl9ldmVudF9vcGVuL3BlcmZfZXZlbnRfb3BlbjAzLmMKPiBA
QCAtMjYsNiArMjYsNyBAQAo+ICBjb25zdCBpbnQgaXRlcmF0aW9ucyA9IDEyMDAwMDAwOwo+ICBz
dGF0aWMgaW50IGZkID0gLTE7Cj4gIHN0YXRpYyBpbnQgcnVudGltZTsKPiArc3RhdGljIGludCBz
YW1wbGU7Cj4KPiAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgewo+IEBAIC03NywyMiArNzgs
NDEgQEAgc3RhdGljIHZvaWQgY2hlY2tfcHJvZ3Jlc3MoaW50IGkpCj4KPiAgc3RhdGljIHZvaWQg
cnVuKHZvaWQpCj4gIHsKPiAtICAgICAgIGxvbmcgZGlmZjsKPiArICAgICAgIGxvbmcgZGlmZiwg
ZGlmZl90b3RhbCwgbWVtX2F2YWlsLCBtZW1fYXZhaWxfcHJldjsKPiAgICAgICAgIGludCBpOwo+
Cj4gLSAgICAgICBkaWZmID0gU0FGRV9SRUFEX01FTUlORk8oIk1lbUF2YWlsYWJsZToiKTsKPiAr
ICAgICAgIHNhbXBsZSA9IDA7Cj4gKyAgICAgICBkaWZmX3RvdGFsID0gMDsKPiArCj4gKyAgICAg
ICBtZW1fYXZhaWxfcHJldiA9IFNBRkVfUkVBRF9NRU1JTkZPKCJNZW1BdmFpbGFibGU6Iik7Cj4g
ICAgICAgICB0c3RfdGltZXJfc3RhcnQoQ0xPQ0tfTU9OT1RPTklDKTsKPgo+ICAgICAgICAgLyog
bGVhayBhYm91dCAxMDBNQiBvZiBSQU0gKi8KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBpdGVy
YXRpb25zOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgaW9jdGwoZmQsIFBFUkZfRVZFTlRfSU9D
X1NFVF9GSUxURVIsICJmaWx0ZXIsMC8wQGFiY2QiKTsKPiAgICAgICAgICAgICAgICAgY2hlY2tf
cHJvZ3Jlc3MoaSk7Cj4gLSAgICAgICB9Cj4KPiAtICAgICAgIGRpZmYgLT0gU0FGRV9SRUFEX01F
TUlORk8oIk1lbUF2YWlsYWJsZToiKTsKPiArICAgICAgICAgICAgICAgLyoKPiArICAgICAgICAg
ICAgICAgICogRXZlcnkgMTIwMDAwMCBpdGVyYXRpb25zLCBjYWxjdWxhdGUgdGhlIGRpZmZlcmVu
Y2UgaW4KPiBtZW1vcnkKPiArICAgICAgICAgICAgICAgICogYXZhaWxhYmlsaXR5LiBJZiB0aGUg
ZGlmZmVyZW5jZSBpcyBncmVhdGVyIHRoYW4gMTAgKgo+IDEwMjQgKDEwTUIpLAo+ICsgICAgICAg
ICAgICAgICAgKiBpbmNyZW1lbnQgdGhlIHNhbXBsZSBjb3VudGVyIGFuZCBsb2cgdGhlIGV2ZW50
Lgo+ICsgICAgICAgICAgICAgICAgKi8KPiArICAgICAgICAgICAgICAgaWYgKChpICUgMTIwMDAw
MCkgPT0gMCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIG1lbV9hdmFpbCA9IFNBRkVfUkVB
RF9NRU1JTkZPKCJNZW1BdmFpbGFibGU6Iik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGlm
ZiA9IG1lbV9hdmFpbF9wcmV2IC0gbWVtX2F2YWlsOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGRpZmZfdG90YWwgKz0gZGlmZjsKPiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGRp
ZmYgPiAyMCAqIDEwMjQpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNhbXBs
ZSsrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgIk1l
bUF2YWlsYWJsZSBkZWNyZWFzZWQgYnkKPiAlbGQga0IgYXQgaXRlcmF0aW9uICVkIiwgZGlmZiwg
aSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+ICsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBtZW1fYXZhaWxfcHJldiA9IG1lbV9hdmFpbDsKPiArICAgICAgICAgICAgICAgfQo+ICsg
ICAgICAgfQo+Cj4gLSAgICAgICBpZiAoZGlmZiA+IDUwICogMTAyNCkKPiAtICAgICAgICAgICAg
ICAgdHN0X3JlcyhURkFJTCwgIkxpa2VseSBrZXJuZWwgbWVtb3J5IGxlYWsgZGV0ZWN0ZWQiKTsK
PiArICAgICAgIGlmICgoc2FtcGxlID4gNSkgfHwgKGRpZmZfdG90YWwgPiAxMDAgKiAxMDI0KSkK
PgoKCkhlcmUgbWF5YmUgZGlmZl90b2FsIGlzIHN0aWxsIHRoZSBpbnRlcmZlcmVuY2UgZmFjdG9y
IGluIHJlcG9ydGluZyBmYWxzZQpwb3NpdGl2ZXMsCkknbSBoZXNpdGF0aW5nIHRvIHJlbW92ZSBv
ciBrZWVwIGl0LgoKT3Igd2UgY291bGQgdXNlIGl0IGZpcnN0IHRvIHNlZSBob3cgdGhlIHRlc3Qg
cGVyZm9ybXMgaW4gdGhlIGxhcmdlLXNjYWxlIENJCnRlc3RpbmcuCgoKCj4gKyAgICAgICAgICAg
ICAgIHRzdF9yZXMoVEZBSUwsICJMaWtlbHkga2VybmVsIG1lbW9yeSBsZWFrIGRldGVjdGVkLCB0
b3RhbAo+IGRlY3JlYXNlOiAlbGQga0IiLCBkaWZmX3RvdGFsKTsKPiAgICAgICAgIGVsc2UKPiAg
ICAgICAgICAgICAgICAgdHN0X3JlcyhUUEFTUywgIk5vIG1lbW9yeSBsZWFrIGZvdW5kIik7Cj4g
IH0KPiAtLQo+IDIuNDUuMgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
