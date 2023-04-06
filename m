Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA83C761A6
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 12:38:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3F833CDB93
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 14:38:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFA863CAC9B
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 14:37:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 74378600D82
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 14:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680784670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGIFQ28S+18eXCBIsaf5bygu1J44s4lzWTLcq8vQccE=;
 b=BGP3fvT0anp+KKMgxXohgtvsXVz8cHCfmudajuUJ/+HBWJLMvgn3jKMH0a5PWG+m4xT9QM
 oJjXRAtVyG96XCm5P34BLQ/YvqRXg88wBfe1rEN5jzWW5bKGFGto0xOHLRU/f94CtByKLI
 XCXc9aaOzqxk+PAh1UKVfs316uRuV68=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-YYi_jIXgPFOkrKQ3bCd-Ww-1; Thu, 06 Apr 2023 08:37:49 -0400
X-MC-Unique: YYi_jIXgPFOkrKQ3bCd-Ww-1
Received: by mail-wm1-f69.google.com with SMTP id
 k25-20020a05600c1c9900b003ef79f2c207so12714915wms.5
 for <ltp@lists.linux.it>; Thu, 06 Apr 2023 05:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680784668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CGIFQ28S+18eXCBIsaf5bygu1J44s4lzWTLcq8vQccE=;
 b=NrA7h+tr+jv8BFuU2RgypAcbyyo0AcMFDAFTLt72oF/yHirlherAtrfdACFEkTNzUH
 oR7+kV7UlxPi1r0iElU6kNwwXohTQ+6HACEsPWq9r8FOhXjspMwL0ZgPiL59KFO+Q8gR
 kbOW6QTKlJK3ZGTTFL3FkD8dqSlRRT0oArSyJAr+/Cy0e0Fc05EN2rRq5Q5VgzTSS4F1
 c20phuGqnLBp9ccbcZKbDqqtvL4dxY57dSLIbVQgUifjHxiG+5X0uQWvHm+YahdfwoKV
 vej/eByA+LtAGT/D4FYr5ajwjgHMsPFpjtkTPv/X/bzClxHkeWYeqYKsF4PYJuc3qLX7
 2M8Q==
X-Gm-Message-State: AAQBX9eCJv+gQbEFYSZFpxIOf4tfaYJ6/TRQQSxTDJQjFcNAhB1CaVBq
 H34XD/q+ZzTneR7OfrnlyrQjQWhGZqybXItQGWsa0+SBVbElbt5jSMzjcZYP54tbhNqMxQ3vIRO
 CR9xIe39VaCnwqgF9+1NJwxEbjfQ=
X-Received: by 2002:a05:6000:a01:b0:2ee:ef0b:1ba5 with SMTP id
 co1-20020a0560000a0100b002eeef0b1ba5mr535685wrb.2.1680784668332; 
 Thu, 06 Apr 2023 05:37:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zf3Z3saGcq5f+1QipSpSsyWzevu5XQli1xbStP3eRILToUYei0Xju1+wyWsDKpSzw4OiYVnC/QhsigcgcbpSY=
X-Received: by 2002:a05:6000:a01:b0:2ee:ef0b:1ba5 with SMTP id
 co1-20020a0560000a0100b002eeef0b1ba5mr535673wrb.2.1680784668076; Thu, 06 Apr
 2023 05:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230404112852.1271969-1-pvorel@suse.cz>
 <CAEemH2fNLRxhj7NxRvxOr-XYe+gbXiEsYiKosm855_z+jdO5hA@mail.gmail.com>
 <20230406094853.GA1545779@pevik>
 <CAEemH2db7gN9GduVYwfeLM1Px9rp_WTV6uXm1O+urVLXWrMbfA@mail.gmail.com>
 <20230406111301.GC1545779@pevik>
In-Reply-To: <20230406111301.GC1545779@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 6 Apr 2023 20:37:36 +0800
Message-ID: <CAEemH2fFPb6MAMEN2b7QW2zCnUkj3zCjGAXvFzOpmRg=jO-c2A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] mmap20: Fix invalid address
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
Cc: Paulson Raja L <paulson@zilogic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgNiwgMjAyMyBhdCA3OjEz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBhbGwsCj4KPiA+IE9uIFRodSwgQXByIDYsIDIwMjMgYXQgNTo0OeKA
r1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiBIaSBhbGwsCj4K
PiA+ID4gPiBIaSBQZXRyLAo+Cj4gPiA+ID4gKDE8PDkpIGlzIGFsc28gdXNlZCBieSBhbm90aGVy
IGZsYWcgb24gYWxwaGEsIGJ1dCBpdCBzYWlkIG5vdAo+ID4gPiA+IGxpbnV4LXNwZWNpZmljLAo+
ID4gPiA+IHNvIEkgZ3Vlc3MgaXQgd29uJ3QgYmUgYSBwcm9ibGVtIChhdCBsZWFzdCBmb3Igbm93
KS4KPiA+ID4gPiAgIGFscGhhL2luY2x1ZGUvdWFwaS9hc20vbW1hbi5oOiNkZWZpbmUgX01BUF9I
QVNTRU1BUEhPUkUgMHgwMjAwCj4KPiA+ID4gR29vZCBwb2ludCEgSSBjaGVja2VkIG9ubHkgZ2xp
YmMvbXVzbCBoZWFkZXJzLCBvYnZpb3VzbHkgY2hlY2tpbmcKPiBrZXJuZWwKPiA+ID4gc291cmNl
cwo+ID4gPiBpcyBiZXR0ZXIgYXMgaXQgY29udGFpbnMgb2xkIGFyY2hzLiBJdCBhZmZlY3RzIGFs
cGhhLCBpYTY0IGFuZCBzcGFyYwo+ID4gPiAod2VsbCwgdGhleSBtaWdodCBub3QgZXZlbiBjb21w
aWxlIGN1cnJlbnQgTFRQLCB3ZSB3ZXJlIGRyb3BwaW5nIGlhNjQKPiBmaXhlcwo+ID4gPiBhbnl3
YXkpLgo+Cj4KPiA+IE9rYXksIEkgb25seSBub3RpY2VkIHRoYXQgYWxwaGEgaXMgbm90IGRlZmlu
ZWQgMHgwMjAwIGZvciBMaW51eAo+ID4gc3BlY2lmaWNhbGx5Lgo+Cj4gPiA+ICQgZ2l0IGdyZXAg
LXcgMHgwMjAwIGFyY2gvKi9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaAo+ID4gPiBhcmNoL2FscGhh
L2luY2x1ZGUvdWFwaS9hc20vbW1hbi5oOiNkZWZpbmUgX01BUF9IQVNTRU1BUEhPUkUgMHgwMjAw
Cj4gPiA+IGFyY2gvaWE2NC9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaDojZGVmaW5lIE1BUF9HUk9X
U1VQICAgMHgwMjAwCj4gICAvKgo+ID4gPiByZWdpc3RlciBzdGFjay1saWtlIHNlZ21lbnQgKi8K
PiA+ID4gYXJjaC9zcGFyYy9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaDojZGVmaW5lIE1BUF9HUk9X
U0RPV04gICAgICAgIDB4MDIwMAo+ID4gPiAgICAgICAvKiBzdGFjay1saWtlIHNlZ21lbnQgKi8K
Pgo+ID4gPiBCdXQgYXMgMHg0MDAgKDEgPDwgMTApIGlzIG5vdCB1c2VkIGFueXdoZXJlLCBJIG1l
cmdlZCBpdCB3aXRoIHRoaXMKPiB2YWx1ZS4KPgo+Cj4KPiA+IEhtbSwgSSBkaWRuJ3QgdW5kZXJz
dGFuZCBoZXJlIHdoeSBtZXJnZWQgd2l0aCAweDA0MDAsCj4gPiBhcmVuJ3QgdGhlcmUgc3RpbGwg
ZHVwbGljYXRlZCBmbGFncz8KPgo+ID4gJCBnaXQgZ3JlcCAtdyAweDA0MDAgYXJjaC8qL2luY2x1
ZGUvdWFwaS9hc20vbW1hbi5oCj4gPiBhcmNoL2FscGhhL2luY2x1ZGUvdWFwaS9hc20vbW1hbi5o
OiNkZWZpbmUgX01BUF9JTkhFUklUIDB4MDQwMAo+ID4gYXJjaC9taXBzL2luY2x1ZGUvdWFwaS9h
c20vbW1hbi5oOiNkZWZpbmUgTUFQX05PUkVTRVJWRSAweDA0MDAKPiAvKgo+ID4gZG9uJ3QgY2hl
Y2sgZm9yIHJlc2VydmF0aW9ucyAqLwo+ID4gYXJjaC94dGVuc2EvaW5jbHVkZS91YXBpL2FzbS9t
bWFuLmg6I2RlZmluZSBNQVBfTk9SRVNFUlZFICAgICAgIDB4MDQwMAo+ID4gICAgICAvKiBkb24n
dCBjaGVjayBmb3IgcmVzZXJ2YXRpb25zICovCj4KPiBJJ20gc29ycnkgSSBub3cgZG9uJ3Qga25v
dyB3aGF0IEkgZ3JlcGVkLCBiZWNhdXNlIHRoZXJlIGFyZSByZXN1bHRzIGZvcgo+IDB4MDQwMCA6
KC4KPiBPYnZpb3VzbHkgbGFzdCBtaW51dGUgY2hhbmdlIHdpdGhvdXQgYWNrIGlzIGEgYmFkIHBy
YWN0aXNlLgo+Cj4gWW91J3JlIHJpZ2h0LCBsaW51eCBzcGVjaWZpYyAweDA0MDAgaXMgaW4gbWlw
cyBhbmQgeHRlbnNhIChpdCdzIG5vbi1saW51eAo+IHNwZWNpZmljIG9uIGFscGhhKS4gT1RPSCBp
YTY0IGFuZCBzcGFyYyBkZWZpbmU6Cj4KPiBhcmNoL2lhNjQvaW5jbHVkZS91YXBpL2FzbS9tbWFu
LmgKPiAjZGVmaW5lIE1BUF9HUk9XU1VQICAgICAweDAyMDAgICAgICAgICAgLyogcmVnaXN0ZXIg
c3RhY2stbGlrZSBzZWdtZW50ICovCj4KPiBhcmNoL3NwYXJjL2luY2x1ZGUvdWFwaS9hc20vbW1h
bi5oCj4gI2RlZmluZSBNQVBfR1JPV1NET1dOICAgMHgwMjAwICAgICAgICAgIC8qIHN0YWNrLWxp
a2Ugc2VnbWVudCAqLwo+Cj4gQXJlIHRoZXNlIHVzZWQgYXMgZmxhZ3M/IElmIHllcyBub25lIG9m
IHRoZSB2YWx1ZXMgaXMgb3B0aW1hbCBhcyBpdCBicmVha3MKPiBzb21lCj4KClRoZSBhbnN3ZXIg
aXMgeWVzLCBNQVBfR1JPV1NET1dOL0dST1dTVVAgaXMKd2lkZWx5IHVzZWQgZm9yIHN0YWNrIGdy
b3d0aCBkaXJlY3Rpb24uCgpJdCBpcyBoYXJkIHRvIGNob29zZSBhbiB1bnVzZWQgdmFsdWUgZm9y
IElOVkFMSURfRkxBRywKYXMgaXQgdGhlcmUgcG9zc2libHkgYmUgZHVwbGljYXRlZCBpbiB0aGUg
ZnV0dXJlIHdlIGRvbid0IGtub3cuCgoKCj4gYXJjaC4gSWYgeW91IGFncmVlLCBJJ2Qga2VlcCAw
eDA0MDAgYW5kIGZvbGxvdyBKYW4ncyBzdWdnZXN0aW9uIChkb24ndCBtYXAKPiBhCj4gZmlsZSwg
YW5kIHRoZW4gYWRkIE1BUF9TWU5DIHRvIGZsYWdzKS4KPgoKQWRkIE1BUF9TWU5DIHNvdW5kcyBs
aWtlIGEgZ29vZCBwcmFjdGljZSwgd2UgY2FuIGhhdmUgYSB0cnkuCgotLSAKUmVnYXJkcywKTGkg
V2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
