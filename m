Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EFEC77B7C
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 16:34:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9EE3CB6C3
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 18:34:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83DF3CB678
 for <ltp@lists.linux.it>; Fri,  5 May 2023 18:34:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3718C1A0099F
 for <ltp@lists.linux.it>; Fri,  5 May 2023 18:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683304443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdD+jmiH4jfybCqbNb/dr3i/jQ5jREXILe+954hqmto=;
 b=U45jroW0H4CqEkRH4HTZEWVKHhLiCjyzIghUvAXyKdSyPk+RQGT+mY4ItMYVJglfTwvUPO
 QGS2i3CUL3tif7t94nXxtORD4ZjwPdLmGg/PYxeU7BvAY9sK26XIlYjGgMAg7yVo+D/psP
 Tb5LSvua0YltOQkkW44B1uQzefyXQW8=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-RTNcAMr9OBa3AfXWOipFzA-1; Fri, 05 May 2023 12:33:59 -0400
X-MC-Unique: RTNcAMr9OBa3AfXWOipFzA-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-4409621e78bso467261e0c.2
 for <ltp@lists.linux.it>; Fri, 05 May 2023 09:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683304439; x=1685896439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdD+jmiH4jfybCqbNb/dr3i/jQ5jREXILe+954hqmto=;
 b=b/TKok4JHMdGOc+dUvPdcI1qSEGUVOQIxs0qvE/pa1cDzlZH/wLq726fnk+xVCmrj4
 mLBMobCmadoirQno3GuRGCMHIXkBFoAa8e4/pqCMTmL/7KpbWkQOGWQrUOL3FFwF89NG
 S5K5SgP4JQYRSVp39itSZ8DnnMSDdVscmNN5SfFQT4+V8f/9NLQj9c9SwGZaCkB9Nvjs
 KNXHLYNr591TekYZQCoYiLMXaKGKqJch0Ip5q1S+JMKW8kOIHChprGKAtb3uJCR1EXjA
 ma1dZ9lHmBzx/kOrm8+0ilYg8Hg8MGDSar8c0w0eVdmjxJ5roYbyemEjI4RUWBvGzIBm
 uMXQ==
X-Gm-Message-State: AC+VfDxD14QGeK/FW8WKnkWS5LLOzxSDK3vmzqHhJo+KTr4UyBvRfBrW
 V/abBHRumGSg11l4Q49IsDXVzRv+8NuEab4qy6lwwS6GNjrConc+BNQhkTYuNdd38HkLQW4PkRs
 SKkRM4YZJNyPYaTj699frvRn6/kw=
X-Received: by 2002:a67:f353:0:b0:434:8479:1812 with SMTP id
 p19-20020a67f353000000b0043484791812mr285788vsm.18.1683304439502; 
 Fri, 05 May 2023 09:33:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jgjnDPStsy2ywv0JgWIVWfJVq7FhYcjuIa3rgcdLWz4WzwassEpdpJLcpBXGuT2Nws65QbOOxhOA4nxWOCXY=
X-Received: by 2002:a67:f353:0:b0:434:8479:1812 with SMTP id
 p19-20020a67f353000000b0043484791812mr285785vsm.18.1683304439224; Fri, 05 May
 2023 09:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230505162822.15676-1-pvorel@suse.cz>
In-Reply-To: <20230505162822.15676-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 5 May 2023 18:34:36 +0200
Message-ID: <CAASaF6w=6dOVtH_FYrMuUQPOrwXdMHM_dHD7e-74KHHaimeQWg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] endian_switch01: Add HAVE_GETAUXVAL guarder
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

T24gRnJpLCBNYXkgNSwgMjAyMyBhdCA2OjI44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gRnJvbTogUGV0ciBWb3JlbCA8cGV0ci52b3JlbEBnbWFpbC5jb20+Cj4K
PiBUaGlzIGZpeGVzIGNvbXBpbGF0aW9uIG9uIHVDbGliYyAvIHVDbGliYy1uZyAoYW5kIGFsc28g
b2xkZXIgZ2xpYmMpLAo+IHdoaWNoIGRvZXMgbm90IHByb3ZpZGUgdGhpcyBoZWFkZXIuCj4KPiBG
aXhlczogMDNiNzZhMjBjICgiZW5kaWFuX3N3aXRjaDAxLmM6IGRyb3AgdW51c2VkIG1haW40KCki
KQo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHBldHIudm9yZWxAZ21haWwuY29tPgo+IC0t
LQo+IEhpIEphbiwKPgo+IGNhbiB5b3UgcGxlYXNlIGhhdmUgYSBsb29rLCBJJ2QgcHJlZmVyIHRv
IG1lcmdlIHRoaXMgYmVmb3JlIHJlbGVhc2UKPiAoYnVpbGQgZml4IG9uIEJ1aWxkcm9vdCkuCgpM
b29rcyByZWFzb25hYmxlIChvbiBteSBwaG9uZSksIGFjay4KCj4KPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+Cj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dpdGNoL2VuZGlhbl9zd2l0Y2gw
MS5jIHwgMTQgKysrKysrKysrKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zd2l0Y2gvZW5kaWFuX3N3aXRjaDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N3aXRjaC9lbmRpYW5fc3dpdGNoMDEuYwo+IGluZGV4IGQ5NjVhZWQ1Ni4uZmFjOWUyMzgyIDEw
MDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dpdGNoL2VuZGlhbl9zd2l0
Y2gwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2l0Y2gvZW5kaWFuX3N3
aXRjaDAxLmMKPiBAQCAtMiw3ICsyLDcgQEAKPiAgLyoKPiAgICogQ29weXJpZ2h0IChjKSBJbnRl
cm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzIENvcnAuLCAyMDA4Cj4gICAqIENvcHlyaWdodCAo
YykgUGF1bCBNYWNrZXJyYXMsIElCTSBDb3JwLiwgMjAwOAo+IC0gKiBDb3B5cmlnaHQgKGMpIDIw
MTggTGludXggVGVzdCBQcm9qZWN0Cj4gKyAqIENvcHlyaWdodCAoYykgMjAxOC0yMDIzIExpbnV4
IFRlc3QgUHJvamVjdAo+ICAgKi8KPgo+ICAvKgo+IEBAIC0xNSwxNiArMTUsMjAgQEAKPiAgI2lu
Y2x1ZGUgPHN0ZGxpYi5oPgo+ICAjaW5jbHVkZSA8dW5pc3RkLmg+Cj4gICNpbmNsdWRlIDxlbGYu
aD4KPiAtI2luY2x1ZGUgPHN5cy9hdXh2Lmg+Cj4gICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPiAg
I2luY2x1ZGUgPHN5cy93YWl0Lmg+Cj4gKwo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPgo+ICAj
aWYgZGVmaW5lZChfX3Bvd2VycGM2NF9fKSB8fCBkZWZpbmVkKF9fcG93ZXJwY19fKQo+ICsKPiAg
IyBpZm5kZWYgUFBDX0ZFQVRVUkVfVFJVRV9MRQo+IC0jIGRlZmluZSBQUENfRkVBVFVSRV9UUlVF
X0xFICAgICAgICAgICAgICAweDAwMDAwMDAyCj4gKyMgIGRlZmluZSBQUENfRkVBVFVSRV9UUlVF
X0xFICAgICAgICAgICAgICAweDAwMDAwMDAyCj4gICMgZW5kaWYKPgo+ICsjIGlmZGVmIEhBVkVf
R0VUQVVYVkFMCj4gKyMgIGluY2x1ZGUgPHN5cy9hdXh2Lmg+Cj4gKwo+ICAvKgo+ICAgKiBNYWtl
IG1pbmltYWwgY2FsbCB0byAweDFlYmUuIElmIHdlIGdldCBFTk9TWVMgdGhlbiBzeXNjYWxsIGlz
IG5vdAo+ICAgKiBhdmFpbGFibGUsIGxpa2VseSBiZWNhdXNlIG9mOgo+IEBAIC05OCw2ICsxMDIs
MTAgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICAgICAgICAgLmZvcmtzX2No
aWxkID0gMSwKPiAgfTsKPgo+ICsjIGVsc2UKPiArVFNUX1RFU1RfVENPTkYoIlRvb2xjaGFpbiBk
b2VzIG5vdCBoYXZlIDxzeXMvYXV4di5oPiIpOwo+ICsjIGVuZGlmIC8qIEhBVkVfR0VUQVVYVkFM
ICovCj4gKwo+ICAjZWxzZSAvKiBkZWZpbmVkIChfX3Bvd2VycGM2NF9fKSB8fCAoX19wb3dlcnBj
X18pICovCj4gIFRTVF9URVNUX1RDT05GKCJUaGlzIHN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IHJ1
bm5pbmcgb2Ygc3dpdGNoKCkgc3lzY2FsbCIpOwo+ICAjZW5kaWYKPiAtLQo+IDIuNDAuMQo+CgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
