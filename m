Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D78EB64DA
	for <ltp@archiver.kernel.org>; Fri, 23 Jun 2023 01:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9CF83CD997
	for <ltp@archiver.kernel.org>; Fri, 23 Jun 2023 03:34:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C61183CC3FA
 for <ltp@lists.linux.it>; Fri, 23 Jun 2023 03:34:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E34AD1A00359
 for <ltp@lists.linux.it>; Fri, 23 Jun 2023 03:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687484083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NXWS8j+LulzH9lCHwHmXKf+DD485HRiW4u0AePdfyB4=;
 b=HOLbceqWG4cl4MVE9nWF3IFwMM8TZpJIvAms/TEBTQvZ2FVIB7KxEBHMIrHn8cR5zgjL0m
 7v7bvAJpTZF6vSjqjhn6Mx3zrbx4ap/AK5MBmK/dNCNzkMrFbui3gQKiSzhukyyPoprgF/
 fllfCGPXHsDu8LC3DlacOFfbST8Fpc4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-39Z56A0DMyy0EtP5sEYmsA-1; Thu, 22 Jun 2023 21:34:39 -0400
X-MC-Unique: 39Z56A0DMyy0EtP5sEYmsA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b46d3eb01fso1225511fa.2
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 18:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687484078; x=1690076078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXWS8j+LulzH9lCHwHmXKf+DD485HRiW4u0AePdfyB4=;
 b=D/s5VY/lqtm7J7d/TO3nGQ+n8OW4IXuKov5OpgJVrmObU2P7djnkTGKV72k1kYRstd
 aE+Z9vUBpEQJq7QGA+D+YlFaI8xUoIskQHbx8rj8wMJu52isTIK6lfHQK72Xpi89hQHT
 m248kyymE/8KNCtmh1P2kiOz/R+w0cMUSQM869cxBIM4E6Wid8jRvItIjakfooR003p+
 iIYEpksVzcdsUJQmdzJCqJlO0xyVALWAm+ZMz6uCzpqQmmDiIGBm6xNWM5Qs8uo5FEah
 GLHOm9oMy21sYF1yUXvA+9o2RteUZkTaeKuWThhN/F1IZR7qxZnneca9oN7/HVMPUV1c
 DN+A==
X-Gm-Message-State: AC+VfDxtgElJkWrwfjlgHeIamefVRE+nGObUOIbiXSkooes91eaNZVMV
 qmWL8aaJXy/ptPn3wVqBltVsjTT2fYi2LINyCspieFqXzboqDn3ERW3XnehocbjBpREmT7nVjUR
 h3KMkGQ4dQVnHpWjyATJ5Su5d5pI=
X-Received: by 2002:a2e:87cd:0:b0:2b5:9b3b:f7e5 with SMTP id
 v13-20020a2e87cd000000b002b59b3bf7e5mr66425ljj.42.1687484078417; 
 Thu, 22 Jun 2023 18:34:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Z1bQkeJuodHWv4qJQjznfx/q/WkCG5aPmZ12wFMJUJvf9qSDMt3AvNVqGZ0BpxDzsL/vELdDXmObw+q6qhvM=
X-Received: by 2002:a2e:87cd:0:b0:2b5:9b3b:f7e5 with SMTP id
 v13-20020a2e87cd000000b002b59b3bf7e5mr66419ljj.42.1687484078061; Thu, 22 Jun
 2023 18:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230601105127.55155-1-liwang@redhat.com>
 <20230621083506.GC361973@pevik>
 <CAEemH2dQwL10cg3M8Pe3e=Q6X8nmVKtkpSZdv7X6ZFh4gFUNgQ@mail.gmail.com>
 <20230622100559.GC482307@pevik>
In-Reply-To: <20230622100559.GC482307@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Jun 2023 09:34:25 +0800
Message-ID: <CAEemH2f5i5NhuCT3DFUNEK3h4giedMg0pQGa5vSga6GB8eiCaA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mem: make use of save_restore to simplify code
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

T24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgNjowNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiAuLi4KPiA+ID4gQWxzbyB0aGlyZCBwYXJhbWV0ZXIg
b2Ygc2V0X3N5c190dW5lKCkgKGNoZWNrKSBpcyAwLgo+Cj4KPiA+IFRoZSBjaGVja3MgaW5zaWRl
IHNldF9zeXNfdHVlbigpIGNhbiBOT1QgZ3VhcmFudGVlIHRoZQo+ID4gIm92ZXJjb21taXRfbWVt
b3J5IiBrbm9iIGlzIGV4aXN0IG9yIG5vdCwgaXQgb25seSBleGFtaW5lcyBpZiB0aGUKPiA+IHZh
bHVlIHdhcyBiZWluZyBzZXQgY29ycmVjdGx5LCBiZWNhdXNlIHNldF9zeXNfdHVuZSBoYXMgZmly
c3QgdXNlCj4gPiBTQUZFX0ZJTEVfUFJJTlRGIHdoaWNoIHdpbGwgVEJST0sgZGlyZWN0bHkgd2hl
biB0aGUga25vYiBub24tZXhpc3QuCj4KPiBBaCwgdGhhbmtzIGZvciBjb3JyZWN0aW5nIG1lLgo+
Cj4KPiA+ID4gPiAtICAgICBpZiAob2xkX292ZXJjb21taXRfcmF0aW8gIT0gLTEpCj4gPiA+ID4g
LSAgICAgICAgICAgICBzZXRfc3lzX3R1bmUoIm92ZXJjb21taXRfcmF0aW8iLCBvbGRfb3ZlcmNv
bW1pdF9yYXRpbywKPiAwKTsKPiA+ID4gPiAtfQo+ID4gPiA+IC0KPiA+ID4gPiAgc3RhdGljIHZv
aWQgb3ZlcmNvbW1pdF9tZW1vcnlfdGVzdCh2b2lkKQo+ID4gPiA+ICB7Cj4KPiA+ID4gPiBAQCAt
MjY5LDYgKzI1NSwxMCBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gPiA+ID4g
ICAgICAgICAgICAgICB7fQo+ID4gPiA+ICAgICAgIH0sCj4gPiA+ID4gICAgICAgLnNldHVwID0g
c2V0dXAsCj4gPiA+ID4gLSAgICAgLmNsZWFudXAgPSBjbGVhbnVwLAo+ID4gPiA+ICAgICAgIC50
ZXN0X2FsbCA9IG92ZXJjb21taXRfbWVtb3J5X3Rlc3QsCj4gPiA+ID4gKyAgICAgLnNhdmVfcmVz
dG9yZSA9IChjb25zdCBzdHJ1Y3QgdHN0X3BhdGhfdmFsW10pIHsKPiA+ID4gPiArICAgICAgICAg
ICAgIHsiL3Byb2Mvc3lzL3ZtL292ZXJjb21taXRfbWVtb3J5IiwgTlVMTCwgVFNUX1NSX1RCUk9L
fSwKPiA+ID4gPiArICAgICAgICAgICAgIHsiL3Byb2Mvc3lzL3ZtL292ZXJjb21taXRfcmF0aW8i
LCBOVUxMLCBUU1RfU1JfVEJST0t9LAo+ID4gPiA9PiBzaG91bGRuJ3QgYmUgaGVyZSBUU1RfU1Jf
VENPTkYgaW5zdGVhZCBvZiBUU1RfU1JfVEJST0s/Cj4KPgo+ID4gSXQgZG9lc24ndCBtYXR0ZXIs
IEkgaW5kZWVkIGNvbnNpZGVyIHRoaXMgYmVmb3JlLCBidXQgYWZ0ZXIgbG9va2luZwo+ID4gdGhy
b3VnaCB0aGUgcmVzdCBtbSB0ZXN0cyB0aGV5IGFsbCB1c2UgdGhlIGZ1bmN0aW9uIGdldHxzZXRf
c3lzX3R1bmUoKQo+ID4gd2hpY2ggY2hlY2tzIHRoZSBrbm9iIG1hbmRhdG9yaWx5IGFuZCBydW4g
c21vb3RobHkgZm9yIHBhc3QKPiA+IG1hbnkgeWVhcnMgYW5kIG5vYm9keSBldmVyIGNvbXBsYWlu
cyBhYm91dCB0aGF0Lgo+Cj4gKzEKPgo+ID4gU28gSSB0aGluayBpdCdzIHNhZmUgdG8gY29udmVy
dCB0aGlzIG9uZSB1c2luZyBUQlJPSyB0b28sIGl0IGVzc2VudGlhbGx5Cj4gPiBoYXMgbm8gZGlm
ZmVyZW5jZSBmcm9tIG90aGVyIG9vbS10ZXN0cy4gJ292ZXJjb21taXRfcmF0aW8nIGFuZAo+ID4g
J292ZXJjb21taXRfbWVtb3J5JyBhcmUgcXVpdGUgYmFzaWMgb24gTGludXggZGlzdHJpYnV0aW9u
Lgo+Cj4gKzEKPiA9PiBnbyBhaGVhZCBhbmQgbWVyZ2UuCj4KCgpCb3RoIHB1c2hlZCwgdGhhbmsg
eW91IQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
