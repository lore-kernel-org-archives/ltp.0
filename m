Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FADC3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 06:59:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12CC33D1FCD
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 08:59:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EABEB3D12B1
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:59:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0DBDF600A38
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722841155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+hy6rTjIbLKRg8Bfb6Rojze/j1iM5E6aekRk3FVJTg=;
 b=Iv3Y26XrB7JZx7BarfXw316IL2DcbDXZhVfWbR7N6yhyxcnYNRgDxiavSlrb/qCZQG42ez
 hEjJD335+Vm+wdLEAwRfqiTvTIvWAABOg3fUpotnxCokXjzeni6mAtUDowtPzha+UkDg0O
 8CPBmIdmMcsCJ4ywXp6xN1v9Ykm6xHw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-dgTXBuylP8mCYfGFa9H7lg-1; Mon, 05 Aug 2024 02:59:13 -0400
X-MC-Unique: dgTXBuylP8mCYfGFa9H7lg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cfe9270d82so5867490a91.3
 for <ltp@lists.linux.it>; Sun, 04 Aug 2024 23:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722841151; x=1723445951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+hy6rTjIbLKRg8Bfb6Rojze/j1iM5E6aekRk3FVJTg=;
 b=a+PGKrflu3O2b/IxaKkQs0edeTGprWVqI/mVFvQn17bUp4a7zEObC/tDxeKAs2Yh/F
 Yg1Ydlf9Dh26IUwKiKqBDYhRhR/GDvjW03wFWzh9Sf4YO0sFPaDAzxkSfg//dwe8p/ba
 UvlDAMxiFmsiqPzW6N/VExCvS4F3+D2cAFYK6ubkF8FrumRF5R78IEiyunUYUnPWwszS
 HRrxnAhTiOxfnjxfBxyBHbbYrqnfv3rf5pjtJA/TScnmprBCoam1QhBpbeJwyTdhpBOw
 puq/B2sV9TznRFAqnQk+Bg8QLDJ5NOVtTXwHMuheG+c9jgVV7VkriQSVnELHDHM9ZkW3
 HvuA==
X-Gm-Message-State: AOJu0Yzv1QoVf5vAubVc+tl4UzL+RBDtIccbjot8uVEGDaTx1NN5aKBp
 +0OqtIm7GvCFyfXbjkkR72bVf1H9exi5WKrHZ0Y/RT8eKd8zKstro4BDnPKZrHbJB4cvkjqUSG8
 XrKUfeV3wWm4F+RCfE9EPMMJhTSkOH/spsxdGSU2LuVpaChBku2kWLQd7bwDZr5oeV0w+VykawD
 78Fi09dqCXgPBWY9Nrl9eg8p5rDK9kgKz2YA==
X-Received: by 2002:a17:90a:5e04:b0:2c9:e44:fb98 with SMTP id
 98e67ed59e1d1-2cff955208cmr12376714a91.37.1722841151250; 
 Sun, 04 Aug 2024 23:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/sBi87BW8e3SiNrQ8dIrP9NfS4fjRfztImKV6FSyF82u/OB7HSU4Z7rSBH4Vomo+akw4pVn+7GAzB/2C6CJQ=
X-Received: by 2002:a17:90a:5e04:b0:2c9:e44:fb98 with SMTP id
 98e67ed59e1d1-2cff955208cmr12376704a91.37.1722841150743; Sun, 04 Aug 2024
 23:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240805063616.12572-1-liwang@redhat.com>
In-Reply-To: <20240805063616.12572-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Aug 2024 14:58:59 +0800
Message-ID: <CAEemH2fXU-Bb9nG6TNqjPUVDX3MkLego5PWDpqKDEMkkcp1_fQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getrusage03: Forcing context switches to update
 resource usage
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
Cc: Scott Weaver <scweaver@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSBwcm9wb3NlZCBhIHBhdGNoIGluIHVwc3RyZWFtIE1MOgogIGh0dHBzOi8vbGlzdHMubGludXgu
aXQvcGlwZXJtYWlsL2x0cC8yMDI0LUF1Z3VzdC8wMzk2OTMuaHRtbAoKT24gTW9uLCBBdWcgNSwg
MjAyNCBhdCAyOjM24oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBP
dXIgQ0kgc3BvcmFkaWNhbGx5IGNvbXBsYWlucyB0aGF0IHRoaXMgdGVzdCBncmFuZGNoaWxkJ3Mg
TUFYUlNTIGRpZCBub3QKPiByZWFjaAo+IHRoZSBleHBlY3RlZCAzMDBNQiBzaXplLgo+Cj4gICAg
IDEyIGdldHJ1c2FnZTAzLmM6ODY6IFRGQUlMOiBjaGlsZC5jaGlsZHJlbiA9IDI1ODA0OCwgZXhw
ZWN0ZWQgMzA3MjAwCj4KPiBBcyB0aGUgcnVfbWF4cnNzIHZhbHVlIGlzIGdlbmVyYWxseSB1cGRh
dGVkIGF0IGNlcnRhaW4gaW50ZXJ2YWxzIG9yIHVuZGVyCj4gc3BlY2lmaWMgY29uZGl0aW9ucywg
c3VjaCBhcyBwYWdlIGZhdWx0cyBvciBjb250ZXh0IHN3aXRjaGVzLiBUaGVyZSBtYXkgYmUKPiBk
ZWxheSBiZXR3ZWVuIHRoZSBjb21wbGV0aW9uIG9mIG1lbXNldCgpIGFuZCB0aGUgdXBkYXRlIG9m
IHJ1X21heHJzcy4KPgo+IFRvIGFkZHJlc3MgdGhpcyBpc3N1ZSwgd2UgY3JlYXRlIGEgZnVuY3Rp
b24gdG8gZm9yY2UgY29udGV4dCBzd2l0Y2hlcyBieQo+IGNhbGxpbmcgc2NoZWRfeWllbGQoKSBt
dWx0aXBsZSB0aW1lcy4gVGhpcyBhcHByb2FjaCBoZWxwcyB0byBlbnN1cmUgdGhhdAo+IHRoZSBz
eXN0ZW0gaGFzIHRoZSBvcHBvcnR1bml0eSB0byB1cGRhdGUgdGhlIHJ1X21heHJzcyB2YWx1ZSBt
b3JlIHByb21wdGx5Lgo+Cj4gUmVwcm90ZWQtYnk6IFNjb3R0IFdlYXZlciA8c2N3ZWF2ZXJAcmVk
aGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiAt
LS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuaCB8
IDExICsrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdl
MDMuaAo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMu
aAo+IGluZGV4IDhiZWUwYjllNS4uNThhOThiNDMwIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzLmgKPiArKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2dldHJ1c2FnZS9nZXRydXNhZ2UwMy5oCj4gQEAgLTYsMTAgKzYsMTkg
QEAKPiAgI2lmbmRlZiBMVFBfR0VUUlVTQUdFMDNfSAo+ICAjZGVmaW5lIExUUF9HRVRSVVNBR0Uw
M19ICj4KPiArI2luY2x1ZGUgPHNjaGVkLmg+Cj4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+Cj4g
ICNkZWZpbmUgREVMVEFfTUFYIDIwNDgwCj4KPiArc3RhdGljIHZvaWQgZm9yY2VfY29udGV4dF9z
d2l0Y2hlcyhpbnQgaXRlcmF0aW9ucykKPiArewo+ICsgICAgICAgdHN0X3JlcyhUSU5GTywgIkZv
cmNpbmcgY29udGV4dCBzd2l0Y2ggJWQgdGltZXMiLCBpdGVyYXRpb25zKTsKPiArCj4gKyAgICAg
ICBmb3IgKGludCBpID0gMDsgaSA8IGl0ZXJhdGlvbnM7IGkrKykKPiArICAgICAgICAgICAgICAg
c2NoZWRfeWllbGQoKTsKPiArfQo+ICsKPiAgc3RhdGljIHZvaWQgY29uc3VtZV9tYihpbnQgY29u
c3VtZV9ucikKPiAgewo+ICAgICAgICAgdm9pZCAqcHRyOwo+IEBAIC0yMiw2ICszMSw4IEBAIHN0
YXRpYyB2b2lkIGNvbnN1bWVfbWIoaW50IGNvbnN1bWVfbnIpCj4gICAgICAgICBwdHIgPSBTQUZF
X01BTExPQyhzaXplKTsKPiAgICAgICAgIG1lbXNldChwdHIsIDAsIHNpemUpOwo+Cj4gKyAgICAg
ICBmb3JjZV9jb250ZXh0X3N3aXRjaGVzKDEwKTsKPiArCj4gICAgICAgICBTQUZFX0ZJTEVfTElO
RVNfU0NBTkYoIi9wcm9jL3NlbGYvc3RhdHVzIiwgIlZtU3dhcDogJWx1IiwKPiAmdm1zd2FwX3Np
emUpOwo+ICAgICAgICAgaWYgKHZtc3dhcF9zaXplID4gMCkKPiAgICAgICAgICAgICAgICAgdHN0
X2JyayhUQlJPSywgIlZtU3dhcCBpcyBub3QgemVybyIpOwo+IC0tCj4gMi40NS4yCj4KPgo+IC0t
Cj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
