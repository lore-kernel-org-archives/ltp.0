Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D59CC4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B532A3CB18F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:09:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17C1E3CB0B9
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 13:09:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 390FD60045F
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 13:09:05 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7E2A322B53;
 Thu, 20 Oct 2022 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666264145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBzyM60u/i9HXVQ/sHDLWt8JTq5sogTbRJq3yuPieS0=;
 b=xlp3sSTB/5oBaYwFB9L6cX6cz6fcNuIzPUbSRegghm1HQzbkEACCVWwsQ/r/P4T7TEADs/
 UEjT1y/XHpHDMMvC2fCeXhjpq9lylS8qbGq5jkkzKxjaQm/rBuBrK3pf9Gum4IBq15TywY
 eLM40fd7NPHwGyNJKt8VhO4w+a/uBq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666264145;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBzyM60u/i9HXVQ/sHDLWt8JTq5sogTbRJq3yuPieS0=;
 b=6W4t1MwZK98Af88wXI044YX/1L35Nat7B7J+FPKqKpQiZZO47OH950ToKGnG/zTgU3jY8q
 D7oSVAao3U40lVDQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 109842C141;
 Thu, 20 Oct 2022 11:09:04 +0000 (UTC)
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <f15cfed9-b389-b176-9d7d-8f2fcc8aaff0@suse.cz>
 <CAEemH2fVhxhZNsMx0_CU8am_MRoOxnJ1fgu=qJTRag5z1=o0Yw@mail.gmail.com>
 <d4d411f1-8f07-1fc9-8762-3ab7faa75f24@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 20 Oct 2022 11:59:10 +0100
In-reply-to: <d4d411f1-8f07-1fc9-8762-3ab7faa75f24@suse.cz>
Message-ID: <87zgdqu4z3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ptrace07: Fix compilation when not on x86
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+IHdyaXRlczoKCj4gT24gMjAu
IDEwLiAyMiA1OjUzLCBMaSBXYW5nIHdyb3RlOgo+PiBPbiBXZWQsIE9jdCAxOSwgMjAyMiBhdCA1
OjMwIFBNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jego+PiA8bWFpbHRvOm1kb3VjaGFA
c3VzZS5jej4+IHdyb3RlOgo+PiAgICAgUmV2ZXJ0aW5nIDFkZjRkZTA2MjA2YjA3OWYyNGRkZTcx
NTdkMDM3YjQ4NzI3Yzc0M2QgaXMgdGhlIGJlc3Qgc29sdXRpb24KPj4gICAgIGhlcmUuIEJ1aWxk
aW5nIHB0cmFjZTA3IGFuZCBzaW1pbGFyIGFyY2gtc3BlY2lmaWMgdGVzdHMgd2l0aG91dCBhIGtl
eQo+PiAgICAgcGllY2Ugb2YgY29kZSBkb2VzIG5vdCBtYWtlIHNlbnNlLiBUaGUgcHJlcHJvY2Vz
c29yIGFyY2ggY2hlY2tzIHNob3VsZAo+PiAgICAgd3JhcCBhcm91bmQgdGhlIHdob2xlIGZpbGUs
IG5vdCBqdXN0IGEgc21hbGwgbm9uLXBvcnRhYmxlIGJpdCB0aGF0J3MKPj4gICAgIGNydWNpYWwg
Zm9yIHRoZSB0ZXN0IHRvIHdvcmsuCj4+ICBGcm9tIHdoYXQgSSBrbm93LCBvbmUgb2YgdGhlIHVz
ZXMgb2YgImVtcHR5IG1hY3JvIiBpcyB0bwo+PiBjb25kaXRpb25hbGx5Cj4+IGluY2x1ZGUgY2Vy
dGFpbiBwb3J0aW9ucyBvZiBhIHByb2dyYW0uIEluIHB0cmFjZTA3LCBpdCBpbnZva2VzIHRoYXQg
dXNlbGVzcwo+PiBtYWNybyBmb3IgY29tcGlsaW5nIHBhc3Mgb24gbm9uLXg4NiBhcmNoIGJ1dCBk
b2VzIG5vdCBhbGxvdyBleGVjdXRlIGl0Lgo+PiBJIGRvbid0IHNlZSB3aHkgdGhhdCdzIGNydWNp
YWwgZm9yIGEgdGVzdCwgaWYgd2Ugd3JhcCBhcm91bmQgdGhlCj4+IHdob2xlIGZpbGUgYW5kCj4+
IGF2b2lkIGl0IGNvbXBpbGluZyBvbiBub24teDg2LCBpc24ndCB0aGlzIGVzc2VudGlhbGx5IHNh
bWUgYXMgdGhhdD8KPj4gVGhlIG9ubHkgZGlzdGluY3Rpb27CoGJldHdlZW4gdGhlbSBpcyBwYXJ0
bHkgb3Igd2hvbGx5IHNraXBwaW5nIHRoZQo+PiBrZXkKPj4gY29kZSBjb21waWxhdGlvbi4gb3Ig
bWF5YmUgSSBjb21wbGV0ZWx5IG1pc3VuZGVyc3Rvb2QgdGhpcyBwYXJ0Lgo+Cj4gVGhlIGNvZGUg
dGhhdCB3b3VsZCBiZSBnZW5lcmF0ZWQgYnkgdGhlIG5vbi1lbXB0eSB2ZXJzaW9uIG9mIHRoZSBt
YWNybwo+IGlzIGNydWNpYWwgZm9yIHJlc3Qgb2YgdGhlIHByb2dyYW0gdG8gd29yay4gUHV0dGlu
ZyBjb25kaXRpb25hbCBidWlsZAo+IGRpcmVjdGl2ZXMgb25seSBhcm91bmQgYSBmZXcgbGluZXMg
b2YgY29kZSBjYW4gY2F1c2UgYm9ndXMgd2FybmluZ3MKPiBhYm91dCB1bmluaXRpYWxpemVkIHZh
cmlhYmxlcyBhbmQgbWFrZSBpdCBkaWZmaWN1bHQgdG8gYWRkIG1vcmUKPiBhcmNoLXNwZWNpZmlj
IGNvZGUgbGlrZSB0aGUgY3B1aWRfY291bnQoKSBtYWNyby4gVGhlcmUncyBub3RoaW5nIHdyb25n
Cj4gd2l0aCB3cml0aW5nIHRlc3RzIGxpa2UgdGhpczoKPgo+ICNpbmNsdWRlICJ0c3RfdGVzdC5o
Igo+Cj4gI2lmZGVmIF9feDg2XzY0X18KPiAjaW5jbHVkZSAibGFwaS9jcHVpZC5oIgo+Cj4gdm9p
ZCBzZXR1cCh2b2lkKQo+IHsKPiAJLi4uCj4gfQo+Cj4gdm9pZCBydW4odm9pZCkKPiB7Cj4gCS4u
Lgo+IH0KPgo+IHZvaWQgY2xlYW51cCh2b2lkKQo+IHsKPiAJLi4uCj4gfQo+Cj4gc3RhdGljIHN0
cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+IAkuLi4KPiAJLnN1cHBvcnRlZF9hcmNocyA9IChjb25z
dCBjaGFyICpjb25zdCBbXSkgewo+IAkJIng4Nl82NCIsCj4gCQlOVUxMCj4gCX0sCj4gfTsKPgo+
ICNlbHNlIC8qIF9feDg2XzY0X18gKi8KPiAjZGVmaW5lIFRTVF9URVNUX1RDT05GKCJ0aGlzIHRl
c3QgaXMgb25seSBzdXBwb3J0ZWQgb24geDg2XzY0IikKPiAjZW5kaWYgLyogX194ODZfNjRfXyAq
Lwo+Cj4KPiBJSVVDLCB0aGUgbWV0YWRhdGEgcGFyc2VyIHdpbGwgc3RpbGwgcmVhZCAuc3VwcG9y
dGVkX2FyY2hzIHJlZ2FyZGxlc3MKPiBvZiBjb25kaXRpb25hbCBidWlsZCBkaXJlY3RpdmVzLiBB
bmQgaXQnbGwgcHJldmVudCBlcnJhdGljIHRlc3QKPiBiZWhhdmlvciBpbiBlZGdlIGNhc2VzIHdo
ZXJlIHRoZSBMVFAgbGlicmFyeSBiZWxpZXZlcyB0aGUgY29kZSB3YXMKPiBjb21waWxlZCBmb3Ig
dGhlIHJpZ2h0IGFyY2hpdGVjdHVyZSBidXQgdGhlIEdDQyBwcmVwcm9jZXNzb3IKPiBkaXNhZ3Jl
ZXMuCgpZZXMsIHRoaXMgc291bmRzIHJlYXNvbmFibGUgYW5kIEkgd2lsbCBzdWJtaXQgYSBwYXRj
aCBmb3IgaXQgKG9uIE1vbmRheQp0aG91Z2gpLgoKTXkgcmVtYWluaW5nIGNvbmNlcm4gaXMgdGhh
dCBwZW9wbGUgd2lsbCBpbmNsdWRlIGxhcGkvY3B1aWQuaCAob3IKc2ltaWxhcikgb3V0c2lkZSBv
ZiB0aGUgaWZkZWYgYW5kIGl0IHdpbGwgbm90IGJlIGNhdWdodCB1bnRpbCBpdCdzCm1lcmdlZCBp
bnRvIG1hc3Rlci4KCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
