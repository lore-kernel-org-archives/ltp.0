Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB17DC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D17D3D3939
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 14:14:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7B4F3D2BB5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:14:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F20491A00CC1
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720527260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3+aU40LuANJ91DTn5I+bjYdkFXOIUCW78xHA+15uHvs=;
 b=htQjqEN57xDnpNafRuVq64Z8uw5oVKZ2SimNpYVf7nnlH+bTR6UB1Upn+JtZSBF8qCOBEz
 LCcfMTekC+tF6E1BNclg2I3rCOGuAHa8QTEpn3DHIVvV0NqGHfgNp5Qk97Y7axTYQ4pOyZ
 gLUqpwxirn21JVMGrLH4VilTH1BUljE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-QD9svSX5MieZa6zT4xa2xQ-1; Tue, 09 Jul 2024 08:14:18 -0400
X-MC-Unique: QD9svSX5MieZa6zT4xa2xQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c968fd53adso3675050a91.1
 for <ltp@lists.linux.it>; Tue, 09 Jul 2024 05:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720527257; x=1721132057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+aU40LuANJ91DTn5I+bjYdkFXOIUCW78xHA+15uHvs=;
 b=ZtXZeFxlsTTUvIIjee4U0rNwHDYto6cpWo2cQzx6gIy3l/zBAI9GTD/+oD1yVZNYAa
 OXFeYojMnV+yJQN9PHS7NSYfDnpLnMfgmzuCqkNvEjMox30ZCJiqLSnjI921o9M02YDv
 IFJQeRXcJ+ZJmKB9MWRaC959W2ab5lWXriF2RyIZ61ISnLju9koeAaLTF8t6PxQ+BsdP
 L5BBk5zvCVwY3MMMfOIqs13gSqi5fdRpZlblZo1B+y4xPOQGOT9iOhmQnUqP0MQXguwE
 +N8Uq6fq2z2pznI4cNwPqcrhoGAib+sKeuF6Ci1BKoOhEdLAkISnyaHwBvlK8ghpQZgT
 jllA==
X-Gm-Message-State: AOJu0YwyeZO0Jf+zJe7GVWipBzfjmJRFmQ0aIigZoz1F+SKZAUlAlRmL
 TZ7OwydB2ZGQUk4acM8BfkySPukprY+ZLr0oy3XhxGyDuixwCaknJYfPPKY1uBe/KQsG+tha3Al
 bGN1fTbPcD6BAGYt4kEUy13ejEdLAPg81bcwFqmo7O4AGihU/qtMyUpPhIlIR+sEPsRp8+qTY4q
 74WcOM5BxsuNF7W10grEPuxYWKTSb9LEa/OPJO
X-Received: by 2002:a17:90b:1057:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2ca35bdffa5mr1793930a91.2.1720527256723; 
 Tue, 09 Jul 2024 05:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQGVrK8qHafH0tb94RPaqz2vzXvoG+kkMmcsc5XIq4UB4pqsTZm41khuKi9zdl1MjgpwDOC/su8plINJ/xmSw=
X-Received: by 2002:a17:90b:1057:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2ca35bdffa5mr1793909a91.2.1720527256328; Tue, 09 Jul 2024
 05:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-5-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-5-2693a473a2ab@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Jul 2024 20:14:04 +0800
Message-ID: <CAEemH2eC8Vgrnfiaf=fL69crXtc4kXScFEYFP1AyLES_NfPAyw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 5/5] Add open15 test
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

SGkgQW5kcmVhLAoKT24gVHVlLCBKdWwgOSwgMjAyNCBhdCA2OjQ34oCvUE0gQW5kcmVhIENlcnZl
c2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmRlPgp3cm90ZToKCj4gRnJvbTogQW5kcmVhIENl
cnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+IFRoaXMgdGVzdCBoYXMgYmVl
biBleHRyYWN0ZWQgZnJvbSBzeW1saW5rMDEgYW5kIGl0IHZlcmlmaWVzIHRoYXQKPiBvcGVuKCkg
aXMgd29ya2luZyBjb3JyZWN0bHkgb24gc3ltbGluaygpIGdlbmVyYXRlZCBmaWxlcy4KPgo+IFNp
Z25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
Cj4gLS0tCj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIg
Ky0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuLy5naXRpZ25vcmUgfCAgMSArCj4g
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi9vcGVuMTUuYyAgIHwgNjQKPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9y
dW50ZXN0L3N5c2NhbGxzCj4gaW5kZXggNDBjMGRkMDcwLi40ZGZkZjM3ODIgMTAwNjQ0Cj4gLS0t
IGEvcnVudGVzdC9zeXNjYWxscwo+ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAtOTIzLDcg
KzkyMyw2IEBAIG5pY2UwNCBuaWNlMDQKPiAgbmljZTA1IG5pY2UwNQo+Cj4gIG9wZW4wMSBvcGVu
MDEKPiAtb3BlbjAxQSBzeW1saW5rMDEgLVQgb3BlbjAxCj4gIG9wZW4wMiBvcGVuMDIKPiAgb3Bl
bjAzIG9wZW4wMwo+ICBvcGVuMDQgb3BlbjA0Cj4gQEAgLTkzNiw2ICs5MzUsNyBAQCBvcGVuMTEg
b3BlbjExCj4gIG9wZW4xMiBvcGVuMTIKPiAgb3BlbjEzIG9wZW4xMwo+ICBvcGVuMTQgb3BlbjE0
Cj4gK29wZW4xNSBvcGVuMTUKPgo+ICBvcGVuYXQwMSBvcGVuYXQwMQo+ICBvcGVuYXQwMiBvcGVu
YXQwMgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vLmdpdGln
bm9yZQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuLy5naXRpZ25vcmUKPiBpbmRl
eCAwMDFkODc0ZDYuLmFmNTk5NzU3MiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL29wZW4vLmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
b3Blbi8uZ2l0aWdub3JlCj4gQEAgLTEyLDMgKzEyLDQgQEAKPiAgL29wZW4xMl9jaGlsZAo+ICAv
b3BlbjEzCj4gIC9vcGVuMTQKPiArL29wZW4xNQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
b3Blbi9vcGVuMTUuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi40
YWQ3MjkyYWUKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9vcGVuL29wZW4xNS5jCj4gQEAgLTAsMCArMSw2NCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMDAg
U2lsaWNvbiBHcmFwaGljcywgSW5jLiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiArICogICAgQXV0
aG9yOiBEYXZpZCBGZW5uZXIKPiArICogICAgQ29waWxvdDogSm9uIEhlbmRyaWNrc29uCj4gKyAq
IENvcHlyaWdodCAoQykgMjAyNCBBbmRyZWEgQ2VydmVzYXRvIGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5jb20KPiArICovCj4gKwo+ICsvKlwKPiArICogW0Rlc2NyaXB0aW9uXQo+ICsgKgo+ICsgKiBU
aGlzIHRlc3QgdmVyaWZpZXMgdGhhdCBvcGVuKCkgaXMgd29ya2luZyBjb3JyZWN0bHkgb24gc3lt
bGluaygpCj4gKyAqIGdlbmVyYXRlZCBmaWxlcy4KPiArICovCj4gKwo+ICsjaW5jbHVkZSAidHN0
X3Rlc3QuaCIKPiArCj4gKyNkZWZpbmUgRklMRU5BTUUgIm15ZmlsZS50eHQiCj4gKyNkZWZpbmUg
U1lNQk5BTUUgIm15ZmlsZV9zeW1saW5rIgo+ICsjZGVmaW5lIEJJR19TVFJJTkcgImFiY2RlZmdo
aWprbG1ub3BxcnN0dXZ3eHl6YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXoiCj4gKwo+ICtzdGF0
aWMgY2hhciBidWZmX2ZpbGVbMTI4XTsKPiArc3RhdGljIGNoYXIgYnVmZl9zeW1saW5rWzEyOF07
Cj4gK3N0YXRpYyBpbnQgc3RyX3NpemU7Cj4gKwo+ICtzdGF0aWMgdm9pZCBydW4odm9pZCkKPiAr
ewo+ICsgICAgICAgaW50IGZkX2ZpbGUsIGZkX3N5bWxpbms7Cj4gKwo+ICsgICAgICAgbWVtc2V0
KGJ1ZmZfZmlsZSwgMCwgc2l6ZW9mKGJ1ZmZfZmlsZSkpOwo+ICsgICAgICAgbWVtc2V0KGJ1ZmZf
c3ltbGluaywgMCwgc2l6ZW9mKGJ1ZmZfc3ltbGluaykpOwo+ICsKPiArICAgICAgIGZkX2ZpbGUg
PSBTQUZFX09QRU4oRklMRU5BTUUsIE9fQ1JFQVQgfCBPX1JEV1IsIDA3NzcpOwo+CgpNeSBpbml0
aWFsIHN1Z2dlc3Rpb24gaW4gdGhlIGxhc3QgZW1haWwgd2FzIHRvIGdlbmVyYXRlIGZpbGUgZGF0
YSBieQpzeW1saW5rLCB3aGljaCBtYXRjaGVzIHRoZSBkZXNjcmlwdGlvbiBpbiBjb2RlIGNvbW1l
bnRzLgoKICAgIGZkX3N5bWxpbmsgPSBTQUZFX09QRU4oc3ltbmFtZSwgT19DUkVBVCB8IE9fUkRX
UiwgMDc3Nyk7CiAgICBTQUZFX1dSSVRFKFNBRkVfV1JJVEVfQUxMLCBmZF9zeW1saW5rLCBCSUdf
U1RSSU5HLCBzdHJfc2l6ZSk7CgpCdXQgbm90IHRvIGNyZWF0ZSZ3cml0ZSBmaWxlcyB2aWEgZmRf
ZmlsZS4gT3RoZXJ3aXNlIGl0IGRldmlhdGVzIGZyb20gdGhlCnRlc3QgZ29hbC4KCgoKPiArICAg
ICAgIFNBRkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkX2ZpbGUsIEJJR19TVFJJTkcsIHN0cl9z
aXplKTsKPiArCj4gKyAgICAgICBTQUZFX1NZTUxJTksoRklMRU5BTUUsIFNZTUJOQU1FKTsKPiAr
Cj4gKyAgICAgICBTQUZFX0xTRUVLKGZkX2ZpbGUsIDAsIDApOwo+ICsgICAgICAgU0FGRV9SRUFE
KDEsIGZkX2ZpbGUsIGJ1ZmZfZmlsZSwgc3RyX3NpemUpOwo+ICsKPiArICAgICAgIGZkX3N5bWxp
bmsgPSBTQUZFX09QRU4oU1lNQk5BTUUsIE9fUkRXUiwgMDc3Nyk7Cj4gKyAgICAgICBTQUZFX0xT
RUVLKGZkX3N5bWxpbmssIDAsIDApOwo+ICsgICAgICAgU0FGRV9SRUFEKDEsIGZkX3N5bWxpbmss
IGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpOwo+ICsKPiArICAgICAgIFRTVF9FWFBfRVhQUighc3Ry
bmNtcChidWZmX2ZpbGUsIGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpLAo+ICsgICAgICAgICAgICAg
ICAiZmlsZSBkYXRhIGlzIHRoZSBlcXVpdmFsZW50IHRvIHN5bWxpbmsgZ2VuZXJhdGVkIGZpbGUK
PiBkYXRhIik7Cj4gKwo+ICsgICAgICAgU0FGRV9DTE9TRShmZF9maWxlKTsKPiArICAgICAgIFNB
RkVfQ0xPU0UoZmRfc3ltbGluayk7Cj4gKwo+ICsgICAgICAgU0FGRV9VTkxJTksoU1lNQk5BTUUp
Owo+ICsgICAgICAgU0FGRV9VTkxJTksoRklMRU5BTUUpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKyAgICAgICBzdHJfc2l6ZSA9IHN0cmxlbihCSUdfU1RSSU5H
KTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsgICAgICAg
LnRlc3RfYWxsID0gcnVuLAo+ICsgICAgICAgLnNldHVwID0gc2V0dXAsCj4gKyAgICAgICAubmVl
ZHNfdG1wZGlyID0gMSwKPiArfTsKPgo+IC0tCj4gMi40My4wCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
