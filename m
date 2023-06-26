Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC146EB64D7
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 06:57:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 438413CD817
	for <ltp@archiver.kernel.org>; Mon, 26 Jun 2023 08:57:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8125F3C99BA
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 08:57:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1A65600710
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 08:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687762653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IuCXl/GhtcWIKu0L8diVexA0X7g1k450rqM5JQWGpXw=;
 b=GJIuaqmExbaejcdwDaPSikoFauN5sfA/8mOiwpXk3yXNzLnEq9DmvbP3wPjfvkWXnVr2MG
 uUkoHDxVVPtBCgl/sze4Hd2wc2MyBIWCNwyukZ0O1IDr7lYJYorTvVMvebnPrfQbLDyHGf
 yR2UPF1wCMwGLqnIayCYvdE94WhB+T4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-zLuZC_xWPvyuX4DOn8aTeg-1; Mon, 26 Jun 2023 02:57:29 -0400
X-MC-Unique: zLuZC_xWPvyuX4DOn8aTeg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b69e64ddabso6574551fa.0
 for <ltp@lists.linux.it>; Sun, 25 Jun 2023 23:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687762648; x=1690354648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IuCXl/GhtcWIKu0L8diVexA0X7g1k450rqM5JQWGpXw=;
 b=Tp1lCMaHRsGV7w+x74vws1ti4dGkWv0tTnivQHYOg0Y/FNSmeQ9RFHysWDvM1MEcW4
 13CdZf0gbU8oXu2AWDgEb2HSJPxt8cSBVZHhGN7p+736YIlH1t/z34y3fkIK2ImqY6M6
 MEbax1Rj5MUs6ysQrSQoVQvYUHStboS/fej/k3cbgSw3sFCCBUW38SJOi0P8zgiMc11K
 P0BSaXW+xAA/tL7lMCO6hhM9MzTEn1/f1sdqc2r6UHI1UCrjpxZhhCGeWZcZOk70CXjV
 ECDgQsmNwOwG0T3z2KS1oBkdpha21/uA/3u2E4bn7WmB4uqAy70PBjeGd0f+FiRbRJOF
 YPcw==
X-Gm-Message-State: AC+VfDyUANTc/5rgPllyyK849Nf2EWCjBLtUQi+T4uQEO1vRUAJwek4Y
 zwmE/fronMFDlToAJkA0Zh/Kd/MDPeM6eJ5ED66mZEmP0wL9N8clc3Ktiuceph+zTldy65S+Pwa
 wcUaR0iiBP4yhrZd4bGHWOOmvRRo=
X-Received: by 2002:a2e:9b92:0:b0:2b6:a630:1e5 with SMTP id
 z18-20020a2e9b92000000b002b6a63001e5mr177566lji.33.1687762647867; 
 Sun, 25 Jun 2023 23:57:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nAbCOZuUwTsTtRJeWc7HinYGXfGl0R38h1tQNrLV2wUJFovaICahJO/2+LUaE+yCY6KvAHnv2EcTbrCZbQW0=
X-Received: by 2002:a2e:9b92:0:b0:2b6:a630:1e5 with SMTP id
 z18-20020a2e9b92000000b002b6a63001e5mr177559lji.33.1687762647516; Sun, 25 Jun
 2023 23:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615093933.3185297-1-dylan@andestech.com>
In-Reply-To: <20230615093933.3185297-1-dylan@andestech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Jun 2023 14:57:15 +0800
Message-ID: <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
To: Dylan Jhong <dylan@andestech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: minachou@andestech.com, tim609@andestech.com, x5710999x@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gMTUsIDIwMjMgYXQgNTo0MOKAr1BNIER5bGFuIEpob25nIDxkeWxhbkBhbmRl
c3RlY2guY29tPiB3cm90ZToKCj4gV2hlbiB0ZXN0aW5nIGh1Z2VzaG1jdGwwMiB1bmRlciB0aGUg
MzJiaXQgYXJjaGl0ZWN0dXJlLCBhIHNlZ21lbnRhdGlvbgo+IGZhdWx0Cj4gd2lsbCBvY2N1ci4g
VGhpcyBwYXRjaCB3aWxsIHNraXAgRUZBVUxUIHRlc3RzIGZvciBsaWJjIHZhcmlhbnQuCj4KPiBI
dWdlc2htY3RsMDIgd2lsbCBpbnRlbnRpb25hbGx5IHBhc3MgIihzdHJ1Y3Qgc2htaWRfZHMgKikt
MSIgdG8gc2htY3RsKCksCj4gYnV0Cj4gZ2xpYmMgd2lsbCBwZXJmb3JtIGFuIGFkZGl0aW9uYWwg
Y29udmVyc2lvbiBmdW5jdGlvbiB3aGVuIHRoZSBhcmNoaXRlY3R1cmUKPiBpcwo+IDMyYml0LCB3
aGljaCB3aWxsIHRyeSB0byBjb3B5IGFsbCBpdGVtcyBpbiAoc3RydWN0IHNobWlkX2RzICopIHRv
IGFub3RoZXIKPiBzdHJ1Y3R1cmVbKjFdLiBJbiB0aGUgcHJvY2VzcyBvZiBjb3B5aW5nLCBpdCBp
cyBuZWNlc3NhcnkgdG8gZGVyZWZlcmVuY2UKPiAiKHN0cnVjdCBzaG1pZF9kcyAqKS0xIiwgcmVz
dWx0aW5nIGluIHNlZ21lbnRhdGlvbiBmYXVsdC4KPgo+IFRoZSBMVFAgYWxzbyBoYXMgc2ltaWxh
ciBwcm9ibGVtcyBiZWZvcmUsIHRoaXMgcGF0Y2ggaXMgcmVmZXJlbmNlIGZyb20gdGhlCj4gc2ht
Y3RsMDMgcGF0Y2hbKjJdLgo+Cj4gWyoxXToKPiBodHRwczovL2dpdGh1Yi5jb20vYm1pbm9yL2ds
aWJjL2Jsb2IvbWFzdGVyL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3NobWN0bC5jI0wzNwo+IFsq
Ml06Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvY29tbWl0L2E1
YTgwYWE4NDg1YTdjYjAxN2Y5NmFiYThkN2I1ZWE3OWYxYmE0ZDQKPgo+IFNpZ25lZC1vZmYtYnk6
IER5bGFuIEpob25nIDxkeWxhbkBhbmRlc3RlY2guY29tPgo+IC0tLQo+ICAuLi4vbWVtL2h1Z2V0
bGIvaHVnZXNobWN0bC9odWdlc2htY3RsMDIuYyAgICAgfCAzNSArKysrKysrKysrKysrKysrKyst
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htY3RsL2h1Z2Vz
aG1jdGwwMi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1jdGwvaHVn
ZXNobWN0bDAyLmMKPiBpbmRleCAwYmM5ZmZkNzQuLmU5YzJlOWZjOCAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1jdGwvaHVnZXNobWN0bDAyLmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1jdGwvaHVnZXNobWN0bDAy
LmMKPiBAQCAtMjcsNiArMjcsNyBAQAo+ICAjaW5jbHVkZSA8cHdkLmg+Cj4gICNpbmNsdWRlIDxs
aW1pdHMuaD4KPiAgI2luY2x1ZGUgImh1Z2V0bGIuaCIKPiArI2luY2x1ZGUgImxhcGkvc3lzY2Fs
bHMuaCIKPgo+ICBzdGF0aWMgc2l6ZV90IHNobV9zaXplOwo+ICBzdGF0aWMgaW50IHNobV9pZF8x
ID0gLTE7Cj4gQEAgLTUwLDkgKzUxLDM3IEBAIHN0cnVjdCB0Y2FzZSB7Cj4gICAgICAgICB7JnNo
bV9pZF8yLCAtMSwgJmJ1ZiwgRUlOVkFMfSwKPiAgfTsKPgo+ICtzdGF0aWMgaW50IGxpYmNfc2ht
Y3RsKGludCBzaG1pZCwgaW50IGNtZCwgdm9pZCAqYnVmKQo+ICt7Cj4gKyAgICAgICByZXR1cm4g
c2htY3RsKHNobWlkLCBjbWQsIGJ1Zik7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgc3lzX3NobWN0
bChpbnQgc2htaWQsIGludCBjbWQsIHZvaWQgKmJ1ZikKPiArewo+ICsgICAgICAgcmV0dXJuIHRz
dF9zeXNjYWxsKF9fTlJfc2htY3RsLCBzaG1pZCwgY21kLCBidWYpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgc3RydWN0IHRlc3RfdmFyaWFudHMKPiArewo+ICsgICAgICAgaW50ICgqc2htY3RsKShpbnQg
c2htaWQsIGludCBjbWQsIHZvaWQgKmJ1Zik7Cj4gKyAgICAgICBjaGFyICpkZXNjOwo+ICt9IHZh
cmlhbnRzW10gPSB7Cj4gKyAgICAgICB7IC5zaG1jdGwgPSBsaWJjX3NobWN0bCwgLmRlc2MgPSAi
bGliYyBzaG1jdGwoKSJ9LAo+ICsjaWYgKF9fTlJfc2htY3RsICE9IF9fTFRQX19OUl9JTlZBTElE
X1NZU0NBTEwpCj4gKyAgICAgICB7IC5zaG1jdGwgPSBzeXNfc2htY3RsLCAgLmRlc2MgPSAiX19O
Ul9zaG1jdGwgc3lzY2FsbCJ9LAo+ICsjZW5kaWYKPiArfTsKPiArCj4gIHN0YXRpYyB2b2lkIHRl
c3RfaHVnZXNobWN0bCh1bnNpZ25lZCBpbnQgaSkKPiAgewo+IC0gICAgICAgVEVTVChzaG1jdGwo
Kih0Y2FzZXNbaV0uc2htaWQpLCB0Y2FzZXNbaV0uY21kLCB0Y2FzZXNbaV0uc2J1ZikpOwo+ICsg
ICAgICAgc3RydWN0IHRlc3RfdmFyaWFudHMgKnR2ID0gJnZhcmlhbnRzW3RzdF92YXJpYW50XTsK
PiArCj4gKyAgICAgICBpZiAodGNhc2VzW2ldLmVycm9yID09IEVGQVVMVCAmJiB0di0+c2htY3Rs
ID09IGxpYmNfc2htY3RsKSB7Cj4KCllvdSBwb2ludGVkIHRoZSBzZWdtZW50IGZhdWx0IG9ubHkg
ZXhpc3RzIG9uIDMyYml0IHdoZW4gdXNlCmxpYmMgd3JhcHBlciwgYnV0IHRoaXMgY29uZGl0aW9u
IHNraXBzIGZvciBib3RoIDY0YW5kMzIgYml0cywKaXNuJ3QgaXQ/CgpJIGd1ZXNzIHRoZSBzdHJp
Y3QgY29uZGl0aW9uIHNob3VsZCBiZSBhcyBiZWxvdz8KCiAgICBpZiAodGNhc2VzW2ldLmVycm9y
ID09IEVGQVVMVCAmJiB0di0+c2htY3RsID09IGxpYmNfc2htY3RsICYmCnRzdF9rZXJuZWxfYml0
cygpID09IDMyKSB7CiAgICAuLi4KICAgIH0KCgoKPiArICAgICAgICAgICAgICAgdHN0X3JlcyhU
Q09ORiwgIkVGQVVMVCBpcyBza2lwcGVkIGZvciBsaWJjIHZhcmlhbnQiKTsKPiArICAgICAgICAg
ICAgICAgcmV0dXJuOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIFRFU1QodHYtPnNobWN0bCgq
KHRjYXNlc1tpXS5zaG1pZCksIHRjYXNlc1tpXS5jbWQsCj4gdGNhc2VzW2ldLnNidWYpKTsKPiAg
ICAgICAgIGlmIChUU1RfUkVUICE9IC0xKSB7Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVEZB
SUwsICJzaG1jdGwgc3VjY2VlZGVkIHVuZXhwZWN0ZWRseSIpOwo+ICAgICAgICAgICAgICAgICBy
ZXR1cm47Cj4gQEAgLTcwLDggKzk5LDExIEBAIHN0YXRpYyB2b2lkIHRlc3RfaHVnZXNobWN0bCh1
bnNpZ25lZCBpbnQgaSkKPgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICB7Cj4gKyAgICAg
ICBzdHJ1Y3QgdGVzdF92YXJpYW50cyAqdHYgPSAmdmFyaWFudHNbdHN0X3ZhcmlhbnRdOwo+ICAg
ICAgICAgbG9uZyBocGFnZV9zaXplOwo+Cj4gKyAgICAgICB0c3RfcmVzKFRJTkZPLCAiVGVzdGlu
ZyB2YXJpYW50OiAlcyIsIHR2LT5kZXNjKTsKPiArCj4gICAgICAgICBpZiAodHN0X2h1Z2VwYWdl
cyA9PSAwKQo+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiTm8gZW5vdWdoIGh1Z2Vw
YWdlcyBmb3IgdGVzdGluZy4iKTsKPgo+IEBAIC0xMDEsNiArMTMzLDcgQEAgc3RhdGljIHZvaWQg
Y2xlYW51cCh2b2lkKQo+Cj4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiAgICAg
ICAgIC50ZXN0ID0gdGVzdF9odWdlc2htY3RsLAo+ICsgICAgICAgLnRlc3RfdmFyaWFudHMgPSBB
UlJBWV9TSVpFKHZhcmlhbnRzKSwKPiAgICAgICAgIC50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMp
LAo+ICAgICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+ICAgICAgICAgLm5lZWRzX3RtcGRpciA9IDEs
Cj4gLS0KPiAyLjM0LjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
