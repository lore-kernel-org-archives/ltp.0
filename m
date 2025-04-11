Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB10FC3601E
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744341025; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6WWtL6j2+Dh+MtJZ4BgC9JrZeFcsVto5MJtw+bDZ/qc=;
 b=NgUeuDCcxFkv5O1uL1Z4HwXGI3vPHmxPiAH9FYrWj0+XSngdOqjuaV9tz6xXVWLZEc/e2
 dzCS4TxdES0JsUoTLUXX3RtZcOmX2qkNKNcAbdPnNRYxKLC0XPUrjbiaEmhtwg2ykagEO74
 EucV+ZAKI1f1zjfo2zQ5NFs2/8GjpKY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B9713CB54F
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 05:10:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59C153CA355
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 05:10:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6520860074A
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 05:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744341001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGr2W2jqgRrjn5KI0DNuaTHV7mmLEwUQzXQ0/f5bMB4=;
 b=UzEf4V5ZtZ7enmO/hTT99ynCORFhZIBHp8skez9YLSlKbt0M1SdeunaDcmB9dqwwDmNVCa
 A89VYddC6XOSgsPutV8ZZ0LLgaEFk0p1NWVPp/qHjfCPwIrb3n7V9RdYQdVqw91vOfXD/t
 n6RewHetd4oqKIUTi7oLAn95TDQLtBQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-VYj7mXooMoOE7IGCaxU1kA-1; Thu, 10 Apr 2025 23:09:59 -0400
X-MC-Unique: VYj7mXooMoOE7IGCaxU1kA-1
X-Mimecast-MFC-AGG-ID: VYj7mXooMoOE7IGCaxU1kA_1744340998
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3055f2e1486so2196297a91.0
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744340998; x=1744945798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGr2W2jqgRrjn5KI0DNuaTHV7mmLEwUQzXQ0/f5bMB4=;
 b=ltDRmJO8IQab1M6mCP9mtxGyzvGad6zH1WNzFg/1hNnyic3LbShIUgAoI1hsQsXmNp
 BiSAZsbHVNeCcqMejiZbn++NrKqTIUItD8uhtxeS+/66AMEy9H+pSpN5tJKN4ikNnMzN
 YSK5nFUcX3z2MVuO5u5aLy4dV2OfktoOYK4zabGgRVaOcauD5JRfiPNH4M/hd1O33pIM
 JXeKcrvuy1o7NlXfhuRDxlkWM3f7by0BSh6ehRxMvSQe+fjfhYOpKyHRfJtrWGMGMdaR
 klbWz7BTNeezrF6bk+IHsuozGR9lPm8kAfINsVCfzZwI5PBZMjKgO9J74ig0F7lTaMIo
 Yclw==
X-Gm-Message-State: AOJu0YyM8o+uRJxFXicKRKgkr7c7y8iQwkwR6WcyLwVP1kOV8ak1Yj17
 m1pqJqbBObm0SFRwZqctZF6yAARHPkCNPJuryRr8wxPQWB1cwT66D/iFX4KVF2owq0dN8/zd7Cg
 Foc1DV1Fn37k5bMQvWcA+JO+8QxmeUg1I/K7geDNCL6jCA+f8j7kXNnbdfPTHST20gYxXhzfsgB
 pUL+UvAyuVwv5UtYsFDfME7Wc=
X-Gm-Gg: ASbGncvk80rhrKEcvI4ehywyw2HQCGwmjv/wUhIsUB7dv1oM0Biw/+/9wBA+UoYI+RR
 cysVMOi8l4y4vXqg8T1WYVun7wXOAgDlYdX12DXQY882laNVuQcDROaLIjFntvs13ulDmoQ==
X-Received: by 2002:a17:90b:58eb:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-30823784865mr2084930a91.35.1744340998010; 
 Thu, 10 Apr 2025 20:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELp1e1PRculz0rG2hWcoNjK8zOmqVQepUJzepNzMoyilPnV5YP+Gm7XWGlgZk36l3bDHj0L9dRNhPn5P6B0zk=
X-Received: by 2002:a17:90b:58eb:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-30823784865mr2084899a91.35.1744340997616; Thu, 10 Apr 2025
 20:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <20250409074906.128290-1-lufei@uniontech.com>
In-Reply-To: <20250409074906.128290-1-lufei@uniontech.com>
Date: Fri, 11 Apr 2025 11:09:45 +0800
X-Gm-Features: ATxdqUEKF25R7wREqQh6vSNmeunTUrOhdIl42nZetVanWT2s2JbV7n72hNNg9CQ
Message-ID: <CAEemH2ef7SZ_U5Z-rHst3Wcg-+fuRjSSOU9NxZOSW2Hjx3kiEg@mail.gmail.com>
To: lufei <lufei@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xDMd_jRq-DwVbRBVnAWUaDhQtP2GjH0aTedAHNmMTus_1744340998
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] unshare03: set nr_open with sizeof(long)*8
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
Cc: viro@zeniv.linux.org.uk, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBcHIgOSwgMjAyNSBhdCAzOjUw4oCvUE0gbHVmZWkgPGx1ZmVpQHVuaW9udGVjaC5j
b20+IHdyb3RlOgoKPiBTZXQgbnJfb3BlbiB3aXRoIHNpemVvZihsb25nKSo4IHRvIHRyaWdnZXIg
RU1GSUxFLCBpbnN0ZWFkIG9mIHJlYWRpbmcKPiBudW1iZXIgb2YgZmlsZWRlc2NyaXB0b3JzIGxp
bWl0Lgo+CgpBbnkgbmV3IGNoYW5nZXMgaW4gTGludXggdGhhdCBoYXZlIG1hZGUgdGhlIHByZXZp
b3VzIHdheSBub3Qgd29yayBub3c/CgoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBsdWZlaSA8bHVmZWlA
dW5pb250ZWNoLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJl
L3Vuc2hhcmUwMy5jIHwgMjMgKystLS0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTAzLmMKPiBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDMuYwo+IGluZGV4IDdjNWU3MWM0ZS4uYzNiOTg5
MzBkIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNo
YXJlMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJl
MDMuYwo+IEBAIC0xNyw0NCArMTcsMjUgQEAKPiAgI2luY2x1ZGUgImxhcGkvc2NoZWQuaCIKPgo+
ICAjZGVmaW5lIEZTX05SX09QRU4gIi9wcm9jL3N5cy9mcy9ucl9vcGVuIgo+IC0jZGVmaW5lIE5S
X09QRU5fTElNSVQgMTAyNAo+IC0jZGVmaW5lIE5SX09QRU5fRFVQIDY0Cj4KPiAgI2lmZGVmIEhB
VkVfVU5TSEFSRQo+Cj4gIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICB7Cj4gLSAgICAgICBpbnQg
bnJfb3BlbjsKPiAtICAgICAgIGludCBucl9saW1pdDsKPiAtICAgICAgIHN0cnVjdCBybGltaXQg
cmxpbWl0Owo+ICAgICAgICAgc3RydWN0IHRzdF9jbG9uZV9hcmdzIGFyZ3MgPSB7Cj4gICAgICAg
ICAgICAgICAgIC5mbGFncyA9IENMT05FX0ZJTEVTLAo+ICAgICAgICAgICAgICAgICAuZXhpdF9z
aWduYWwgPSBTSUdDSExELAo+ICAgICAgICAgfTsKPgo+IC0gICAgICAgU0FGRV9GSUxFX1NDQU5G
KEZTX05SX09QRU4sICIlZCIsICZucl9vcGVuKTsKPiAtICAgICAgIHRzdF9yZXMoVERFQlVHLCAi
TWF4aW11bSBudW1iZXIgb2YgZmlsZSBkZXNjcmlwdG9yczogJWQiLCBucl9vcGVuKTsKPiArICAg
ICAgIGludCBucl9vcGVuID0gc2l6ZW9mKGxvbmcpICogODsKPgo+IC0gICAgICAgbnJfbGltaXQg
PSBucl9vcGVuICsgTlJfT1BFTl9MSU1JVDsKPiAtICAgICAgIFNBRkVfRklMRV9QUklOVEYoRlNf
TlJfT1BFTiwgIiVkIiwgbnJfbGltaXQpOwo+IC0KPiAtICAgICAgIFNBRkVfR0VUUkxJTUlUKFJM
SU1JVF9OT0ZJTEUsICZybGltaXQpOwo+IC0KPiAtICAgICAgIHJsaW1pdC5ybGltX2N1ciA9IG5y
X2xpbWl0Owo+IC0gICAgICAgcmxpbWl0LnJsaW1fbWF4ID0gbnJfbGltaXQ7Cj4gLQo+IC0gICAg
ICAgU0FGRV9TRVRSTElNSVQoUkxJTUlUX05PRklMRSwgJnJsaW1pdCk7Cj4gLSAgICAgICB0c3Rf
cmVzKFRERUJVRywgIlNldCBuZXcgbWF4aW11bSBudW1iZXIgb2YgZmlsZSBkZXNjcmlwdG9ycyB0
byA6Cj4gJWQiLAo+IC0gICAgICAgICAgICAgICBucl9saW1pdCk7Cj4gLQo+IC0gICAgICAgU0FG
RV9EVVAyKDIsIG5yX29wZW4gKyBOUl9PUEVOX0RVUCk7Cj4gKyAgICAgICBTQUZFX0RVUDIoMiwg
bnJfb3BlbiArIDEpOwo+Cj4gICAgICAgICBpZiAoIVNBRkVfQ0xPTkUoJmFyZ3MpKSB7Cj4gICAg
ICAgICAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoRlNfTlJfT1BFTiwgIiVkIiwgbnJfb3Blbik7
Cj4gICAgICAgICAgICAgICAgIFRTVF9FWFBfRkFJTCh1bnNoYXJlKENMT05FX0ZJTEVTKSwgRU1G
SUxFKTsKPiAgICAgICAgICAgICAgICAgZXhpdCgwKTsKPiAgICAgICAgIH0KPiAtCj4gIH0KPgo+
ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+IC0tCj4gMi4zOS4zCj4KPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
