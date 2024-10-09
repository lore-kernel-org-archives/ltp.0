Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C387BCED632
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 09:10:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 167D13C269C
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 11:10:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC1893C1BDB
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:10:37 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8527D603A24
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 11:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728465034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgNifI3nKMkDaBsxtmXBuT5/ctIwxiNucWjjGGz84SY=;
 b=hG5MOVbcHqyPZ0pF3jLYR2HovMR2I0ngI2HBwfpYIZ6Pa89xx1fKHCzjFcBGBpWHFWYSTU
 50WEyRhFjXdvxi73Tx3dtGwn8OSJIvhuyzBFsfnb3U3R9jB91KUDaoBCOtoN1aKeZi0eZ3
 QwsoYSCZ21WsuFtW3xiow8LIq9U+bRg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-XLvCrZmXPS2uzZnKIxOFDQ-1; Wed, 09 Oct 2024 05:10:33 -0400
X-MC-Unique: XLvCrZmXPS2uzZnKIxOFDQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e3a993fbc7so5522050b6e.2
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 02:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465032; x=1729069832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgNifI3nKMkDaBsxtmXBuT5/ctIwxiNucWjjGGz84SY=;
 b=CIXI4BnS2I0Fto+gOPyDDePtZXWYysvvDRDulrinVO9XR0hwJRHyKG0MiwWazctGxP
 XP8uY1H0VgSagM5uz9axHyAydg7vDAf0qxzZhqFT+KbHRAjE2SZr50CRk+UmQk71ANJV
 YNPzhSsALrdc3faW4kJb+TMysNLPCJXP3leapJKhWUQRyquWse0pmwB5sMbKdACkyG49
 wmotZ6FspM5ysE8YtJ1K7xIN11ih009Ko2vulTq4DArcuBM6T9EPxWUH3LsQxLQu1YXd
 McLxDdc1GKQZaskFi7OVepfiUM8lcyy7Lo+Cous41mK6V+HaDs/nLExuZ3h+/gIKcHhV
 X2uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmEGEmLHoOOQUp6hNwvhfh4epigVknuEzSikTOrt3HPIumcwq7+CWbSa4OcRde++bkxb8=@lists.linux.it
X-Gm-Message-State: AOJu0YyaXGc/tBnvmMqny4kZU/+hamYZ+nsBpf8G7rnUC5huqxc7kMgo
 7/P73o9bVG5ESwNrZvmzSN23AIpawRjE+hIUVBhY4sdu/iUl9+73dWh4e0t5wiWDZN5tHbkr7ub
 nC6b7rUVUYtYX9CihcGiq1e8ebcY8HnyG2IBY7PT7wmJGY++M794irW7Yc8powEd+P4n92/0jka
 M7NUKHhgcrpeSrvpFUBmVdyVE=
X-Received: by 2002:a05:6808:180c:b0:3e2:8754:f017 with SMTP id
 5614622812f47-3e3e66bd035mr1086892b6e.11.1728465032518; 
 Wed, 09 Oct 2024 02:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpyi7OW14UwMG8IHZdosgX9Z0Mr/oq5lXeioxCdFBviv3NktyebsiV/QHLlg62QomsxaIIt02FfHu8RKFVcWg=
X-Received: by 2002:a05:6808:180c:b0:3e2:8754:f017 with SMTP id
 5614622812f47-3e3e66bd035mr1086879b6e.11.1728465032105; Wed, 09 Oct 2024
 02:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240930-generate_syscalls-v3-0-e56ede4bc7f5@suse.com>
 <20240930-generate_syscalls-v3-2-e56ede4bc7f5@suse.com>
 <CAASaF6zQNop70BfkZoSOjXmDPQ=+uiP++D1z3TaG1_yy7_-eBg@mail.gmail.com>
 <687dfd38-6f1f-4646-9f4e-5c6056cca2d6@suse.com>
In-Reply-To: <687dfd38-6f1f-4646-9f4e-5c6056cca2d6@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2024 11:10:09 +0200
Message-ID: <CAASaF6xebiCEiEqi0UeDDJE4bcB2NfQ4PUiOBYdj1Bf4LJKuDw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add script to generate arch(s) dependant
 syscalls
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

T24gV2VkLCBPY3QgOSwgMjAyNCBhdCAxMDo0MeKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGksCj4KPiBPbiAxMC8zLzI0IDE1OjU4
LCBKYW4gU3RhbmNlayB3cm90ZToKPiA+IE9uIE1vbiwgU2VwIDMwLCAyMDI0IGF0IDk6MjLigK9Q
TSBBbmRyZWEgQ2VydmVzYXRvCj4gPiA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmRlPiB3cm90ZToK
PiA+PiBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+
ID4+Cj4gPj4gQWRkIGdlbmVyYXRlX2FyY2guc2ggc2NyaXB0IHdoaWNoIGNhbiBiZSB1c2VkIHRv
IGdlbmVyYXRlIGFyY2gocykKPiA+PiBkZXBlbmRhbnQgc3lzY2FsbHMgZmlsZS4gVGhlIHdheSBp
dCB3b3JrcyBpcyBwcmV0dHkgc2ltcGxlOiBmb3IgZWFjaAo+ID4+IGFyY2hpdGVjdHVyZSBkZWZp
bmVkIGludG8gc3VwcG9ydGVkLWFyY2gudHh0LCBjb21waWxlIGtlcm5lbCBoZWFkZXJzLAo+ID4+
IGV4dHJhY3QgdGhlIGxpc3Qgb2Ygc3lzY2FsbHMgYW5kIGdlbmVyYXRlIGEgLmluIGZpbGUgY29u
dGFpbmluZyBhbGwgb2YKPiA+PiB0aGVtLCBhc3NvY2lhdGVkIHdpdGggdGhlaXIgb3duIHN5c2Nh
bGwncyBudW1iZXIuCj4gPj4gVGhlIHdheSBzeXNjYWxscyBmaWxlcyBhcmUgZ2VuZXJhdGVkLCBw
YXNzZXMgdGhyb3VnaCBhIEMgYXBwbGljYXRpb24KPiA+PiB3aGljaCBpcyBhdXRvbWF0aWNhbGx5
IGNoZWNraW5nIHRoZSBhdmFpbGFiaWxpdHkgb2YgdGhlIHN5c2NhbGxzIGluCj4gPj4gdGhlIHVz
ZXIgc3BhY2UgZW52aXJvbm1lbnQuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2Vy
dmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+ID4+IC0tLQo+ID4+ICAgaW5jbHVk
ZS9sYXBpL3N5c2NhbGxzL3thYXJjaDY0LmluID0+IGFybTY0LmlufSAgICAgfCAgIDAKPiA+PiAg
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy9ibGFja2xpc3Qtc3lzY2FsbHMudHh0ICAgICAgIHwgICA2
ICsKPiA+PiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9nZW5lcmF0ZV9hcmNoLnNoICAgICAgICAg
ICAgIHwgMjEwICsrKysrKysrKysrKysrKysrKysrKwo+ID4+ICAgaW5jbHVkZS9sYXBpL3N5c2Nh
bGxzL2dlbmVyYXRlX3N5c2NhbGxzLnNoICAgICAgICAgfCAgIDkgKy0KPiA+PiAgIC4uLi9sYXBp
L3N5c2NhbGxzL3tsb29uZ2FyY2guaW4gPT4gbG9vbmdhcmNoNjQuaW59IHwgICAwCj4gPj4gICBp
bmNsdWRlL2xhcGkvc3lzY2FsbHMve21pcHNfbjY0LmluID0+IG1pcHM2NC5pbn0gICB8ICAgMAo+
ID4+ICAgLi4uL2xhcGkvc3lzY2FsbHMve21pcHNfbjMyLmluID0+IG1pcHM2NG4zMi5pbn0gICAg
fCAgIDAKPiA+PiAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy97bWlwc19vMzIuaW4gPT4gbWlwc28z
Mi5pbn0gIHwgICAwCj4gPj4gICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMve2hwcGEuaW4gPT4gcGFy
aXNjLmlufSAgICAgICB8ICAgMAo+ID4+ICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3N1cHBvcnRl
ZC1hcmNoLnR4dCAgICAgICAgICAgfCAgMTIgKy0KPiA+PiAgIDEwIGZpbGVzIGNoYW5nZWQsIDIy
OCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGFwaS9zeXNjYWxscy9hYXJjaDY0LmluIGIvaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2Fy
bTY0LmluCj4gPj4gc2ltaWxhcml0eSBpbmRleCAxMDAlCj4gPj4gcmVuYW1lIGZyb20gaW5jbHVk
ZS9sYXBpL3N5c2NhbGxzL2FhcmNoNjQuaW4KPiA+PiByZW5hbWUgdG8gaW5jbHVkZS9sYXBpL3N5
c2NhbGxzL2FybTY0LmluCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9zeXNjYWxscy9i
bGFja2xpc3Qtc3lzY2FsbHMudHh0IGIvaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2JsYWNrbGlzdC1z
eXNjYWxscy50eHQKPiA+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4+IGluZGV4IDAwMDAwMDAw
MC4uZTFhZTVmNzZmCj4gPj4gLS0tIC9kZXYvbnVsbAo+ID4+ICsrKyBiL2luY2x1ZGUvbGFwaS9z
eXNjYWxscy9ibGFja2xpc3Qtc3lzY2FsbHMudHh0Cj4gPj4gQEAgLTAsMCArMSw2IEBACj4gPj4g
K2FyY2hfc3BlY2lmaWNfc3lzY2FsbAo+ID4+ICthdmFpbGFibGUKPiA+PiArbmlfc3lzY2FsbAo+
ID4gT3ZlcmFsbCBJIGxpa2UgdjMsIGl0IGFwcGVhcnMgdG8gY29ycmVjdCBtYW55IG1pc3Rha2Vz
IHdlIG1hZGUgbWFudWFsbHkuCj4gPgo+ID4gQnV0IEknbSBub3Qgc3VyZSB3ZSB3YW50IHRvIGJs
YWNrbGlzdCAibmlfc3lzY2FsbCIgZW50cmllcy4KPiA+IEl0J3Mgc3RpbGwgYSB2YWxpZCBzeXNj
YWxsIG51bWJlciwgYW5kIHRoZSBkZWZpbmUgaXMgc3RpbGwgcHJvdmlkZWQgaW4KPiA+IGtlcm5l
bCBoZWFkZXJzLgo+ID4KPiA+IElmIHdlIGhhdmUgYSB0ZXN0IGZvciBzeXNjYWxsLCB0aGF0IHVw
c3RyZWFtIGRlcHJlY2F0ZXMsIHRoZSB0ZXN0IHdvdWxkIGJlY29tZQo+ID4gdW5idWlsZGFibGUg
YWZ0ZXIgd2UgdXBkYXRlIHN5c2NhbGxzIHdpdGggdGhpcyBzY3JpcHQgKHdoaWNoIGRyb3BzIHRo
ZSBkZWZpbmUpLgo+ID4KPiA+IFJlZ2FyZHMsCj4gPiBKYW4KPiA+Cj4gVGhpcyBpcyBhIGdvb2Qg
cG9pbnQuIFNvIHlvdXIgc3VnZ2VzdGlvbiBpcyB0byBrZWVwIGFsbCBzeXNjYWxscyBkZWZpbmVk
Cj4gaW4gYmxhY2tsaXN0LXN5c2NhbGxzLnR4dCBhdmFpbGFibGUgYW55d2F5LCBvciBqdXN0IHRo
ZSBuaV9zeXNjYWxsCj4gZGVmaW5pdGlvbj8gQXQgdGhpcyBwb2ludCBJIHdvdWxkIGp1c3QgZHJv
cCB0aGUgYmxhY2tsaXN0LXN5c2NhbGxzLnR4dAo+IGZpbGUgYW5kIGtlZXAgYWxsIGRlZmluZWQg
c3lzY2FsbHMgZm9yIHRoZSBMVFAgc3lzY2FsbHMgYmFja29ydHMuCgpTb3VuZHMgZ29vZCwgd2Ug
Y2FuIGRyb3AgdGhlIGJsYWNrbGlzdC4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
