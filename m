Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB9C83F10
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 08:42:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F5573CBDD0
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 10:42:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 396753C9422
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 10:42:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2C9841002888
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 10:42:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 751311F45E;
 Thu, 31 Aug 2023 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693471342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiByCE7tGCmnse/G2nds93nowJh86husDMveVuDRS2Q=;
 b=xtvCMmBS4c6GDjqo+aOIaDPtxBe5tMCQnnO4CiQdh50Q1vInHi09TlPwYYXxOwleK3gHMj
 tO3UVKOzyEbdHWczCdrDdOzKEYNXpJdqLkXpOkEWnlFGOyuXqeNkci63c0RQWEs2Xy6ksd
 m9hitEw+uhFk3YDgP4yNQAvrUQWeeKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693471342;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiByCE7tGCmnse/G2nds93nowJh86husDMveVuDRS2Q=;
 b=3Uhzn5Ez3tmV72XVAoBaAuw5SjgBtRyqSwmM0sp3/Q2tiHDFHNrvNdZBv5C8PI7WD4nMoU
 F7BQc5zvnTyXFoCw==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AC81E2C142;
 Thu, 31 Aug 2023 08:42:20 +0000 (UTC)
References: <20230830064250.31904-1-zhanghongchen@loongson.cn>
 <87r0nlhsh7.fsf@suse.de>
 <d9b87423-f3e3-1585-1f3a-3821622ef040@loongson.cn>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Date: Thu, 31 Aug 2023 09:27:16 +0100
Organization: Linux Private Site
In-reply-to: <d9b87423-f3e3-1585-1f3a-3821622ef040@loongson.cn>
Message-ID: <871qfjiowk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cpuset_memory_spread: set lowerlimit according
 to pagesize
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

SGVsbG8sCgpIb25nY2hlbiBaaGFuZyA8emhhbmdob25nY2hlbkBsb29uZ3Nvbi5jbj4gd3JpdGVz
OgoKPiBIaSBSaWNoYXJkLAo+Cj4gT24gMjAyMy84LzMwIOS4i+WNiDM6NDUsIFJpY2hhcmQgUGFs
ZXRob3JwZSB3cm90ZToKPj4gSGVsbG8sCj4+IEhvbmdjaGVuIFpoYW5nIDx6aGFuZ2hvbmdjaGVu
QGxvb25nc29uLmNuPiB3cml0ZXM6Cj4+IAo+Pj4gV2hlbiBJIHRlc3QgdGhlIGNwdXNldF9tZW1v
cnlfc3ByZWFkIGNhc2UsdGhpcyBjYXNlIEZBSUwgdG9vIG9mdGVuLgo+Pj4gQWZ0ZXIgZGlnIGlu
dG8gdGhlIGNvZGUsIEkgZmluZCBvdXQgdGhhdCB0aGUgZm93bGxvaW5nIHRoaW5ncyB0cmlnZ2Vy
Cj4+PiB0aGUgRkFJTDoKPj4+IDEpIHJhbmRvbSBldmVudHMsdGhlIHByb2JhYmlsaXR5IGlzIHZl
cnkgc21hbGwgYW5kIGNhbiBiZSBpZ25vcmVkCj4+PiAyKSBnZXRfbWVtaW5mbyB3aGljaCBiZWZv
cmUgc2VuZCBzaWduYWwgdG8gdGVzdF9waWQKPj4+IDMpIGFjY291bnRfbWVtc2luZm8gYmVmb3Jl
IHJlc3VsdF9jaGVjawo+Pj4KPj4+IEFib3V0IDIpIGFuZCAzKSwgd2UgY2FuIGluY3JlYXNlIHRo
ZSB2YWx1ZSBvZiBsb3dlcmxpbWl0IHRvIGtlZXAKPj4+IHRoZSByZXN1bHQgYXMgU1VDQ0VTUy4K
Pj4+Cj4+PiBBZnRlciBkaXNjdXNzaW5nIHdpdGggUmljaGFyZCwgd2UgYWxsIGFncmVlIHRvIHVz
ZSB0aGUgZm9sbG93aW5nCj4+PiBmb3JtdWxhIHRvIGNhbGN1bGF0ZSB0aGUgbG93ZXJsaW1pdDoK
Pj4+IGxvd2VybGltaXQoa2IpID0gcGFnZXNpemUoYnl0ZSkgKiA1MTIgLyAxMDI0Cj4+Pgo+Pj4g
U2lnbmVkLW9mZi1ieTogSG9uZ2NoZW4gWmhhbmcgPHpoYW5naG9uZ2NoZW5AbG9vbmdzb24uY24+
Cj4+PiAtLS0KPj4+ICAgLi4uL2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3RzZXQuc2ggICAgICAg
ICAgICAgICAgICAgIHwgMTAgKysrKysrKysrLQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdAo+Pj4gYS90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0L2Nw
dXNldF9tZW1vcnlfc3ByZWFkX3Rlc3RzZXQuc2gKPj4+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250
cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9zcHJlYWRfdGVzdC9jcHVzZXRfbWVtb3J5X3Nw
cmVhZF90ZXN0c2V0LnNoCj4+PiBpbmRleCBlMjc2N2VmMDUuLmY3MjMwYTRlYSAxMDA3NTUKPj4+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9tZW1vcnlf
c3ByZWFkX3Rlc3QvY3B1c2V0X21lbW9yeV9zcHJlYWRfdGVzdHNldC5zaAo+Pj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9zcHJlYWRfdGVz
dC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0c2V0LnNoCj4+PiBAQCAtMzgsNyArMzgsMTUgQEAg
bnJfbWVtcz0kTl9OT0RFUwo+Pj4gICAjIG9uIHdoaWNoIGl0IGlzIHJ1bm5pbmcuIFRoZSBvdGhl
ciBub2Rlcycgc2xhYiBzcGFjZSBoYXMgbGl0dGxlciBjaGFuZ2UuKGxlc3MKPj4+ICAgIyB0aGFu
IDEwMDAga2IpLgo+Pj4gICB1cHBlcmxpbWl0PTEwMDAwCj4+PiAtbG93ZXJsaW1pdD0yMDAwCj4+
PiArCj4+PiArIyBzZXQgbG93ZXJsaW1pdCBhY2NvcmRpbmcgdG8gcGFnZXNpemUKPj4+ICsjIHBh
Z2VzaXplKGJ5dGVzKSAgfCBsb3dlcmxpbWl0KGtiKQo+Pj4gKyMgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4+PiArIyAgNDA5NiAgICAgICAgICAgIHwgMjA0OAo+Pj4gKyMg
IDE2Mzg0ICAgICAgICAgICB8IDgxOTIKPj4+ICsKPj4+ICtQQUdFX1NJWkU9YHRzdF9nZXRjb25m
IFBBR0VTSVpFYAo+Pj4gK2xvd2VybGltaXQ9JCgoUEFHRV9TSVpFICogNTEyIC8gMTAyNCkpCj4+
PiAgICAgY3B1c19hbGw9IiQoc2VxIC1zLCAwICQoKG5yX2NwdXMtMSkpKSIKPj4+ICAgbWVtc19h
bGw9IiQoc2VxIC1zLCAwICQoKG5yX21lbXMtMSkpKSIKPj4+Cj4+PiBiYXNlLWNvbW1pdDogMDIw
ZjM5ODVhNWNhODZjOGJiZWNlMjdlZWY4ZmIwMzE1YTEwNDYzZQo+PiBJZiB3ZSBkb24ndCBzZXQg
dGhlIHVwcGVybGltaXQgd2hhdCBoYXBwZW5zIGlmIHdlIGhhdmUgNjRLYiBwYWdlcwo+PiBhbmQK
Pj4gdGhlIGxvd2VybGltaXQgPiB1cHBlcmxpbWl0Pwo+Cj4gVGhlIGxvd2VybGltaXQgaXMgdXNl
ZCB0byBsaW1pdCB0aGUgbWF4IHZhbHVlIG9uIG90aGVyIG5vZGVzIGFuZCB0aGUKPiB1cHBlcmxp
bWl0IGlzIHVzZWQgdG8gbGltaXQgdGhlIG1pbiB2YWx1ZSBvbiB0aGUgZXhwZWN0ZWQgbm9kZS4K
PiBTbyB0aGVyZSBpcyBubyBwcm9ibGVtIGlmIGxvd2VybGltaXQgPiB1cHBlcmxpbWl0Lgo+PiAK
Cldvbid0IHRoaXMgY2F1c2UgZmFsc2UgbmVnYXRpdmVzIG9uIHN5c3RlbXMgd2l0aCBsYXJnZXIg
cGFnZSBzaXplcz8KCkkgaGF2ZSBtZXJnZWQgaXQgaG93ZXZlciBiZWNhdXNlIHJpZ2h0IG5vdyB0
aGUgdGVzdCBpcyBtb3N0IGxpa2VseSBqdXN0CmEgc291cmNlIG9mIGZhbHNlIHBvc2l0aXZlcy4K
Ci0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
