Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029FCC41513
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 09:06:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36EB73CEE01
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 11:06:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69FDA3C036A
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 11:06:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61D511A01117
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 11:06:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697447159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EqdAEgPPAqUuUcMPMo/sBEavH9iyKmvxTc+uw9QGTwI=;
 b=eKELIS/eEIgkFeE/H+qjm0m1WDujVRprRXWesqbleSQvYopfKp9Q/DZHQ5GURzvY8LqObW
 Qc8VaQjGMSpV2dDw7t/OsYMft+HSgIBHX+140w7ir7VQkD5CHKydtY+NR3c+gQmuTK5PK8
 8Cz1FxW+HYL/R5vptsy7xOM90e2yk/M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-u3DkXH-OMsGWkVFBQ1E7Yg-1; Mon, 16 Oct 2023 05:05:57 -0400
X-MC-Unique: u3DkXH-OMsGWkVFBQ1E7Yg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079630993dso3145029e87.1
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 02:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447155; x=1698051955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqdAEgPPAqUuUcMPMo/sBEavH9iyKmvxTc+uw9QGTwI=;
 b=wl41tbJ/bO6MuAgZXndSZHmfbF6RBn9ntpMem/f4AR+JMvCeYwBdZzk32ISlO1inHp
 t50lU8hHQJ9soLRwTrY/wbFpGgqfuW/mjLfikdb2tcEoUFpaqxCvOMZvs0SwmTQtt10G
 XHTySkLdZghGVN08uhAyuwP091vSMSQgSUy/L0OPraiQAOQDmoBBLwpWcnQBsiiHFzEi
 zhhIXcsow6DMxLkUQY24LNcGgwWV/Fd9onmQ6An75oaTj3nZPnKwX/kIWytBNMeNb2V6
 WZSkoqZinV+XSjw4tAtzyCpTrav05URId8wE/69y8hChnjEnjuwqD1gtmb+pAO9RvDYt
 b0tQ==
X-Gm-Message-State: AOJu0Ywba6K6RZnrhl3nlI24RVlvub2Em/Xckcty8Nd97S6xqc0obnx8
 dzI1Wf1K2svfvE6q0RLRKm5tYvqccJJniCKD+GslWhAedOoZMYxtIboZ7106w+gtvjZBsVIYHbL
 g0LqAxOYdsx3swcg8+hrp7Pi6UdYjcvUPSZtmaw==
X-Received: by 2002:a05:6512:1154:b0:506:93a0:777a with SMTP id
 m20-20020a056512115400b0050693a0777amr21939488lfg.2.1697447154770; 
 Mon, 16 Oct 2023 02:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5PLpcIgvXsopuh40zvu3g8Y9IGVauq8htc9+T7cX8N1K1nicVRti0d9cfPZItVv20SXCuDdt8JKRIRJPOoYc=
X-Received: by 2002:a05:6512:1154:b0:506:93a0:777a with SMTP id
 m20-20020a056512115400b0050693a0777amr21939472lfg.2.1697447154364; Mon, 16
 Oct 2023 02:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz>
 <CAEemH2fQuqPhd+5wjiBeswJQOG=FikpKmL6eubdWgyWqehX6fw@mail.gmail.com>
In-Reply-To: <CAEemH2fQuqPhd+5wjiBeswJQOG=FikpKmL6eubdWgyWqehX6fw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 16 Oct 2023 17:05:42 +0800
Message-ID: <CAEemH2fjTMaGgHeCJiuGJg7BLT4KoCDjY7ZPod3P9xUQTJFW1g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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

T24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgODowOeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgUGV0ciwKPgo+IE9uIEZyaSwgT2N0IDEzLCAyMDIzIGF0IDM6NDji
gK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gU2lnbmVkLW9mZi1i
eTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4+IC0tLQo+PiAgZG9jL0MtVGVzdC1BUEku
YXNjaWlkb2MgICAgICAgICAgICAgIHwgIDUgKysrCj4+ICBkb2MvVGVzdC1Xcml0aW5nLUd1aWRl
bGluZXMuYXNjaWlkb2MgfCAgMSArCj4+ICBpbmNsdWRlL3RzdF90ZXN0LmggICAgICAgICAgICAg
ICAgICAgfCAgNSArKy0KPj4gIGxpYi90c3RfdGVzdC5jICAgICAgICAgICAgICAgICAgICAgICB8
IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gIDQgZmlsZXMgY2hhbmdlZCwgNjMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZG9jL0MtVGVz
dC1BUEkuYXNjaWlkb2MgYi9kb2MvQy1UZXN0LUFQSS5hc2NpaWRvYwo+PiBpbmRleCBkYWI4MTE1
NjQuLmYyYmEzMDJlMiAxMDA2NDQKPj4gLS0tIGEvZG9jL0MtVGVzdC1BUEkuYXNjaWlkb2MKPj4g
KysrIGIvZG9jL0MtVGVzdC1BUEkuYXNjaWlkb2MKPj4gQEAgLTE2MDksNiArMTYwOSwxMSBAQCBm
aXJzdCBtaXNzaW5nIGRyaXZlci4KPj4gIFRoZSBkZXRlY3Rpb24gaXMgYmFzZWQgb24gcmVhZGlu
ZyAnbW9kdWxlcy5kZXAnIGFuZCAnbW9kdWxlcy5idWlsdGluJwo+PiBmaWxlcwo+PiAgZ2VuZXJh
dGVkIGJ5IGttb2QuIFRoZSBjaGVjayBpcyBza2lwcGVkIG9uIEFuZHJvaWQuCj4+Cj4+ICtOVUxM
IHRlcm1pbmF0ZWQgYXJyYXkgJy5tb2Rwcm9iZScgb2Yga2VybmVsIG1vZHVsZSBuYW1lcyBhcmUg
dHJpZWQgdG8gYmUKPj4gbG9hZGVkCj4+ICt3aXRoICdtb2Rwcm9iZScgdW5sZXNzIHRoZXkgYXJl
IGJ1aWx0aW4gb3IgYWxyZWFkeSBsb2FkZWQuIFRlc3QgZXhpdHMKPj4gd2l0aAo+PiArJ1RDT05G
JyBvbiBmaXJzdCAnbW9kcHJvYmUnIG5vbi16ZXJvIGV4aXQuIER1cmluZyBjbGVhbnVwIGFyZSB0
aGUgbW9kdWxlcwo+PiArbG9hZGVkIGJ5IHRoZSB0ZXN0IHVubG9hZGVkIHdpdGggJ3JtbW9kJy4K
Pj4gKwo+PiAgMS4yNyBTYXZpbmcgJiByZXN0b3JpbmcgL3Byb2N8c3lzIHZhbHVlcwo+PiAgfn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZG9jL1Rlc3QtV3JpdGluZy1HdWlkZWxpbmVzLmFzY2lpZG9jCj4+IGIvZG9jL1Rlc3QtV3JpdGlu
Zy1HdWlkZWxpbmVzLmFzY2lpZG9jCj4+IGluZGV4IDBkYjg1MmFlNi4uMTk0ODc4MTZlIDEwMDY0
NAo+PiAtLS0gYS9kb2MvVGVzdC1Xcml0aW5nLUd1aWRlbGluZXMuYXNjaWlkb2MKPj4gKysrIGIv
ZG9jL1Rlc3QtV3JpdGluZy1HdWlkZWxpbmVzLmFzY2lpZG9jCj4+IEBAIC0zNzEsNiArMzcxLDcg
QEAKPj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9TaGVs
bC1UZXN0LUFQSVtTaGVsbCBUZXN0Cj4+IEFQSV0uCj4+ICB8ICcubWluX21lbV9hdmFpbCcgfCBu
b3QgYXBwbGljYWJsZQo+PiAgfCAnLm1udF9mbGFncycgfCAnVFNUX01OVF9QQVJBTVMnCj4+ICB8
ICcubWluX3N3YXBfYXZhaWwnIHwgbm90IGFwcGxpY2FibGUKPj4gK3wgJy5tb2Rwcm9iZScgfCDi
gJMKPj4gIHwgJy5tbnRwb2ludCcsICcubW50X2RhdGEnIHwgJ1RTVF9NTlRQT0lOVCcKPj4gIHwg
Jy5tb3VudF9kZXZpY2UnIHwgJ1RTVF9NT1VOVF9ERVZJQ0UnCj4+ICB8ICcubmVlZHNfY2dyb3Vw
X2N0cmxzJyB8IOKAkwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfdGVzdC5oIGIvaW5jbHVk
ZS90c3RfdGVzdC5oCj4+IGluZGV4IDc1YzIxMDliOS4uNmI0ZmFjOTg1IDEwMDY0NAo+PiAtLS0g
YS9pbmNsdWRlL3RzdF90ZXN0LmgKPj4gKysrIGIvaW5jbHVkZS90c3RfdGVzdC5oCj4+IEBAIC0y
OTcsOSArMjk3LDEyIEBAIHN0cnVjdCB0c3RfdGVzdCB7Cj4+ICAgICAgICAgLyogTlVMTCB0ZXJt
aW5hdGVkIGFycmF5IG9mIHJlc291cmNlIGZpbGUgbmFtZXMgKi8KPj4gICAgICAgICBjb25zdCBj
aGFyICpjb25zdCAqcmVzb3VyY2VfZmlsZXM7Cj4+Cj4+IC0gICAgICAgLyogTlVMTCB0ZXJtaW5h
dGVkIGFycmF5IG9mIG5lZWRlZCBrZXJuZWwgZHJpdmVycyAqLwo+PiArICAgICAgIC8qIE5VTEwg
dGVybWluYXRlZCBhcnJheSBvZiBuZWVkZWQga2VybmVsIGRyaXZlcnMgdG8gYmUgY2hlY2tlZCAq
Lwo+PiAgICAgICAgIGNvbnN0IGNoYXIgKiBjb25zdCAqbmVlZHNfZHJpdmVyczsKPj4KPj4gKyAg
ICAgICAvKiBOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2YgbmVlZGVkIGtlcm5lbCBkcml2ZXJzIHRv
IGJlIGxvYWRlZAo+PiB3aXRoIG1vZHByb2JlICovCj4+ICsgICAgICAgY29uc3QgY2hhciAqIGNv
bnN0ICptb2Rwcm9iZTsKPj4gKwo+PiAgICAgICAgIC8qCj4+ICAgICAgICAgICoge05VTEwsIE5V
TEx9IHRlcm1pbmF0ZWQgYXJyYXkgb2YgKC9wcm9jLCAvc3lzKSBmaWxlcyB0byBzYXZlCj4+ICAg
ICAgICAgICogYmVmb3JlIHNldHVwIGFuZCByZXN0b3JlIGFmdGVyIGNsZWFudXAKPj4gZGlmZiAt
LWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKPj4gaW5kZXggMDg3YzYyYTE2
Li5jY2JhYTRjMDIgMTAwNjQ0Cj4+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4+ICsrKyBiL2xpYi90
c3RfdGVzdC5jCj4+IEBAIC00OSw2ICs0OSw3IEBAIGNvbnN0IGNoYXIgKlRDSUQgX19hdHRyaWJ1
dGVfXygod2VhaykpOwo+PiAgI2RlZmluZSBDVkVfREJfVVJMICJodHRwczovL2N2ZS5taXRyZS5v
cmcvY2dpLWJpbi9jdmVuYW1lLmNnaT9uYW1lPUNWRS0iCj4+Cj4+ICAjZGVmaW5lIERFRkFVTFRf
VElNRU9VVCAzMAo+PiArI2RlZmluZSBNT0RVTEVTX01BWF9MRU4gMTAKPj4KPj4gIHN0cnVjdCB0
c3RfdGVzdCAqdHN0X3Rlc3Q7Cj4+Cj4+IEBAIC04Myw2ICs4NCw4IEBAIGNvbnN0IGNoYXIgKnRz
dF9pcGNfcGF0aCA9IGlwY19wYXRoOwo+Pgo+PiAgc3RhdGljIGNoYXIgc2htX3BhdGhbMTAyNF07
Cj4+Cj4+ICtzdGF0aWMgaW50IG1vZHVsZXNfbG9hZGVkW01PRFVMRVNfTUFYX0xFTl07Cj4+ICsK
Pj4gIGludCBUU1RfRVJSOwo+PiAgaW50IFRTVF9QQVNTOwo+PiAgbG9uZyBUU1RfUkVUOwo+PiBA
QCAtMTEzNSw2ICsxMTM4LDI5IEBAIHN0YXRpYyB2b2lkIGRvX2Nncm91cF9yZXF1aXJlcyh2b2lk
KQo+PiAgICAgICAgIHRzdF9jZ19pbml0KCk7Cj4+ICB9Cj4+Cj4+ICsvKgo+PiArICogU2VhcmNo
IGtlcm5lbCBkcml2ZXIgaW4gL3Byb2MvbW9kdWxlcy4KPj4gKyAqCj4+ICsgKiBAcGFyYW0gZHJp
dmVyIFRoZSBuYW1lIG9mIHRoZSBkcml2ZXIuCj4+ICsgKiBAcmV0dXJuIDEgaWYgZHJpdmVyIGlz
IGZvdW5kLCBvdGhlcndpc2UgMC4KPj4gKyAqLwo+PiArc3RhdGljIGludCBtb2R1bGVfbG9hZGVk
KGNvbnN0IGNoYXIgKmRyaXZlcikKPj4KPgo+Cj4gV2hhdCBhYm91dCByZW5hbWluZyBpdCBhcyB0
c3RfbW9kdWxlX2lzX2xvYWRlZCgpIGFuZCBtb3ZlIGludG8KPiB0c3Rfa2VybmVsLmg/Cj4gSSBn
dWVzcyB3ZSBjb3VsZCBtYWtlIHVzZSBvZiBpdCB3aWRlbHkgZm9yIGNoZWNraW5nIG1vZHVsZSBs
b2FkaW5nIG9yIG5vdC4KPgoKCnRzdF9tb2R1bGUuaCBzaG91bGQgYmUgYSBiZXR0ZXIgcGxhY2Us
IEkganVzdCBmaW5kIGl0IHdoZW4gcmVhZCBzb21lCmV4aXN0aW5nIExUUCBjYXNlcy4KCgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
