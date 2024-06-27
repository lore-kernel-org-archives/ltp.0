Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8285EC3064D
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:47:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 166123D12C5
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 13:47:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47C183D0D30
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:46:47 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75E611A00E7C
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 13:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719488804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5uZvXu3aKp9D0+0yx8t7//7gglY8DhVydBni0hy/iU=;
 b=NMaqUqY0cCNjHdullY7aq913KxtTHrRhebNmg2WspoP0X++UK4XxLLFBCSi23ZepUUvbMU
 P49B6qNlKHLEAIv+C+UpAjiYLQFoge6ODYU/oULpTNham9sI7lslCFOgB8Hgd/E4BhivPW
 OZ59WIP5xEU7Ue7A8GMb0tjme35ulwQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-zACaA11GPJ-UgWiFaoirNQ-1; Thu, 27 Jun 2024 07:46:42 -0400
X-MC-Unique: zACaA11GPJ-UgWiFaoirNQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7ef1fcf68so8530714a91.1
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 04:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719488801; x=1720093601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5uZvXu3aKp9D0+0yx8t7//7gglY8DhVydBni0hy/iU=;
 b=bj127DoBVjhLDEXpGsTak6WCYfDNVQhD2o1912F5kgwSkZ3iPdEor5dj5JzCvPmZcw
 VpBCNEqif/qFTeRoAccQyR5D3Bq3PSnpxE+HmSFgQmZKbPQF2/BVHDXqnyUA/kKEcn8N
 rZoHBexik2jpQVeLobIcCXxEOeatQfDjXfIbuBVVnARUuRhAdkoI8n0ZRUTrDm+IFkpm
 uKfChNF7jQekexhrufP9A2kwqZBrDxzfGJlDTI6aV+d3aGA/1EUmXVLAjdccjFyhbZKm
 3I5weQB6MQFEdR0Wo608Cd7pI0ORRHzAa8l+jN+w4hU4JZWCvBmb1MQF4hHzZyEbUrpR
 g6HA==
X-Gm-Message-State: AOJu0Yx41Yp0cZYTUrN5QIZGU23s/CENkt7ct4yyYsnDwoqga8Fy4E9Q
 2xxqtbSyp6xEQd1/Zt8hpRzZaqZTtZ8BLJ9UEGIqtTm4o9YeU96ls7stVe4rHRjsM0zBBtIH7w/
 FXzy8ehAnQfHGtQjvGkHFrBlCAdi2LkRfAD0DnwsABNhpipYVHwRfF9wlpEAwTpiJrh7wGlg8U9
 vR0i+oCLIOVKnUEQI7poeBzUE=
X-Received: by 2002:a17:90b:1918:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2c8504f6afbmr12057549a91.20.1719488801457; 
 Thu, 27 Jun 2024 04:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZjSjWmZvsyWNFvXRHCqEPj/qCAgKphEGsMMZlgPvHEJewdcE9A9U5xjaHFuGc+GPONIHeKyWjlVbTMKeXxls=
X-Received: by 2002:a17:90b:1918:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2c8504f6afbmr12057538a91.20.1719488801120; Thu, 27 Jun 2024
 04:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
 <20240627031440.799114-1-liwang@redhat.com> <Zn1PluxR0lVO1qdn@yuki>
In-Reply-To: <Zn1PluxR0lVO1qdn@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Jun 2024 19:46:29 +0800
Message-ID: <CAEemH2eh3kDZ7xLPp94buH1f9b3Z3JgiVaRVEzvgiGw8mv3mow@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] msgstress01: remove TWARN from runtime
 remaining
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

T24gVGh1LCBKdW4gMjcsIDIwMjQgYXQgNzo0MOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUbyBtYXNrIHRoZSBpc3N1ZSB3aGVyZSBhIHdhcm5p
bmcgaXMgYmVpbmcgdHJlYXRlZCBhcyBhIGZhaWx1cmUgaW4gQ0kKPiA+IGxvZ3MsIHdlIG1vZGlm
eSB0aGUgY29kZSB0byBjaGFuZ2UgdGhlIG1lc3NhZ2UgdHlwZSBmcm9tIFRXQVJOIHRvIFRDT05G
Lgo+ID4KPiA+IEFkZGl0aW9uYWxseSwgd2UgcmVmaW5lIHRoZSBjb25kaXRpb24gdW5kZXIgd2hp
Y2ggdGhlIHRlc3QgcmVwb3J0cyBhcwo+ID4gUEFTUyB0byBlbnN1cmUgdGhhdCBpdCBhbHNvIGFj
Y291bnRzIGZvciB0aGUgYHN0b3BgIGZsYWcuIFRoaXMgcHJldmVudHMKPiA+IHRoZSB0ZXN0IGZy
b20gaW5jb3JyZWN0bHkgcmVwb3J0aW5nIHN1Y2Nlc3Mgd2hlbiBpdCBoYWQgdG8gc3RvcCBkdWUg
dG8KPiA+IHJ1bnRpbWUgY29uc3RyYWludHMuCj4gPgo+ID4gVGhpcyB3YXJuaW5nIGVhc2lseSBo
YXBwZW5zIGVzcGVjYWlsbCBvbiBkZWJ1Zy9zbG93ZXIga2VybmVsOgo+ID4KPiA+ICAgICBtc2dz
dHJlc3MwMS5jOjIxNzogVFdBUk46IE91dCBvZiBydW50aW1lIGR1cmluZyBmb3JraW5nLi4uCj4g
Pgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0K
PiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dzdHJlc3MvbXNnc3RyZXNzMDEu
YyB8IDQgKystLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBj
L21zZ3N0cmVzcy9tc2dzdHJlc3MwMS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lw
Yy9tc2dzdHJlc3MvbXNnc3RyZXNzMDEuYwo+ID4gaW5kZXggOGIxZTlhOGMwLi45MjMxYTBiNWYg
MTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dzdHJlc3Mv
bXNnc3RyZXNzMDEuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvbXNn
c3RyZXNzL21zZ3N0cmVzczAxLmMKPiA+IEBAIC0yMTQsNyArMjE0LDcgQEAgc3RhdGljIHZvaWQg
cnVuKHZvaWQpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPgo+ID4gICAgICAg
ICAgICAgICBpZiAoIXRzdF9yZW1haW5pbmdfcnVudGltZSgpKSB7Cj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgdHN0X3JlcyhUV0FSTiwgIk91dCBvZiBydW50aW1lIGR1cmluZyBmb3JraW5nLi4u
Iik7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiwgIk91dCBvZiBydW50
aW1lIGR1cmluZyBmb3JraW5nLi4uIik7Cj4KPiBUaGlzIHBhcnQgbG9va3MgZ29vZC4KPgo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICpzdG9wID0gMTsKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsKPiA+ICAgICAgICAgICAgICAgfQo+ID4gQEAgLTI0Miw3ICsyNDIsNyBAQCBzdGF0
aWMgdm9pZCBydW4odm9pZCkKPiA+ICAgICAgIHRzdF9yZWFwX2NoaWxkcmVuKCk7Cj4gPiAgICAg
ICByZW1vdmVfcXVldWVzKCk7Cj4gPgo+ID4gLSAgICAgaWYgKCEoKmZhaWwpKQo+ID4gKyAgICAg
aWYgKCEoKmZhaWwpICYmICEoKnN0b3ApKQo+ID4gICAgICAgICAgICAgICB0c3RfcmVzKFRQQVNT
LCAiVGVzdCBwYXNzZWQuIEFsbCBtZXNzYWdlcyBoYXZlIGJlZW4KPiByZWNlaXZlZCIpOwo+Cj4g
SG93ZXZlciB0aGlzIHdvdWxkIGNhdXNlIHRoZSB0ZXN0IHRvIHJlcG9ydCBUQlJPSyBpbiB0aGUg
Y2FzZSB0aGF0IHdlCj4gZW5kZWQgdXAgb3V0IG9mIHJ1bnRpbWUgaW4gdGhlIHNlY29uZCBmb3Ig
bG9vcCBiZWNhdXNlIGluIHRoYXQgY2FzZSBubwo+IHJlc3VsdHMgd2lsbCBiZSByZXBvcnRlZCBi
eSB0aGUgdGVzdC4KPgoKCkFoIHllcywgYnV0IGlmIHRoZSBzZWNvbmQgcnVudGltZSBvdXQgaGFw
cGVucywgaXQgc3RpbGwKbm90IGdldCBhbiBleHBlY3RlZCByZXN1bHQgb24gdGhlIHRlc3QsIHNv
IG1heWJlIHdlCnNob3VsZG4ndCBwcmludCAiVFBBU1MgKyBBbGwgbWVzc2FnZXMgcmVjZWl2ZWQi
PwoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
