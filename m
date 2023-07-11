Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F29FEB64DC
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 08:05:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99E483CDEC2
	for <ltp@archiver.kernel.org>; Tue, 11 Jul 2023 10:05:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 367193C2FB1
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 10:05:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 03B9F140053B
 for <ltp@lists.linux.it>; Tue, 11 Jul 2023 10:05:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53CE920464;
 Tue, 11 Jul 2023 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689062724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0alISHvoFhy/mNUZKiVyYaNgs6jWpA1m4gQQ9c9+IU=;
 b=O+I2N8iIwPw11b7Lw/9ONCIqVOzbZ6CZNXYn9cL35G553vqP3a5mnH+uphQCeR1Vok+j4u
 bvofaGmS5Y+4nozcjHPl7MwEBjsMtDLa0biuBq1nuiWZ9SFttdzbPZRPK9dFm+MsFZGWEM
 xt2vWtDdJD2eoBXv5HWES4Dt8zxgIEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689062724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0alISHvoFhy/mNUZKiVyYaNgs6jWpA1m4gQQ9c9+IU=;
 b=HkN7eDdHUl/5h9aelhYXnNgCl9nn/afOSNIi3Vd5CXuHmG+Rq2xGZuE46XUTsaJrBn91iv
 xoXcSHQaRuCzHWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 122041391C;
 Tue, 11 Jul 2023 08:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8AO4AUQNrWQpNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 11 Jul 2023 08:05:24 +0000
Date: Tue, 11 Jul 2023 10:05:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230711080522.GA705589@pevik>
References: <20230710141403.1155151-1-amir73il@gmail.com>
 <20230710155006.GA659329@pevik>
 <CAOQ4uxjUkLo_MX+nxM1KFp66+C6c5zr75GAgpA0RZofZm7sfgw@mail.gmail.com>
 <20230711063404.GA693714@pevik>
 <CAOQ4uxhhUyFVUiOqVpTb6k31bCxLhqV1ihkGNi2Y0_Sk4Yu_TA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhhUyFVUiOqVpTb6k31bCxLhqV1ihkGNi2Y0_Sk4Yu_TA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify14: Test disallow sb/mount mark on
 anonymous pipe
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUdWUsIEp1bCAxMSwgMjAyMyBhdCA5OjM04oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgNjo1MOKAr1BNIFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiA+ID4gSGkgQW1pciwKCj4gPiA+
ID4gPiBUaGlzIGNhc2Ugd2FzIHJldHJvYWN0aXZlbHkgZGlzYWxsb3dlZC4KCj4gPiA+ID4gPiBU
aGlzIHRlc3QgaXMgbWVhbnQgdG8gZW5jb3VyYWdlIHRoZSBiYWNrcG9ydGluZyBvZiBjb21taXQg
Njk1NjJlYjBiZDNlCj4gPiA+ID4gPiAoImZhbm90aWZ5OiBkaXNhbGxvdyBtb3VudC9zYiBtYXJr
cyBvbiBrZXJuZWwgaW50ZXJuYWwgcHNldWRvIGZzIikgdG8KPiA+ID4gPiA+IGFsbCBzdGFibGUg
a2VybmVscy4KCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPgo+ID4gPiA+ID4gLS0tCgo+ID4gPiA+ID4gUGV0ciwKCj4gPiA+ID4gPiBU
aGlzIHRlc3RzIGZvciBhIGJlaGF2aW9yIHRoYXQgd2UgY29uc2lkZXIgYnJva2VuIHNpbmNlIHRo
ZSBkYXduIG9mCj4gPiA+ID4gPiBmYW5vdGlmeS4KCj4gPiA+ID4gPiBUaGUgZml4IHdhcyBtZXJn
ZWQgdG8gdjYuNS1yYzEuCj4gPiA+ID4gPiBJJ3ZlIGFscmVhZHkgcG9zdGVkIGJhY2twb3J0IHBh
dGNoZXMgZm9yIGtlcm5lbHMgPiB2NS4wLgo+ID4gPiA+ID4gSSBhbSBub3QgcGxhbm5pbmcgdG8g
cG9zdCBiYWNrcG9ydCBwYXRjaGVzIGZvciBvbGRlciBrZXJuZWxzLgoKPiA+ID4gPiBJIHNlZQo+
ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8yMDIzMDcxMDEzMzIwNS4xMTU0
MTY4LTEtYW1pcjczaWxAZ21haWwuY29tLwoKPiA+ID4gPiBJJ2xsIHN1Z2dlc3QgdG8gd2FpdCB0
aWxsIEdyZWcgcmVsZWFzZXMgdGhlIGJhY2twb3J0IChzaG91bGQgYmUgcXVpY2sgZW5vdWdoKS4K
Cgo+ID4gPiBvay4KCj4gPiA+ID4gPiBFdmVuIHRob3VnaCB0aGUgdHdvIG5ldyB0ZXN0IGNhc2Vz
IGRvIG5vdCB1c2UgRkFOX1JFUE9SVF9GSUQsCj4gPiA+ID4gPiBmYW5vdGlmeTE0IHJlcXVpcmVz
IEZBTl9SRVBPUlRfRklELCBzbyBpdCBpcyBub3QgZ29pbmcgdG8gcnVuIHRoZXNlCj4gPiA+ID4g
PiB0ZXN0IGNhc2VzIG9uIGtlcm5lbCA8IHY1LjEgYW55d2F5LgoKPiA+ID4gPiA+IFRoYW5rcywK
PiA+ID4gPiA+IEFtaXIuCgo+ID4gPiA+ID4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkv
ZmFub3RpZnkxNC5jICAgICB8IDMyICsrKysrKysrKysrKysrKysrLS0KPiA+ID4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0
LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+ID4g
PiA+ID4gaW5kZXggYmZhMDM0OWZlLi4wNjNhOWY5NmYgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+ID4gPiA+ID4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPiA+
ID4gPiA+IEBAIC0xOSw2ICsxOSw5IEBACj4gPiA+ID4gPiAgICoKPiA+ID4gPiA+ICAgKiAgICAg
Y2VhZjY5ZjhlYWRjIGZhbm90aWZ5OiBkbyBub3QgYWxsb3cgc2V0dGluZyBkaXJlbnQgZXZlbnRz
IGluIG1hc2sgb2Ygbm9uLWRpcgo+ID4gPiA+ID4gICAqICAgICA4Njk4ZTNiYWI0ZGQgZmFub3Rp
Znk6IHJlZmluZSB0aGUgdmFsaWRhdGlvbiBjaGVja3Mgb24gbm9uLWRpciBpbm9kZSBtYXNrCj4g
PiA+ID4gPiArICoKPiA+ID4gPiA+ICsgKiBUaGUgcGlwZXMgdGVzdCBjYXNlcyBhcmUgcmVncmVz
c2lvbiB0ZXN0cyBmb3IgY29tbWl0Ogo+ID4gPiA+ID4gKyAqICAgICA2OTU2MmViMGJkM2UgZmFu
b3RpZnk6IGRpc2FsbG93IG1vdW50L3NiIG1hcmtzIG9uIGtlcm5lbCBpbnRlcm5hbCBwc2V1ZG8g
ZnMKPiA+ID4gPiA+ICAgKi8KCj4gPiA+ID4gPiAgI2RlZmluZSBfR05VX1NPVVJDRQo+ID4gPiA+
ID4gQEAgLTQwLDYgKzQzLDcgQEAKCj4gPiA+ID4gPiAgI2RlZmluZSBGTEFHU19ERVNDKGZsYWdz
KSB7KGZsYWdzKSwgKCNmbGFncyl9Cgo+ID4gPiA+ID4gK3N0YXRpYyBpbnQgcGlwZXNbMl0gPSB7
LTEsIC0xfTsKPiA+ID4gPiA+ICBzdGF0aWMgaW50IGZhbm90aWZ5X2ZkOwo+ID4gPiA+ID4gIHN0
YXRpYyBpbnQgZmFuX3JlcG9ydF90YXJnZXRfZmlkX3Vuc3VwcG9ydGVkOwo+ID4gPiA+ID4gIHN0
YXRpYyBpbnQgaWdub3JlX21hcmtfdW5zdXBwb3J0ZWQ7Cj4gPiA+ID4gPiBAQCAtNjAsNiArNjQs
NyBAQCBzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiA+ID4gPiA+ICAgICAgIC8qIHdoZW4g
bWFzay5mbGFncyA9PSAwLCBmYW5vdGlmeV9pbml0KCkgaXMgZXhwZWN0ZWQgdG8gZmFpbCAqLwo+
ID4gPiA+ID4gICAgICAgc3RydWN0IHRlc3RfY2FzZV9mbGFnc190IG1hc2s7Cj4gPiA+ID4gPiAg
ICAgICBpbnQgZXhwZWN0ZWRfZXJybm87Cj4gPiA+ID4gPiArICAgICBpbnQgKnBmZDsKCj4gPiA+
ID4gVGhpcyBwcm9kdWNlcyB3YXJuaW5nczoKPiA+ID4gPiBmYW5vdGlmeTE0LmM6NzA6OTogd2Fy
bmluZzogbWlzc2luZyBpbml0aWFsaXplciBmb3IgZmllbGQg4oCYcGZk4oCZIG9mIOKAmHN0cnVj
dCB0ZXN0X2Nhc2VfdOKAmSBbLVdtaXNzaW5nLWZpZWxkLWluaXRpYWxpemVyc10KPiA+ID4gPiAg
ICA3MCB8ICAgICAgICAge0ZMQUdTX0RFU0MoRkFOX0NMQVNTX0NPTlRFTlQgfCBGQU5fUkVQT1JU
X0ZJRCksIHt9LCB7fSwgRUlOVkFMfSwKPiA+ID4gPiAgICAgICB8ICAgICAgICAgXgo+ID4gPiA+
IGZhbm90aWZ5MTQuYzo2NzoxNDogbm90ZTog4oCYcGZk4oCZIGRlY2xhcmVkIGhlcmUKPiA+ID4g
PiAgICA2NyB8ICAgICAgICAgaW50ICpwZmQ7Cj4gPiA+ID4gICAgICAgfCAgICAgICAgICAgICAg
Xn5+Cj4gPiA+ID4gZmFub3RpZnkxNC5jOjczOjk6IHdhcm5pbmc6IG1pc3NpbmcgaW5pdGlhbGl6
ZXIgZm9yIGZpZWxkIOKAmHBmZOKAmSBvZiDigJhzdHJ1Y3QgdGVzdF9jYXNlX3TigJkgWy1XbWlz
c2luZy1maWVsZC1pbml0aWFsaXplcnNdCj4gPiA+ID4gICAgNzMgfCAgICAgICAgIHtGTEFHU19E
RVNDKEZBTl9DTEFTU19QUkVfQ09OVEVOVCB8IEZBTl9SRVBPUlRfRklEKSwge30sIHt9LCBFSU5W
QUx9LAo+ID4gPiA+ICAgICAgIHwgICAgICAgICBeCj4gPiA+ID4gZmFub3RpZnkxNC5jOjY3OjE0
OiBub3RlOiDigJhwZmTigJkgZGVjbGFyZWQgaGVyZQo+ID4gPiA+ICAgIDY3IHwgICAgICAgICBp
bnQgKnBmZDsKPiA+ID4gPiAgICAgICB8ICAgICAgICAgICAgICBefn4KCj4gPiA+ID4gQ291bGQg
eW91IHBsZWFzZSBmaXggdGhlbT8gSSBndWVzcyBwZmQgbXVzdCBiZSBOVUxMIHdoZW4gdW51c2Vk
LgoKCj4gPiA+IG9rLiBidXQgSSBoYXZlIHRvIGFzaywKPiA+ID4gd2hhdCBpcyB0aGUgdmFsdWUg
b2YgZXhwbGljaXRseSBpbml0aWFsaXppbmcgYWxsIHRoZSBvbGQgdGVzdCBjYXNlcyB0bwo+ID4g
PiBwZmQgPSBOVUxMPwo+ID4gPiBhbmQgd2hhdCBpcyB3cm9uZyB3aXRoIGRlZmF1bHQgTlVMTCBp
bml0aWFsaXplcnM/Cj4gPiA+IElzIGl0IGEgZGVsaWJlcmF0ZSBkZWNpc2lvbiBvZiBMVFAgdG8g
Y2FyZSBhYm91dCB0aGlzIHdhcm5pbmc/Cj4gPiA+IGl0J3MgYSBjbGFzc2ljIHBhdHRlcm4gZm9y
IHdoYXQgdGhpcyBwYXRjaCBkb2VzIC0KPiA+ID4gYWRkIGEgbmV3IGZpZWxkIHRvIHRlc3QgY2Fz
ZSB3aGljaCBhbGwgdGhlIGV4aXN0aW5nIHRlc3QgY2FzZXMKPiA+ID4gc2hvdWxkIG5vdCBjYXJl
IGFib3V0LgoKPiA+IFdlbGwsIHdlIHRyeSB0byBhdm9pZCB3YXJuaW5ncyBpbiBuZXcgQVBJIHRl
c3RzIChhbmQgcmV3cml0aW5nIGxlZ2FjeSBBUEkgdGVzdHMKPiA+IGludG8gbmV3IEFQSSB0byBj
bGVhbnVwIHRoZSBjb2RlKS4KCj4gPiBUaGUgc29sdXRpb24gdG8gYXZvaWQgd2FybmluZ3MgaXMg
dG8gdXNlIGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXJzIChuYW1lZAo+ID4gaW5pdGlhbGl6ZXJzKSwg
dGhlIHNhbWUgd2F5IGFzIGluIGVkZTdmMDk1ZSAoImZhbm90aWZ5MTA6IFVzZSBuYW1lZAo+ID4g
aW5pdGlhbGl6ZXJzIik6Cgo+ID4gICAgICAgICAvKiBGQU5fUkVQT1JUX0ZJRCB3aXRob3V0IGNs
YXNzIEZBTl9DTEFTU19OT1RJRiBpcyBub3QgdmFsaWQgKi8KPiA+ICAgICAgICAgewo+ID4gICAg
ICAgICAgICAgICAgIC5pbml0ID0gRkxBR1NfREVTQyhGQU5fQ0xBU1NfQ09OVEVOVCB8IEZBTl9S
RVBPUlRfRklEKSwKPiA+ICAgICAgICAgICAgICAgICAuZXhwZWN0ZWRfZXJybm8gPSBFSU5WQUwK
PiA+ICAgICAgICAgfSwKCj4gPiAgICAgICAgIC8qIEZBTl9SRVBPUlRfRklEIHdpdGhvdXQgY2xh
c3MgRkFOX0NMQVNTX05PVElGIGlzIG5vdCB2YWxpZCAqLwo+ID4gICAgICAgICB7Cj4gPiAgICAg
ICAgICAgICAgICAgLmluaXQgPSBGTEFHU19ERVNDKEZBTl9DTEFTU19QUkVfQ09OVEVOVCB8IEZB
Tl9SRVBPUlRfRklEKSwKPiA+ICAgICAgICAgICAgICAgICAuZXhwZWN0ZWRfZXJybm8gPSBFSU5W
QUwKPiA+ICAgICAgICAgfSwKCj4gPiAgICAgICAgIC4uLgo+ID4gICAgICAgICB7Cj4gPiAgICAg
ICAgICAgICAgICAgLmluaXQgPSBGTEFHU19ERVNDKEZBTl9DTEFTU19OT1RJRiksCj4gPiAgICAg
ICAgICAgICAgICAgLm1hcmsgPSBGTEFHU19ERVNDKEZBTl9NQVJLX0ZJTEVTWVNURU0pLAo+ID4g
ICAgICAgICAgICAgICAgIC5tYXNrID0geyBGQU5fQUNDRVNTLCAiYW5vbnltb3VzIHBpcGUifSwK
PiA+ICAgICAgICAgICAgICAgICAuZXhwZWN0ZWRfZXJybm8gPSBFSU5WQUwsCj4gPiAgICAgICAg
ICAgICAgICAgLnBmZCA9IHBpcGVzCj4gPiAgICAgICAgIH0sCgo+ID4gVGhlIGxhc3Qgb25lIGNv
dWxkIGJlIHdpdGhvdXQgZGVzaWduYXRlZCBpbml0aWFsaXplcnMsIGJlY2F1c2Ugd2UgcGFzcyBh
bGwKPiA+IHN0cnVjdCBtZW1iZXJzLCBidXQgSU1ITyBpdCdzIGJldHRlciBmb3IgcmVhZGFiaWxp
dHkuCgo+ID4gVGhlcmVmb3JlIGlkZWFsIHNvbHV0aW9uIHdvdWxkIGJlIHRvIHR1cm4gdGhlIHRl
c3QgaW50byBkZXNpZ25hdGVkIGluaXRpYWxpemVycwo+ID4gaW4gc2VwYXJhdGUgY29tbWl0LCBm
b2xsb3dlZCBieSB0aGlzIGNoYW5nZS4KCgo+IEFoIHllcywgSSByZW1lbWJlciBub3cuIFdpbGwg
ZG8gdGhhdC4KClRoYW5rcyBhIGxvdCEKCktpbmQgcmVnYXJkcywKUGV0cgoKPiA+ID4gQWxzbywg
SSBoYXZlIGFsd2F5cyBzZWVuIHRoZXNlIHdhcm5pbmdzIGZvciBzdHJ1Y3QgdHN0X3Rlc3QuCgo+
ID4gPiBmYW5vdGlmeTE0LmM6Mjg0OjE6IHdhcm5pbmc6IG1pc3NpbmcgaW5pdGlhbGl6ZXIgZm9y
IGZpZWxkCj4gPiA+ICduZWVkc19jbWRzJyBvZiAnc3RydWN0IHRzdF90ZXN0JyBbLVdtaXNzaW5n
LWZpZWxkLWluaXRpYWxpemVyc10KPiA+ID4gICAyODQgfCB9Owo+ID4gPiAgICAgICB8IF4KPiA+
ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGZhbm90aWZ5MTQuYzoyODoKPiA+ID4gLi4vLi4vLi4v
Li4vaW5jbHVkZS90c3RfdGVzdC5oOjMyNDoyMTogbm90ZTogJ25lZWRzX2NtZHMnIGRlY2xhcmVk
IGhlcmUKPiA+ID4gICAzMjQgfCAgY29uc3QgY2hhciAqY29uc3QgKm5lZWRzX2NtZHM7Cj4gPiA+
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+Cgo+ID4gVGhlc2Ugd2Fybmlu
Z3Mgd2VyZSBjYXVzZWQgYnkgdGhlc2UgR0NDIGJ1Z3MgKGZpeGVkIGluIGdjYyAxMiBhbmQgYmFj
a3BvcnRlZCB0bwo+ID4gZ2NjIDExKToKPiA+IGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemlsbGEv
c2hvd19idWcuY2dpP2lkPTg0Njg1Cj4gPiBodHRwczovL2djYy5nbnUub3JnL2J1Z3ppbGxhL3No
b3dfYnVnLmNnaT9pZD04MjI4MwoKCj4gR29vZCB0byBrbm93Lgo+IFRoYW5rcyEKCj4gQW1pci4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
