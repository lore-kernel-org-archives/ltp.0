Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93AAC25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 08:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E96983CEB92
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:50:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 113B33CCAB1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 10:50:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E72AC1A0110D
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 10:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698396600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfdwUqJwYsH0zuRV5+9/lVp00kD+v+Aq88drg/HS7og=;
 b=SxGYRLvx0bPnnYyfLp5PPISa/5DOyaeKHFeQ78+N2w3mOGb++/AzN1aGIqa22teHBSAXDK
 o860ZzhEwgWTzqHYnK1z/1KxSBNhaXgiHf0mf7uafdONF6GrVqalt7wYn3Or+HqV5GBiqa
 fxCPM8k3TNMMUgdMRRgPeOQZGP3TPa8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-uSi0RyreMYG86kFUxz1Ifg-1; Fri, 27 Oct 2023 04:49:57 -0400
X-MC-Unique: uSi0RyreMYG86kFUxz1Ifg-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-458145dbf42so820544137.1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 01:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698396596; x=1699001396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfdwUqJwYsH0zuRV5+9/lVp00kD+v+Aq88drg/HS7og=;
 b=eOTRC80avkAMdeIWpQ0+rvuNQdUkdTEjtyt7th8UYC3J2etqZ/nxnKJwFYZG2M/rNu
 6PKEsghFxGsNIfZqG9gK5z1Ozp2pO7R+XZdCUWOewhgVm/loU2drNBJR+kaSElH8Vym7
 A2eKqtq5NOj++HLtskphdK0kk7scACY9RRKCD8MQXGjlALvF6UwlF2ZInxGFdtA2baAO
 DrhZteoPoa3qqYrI+XZ7TJLhmmkRM5REq8XPIwTvPR4nQHciNmB/uI1R3cEb+T2uywv6
 EsON6aT+h+KIH99dQG1Ofvt4f9gAfc/gtAgv/AFobCG8i9H2cSSNyfVslg31BAid4bwt
 TTEA==
X-Gm-Message-State: AOJu0YwxndViPlllynwhqqiZpx9r6V/6tRfivNpwRCB3dTn6aqxFXnZT
 posBPgMaKN1Dwfw1KMQ3HIGQnE40S4F/3kCdExnyn8JKzGu4l9lz4EXUvLMUcphDlp7F0TteGmw
 R5KuTAKgtP51qgoQahvFt4aNkJZs=
X-Received: by 2002:a67:c295:0:b0:458:11dd:87aa with SMTP id
 k21-20020a67c295000000b0045811dd87aamr2147040vsj.22.1698396596669; 
 Fri, 27 Oct 2023 01:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGERlRY8TAyLDA5URRBz2xa/xrmEcdPMdJsdGZolicfd16c4RE9iedr170PXU4ktBc8n8A2jGKxqcoyNZ7b1j0=
X-Received: by 2002:a67:c295:0:b0:458:11dd:87aa with SMTP id
 k21-20020a67c295000000b0045811dd87aamr2147033vsj.22.1698396596430; Fri, 27
 Oct 2023 01:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <272dd7b41f4e1049c7428d2de2ac97814ed900ba.1697705468.git.jstancek@redhat.com>
 <1f088ac0-fac1-40c4-91eb-accf629daaee@suse.com>
In-Reply-To: <1f088ac0-fac1-40c4-91eb-accf629daaee@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Oct 2023 10:50:28 +0200
Message-ID: <CAASaF6zYqm+ct9C0unRHZfg0z74xyeSu6hOrXzyKNV1peWZcwg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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

T24gVGh1LCBPY3QgMTksIDIwMjMgYXQgMTA6NTjigK9BTSBBbmRyZWEgQ2VydmVzYXRvIHZpYSBs
dHAKPGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cj4KPiBIaSEKPgo+IE9uIDEwLzE5LzIzIDEw
OjUxLCBKYW4gU3RhbmNlayB3cm90ZToKPiA+IHNtYXBzIG1hdGNoaW5nIGNhbiBwcmVtYXR1cmVs
eSBlbmQsIGJlY2F1c2UgdGhlIGNvbXBhcmlzb24gdG8gIlZtRmxhZ3MiCj4gPiBzdHJpbmcgaXMg
bm90IGV4YWN0LiBTbyBkZXBlbmRpbmcgb24gYWRkcmVzcyBvbiBsaW5lLCBpdCBjYW4gYnJlYWsK
PiA+IGJlZm9yZSBpdCBmaW5kcyBTd2FwIGxpbmUuIFRoaXMgbWFrZXMgdGhlIHRlc3QgZmFpbCBv
biByZWNlbnQgYWFyY2g2NAo+ID4ga2VybmVscy4KPiA+Cj4gPiBtaW5fc3dhcF9hdmFpbCBwZXIg
ZG9jdW1lbnRhdGlvbiBpcyBpbiBNQiBub3QgS0IuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFu
IFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICAgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlLmggICB8IDIgKy0K
PiA+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19t
YWR2aXNlMDEuYyB8IDIgKy0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZS5oIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlLmgKPiA+IGluZGV4IGM0
NTcwZTUzMDlkZS4uNWIyMjdhZGEwOTllIDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlLmgKPiA+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZS5o
Cj4gPiBAQCAtNTQsNyArNTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcmVhZF9hZGRyZXNzX21h
cHBpbmcodW5zaWduZWQgbG9uZyBhZGRyZXNzLCBzdHJ1Y3QgYWRkcl9tYXBwaQo+ID4gICAgICAg
ICAgICAgICBpZiAoIWZvdW5kKQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+
ID4KPiA+IC0gICAgICAgICAgICAgaWYgKGZvdW5kICYmIHN0cmNtcChsaW5lLCAiVm1GbGFncyIp
ID49IDApCj4gPiArICAgICAgICAgICAgIGlmIChmb3VuZCAmJiBzdHJuY21wKGxpbmUsICJWbUZs
YWdzIiwgNykgPT0gMCkKPiA+ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+Cj4gPiAg
ICAgICAgICAgICAgIGlmIChzc2NhbmYobGluZSwgIiUzMVteOl06ICVkIiwgbGFiZWwsICZ2YWx1
ZSkgPiAwKSB7Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9wcm9j
ZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvcHJvY2Vzc19tYWR2aXNlL3Byb2Nlc3NfbWFkdmlzZTAxLmMKPiA+IGluZGV4IDMyMmI0Y2Y2
MDM1My4uMGZkM2MxZWY0ZjgwIDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlMDEuYwo+ID4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9wcm9jZXNzX21hZHZpc2UvcHJvY2Vzc19tYWR2aXNlMDEuYwo+
ID4gQEAgLTEyMyw3ICsxMjMsNyBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4g
PiAgICAgICAubWluX2t2ZXIgPSAiNS4xMCIsCj4gPiAgICAgICAubmVlZHNfY2hlY2twb2ludHMg
PSAxLAo+ID4gICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ID4gLSAgICAgLm1pbl9zd2FwX2F2YWls
ID0gTUVNX0NISUxEIC8gVFNUX0tCLAo+ID4gKyAgICAgLm1pbl9zd2FwX2F2YWlsID0gTUVNX0NI
SUxEIC8gVFNUX01CLAo+ID4gICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltd
KSB7Cj4gPiAgICAgICAgICAgICAgICJDT05GSUdfU1dBUD15IiwKPiA+ICAgICAgICAgICAgICAg
TlVMTAo+Cj4gVGhhbmtzIGZvciBmaXhpbmcgdGhpcy4KCkNvdWxkIEkgYWRkIHlvdXIgUmV2aWV3
ZWQvQWNrZWQtYnkgdG8gdGhlIHBhdGNoPwoKPgo+IEFuZHJlYSBDZXJ2ZXNhdG8KPgo+Cj4gLS0K
PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
PgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
