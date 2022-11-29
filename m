Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A8C4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:14:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D664F3CC5D3
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:13:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CA853C01D2
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:13:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D12CB140044C
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:13:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0E68421AD2;
 Tue, 29 Nov 2022 11:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669720428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mo1HAM3Kcn4CL6A3AR/6xi2XJzs/NLguUqCvLtJl2qM=;
 b=HwLbx8DBBDC6iEuK0KvOjCMERkG8KP2TNf5AcjFs4iOvagFi02K/IqLwkltsGM3sVKKs3Z
 t5mmj0IEnpOsobmta4Aga1awXOn+kW6T0JbBO84+6ZnOBBgE2k5D/Sa0yjBjl8FR/R+TQv
 vwzlhJeCiVlFTl0b1eNkH8MJAEk6Vew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669720428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mo1HAM3Kcn4CL6A3AR/6xi2XJzs/NLguUqCvLtJl2qM=;
 b=F5yHV0G/IK/3wJ4OYbXupFdTa7xaydous+eob6cNhwOVPZkgWT2AlNiny7cfOwsLJhVCP+
 ehPr3Meff/7kYOBg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8A9122C141;
 Tue, 29 Nov 2022 11:13:47 +0000 (UTC)
References: <20221123144746.590890-1-tudor.cretu@arm.com>
 <Y4XmlHZyi2DG9DRT@pevik> <Y4Xnt+OsEt94aZRr@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Nov 2022 11:11:24 +0000
Organization: Linux Private Site
In-reply-to: <Y4Xnt+OsEt94aZRr@pevik>
Message-ID: <87mt8at3md.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] safe_macros: Fix undefined behaviour in
 vararg handling
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

SGVsbG8sCgpQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JpdGVzOgoKPj4gSGkgVHVkb3Is
Cj4KPj4gPiBBY2Nlc3NpbmcgZWxlbWVudHMgaW4gYW4gZW1wdHkgdmFfbGlzdCByZXN1bHRzIGlu
IHVuZGVmaW5lZCBiZWhhdmlvdXJbMF0KPj4gPiB0aGF0IGNhbiBpbmNsdWRlIGFjY2Vzc2luZyBh
cmJpdHJhcnkgc3RhY2sgbWVtb3J5LiBXaGlsZSB0eXBpY2FsbHkgdGhpcwo+PiA+IGRvZXNuJ3Qg
cmFpc2UgYSBmYXVsdCwgc29tZSBuZXcgbW9yZSBzZWN1cml0eS1vcmllbnRlZCBhcmNoaXRlY3R1
cmVzCj4+ID4gKGUuZy4gQ0hFUklbMV0gb3IgTW9yZWxsb1syXSkgZG9uJ3QgYWxsb3cgaXQuCj4K
Pj4gPiBUaGVyZWZvcmUsIHJlbW92ZSB0aGUgdmFyaWFkaWNuZXNzIGZyb20gc2FmZV8qIHdyYXBw
ZXJzIHRoYXQgYWx3YXlzIGNhbGwKPj4gPiB0aGUgZnVuY3Rpb25zIHdpdGggdGhlIG9wdGlvbmFs
IGFyZ3VtZW50IGluY2x1ZGVkLgo+Cj4+ID4gQWRhcHQgdGhlIHJlc3BlY3RpdmUgU0FGRV8qIG1h
Y3JvcyB0byBoYW5kbGUgdGhlIGNoYW5nZSBieSBwYXNzaW5nIGEKPj4gPiBkZWZhdWx0IGFyZ3Vt
ZW50IGlmIHRoZXkncmUgb21pdHRlZC4KPgo+PiBUaGFua3MgZm9yIGFuIGludGVyZXN0aW5nIHBh
dGNoc2V0IQo+Cj4+IEkgd29uZGVyIGlmIGl0J3MgYSBjb3JyZWN0IGFwcHJvYWNoIGFzIEMgQVBJ
IGFsbG93cwoKUGVyaGFwcywgbXVzbGMgZG9lcyB0aGUgZm9sbG93aW5nIGZvciBvcGVuKCkKCglp
ZiAoKGZsYWdzICYgT19DUkVBVCkgfHwgKGZsYWdzICYgT19UTVBGSUxFKSA9PSBPX1RNUEZJTEUp
IHsKCQl2YV9saXN0IGFwOwoJCXZhX3N0YXJ0KGFwLCBmbGFncyk7CgkJbW9kZSA9IHZhX2FyZyhh
cCwgbW9kZV90KTsKCQl2YV9lbmQoYXApOwoJfQoKU28gaXQncyBvbmx5IGFjY2Vzc2VkIGlmIHdl
IG5lZWQgdGhlIG1vZGUuIElmIHRoZSBlcnJvciBiZWxvdyBjYW4gYmUKZml4ZWQgd2l0aCB0aGUg
Y3VycmVudCBhcHByb2FjaCBJJ2QgYWxzbyBiZSBoYXBweS4KCgo+PiBpbnQgb3Blbihjb25zdCBj
aGFyICpwYXRobmFtZSwgaW50IGZsYWdzKTsKPj4gd2Ugd2lsbCByZXBsYWNlIGl0IAo+PiBpbnQg
b3Blbihjb25zdCBjaGFyICpwYXRobmFtZSwgaW50IGZsYWdzLCBtb2RlX3QgbW9kZSk7Cj4+IHdo
ZXJlIG1vZGUgaXMgMC4KPj4gQnV0IGFzIGl0J3Mgb25seSBpbiBzYWZlXyogaXQgc2hvdWxkIGJl
IG9rLgo+PiBXZSBzdGlsbCBoYXZlIHNvbWUgb3BlbigpIHRlc3RzIHdpdGhvdXQgbW9kZSwgaS5l
Lgo+PiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjA2LmMKPgo+PiBVbmZvcnR1
bmF0ZWx5IHNvbWUgdGVzdHMgbmVlZCB0byBiZSBhZGp1c3RlZCwgYXQgbGVhc3QgYWxsIHRlc3Rz
IGluCj4+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRyIHdpbGwgZmFpbCBkdWUg
aW50LWNvbnZlcnNpb24sCj4+IGFzIHRoZXkgdXNlIE5VTEwgYXMgdGhlIHRoaXJkIHBhcmFtZXRl
cjoKPgo+PiAkIGV4cG9ydCBDRkxBR1M9Ii1XZXJyb3I9Y29udmVyc2lvbiIKPj4gJCAuL2NvbmZp
Z3VyZQo+PiAkIGNkIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRyCj4+ICQgbWFr
ZSBjbGVhbgo+PiAkIG1ha2UgVj0xCj4+IGdjYyAtSS4uLy4uLy4uLy4uL2luY2x1ZGUgLUkuLi8u
Li8uLi8uLi9pbmNsdWRlIC1JLi4vLi4vLi4vLi4vaW5jbHVkZS9vbGQvIC1XZXJyb3I9aW50LWNv
bnZlcnNpb24gLWcgLU8yIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1waXBlIC1XYWxsIC1XIC1Xb2xk
LXN0eWxlLWRlZmluaXRpb24gLXN0ZD1nbnU5OSAtTC4uLy4uLy4uLy4uL2xpYiBmZ2V0eGF0dHIw
MS5jICAtbGx0cCAtbyBmZ2V0eGF0dHIwMQo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4v
Li4vLi4vaW5jbHVkZS90c3RfdGVzdC5oOjk4LAo+PiAgICAgICAgICAgICAgICAgIGZyb20gZmdl
dHhhdHRyMDEuYzozNDoKPj4gZmdldHhhdHRyMDEuYzogSW4gZnVuY3Rpb24g4oCYc2V0dXDigJk6
Cj4+IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmg6OTA6Njc6IGVycm9yOiBw
YXNzaW5nIGFyZ3VtZW50IDYgb2Yg4oCYc2FmZV9vcGVu4oCZIG1ha2VzIGludGVnZXIgZnJvbSBw
b2ludGVyIHdpdGhvdXQgYSBjYXN0IFstV2Vycm9yPWludC1jb252ZXJzaW9uXQo+PiAgICA5MCB8
ICAgICAgICAgc2FmZV9vcGVuKF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBhdGhuYW1lKSwg
KG9mbGFncyksIChtb2RlKSkKPj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4KPgo+PiAgICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKgo+PiAuLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5o
OjkzOjk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX1NBRkVfT1BFTuKAmQo+PiAg
ICA5MyB8ICAgICAgICAgX19TQUZFX09QRU4oKHBhdGhuYW1lKSwgKG9mbGFncyksICMjX19WQV9B
UkdTX18sIDApCj4+ICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fgo+PiBmZ2V0eGF0dHIwMS5j
OjExNDoxNDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFNBRkVfT1BFTuKAmQo+PiAg
IDExNCB8ICAgICAgICAgZmQgPSBTQUZFX09QRU4oRk5BTUUsIE9fUkRPTkxZLCBOVUxMKTsKPj4g
ICAgICAgfCAgICAgICAgICAgICAgXn5+fn5+fn5+Cj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAu
Li8uLi8uLi8uLi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oOjI0Ogo+PiAuLi8uLi8uLi8uLi9p
bmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmg6Nzg6MjI6IG5vdGU6IGV4cGVjdGVkIOKAmG1vZGVfdOKA
mSB7YWthIOKAmHVuc2lnbmVkIGludOKAmX0gYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUg4oCYdm9p
ZCAq4oCZCj4+ICAgIDc4IHwgICAgICAgICAgICAgICBtb2RlX3QgbW9kZSk7Cj4+ICAgICAgIHwg
ICAgICAgICAgICAgICB+fn5+fn5+Xn5+fgo+PiBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJl
YXRlZCBhcyBlcnJvcnMKPj4gbWFrZTogKioqIFsuLi8uLi8uLi8uLi9pbmNsdWRlL21rL3J1bGVz
Lm1rOjQzOiBmZ2V0eGF0dHIwMV0gRXJyb3IgMQo+Cj4gTk9URTogdGhpcyBpcyBmcm9tIGdjYywg
YnV0IG9idmlvdXNseSBhbHNvIGNsYW5nIGhhcyB0aGUgc2FtZSBwcm9ibGVtLAo+IGV2ZW4gd2l0
aG91dCAtV2Vycm9yPWludC1jb252ZXJzaW9uIGluIENGTEFHUywgb2J2aW91c2x5IGl0J3MgdGhl
IGRlZmF1bHQuCj4gVGhhdCdzIHdoeSBpdCB3YXMgZm91bmQgb24gRmVkb3JhLCB3aGljaCB3ZSB0
ZXN0IHdpdGggY2xhbmcuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4+IEZvdW5kIG9uIHJl
Y2VudCBvcGVuU1VTRSBUdW1ibGV3ZWVkIHdoaWNoIGhhcyAyLjM2LiBBbHNvIG91ciBDSSBoYXMg
Y2F1Z2h0IGl0IG9uCj4+IEZlZG9yYSAod2hpY2ggYWxzbyB1c2VzIDIuMzYpOgo+PiBodHRwczov
L2dpdGh1Yi5jb20vcGV2aWsvbHRwL2FjdGlvbnMvcnVucy8zNTczMjE1MzkwL2pvYnMvNjAwNzAx
NjU3Mgo+Cj4+IEtpbmQgcmVnYXJkcywKPj4gUGV0cgo+Cj4+ID4gWzBdOiBbSVNPL0lFQyA5ODk5
OjIwMTFdIFByb2dyYW1taW5nIExhbmd1YWdlc+KAlEMsIDNyZCBlZCwgcGFyYWdyYXBoIDcuMTYu
MS4xCj4+ID4gWzFdOiBodHRwczovL3d3dy5jbC5jYW0uYWMudWsvcmVzZWFyY2gvc2VjdXJpdHkv
Y3RzcmQvY2hlcmkvCj4+ID4gWzJdOiBodHRwczovL3d3dy5tb3JlbGxvLXByb2plY3Qub3JnLwo+
Cj4+ID4gVHVkb3IgQ3JldHUgKDMpOgo+PiA+ICAgc2FmZV9vcGVuOiBGaXggdW5kZWZpbmVkIGJl
aGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPj4gPiAgIHNhZmVfb3BlbmF0OiBGaXggdW5kZWZp
bmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPj4gPiAgIHNhZmVfc2VtY3RsOiBGaXgg
dW5kZWZpbmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPgo+PiA+ICBpbmNsdWRlL29s
ZC9zYWZlX21hY3Jvcy5oICAgfCAgNiArKysrLS0KPj4gPiAgaW5jbHVkZS9zYWZlX21hY3Jvc19m
bi5oICAgIHwgIDMgKystCj4+ID4gIGluY2x1ZGUvdHN0X3NhZmVfZmlsZV9hdC5oICB8IDEwICsr
KysrKy0tLS0KPj4gPiAgaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCAgIHwgIDYgKysrKy0tCj4+
ID4gIGluY2x1ZGUvdHN0X3NhZmVfc3lzdl9pcGMuaCB8IDE0ICsrKysrKysrKy0tLS0tCj4+ID4g
IGxpYi9zYWZlX21hY3Jvcy5jICAgICAgICAgICB8IDEzICstLS0tLS0tLS0tLS0KPj4gPiAgbGli
L3RzdF9jZ3JvdXAuYyAgICAgICAgICAgIHwgIDIgKy0KPj4gPiAgbGliL3RzdF9zYWZlX2ZpbGVf
YXQuYyAgICAgIHwgMTEgKysrLS0tLS0tLS0KPj4gPiAgbGliL3RzdF9zYWZlX3N5c3ZfaXBjLmMg
ICAgIHwgMTAgKy0tLS0tLS0tLQo+PiA+ICA5IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KyksIDQ0IGRlbGV0aW9ucygtKQoKCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
