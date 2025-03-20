Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB5EC35FFC
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 01:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742435009; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QWqY/3UdPYsaml+eQx8UMo5ZEzNTkO20tsFqq1xg9VM=;
 b=Tq/w+sH9sTteo+aq6WIviBmQ1BWTSm5ec0CO0Em2ShCzKD8nHa2QyhBKHkLVbgXR6JWHe
 oSO7cfNVzg7A3LrRWNfQVlEuo+JfyxFyFTcQr6Z8XDdOtm0H2R7oackghBdOLjHVX51ZQmB
 N6Rqa1oqLA+icN8g0uHK14a3QFomgZk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAC1E3CAE0A
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 02:43:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651323CADA7
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 02:43:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7EECD14004FD
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 02:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742434984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDo3QRZzwHwNHJSThqRAgICuapkCl2jmfcr+rZVpIVc=;
 b=Nb1KFiW4jmrbT+nRNQ7CmIWD3fghxzgkJ4AmSQHrTalvHN1+sCLPHP1YKhi/gXmf5+cctB
 zXBNPF+WomgGsDtdmVETIoLAs/5kz7B7v09VsPivTNIvbA4b46rQLYC6IK9RMmyIxzekts
 HQNVLsDIKVbeZv/FTKdVq8cQgGcSGTI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-XWM52_lKONKOufgShbSGkA-1; Wed, 19 Mar 2025 21:43:02 -0400
X-MC-Unique: XWM52_lKONKOufgShbSGkA-1
X-Mimecast-MFC-AGG-ID: XWM52_lKONKOufgShbSGkA_1742434982
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso735441a91.2
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 18:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742434981; x=1743039781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDo3QRZzwHwNHJSThqRAgICuapkCl2jmfcr+rZVpIVc=;
 b=tm+8ssFwc8/jRGzoTHSulGkzPp60d5bS7WeMCaE8HjyRICD7TqtOx2G5u/ecGDHDqQ
 3JY6coPI1/fV4iK2LGPvWXWtywGFuUkTFd/U9wMpjFvcASovRTN5kj1dLYpH7rc5eXlM
 duJsCMqbS5Fp85iRgn5mHIPFPU3w/lpJsGFsee0nAsIUxqh28rM++mIk9gXUF3Cyjyf0
 pB7Yj7kbWgnKeIZrzNZLDAqeZ0muwzGngl0C10hFB2CZqRQnK9r3SYV1IWzMh2+tuRm2
 Iyo1jtgeJf7+QJc7v7C/O4GTGCIO+5ZcPoKLfNpUet3Ia0eshYxZrNybwQzWHuJKmarB
 +fvQ==
X-Gm-Message-State: AOJu0YxOj9Hy38SUab2AfylzrWtuXqX7z9hj2JY+4Ly2i5WW7hflkIfd
 dhstTNW6inHUDz+6sKA4WJ4y8GxNrk/8IiyeV4lJvam9RLs91qWJNPIqfnpVSxqWLTFTZ7XZFuC
 pPFGiYNxQ+Kh0oCw0SBOl0RMiBOnHQ2XflT+xCQ8hTXWaYzggWQFy6W8vB2A3/vFetz02lG9LJ7
 PEfSFNMKmi4XHpyM1wQ0cUrEs=
X-Gm-Gg: ASbGncu9fh4NcmCPBygyT10jTHaXD6/bPDdaiT8LFVq19oVTsfj3zuYHb34Th2il9gK
 gpLN3SEW2BSMqFmtlXckDXKtR5Q8RLWSTpwT3JN8dxTxrKM55eZ4ZXlPX39Syr7nAda33axOfJQ
 ==
X-Received: by 2002:a17:90b:4a92:b0:2ee:74a1:fba2 with SMTP id
 98e67ed59e1d1-301bdf93ed2mr7663798a91.20.1742434981441; 
 Wed, 19 Mar 2025 18:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmC2810JVXmdpSwXCRLJyqwPjGe/dWKASXC1VgjtLVHxj8u8xlTzBRsLpWeyQUgYGBibrjvLPU6hpv26bfuKo=
X-Received: by 2002:a17:90b:4a92:b0:2ee:74a1:fba2 with SMTP id
 98e67ed59e1d1-301bdf93ed2mr7663782a91.20.1742434981042; Wed, 19 Mar 2025
 18:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250319172424.42961-1-mdoucha@suse.cz>
In-Reply-To: <20250319172424.42961-1-mdoucha@suse.cz>
Date: Thu, 20 Mar 2025 09:42:49 +0800
X-Gm-Features: AQ5f1Jp9pwsnBWsYsxKvuebhf_MeKFelNcl2w65nYlQtAknixv296DGzDkUAcRg
Message-ID: <CAEemH2c8=bE6DkNXbS13-wNUXUYp1wSXiBEHNd+c5NNYKKfOdg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -LxlEryszWP0qoNniy9tNrVDKt1RPRzAsUfBfaQy-Js_1742434982
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] move_pages12: Ignore ENOMEM from
 madvise(MADV_SOFT_OFFLINE)
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKSSBoYWQgZXZlciBhZGRlZCBhIGNvbXByZXNzZWQgbWVtb3J5IHN0ZXAgdG8g
ZGlzIGZyYWdtZW50YWwKYmVmb3JlIGRvaW5nIGh1Z2VwYWdlIGFsbG9jYXRpb25zIChpbiBjb21t
aXQgZTk3ZjQxOTcwNTgyICksCmJ1dCB0aGF0IGRpZG4ndCBzZWVtIHRvIHNvbHZlIHRoZSBwcm9i
bGVtIGlkZWFsbHkuCgpBbnl3YXksIHRoaXMgcGF0Y2ggbG9va3MgZ29vZC4KUmV2aWV3ZWQtYnk6
IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCk9uIFRodSwgTWFyIDIwLCAyMDI1IGF0IDE6
MjXigK9BTSBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+IHdyb3RlOgoKPiBUaGUgdGVz
dCBkaXNzb2x2ZXMgaHVnZXBhZ2VzIHdoaWNoIHJlc3VsdHMgaW4gc29mdC1vZmZsaW5lIG1hZHZp
c2UoKSBjYWxsCj4gcmV0dXJuaW5nIEVOT01FTSBhZnRlciBhIGZldyBpdGVyYXRpb25zLiBUaGlz
IGlzIGV4cGVjdGVkIGJlaGF2aW9yLgo+IEhvd2V2ZXIsCj4gdHJ5aW5nIHRvIHByZWFsbG9jYXRl
IG1vcmUgaHVnZXBhZ2VzIHRvIHByZXZlbnQgdGhlIGVycm9yIHdpbGwgYnJlYWsKPiB0aGUgYWJp
bGl0eSB0byByZXByb2R1Y2UgdGhlIFNJR0JVUyBidWcuIFNpbXBseSBpZ25vcmluZyB0aGUgRU5P
TUVNIGVycm9yCj4gaXMgZ29vZCBlbm91Z2guCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91
Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9tb3ZlX3BhZ2VzL21vdmVfcGFnZXMxMi5jCj4gYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPiBpbmRleCA4NzlhODliNmYuLmE1
NDU0YjFlYyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdmVfcGFn
ZXMvbW92ZV9wYWdlczEyLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdmVf
cGFnZXMvbW92ZV9wYWdlczEyLmMKPiBAQCAtMTAwLDcgKzEwMCw3IEBAIHN0YXRpYyB2b2lkICph
ZGRyOwo+ICBzdGF0aWMgaW50IGRvX3NvZnRfb2ZmbGluZShpbnQgdHBncykKPiAgewo+ICAgICAg
ICAgaWYgKG1hZHZpc2UoYWRkciwgdHBncyAqIGhwc3osIE1BRFZfU09GVF9PRkZMSU5FKSA9PSAt
MSkgewo+IC0gICAgICAgICAgICAgICBpZiAoZXJybm8gIT0gRUlOVkFMICYmIGVycm5vICE9IEVC
VVNZKQo+ICsgICAgICAgICAgICAgICBpZiAoZXJybm8gIT0gRUlOVkFMICYmIGVycm5vICE9IEVC
VVNZICYmIGVycm5vICE9IEVOT01FTSkKPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVz
KFRGQUlMIHwgVEVSUk5PLCAibWFkdmlzZSBmYWlsZWQiKTsKPiAgICAgICAgICAgICAgICAgcmV0
dXJuIGVycm5vOwo+ICAgICAgICAgfQo+IC0tCj4gMi40Ny4wCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
