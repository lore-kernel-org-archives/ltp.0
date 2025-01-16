Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DE0C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 15:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 904AD3C7BFD
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 16:57:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A8143C7BFD
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 16:57:33 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3191560048F
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 16:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737043051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmYFL9RHRW2ECp7W6AuUdWn8L+ZzgTupfI5DFDsk0s0=;
 b=OvMdBo4/q8f3lru+TXyBDYnJgQeybO+y2+AhzjCzW1uetCzeQhPUg8k8E9w7esz9R9YCoW
 lCzAJCDCLIXUzjjM3kHZFFOYVNNfjKQ5ddUmG6LPMGzIA0cSazi/zlxQPDbssOdYbbBvsr
 D1fDR8sircsb1UQwiw9mCdDcskM6md8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-oqj0Hjw0Niiq-gKZGACMBA-1; Thu, 16 Jan 2025 10:57:29 -0500
X-MC-Unique: oqj0Hjw0Niiq-gKZGACMBA-1
X-Mimecast-MFC-AGG-ID: oqj0Hjw0Niiq-gKZGACMBA
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2a3c59f8c1cso666331fac.2
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 07:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043049; x=1737647849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YmYFL9RHRW2ECp7W6AuUdWn8L+ZzgTupfI5DFDsk0s0=;
 b=IMdtjMUrwaoK2t7KjMKWjODjXWJkG++FvHiraYaV5ksEp666CFwjBPw6ce5kGC63Ck
 gfVxnHcHkJno3F7GdkJbNffflZuZ9vywLK4zFQDBsG2V5976hCvzyYpZWbN6SUBlByiI
 jD0iY0cReRYA+9fwP3+t3uSgpk5+y8JkAhAZzl8lA1Ka2rYz0ZI8uxdgN/Nlw7888C8g
 g6qKeyF8cVHZem1sB/Zha716v+973LRyPqSH5BKTy1cwBtDkUzIOOJi1ykUDxB9oImzR
 9BNLSEFzlG484OEtw+WVTO3cr4mGsYJOUSiiOWqh5nYApVhTXzS8SRNinkGJEnvfJyzD
 dHuA==
X-Gm-Message-State: AOJu0YzhBY8TJdXY+D05mpZUNZHarGD1tSn6GIKTikt6WI7TDcgWHaYd
 jERqS3Kk1fshCXYtelVIp6qaMjz27AexkUjRP7rU3JGe9sNDHvNUAtpdpZD6CpiNYTKIkf3LECH
 Friw+ZWY/XHpRPxCNplkb5xybSlro/j/iypGr6k7jD7YVBOSdNBskrRCtRpVYF2cOhDe/oy4l/c
 GAozh4aIxBgTMvTwpSdvdpQk0WYjYxEMw=
X-Gm-Gg: ASbGncupG6+eiiUPrF+QFoVDDzNa76pcIVT3eb0oL86Ek6yG5XDmZ2J9sRpPrI2MMX5
 eoCEU6TGFjIHDq32ioPMfwhu51rCTzLJuDyO+Dw==
X-Received: by 2002:a05:6871:418e:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2aa069e2f99mr19117751fac.36.1737043048951; 
 Thu, 16 Jan 2025 07:57:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzj/KI4BOTW6kOKbiK7TJX0Dh5n2Dt4DPsdLYFMnMm7LbDoRsqiTOTL24CTkIl70voqu0RHWqIIVZNtiKkgS4=
X-Received: by 2002:a05:6871:418e:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2aa069e2f99mr19117746fac.36.1737043048686; Thu, 16 Jan 2025
 07:57:28 -0800 (PST)
MIME-Version: 1.0
References: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
 <Z4kqqIQlgj4QF21X@yuki.lan>
In-Reply-To: <Z4kqqIQlgj4QF21X@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 16 Jan 2025 16:57:12 +0100
X-Gm-Features: AbW1kvY-rCROmL1GYWdihPy2AAC6RDso_3g77liZX70UAa_WFMxr5EyhQvyTkI4
Message-ID: <CAASaF6y6_j=fy3XQ-a14t6dm3f9RD0O1bCqiWrDptVw0q3CWAA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tMk5uutCHvZbcLSWhx1fCXvk-iHvrTDLUpVS-Dkbdjs_1737043049
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgNDo1MOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gSW4gY2FzZXMgd2hlcmUgd29ya2VyIGNvbXBsZXRl
cyBzcGVjaWZpZWQgbnVtYmVyIG9mIGBpdGVyYXRpb25zYCBiZWZvcmUKPiA+IG9wZXIgY29tcGxl
dGVzIGFsbCBgdG90YWxfaW9zYCwgc3VjaCBvcGVyIHJlbWFpbnMgb24gYWN0aXZlX2xpc3QuCj4g
PiBUaGlzIGlzIGEgcHJvYmxlbSBiZWNhdXNlIGNsZWFudXAgb25seSB3YWxrcyBvdmVyIGZpbmlz
aGVkIGxpc3QsCj4gPiBhbmQgY2xvc2VzIGZkcyBvbmx5IGZvciBpdGVtcyBvbiB0aGlzIGxpc3Qu
IFNvIGl0J3MgcG9zc2libGUgZm9yCj4gPiB0ZXN0IHRvIGV4aGF1c3QgdWxpbWl0IGZvciBvcGVu
IGZpbGVzIGFuZCBmYWlsOgo+ID4KPiA+ICQgLi9haW8tc3RyZXNzIC1hMSAtSTEwMCAtbzIgLXI0
IC1mMSAtZDFeCj4gPiBhaW8tc3RyZXNzLmM6MTM0NzogVFBBU1M6IFRlc3QgcGFzc2VkCj4gPiBh
aW8tc3RyZXNzLmM6MTI4NTogVElORk86IHN0YXJ0aW5nIHdpdGggcmFuZG9tIHdyaXRlCj4gPiBh
aW8tc3RyZXNzLmM6MTI5NjogVElORk86IGZpbGUgc2l6ZSAxMDI0TUIsIHJlY29yZCBzaXplIDBL
QiwgZGVwdGggMSwgSS9PIHBlciBpdGVyYXRpb24gMQo+ID4gYWlvLXN0cmVzcy5jOjEyOTg6IFRJ
TkZPOiBtYXggaW9fc3VibWl0IDEsIGJ1ZmZlciBhbGlnbm1lbnQgc2V0IHRvIDRLQgo+ID4gYWlv
LXN0cmVzcy5jOjEzMDA6IFRJTkZPOiB0aHJlYWRzIDEgZmlsZXMgMSBjb250ZXh0cyAxIGNvbnRl
eHQgb2Zmc2V0IDJNQiB2ZXJpZmljYXRpb24gb2ZmCj4gPiBhaW8tc3RyZXNzLmM6MTMxNDogVEJS
T0s6IG9wZW4oZmlsZTAuYmluLDEwNTI3MzgsMDYwMCkgZmFpbGVkOiBFTUZJTEUgKDI0KQo+Cj4g
TG9va3MgbGlrZSB0aGUgdGVzdCBoYXMgbWFueSBvcHRpb25zIGFuZCBzb21lIGNvbWJpbmF0aW9u
cyBtYXkgc2V0Cj4gdGhpbmdzIGluIGEgd2F5IHRoYXQgZG9lcyBub3QgbWFrZSBtdWNoIHNlbnNl
LgoKSSB0aGluayB0aGUgb3B0aW9ucyBJIHNhdyBpbiBmYWlsdXJlcyB3ZXJlIGRlZmF1bHRzLCB0
aGUgIi1hMSIgYWJvdmUgSQphZGRlZCB0byByZXByb2R1Y2UgaXQgZmFzdGVyLgoKPgo+ID4gQ2xl
YW4vZnJlZSBhbHNvIGl0ZW1zIGZyb20gYWN0aXZlX2xpc3QuIEFsc28gZG9uJ3QgbGV0IGBzdGF0
dXNgIGZyb20gY2xlYW51cAo+ID4gYmUgc2V0IHRvIHplcm8gb25jZSBpdCBiZWNvbWVzIG5vbi16
ZXJvLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQu
Y29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpby1zdHJl
c3MuYyB8IDcgKysrKysrLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAt
YWlvZGlvL2Fpby1zdHJlc3MuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW8t
c3RyZXNzLmMKPiA+IGluZGV4IDQxOWZjMmNkMjVhNC4uZTg0MzA4ZDFkMGU4IDEwMDY0NAo+ID4g
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpby1zdHJlc3MuYwo+ID4gKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Fpby1zdHJlc3MuYwo+ID4gQEAgLTEx
MjIsNyArMTEyMiwxMiBAQCByZXN0YXJ0Ogo+ID4gICAgICAgd2hpbGUgKHQtPmZpbmlzaGVkX29w
ZXJzKSB7Cj4gPiAgICAgICAgICAgICAgIG9wZXIgPSB0LT5maW5pc2hlZF9vcGVyczsKPiA+ICAg
ICAgICAgICAgICAgb3Blcl9saXN0X2RlbChvcGVyLCAmdC0+ZmluaXNoZWRfb3BlcnMpOwo+ID4g
LSAgICAgICAgICAgICBzdGF0dXMgPSBmaW5pc2hfb3Blcih0LCBvcGVyKTsKPiA+ICsgICAgICAg
ICAgICAgc3RhdHVzID0gZmluaXNoX29wZXIodCwgb3BlcikgPyA6IHN0YXR1czsKPiA+ICsgICAg
IH0KPiA+ICsgICAgIHdoaWxlICh0LT5hY3RpdmVfb3BlcnMpIHsKPiA+ICsgICAgICAgICAgICAg
b3BlciA9IHQtPmFjdGl2ZV9vcGVyczsKPiA+ICsgICAgICAgICAgICAgb3Blcl9saXN0X2RlbChv
cGVyLCAmdC0+YWN0aXZlX29wZXJzKTsKPiA+ICsgICAgICAgICAgICAgc3RhdHVzID0gZmluaXNo
X29wZXIodCwgb3BlcikgPyA6IHN0YXR1czsKPiA+ICAgICAgIH0KPgo+Cj4gSSBndWVzcyB0aGF0
IHRoaXMgd29ya3MgYXMgYSBtaW5pbWFsIGZpeC4KPgo+IFJldmlld2VkLWJ5OiBDeXJpbCBIcnVi
aXMgPGNocnViaXNAc3VzZS5jej4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNl
LmN6Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
