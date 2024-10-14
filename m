Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4312DD1625C
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 12:45:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E993C6609
	for <ltp@archiver.kernel.org>; Mon, 14 Oct 2024 14:45:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4115C3C6577
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 14:45:37 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A355A144731E
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 14:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728909934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jOa0d/mFGS1zn90oc6Nko0edTYcgOekH1fw8pS8VvI=;
 b=I525nHRxYjzqPq60UgnlYa6h5BJueYHmYQkkiwJMbQ9MnGyKNmvvG39FSz0eHmVqU7fihA
 jh/Y/f7Ch4PAOYGRDwmKQpb2GvTaPAGI7mZDyxVC8E2wLBXhAXdn6IQgfte39bctKly0yR
 92i+f1Nb11OVN/k1oXdvW1qi6W4RvEg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-btk0qaglNxycrxweQtGkJQ-1; Mon, 14 Oct 2024 08:45:33 -0400
X-MC-Unique: btk0qaglNxycrxweQtGkJQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2070e327014so40433455ad.1
 for <ltp@lists.linux.it>; Mon, 14 Oct 2024 05:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728909932; x=1729514732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jOa0d/mFGS1zn90oc6Nko0edTYcgOekH1fw8pS8VvI=;
 b=MP/UP5H8ykcySeR3fpAB/jYb2pIhpk256uW/f7655Vkvi7g8tQuolrmKTRi9sv6kPc
 9P1vfJmhvszyJazZp6yG0j8RmDbolt6/ee3nwx7bg/U1yobXTRK/mAG7eC77SRfC3YAh
 N7QVdOD0SbnehZiAE9Q9WbrSeXBjFbQN1XlU2cBu9U3IEXGxKl34o48BODDUHSFlC9Ix
 1ZMDsahRbR5VLSskTtKji4piAr3bwWo2dZlgHbw0LwR7k0JyXebr3tAYfd2ASC37AGZ8
 TgnKrDCjxw40UTzZ1WIDK5l2vrr0lMKtD1wp/JY919OBGHeOlvCrXHyG0CCSNnCs8B/w
 gygA==
X-Gm-Message-State: AOJu0YyaoXRwJvrmt/5dY48TN4r+bmvEMX+3SedpXaloB0F6PtgmglbY
 yIAU7iExtCm8/vH/2uLl6IV0AcHP3WDzVmsUwg1n6RJ53SoM/qQHGHT/AHzHM5BNpWNKklEjaDe
 LN4W5pTqH33eZnfeEcc1nxN0wvBAieFNZljs1i8GWr49bChsctDYzTR53gBJ7jZhUpAX8PSwpqa
 /qsAgDdzBhK0bQGzqnbufEZwk=
X-Received: by 2002:a05:6a20:d045:b0:1cf:6953:2889 with SMTP id
 adf61e73a8af0-1d8bcf0fe6emr16709458637.16.1728909931935; 
 Mon, 14 Oct 2024 05:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGw2ukxOUySfz3A8uuhQeSi4Y+BquYs6BaZc0M1ianKwTNfosye8rL93mxYY0dJSAVWkgjY62+XWXdb56OFYg=
X-Received: by 2002:a05:6a20:d045:b0:1cf:6953:2889 with SMTP id
 adf61e73a8af0-1d8bcf0fe6emr16709429637.16.1728909931502; Mon, 14 Oct 2024
 05:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-1-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-1-5328a785bbad@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Oct 2024 20:45:19 +0800
Message-ID: <CAEemH2eP5T3MKpoZXhKQy3Wq73ADWB1Zx=0WRr6z2fLObrhhLA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/4] Refactor regen.sh script to generate
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

T24gV2VkLCBPY3QgOSwgMjAyNCBhdCA1OjQ14oCvUE0gQW5kcmVhIENlcnZlc2F0byA8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmRlPgp3cm90ZToKCj4gRnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+IFJlbmFtZSByZWdlbi5zaCBpbnRvIGEgbW9yZSBt
ZWFuaW5nZnVsIGdlbmVyYXRlX3N5c2NhbGxzLnNoIG5hbWUsIHJlbmFtZQo+IG9yZGVyIGludG8g
YSBtb3JlIG1lYW5pbmdmdWwgc3VwcG9ydGVkLXN5c2NhbGxzLnR4dCBuYW1lIGFuZCByZXdyaXRl
Cj4gcGFydCBvZiB0aGUgcmVnZW4uc2ggc2NyaXB0IGNvZGUgaW4gb3JkZXIgdG8gZXhlY3V0ZSBp
dCBmcm9tIGFueXdoZXJlIGluCj4gdGhlIGZpbGVzeXN0ZW0sIHdpdGhvdXQgbmVlZCB0byBiZSBp
biBpdHMgb3duIGZvbGRlci4gVGhlIG5ldyBjb2RlIGlzCj4gYWxzbyBtb3JlIGNsZWFyIGFuZCBj
b25jaXNlLCB1c2luZyBuYXRpdmUgc2ggZmVhdHVyZXMgd2hpY2ggYXJlCj4gc2ltcGxpZnlpbmcg
dGhlIGNvZGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICBjb25maWd1cmUuYWMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQo+ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvZ2Vu
ZXJhdGVfc3lzY2FsbHMuc2ggICAgICAgICB8IDExNQo+ICsrKysrKysrKysrKysrKysrKwo+ICBp
bmNsdWRlL2xhcGkvc3lzY2FsbHMvcmVnZW4uc2ggICAgICAgICAgICAgICAgICAgICB8IDEyOQo+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAuLi4vbGFwaS9zeXNjYWxscy97b3JkZXIgPT4gc3Vw
cG9ydGVkLWFyY2gudHh0fSAgICB8ICAgMAo+ICA0IGZpbGVzIGNoYW5nZWQsIDExNiBpbnNlcnRp
b25zKCspLCAxMzAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIv
Y29uZmlndXJlLmFjCj4gaW5kZXggZWJiZjQ5ZTI4Li40NWY5MjQ3N2YgMTAwNjQ0Cj4gLS0tIGEv
Y29uZmlndXJlLmFjCj4gKysrIGIvY29uZmlndXJlLmFjCj4gQEAgLTM4NCw3ICszODQsNyBAQCBl
bHNlCj4gICAgICBBQ19TVUJTVChbV0lUSF9SRUFMVElNRV9URVNUU1VJVEVdLFsibm8iXSkKPiAg
ZmkKPgo+IC1BQ19DT05GSUdfQ09NTUFORFMoW3N5c2NhbGxzLmhdLCBbY2QKPiAke2FjX3RvcF9z
cmNkaXJ9L2luY2x1ZGUvbGFwaS9zeXNjYWxsczsgLi9yZWdlbi5zaF0pCj4gK0FDX0NPTkZJR19D
T01NQU5EUyhbc3lzY2FsbHMuaF0sIFtjZAo+ICR7YWNfdG9wX3NyY2Rpcn0vaW5jbHVkZS9sYXBp
L3N5c2NhbGxzOyAuL2dlbmVyYXRlX3N5c2NhbGxzLnNoCj4gLi4vc3lzY2FsbHMuaF0pCj4KCllv
dSBwcm9iYWJseSBuZWVkIHRvIHJlYmFzZSB0aGlzIGxpbmUgaWYgWmhpamlhbidzIHBhdGNoIGdl
dHMgYXBwbGllZCBmaXJzdC4KIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8y
MDI0LU9jdG9iZXIvMDQwNTc0Lmh0bWwKCk90aGVyd2lzZSwgdGhpcyBvbmUgbG9va3MgcHJldHR5
IGdvb2QuClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
