Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1881C001B0
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 15:50:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47E883CC291
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 17:50:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 738DD3C2A04
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 17:50:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68F8760071D
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 17:50:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3605E21C5B;
 Mon, 10 Jul 2023 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689004209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUltSFDN1OHhr4ch+uB8ok6Cr3USnFADQpE6kyPEH6k=;
 b=pkySpbYDDpgBAhJ7vyFeuMG6Skb6Ft2f3jNMsHtm1+PZUJvpX5DFXvCAwF9WDW8MzS8BAv
 NyJlB0LhybtK/nDKHNzQ5i0N2wj1nmvNkfBDxdbPkz9EGeIWI2cdIFbFHqHLm+OvWDnPYe
 1AXLXUiQuV8jOKZ9Wndf+SrYPgDioRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689004209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUltSFDN1OHhr4ch+uB8ok6Cr3USnFADQpE6kyPEH6k=;
 b=dyStKmKPM6V27OPF6kDu5vK7AeZtRZSQ6LmvEk8G9MZ1g+GmKcSzIGZZGcMe6jc5YC0Kwz
 /XFvw+R+gzdItSCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1BCE1361C;
 Mon, 10 Jul 2023 15:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OXdPLLAorGSWbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jul 2023 15:50:08 +0000
Date: Mon, 10 Jul 2023 17:50:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230710155006.GA659329@pevik>
References: <20230710141403.1155151-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230710141403.1155151-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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

SGkgQW1pciwKCj4gVGhpcyBjYXNlIHdhcyByZXRyb2FjdGl2ZWx5IGRpc2FsbG93ZWQuCgo+IFRo
aXMgdGVzdCBpcyBtZWFudCB0byBlbmNvdXJhZ2UgdGhlIGJhY2twb3J0aW5nIG9mIGNvbW1pdCA2
OTU2MmViMGJkM2UKPiAoImZhbm90aWZ5OiBkaXNhbGxvdyBtb3VudC9zYiBtYXJrcyBvbiBrZXJu
ZWwgaW50ZXJuYWwgcHNldWRvIGZzIikgdG8KPiBhbGwgc3RhYmxlIGtlcm5lbHMuCgo+IFNpZ25l
ZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gLS0tCgo+IFBl
dHIsCgo+IFRoaXMgdGVzdHMgZm9yIGEgYmVoYXZpb3IgdGhhdCB3ZSBjb25zaWRlciBicm9rZW4g
c2luY2UgdGhlIGRhd24gb2YKPiBmYW5vdGlmeS4KCj4gVGhlIGZpeCB3YXMgbWVyZ2VkIHRvIHY2
LjUtcmMxLgo+IEkndmUgYWxyZWFkeSBwb3N0ZWQgYmFja3BvcnQgcGF0Y2hlcyBmb3Iga2VybmVs
cyA+IHY1LjAuCj4gSSBhbSBub3QgcGxhbm5pbmcgdG8gcG9zdCBiYWNrcG9ydCBwYXRjaGVzIGZv
ciBvbGRlciBrZXJuZWxzLgoKSSBzZWUKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzIw
MjMwNzEwMTMzMjA1LjExNTQxNjgtMS1hbWlyNzNpbEBnbWFpbC5jb20vCgpJJ2xsIHN1Z2dlc3Qg
dG8gd2FpdCB0aWxsIEdyZWcgcmVsZWFzZXMgdGhlIGJhY2twb3J0IChzaG91bGQgYmUgcXVpY2sg
ZW5vdWdoKS4KCj4gRXZlbiB0aG91Z2ggdGhlIHR3byBuZXcgdGVzdCBjYXNlcyBkbyBub3QgdXNl
IEZBTl9SRVBPUlRfRklELAo+IGZhbm90aWZ5MTQgcmVxdWlyZXMgRkFOX1JFUE9SVF9GSUQsIHNv
IGl0IGlzIG5vdCBnb2luZyB0byBydW4gdGhlc2UKPiB0ZXN0IGNhc2VzIG9uIGtlcm5lbCA8IHY1
LjEgYW55d2F5LgoKPiBUaGFua3MsCj4gQW1pci4KCj4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFu
b3RpZnkvZmFub3RpZnkxNC5jICAgICB8IDMyICsrKysrKysrKysrKysrKysrLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxNC5jCj4gaW5kZXggYmZhMDM0
OWZlLi4wNjNhOWY5NmYgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeTE0LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zh
bm90aWZ5L2Zhbm90aWZ5MTQuYwo+IEBAIC0xOSw2ICsxOSw5IEBACj4gICAqCj4gICAqICAgICBj
ZWFmNjlmOGVhZGMgZmFub3RpZnk6IGRvIG5vdCBhbGxvdyBzZXR0aW5nIGRpcmVudCBldmVudHMg
aW4gbWFzayBvZiBub24tZGlyCj4gICAqICAgICA4Njk4ZTNiYWI0ZGQgZmFub3RpZnk6IHJlZmlu
ZSB0aGUgdmFsaWRhdGlvbiBjaGVja3Mgb24gbm9uLWRpciBpbm9kZSBtYXNrCj4gKyAqCj4gKyAq
IFRoZSBwaXBlcyB0ZXN0IGNhc2VzIGFyZSByZWdyZXNzaW9uIHRlc3RzIGZvciBjb21taXQ6Cj4g
KyAqICAgICA2OTU2MmViMGJkM2UgZmFub3RpZnk6IGRpc2FsbG93IG1vdW50L3NiIG1hcmtzIG9u
IGtlcm5lbCBpbnRlcm5hbCBwc2V1ZG8gZnMKPiAgICovCgo+ICAjZGVmaW5lIF9HTlVfU09VUkNF
Cj4gQEAgLTQwLDYgKzQzLDcgQEAKCj4gICNkZWZpbmUgRkxBR1NfREVTQyhmbGFncykgeyhmbGFn
cyksICgjZmxhZ3MpfQoKPiArc3RhdGljIGludCBwaXBlc1syXSA9IHstMSwgLTF9Owo+ICBzdGF0
aWMgaW50IGZhbm90aWZ5X2ZkOwo+ICBzdGF0aWMgaW50IGZhbl9yZXBvcnRfdGFyZ2V0X2ZpZF91
bnN1cHBvcnRlZDsKPiAgc3RhdGljIGludCBpZ25vcmVfbWFya191bnN1cHBvcnRlZDsKPiBAQCAt
NjAsNiArNjQsNyBAQCBzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiAgCS8qIHdoZW4gbWFz
ay5mbGFncyA9PSAwLCBmYW5vdGlmeV9pbml0KCkgaXMgZXhwZWN0ZWQgdG8gZmFpbCAqLwo+ICAJ
c3RydWN0IHRlc3RfY2FzZV9mbGFnc190IG1hc2s7Cj4gIAlpbnQgZXhwZWN0ZWRfZXJybm87Cj4g
KwlpbnQgKnBmZDsKClRoaXMgcHJvZHVjZXMgd2FybmluZ3M6CmZhbm90aWZ5MTQuYzo3MDo5OiB3
YXJuaW5nOiBtaXNzaW5nIGluaXRpYWxpemVyIGZvciBmaWVsZCDigJhwZmTigJkgb2Yg4oCYc3Ry
dWN0IHRlc3RfY2FzZV904oCZIFstV21pc3NpbmctZmllbGQtaW5pdGlhbGl6ZXJzXQogICA3MCB8
ICAgICAgICAge0ZMQUdTX0RFU0MoRkFOX0NMQVNTX0NPTlRFTlQgfCBGQU5fUkVQT1JUX0ZJRCks
IHt9LCB7fSwgRUlOVkFMfSwKICAgICAgfCAgICAgICAgIF4KZmFub3RpZnkxNC5jOjY3OjE0OiBu
b3RlOiDigJhwZmTigJkgZGVjbGFyZWQgaGVyZQogICA2NyB8ICAgICAgICAgaW50ICpwZmQ7CiAg
ICAgIHwgICAgICAgICAgICAgIF5+fgpmYW5vdGlmeTE0LmM6NzM6OTogd2FybmluZzogbWlzc2lu
ZyBpbml0aWFsaXplciBmb3IgZmllbGQg4oCYcGZk4oCZIG9mIOKAmHN0cnVjdCB0ZXN0X2Nhc2Vf
dOKAmSBbLVdtaXNzaW5nLWZpZWxkLWluaXRpYWxpemVyc10KICAgNzMgfCAgICAgICAgIHtGTEFH
U19ERVNDKEZBTl9DTEFTU19QUkVfQ09OVEVOVCB8IEZBTl9SRVBPUlRfRklEKSwge30sIHt9LCBF
SU5WQUx9LAogICAgICB8ICAgICAgICAgXgpmYW5vdGlmeTE0LmM6Njc6MTQ6IG5vdGU6IOKAmHBm
ZOKAmSBkZWNsYXJlZCBoZXJlCiAgIDY3IHwgICAgICAgICBpbnQgKnBmZDsKICAgICAgfCAgICAg
ICAgICAgICAgXn5+CgpDb3VsZCB5b3UgcGxlYXNlIGZpeCB0aGVtPyBJIGd1ZXNzIHBmZCBtdXN0
IGJlIE5VTEwgd2hlbiB1bnVzZWQuCgpUaGUgcmVzdCBMR1RNLgoKS2luZCByZWdhcmRzLApQZXRy
CgouLi4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
