Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E6C4708A
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:29:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 301683CC5D3
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:29:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 971673C01D2
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:28:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A73541000231
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:28:54 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A8A1821B04;
 Tue, 29 Nov 2022 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669721333;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0WnJisJtkoTgWV8jHOzPXFdlM+9tRN8eqY4zyY1cvU=;
 b=lVL1yQq/JwIlJAWnFngltW5086HGVfx59cWuop37uylCXxYFwnS1U8HcsncQl5asJTFi1B
 nFBdBV3xP0A/ABh9dsNtoThLKShtdteIFAJXLUY4OvneGBLixXgJtX3A1P5o6k8ss9XeV0
 h+7uJo8uUCEfASrVo1IFQtJqfF5kxy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669721333;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0WnJisJtkoTgWV8jHOzPXFdlM+9tRN8eqY4zyY1cvU=;
 b=W0VxJFO/imPCcU7iRvYrhbMukKjdE9Wsk+N1X0oPcpk+6CustI+x6/a102zL2ASkik/Au6
 gQHQyGuxKkJQQFBw==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 624512C141;
 Tue, 29 Nov 2022 11:28:53 +0000 (UTC)
References: <20221123144746.590890-1-tudor.cretu@arm.com>
 <Y4XmlHZyi2DG9DRT@pevik> <Y4Xnt+OsEt94aZRr@pevik> <87mt8at3md.fsf@suse.de>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Nov 2022 11:27:44 +0000
Organization: Linux Private Site
In-reply-to: <87mt8at3md.fsf@suse.de>
Message-ID: <87iliyt2x7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

SGVsbG8sCgpUaGlzIGxvb2tzIHByZXR0eSB0cml2aWFsIHRvIGZpeCBhY3R1YWxseS4gV2Ugc2hv
dWxkbid0IHBhc3MgTlVMTCBhcwptb2RlLiBJZiBpdCB3b3JrcyBJJ2xsIGFkZCB0aGUgZml4IGFu
ZCBwdXNoLgoKUmljaGFyZCBQYWxldGhvcnBlIDxycGFsZXRob3JwZUBzdXNlLmRlPiB3cml0ZXM6
Cgo+IEhlbGxvLAo+Cj4gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyaXRlczoKPgo+Pj4g
SGkgVHVkb3IsCj4+Cj4+PiA+IEFjY2Vzc2luZyBlbGVtZW50cyBpbiBhbiBlbXB0eSB2YV9saXN0
IHJlc3VsdHMgaW4gdW5kZWZpbmVkIGJlaGF2aW91clswXQo+Pj4gPiB0aGF0IGNhbiBpbmNsdWRl
IGFjY2Vzc2luZyBhcmJpdHJhcnkgc3RhY2sgbWVtb3J5LiBXaGlsZSB0eXBpY2FsbHkgdGhpcwo+
Pj4gPiBkb2Vzbid0IHJhaXNlIGEgZmF1bHQsIHNvbWUgbmV3IG1vcmUgc2VjdXJpdHktb3JpZW50
ZWQgYXJjaGl0ZWN0dXJlcwo+Pj4gPiAoZS5nLiBDSEVSSVsxXSBvciBNb3JlbGxvWzJdKSBkb24n
dCBhbGxvdyBpdC4KPj4KPj4+ID4gVGhlcmVmb3JlLCByZW1vdmUgdGhlIHZhcmlhZGljbmVzcyBm
cm9tIHNhZmVfKiB3cmFwcGVycyB0aGF0IGFsd2F5cyBjYWxsCj4+PiA+IHRoZSBmdW5jdGlvbnMg
d2l0aCB0aGUgb3B0aW9uYWwgYXJndW1lbnQgaW5jbHVkZWQuCj4+Cj4+PiA+IEFkYXB0IHRoZSBy
ZXNwZWN0aXZlIFNBRkVfKiBtYWNyb3MgdG8gaGFuZGxlIHRoZSBjaGFuZ2UgYnkgcGFzc2luZyBh
Cj4+PiA+IGRlZmF1bHQgYXJndW1lbnQgaWYgdGhleSdyZSBvbWl0dGVkLgo+Pgo+Pj4gVGhhbmtz
IGZvciBhbiBpbnRlcmVzdGluZyBwYXRjaHNldCEKPj4KPj4+IEkgd29uZGVyIGlmIGl0J3MgYSBj
b3JyZWN0IGFwcHJvYWNoIGFzIEMgQVBJIGFsbG93cwo+Cj4gUGVyaGFwcywgbXVzbGMgZG9lcyB0
aGUgZm9sbG93aW5nIGZvciBvcGVuKCkKPgo+IAlpZiAoKGZsYWdzICYgT19DUkVBVCkgfHwgKGZs
YWdzICYgT19UTVBGSUxFKSA9PSBPX1RNUEZJTEUpIHsKPiAJCXZhX2xpc3QgYXA7Cj4gCQl2YV9z
dGFydChhcCwgZmxhZ3MpOwo+IAkJbW9kZSA9IHZhX2FyZyhhcCwgbW9kZV90KTsKPiAJCXZhX2Vu
ZChhcCk7Cj4gCX0KPgo+IFNvIGl0J3Mgb25seSBhY2Nlc3NlZCBpZiB3ZSBuZWVkIHRoZSBtb2Rl
LiBJZiB0aGUgZXJyb3IgYmVsb3cgY2FuIGJlCj4gZml4ZWQgd2l0aCB0aGUgY3VycmVudCBhcHBy
b2FjaCBJJ2QgYWxzbyBiZSBoYXBweS4KPgo+Cj4+PiBpbnQgb3Blbihjb25zdCBjaGFyICpwYXRo
bmFtZSwgaW50IGZsYWdzKTsKPj4+IHdlIHdpbGwgcmVwbGFjZSBpdCAKPj4+IGludCBvcGVuKGNv
bnN0IGNoYXIgKnBhdGhuYW1lLCBpbnQgZmxhZ3MsIG1vZGVfdCBtb2RlKTsKPj4+IHdoZXJlIG1v
ZGUgaXMgMC4KPj4+IEJ1dCBhcyBpdCdzIG9ubHkgaW4gc2FmZV8qIGl0IHNob3VsZCBiZSBvay4K
Pj4+IFdlIHN0aWxsIGhhdmUgc29tZSBvcGVuKCkgdGVzdHMgd2l0aG91dCBtb2RlLCBpLmUuCj4+
PiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjA2LmMKPj4KPj4+IFVuZm9ydHVu
YXRlbHkgc29tZSB0ZXN0cyBuZWVkIHRvIGJlIGFkanVzdGVkLCBhdCBsZWFzdCBhbGwgdGVzdHMg
aW4KPj4+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmdldHhhdHRyIHdpbGwgZmFpbCBkdWUg
aW50LWNvbnZlcnNpb24sCj4+PiBhcyB0aGV5IHVzZSBOVUxMIGFzIHRoZSB0aGlyZCBwYXJhbWV0
ZXI6Cj4+Cj4+PiAkIGV4cG9ydCBDRkxBR1M9Ii1XZXJyb3I9Y29udmVyc2lvbiIKPj4+ICQgLi9j
b25maWd1cmUKPj4+ICQgY2QgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mZ2V0eGF0dHIKPj4+
ICQgbWFrZSBjbGVhbgo+Pj4gJCBtYWtlIFY9MQo+Pj4gZ2NjIC1JLi4vLi4vLi4vLi4vaW5jbHVk
ZSAtSS4uLy4uLy4uLy4uL2luY2x1ZGUgLUkuLi8uLi8uLi8uLi9pbmNsdWRlL29sZC8gLVdlcnJv
cj1pbnQtY29udmVyc2lvbiAtZyAtTzIgLWZuby1zdHJpY3QtYWxpYXNpbmcgLXBpcGUgLVdhbGwg
LVcgLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtc3RkPWdudTk5IC1MLi4vLi4vLi4vLi4vbGliIGZn
ZXR4YXR0cjAxLmMgIC1sbHRwIC1vIGZnZXR4YXR0cjAxCj4+PiBJbiBmaWxlIGluY2x1ZGVkIGZy
b20gLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfdGVzdC5oOjk4LAo+Pj4gICAgICAgICAgICAgICAg
ICBmcm9tIGZnZXR4YXR0cjAxLmM6MzQ6Cj4+PiBmZ2V0eGF0dHIwMS5jOiBJbiBmdW5jdGlvbiDi
gJhzZXR1cOKAmToKPj4+IC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmg6OTA6
Njc6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDYgb2Yg4oCYc2FmZV9vcGVu4oCZIG1ha2VzIGlu
dGVnZXIgZnJvbSBwb2ludGVyIHdpdGhvdXQgYSBjYXN0IFstV2Vycm9yPWludC1jb252ZXJzaW9u
XQo+Pj4gICAgOTAgfCAgICAgICAgIHNhZmVfb3BlbihfX0ZJTEVfXywgX19MSU5FX18sIE5VTEws
IChwYXRobmFtZSksIChvZmxhZ3MpLCAobW9kZSkpCj4+PiAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fgo+Pgo+Pj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoKPj4+IC4uLy4uLy4uLy4uL2luY2x1ZGUv
dHN0X3NhZmVfbWFjcm9zLmg6OTM6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmF9f
U0FGRV9PUEVO4oCZCj4+PiAgICA5MyB8ICAgICAgICAgX19TQUZFX09QRU4oKHBhdGhuYW1lKSwg
KG9mbGFncyksICMjX19WQV9BUkdTX18sIDApCj4+PiAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+
fn4KPj4+IGZnZXR4YXR0cjAxLmM6MTE0OjE0OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g
4oCYU0FGRV9PUEVO4oCZCj4+PiAgIDExNCB8ICAgICAgICAgZmQgPSBTQUZFX09QRU4oRk5BTUUs
IE9fUkRPTkxZLCBOVUxMKTsKPj4+ICAgICAgIHwgICAgICAgICAgICAgIF5+fn5+fn5+fgo+Pj4g
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9z
Lmg6MjQ6Cj4+PiAuLi8uLi8uLi8uLi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmg6Nzg6MjI6IG5v
dGU6IGV4cGVjdGVkIOKAmG1vZGVfdOKAmSB7YWthIOKAmHVuc2lnbmVkIGludOKAmX0gYnV0IGFy
Z3VtZW50IGlzIG9mIHR5cGUg4oCYdm9pZCAq4oCZCj4+PiAgICA3OCB8ICAgICAgICAgICAgICAg
bW9kZV90IG1vZGUpOwo+Pj4gICAgICAgfCAgICAgICAgICAgICAgIH5+fn5+fn5efn5+Cj4+PiBj
YzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKPj4+IG1ha2U6ICoqKiBb
Li4vLi4vLi4vLi4vaW5jbHVkZS9tay9ydWxlcy5tazo0MzogZmdldHhhdHRyMDFdIEVycm9yIDEK
Pj4KPj4gTk9URTogdGhpcyBpcyBmcm9tIGdjYywgYnV0IG9idmlvdXNseSBhbHNvIGNsYW5nIGhh
cyB0aGUgc2FtZSBwcm9ibGVtLAo+PiBldmVuIHdpdGhvdXQgLVdlcnJvcj1pbnQtY29udmVyc2lv
biBpbiBDRkxBR1MsIG9idmlvdXNseSBpdCdzIHRoZSBkZWZhdWx0Lgo+PiBUaGF0J3Mgd2h5IGl0
IHdhcyBmb3VuZCBvbiBGZWRvcmEsIHdoaWNoIHdlIHRlc3Qgd2l0aCBjbGFuZy4KPj4KPj4gS2lu
ZCByZWdhcmRzLAo+PiBQZXRyCj4+Cj4+PiBGb3VuZCBvbiByZWNlbnQgb3BlblNVU0UgVHVtYmxl
d2VlZCB3aGljaCBoYXMgMi4zNi4gQWxzbyBvdXIgQ0kgaGFzIGNhdWdodCBpdCBvbgo+Pj4gRmVk
b3JhICh3aGljaCBhbHNvIHVzZXMgMi4zNik6Cj4+PiBodHRwczovL2dpdGh1Yi5jb20vcGV2aWsv
bHRwL2FjdGlvbnMvcnVucy8zNTczMjE1MzkwL2pvYnMvNjAwNzAxNjU3Mgo+Pgo+Pj4gS2luZCBy
ZWdhcmRzLAo+Pj4gUGV0cgo+Pgo+Pj4gPiBbMF06IFtJU08vSUVDIDk4OTk6MjAxMV0gUHJvZ3Jh
bW1pbmcgTGFuZ3VhZ2Vz4oCUQywgM3JkIGVkLCBwYXJhZ3JhcGggNy4xNi4xLjEKPj4+ID4gWzFd
OiBodHRwczovL3d3dy5jbC5jYW0uYWMudWsvcmVzZWFyY2gvc2VjdXJpdHkvY3RzcmQvY2hlcmkv
Cj4+PiA+IFsyXTogaHR0cHM6Ly93d3cubW9yZWxsby1wcm9qZWN0Lm9yZy8KPj4KPj4+ID4gVHVk
b3IgQ3JldHUgKDMpOgo+Pj4gPiAgIHNhZmVfb3BlbjogRml4IHVuZGVmaW5lZCBiZWhhdmlvdXIg
aW4gdmFyYXJnIGhhbmRsaW5nCj4+PiA+ICAgc2FmZV9vcGVuYXQ6IEZpeCB1bmRlZmluZWQgYmVo
YXZpb3VyIGluIHZhcmFyZyBoYW5kbGluZwo+Pj4gPiAgIHNhZmVfc2VtY3RsOiBGaXggdW5kZWZp
bmVkIGJlaGF2aW91ciBpbiB2YXJhcmcgaGFuZGxpbmcKPj4KPj4+ID4gIGluY2x1ZGUvb2xkL3Nh
ZmVfbWFjcm9zLmggICB8ICA2ICsrKystLQo+Pj4gPiAgaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5o
ICAgIHwgIDMgKystCj4+PiA+ICBpbmNsdWRlL3RzdF9zYWZlX2ZpbGVfYXQuaCAgfCAxMCArKysr
KystLS0tCj4+PiA+ICBpbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oICAgfCAgNiArKysrLS0KPj4+
ID4gIGluY2x1ZGUvdHN0X3NhZmVfc3lzdl9pcGMuaCB8IDE0ICsrKysrKysrKy0tLS0tCj4+PiA+
ICBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAgICAgfCAxMyArLS0tLS0tLS0tLS0tCj4+PiA+ICBs
aWIvdHN0X2Nncm91cC5jICAgICAgICAgICAgfCAgMiArLQo+Pj4gPiAgbGliL3RzdF9zYWZlX2Zp
bGVfYXQuYyAgICAgIHwgMTEgKysrLS0tLS0tLS0KPj4+ID4gIGxpYi90c3Rfc2FmZV9zeXN2X2lw
Yy5jICAgICB8IDEwICstLS0tLS0tLS0KPj4+ID4gIDkgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0
aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pCgoKLS0gClRoYW5rIHlvdSwKUmljaGFyZC4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
