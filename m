Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA99CFB440
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 08:23:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5527B3C57F5
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 10:23:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBF0B3C6157
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 21:34:00 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=krisman.be (client-ip=217.70.183.199;
 helo=relay9-d.mail.gandi.net; envelope-from=gabriel@krisman.be;
 receiver=lists.linux.it)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05C312010F4
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 21:33:59 +0200 (CEST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12420FF803;
 Fri,  4 Oct 2024 19:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
 t=1728070439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqgMY+d2SYC/fKjAR/lG04fq4NcjyLPJ10Z85yTqpdg=;
 b=YIou8kT7/wKpmE/IQKf05D0ueTkE7Frr4aKXOe30la5lQnHWFZFTmmyIktxIus76Hq7asC
 RHBxWfBLlJN6l7FW7fzCuakGyoJlRY1gGJJdWF3VK8xs9zENeK4dgnKQRJ0/yItle/1TXv
 M1UPhsprxJYdxOUTxe3BjMg0ELXhs2jVfahRmyme/QtPkeQ6BOsyOICOcl5RVfL1SRI2tD
 XPt8Fz80eAFUk+tnu6AkBpRx+700BURY4zw3zPacrldmfRw1hRP3UTaAMZl+++uCXfIrjB
 mPxjwhUBou9sDX/Ek9+BmDHMaxNnD/uIk+oAG4F9mnN92z9eUog5Mr5bIrg9NA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Amir Goldstein <amir73il@gmail.com>
In-Reply-To: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
 (Amir Goldstein's message of "Fri, 4 Oct 2024 14:32:07 +0200")
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
 <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
Date: Fri, 04 Oct 2024 15:33:56 -0400
Message-ID: <877canu0gr.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-GND-Sasl: gabriel@krisman.be
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 07 Oct 2024 10:22:54 +0200
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
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
Cc: Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4gd3JpdGVzOgoKPiBPbiBNb24sIFNl
cCAzMCwgMjAyNCBhdCAxOjM04oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6Cj4+
Cj4+IE9uIE1vbiAzMC0wOS0yNCAxMjoxNToxMSwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4+ID4gT24g
TW9uLCBBdWcgMDUsIDIwMjQgYXQgMTA6MTI6NDFQTSArMDIwMCwgSmFuIEthcmEgd3JvdGU6Cj4+
ID4gPiBXaGVuIHRoZSBmaWxlc3lzdGVtIGlzIG1vdW50ZWQgd2l0aCBlcnJvcnM9cmVtb3VudC1y
bywgd2Ugd2VyZSBzZXR0aW5nCj4+ID4gPiBTQl9SRE9OTFkgZmxhZyB0byBzdG9wIGFsbCBmaWxl
c3lzdGVtIG1vZGlmaWNhdGlvbnMuIFdlIGtuZXcgdGhpcyBtaXNzZXMKPj4gPiA+IHByb3BlciBs
b2NraW5nIChzYi0+c191bW91bnQpIGFuZCBkb2VzIG5vdCBnbyB0aHJvdWdoIHByb3BlciBmaWxl
c3lzdGVtCj4+ID4gPiByZW1vdW50IHByb2NlZHVyZSBidXQgaXQgaGFzIGJlZW4gdGhlIHdheSB0
aGlzIHdvcmtlZCBzaW5jZSBlYXJseSBleHQyCj4+ID4gPiBkYXlzIGFuZCBpdCB3YXMgZ29vZCBl
bm91Z2ggZm9yIGNhdGFzdHJvcGhpYyBzaXR1YXRpb24gZGFtYWdlCj4+ID4gPiBtaXRpZ2F0aW9u
LiBSZWNlbnRseSwgc3l6Ym90IGhhcyBmb3VuZCBhIHdheSAoc2VlIGxpbmspIHRvIHRyaWdnZXIK
Pj4gPiA+IHdhcm5pbmdzIGluIGZpbGVzeXN0ZW0gZnJlZXppbmcgYmVjYXVzZSB0aGUgY29kZSBn
b3QgY29uZnVzZWQgYnkKPj4gPiA+IFNCX1JET05MWSBjaGFuZ2luZyB1bmRlciBpdHMgaGFuZHMu
IFNpbmNlIHRoZXNlIGRheXMgd2Ugc2V0Cj4+ID4gPiBFWFQ0X0ZMQUdTX1NIVVRET1dOIG9uIHRo
ZSBzdXBlcmJsb2NrIHdoaWNoIGlzIGVub3VnaCB0byBzdG9wIGFsbAo+PiA+ID4gZmlsZXN5c3Rl
bSBtb2RpZmljYXRpb25zLCBtb2RpZnlpbmcgU0JfUkRPTkxZIHNob3VsZG4ndCBiZSBuZWVkZWQu
IFNvCj4+ID4gPiBzdG9wIGRvaW5nIHRoYXQuCj4+ID4gPgo+PiA+ID4gTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsLzAwMDAwMDAwMDAwMGI5MGE4ZTA2MWUyMWQxMmZAZ29vZ2xlLmNv
bQo+PiA+ID4gUmVwb3J0ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5v
cmc+Cj4+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+PiA+ID4g
LS0tCj4+ID4gPiBmcy9leHQ0L3N1cGVyLmMgfCA5ICsrKysrLS0tLQo+PiA+ID4gMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4gPiA+Cj4+ID4gPiBOb3Rl
IHRoYXQgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGZzdGVzdHMgZmFpbHVyZSB3aXRoIGdlbmVyaWMv
NDU5IHRlc3QgYmVjYXVzZQo+PiA+ID4gaXQgYXNzdW1lcyB0aGF0IGVpdGhlciBmcmVlemluZyBz
dWNjZWVkcyBvciAncm8nIGlzIGFtb25nIG1vdW50IG9wdGlvbnMuIEJ1dAo+PiA+ID4gd2UgZmFp
bCB0aGUgZnJlZXplIHdpdGggRUZTQ09SUlVQVEVELiBUaGlzIG5lZWRzIGZpeGluZyBpbiB0aGUg
dGVzdCBidXQgYXQgdGhpcwo+PiA+ID4gcG9pbnQgSSdtIG5vdCBzdXJlIGhvdyBleGFjdGx5Lgo+
PiA+ID4KPj4gPiA+IGRpZmYgLS1naXQgYS9mcy9leHQ0L3N1cGVyLmMgYi9mcy9leHQ0L3N1cGVy
LmMKPj4gPiA+IGluZGV4IGU3MjE0NWM0YWU1YS4uOTNjMDE2YjE4NmMwIDEwMDY0NAo+PiA+ID4g
LS0tIGEvZnMvZXh0NC9zdXBlci5jCj4+ID4gPiArKysgYi9mcy9leHQ0L3N1cGVyLmMKPj4gPiA+
IEBAIC03MzUsMTEgKzczNSwxMiBAQCBzdGF0aWMgdm9pZCBleHQ0X2hhbmRsZV9lcnJvcihzdHJ1
Y3Qgc3VwZXJfYmxvY2sgKnNiLCBib29sIGZvcmNlX3JvLCBpbnQgZXJyb3IsCj4+ID4gPgo+PiA+
ID4gICAgIGV4dDRfbXNnKHNiLCBLRVJOX0NSSVQsICJSZW1vdW50aW5nIGZpbGVzeXN0ZW0gcmVh
ZC1vbmx5Iik7Cj4+ID4gPiAgICAgLyoKPj4gPiA+IC0gICAgKiBNYWtlIHN1cmUgdXBkYXRlZCB2
YWx1ZSBvZiAtPnNfbW91bnRfZmxhZ3Mgd2lsbCBiZSB2aXNpYmxlIGJlZm9yZQo+PiA+ID4gLSAg
ICAqIC0+c19mbGFncyB1cGRhdGUKPj4gPiA+ICsgICAgKiBFWFQ0X0ZMQUdTX1NIVVRET1dOIHdh
cyBzZXQgd2hpY2ggc3RvcHMgYWxsIGZpbGVzeXN0ZW0KPj4gPiA+ICsgICAgKiBtb2RpZmljYXRp
b25zLiBXZSBkb24ndCBzZXQgU0JfUkRPTkxZIGJlY2F1c2UgdGhhdCByZXF1aXJlcwo+PiA+ID4g
KyAgICAqIHNiLT5zX3Vtb3VudCBzZW1hcGhvcmUgYW5kIHNldHRpbmcgaXQgd2l0aG91dCBwcm9w
ZXIgcmVtb3VudAo+PiA+ID4gKyAgICAqIHByb2NlZHVyZSBpcyBjb25mdXNpbmcgY29kZSBzdWNo
IGFzIGZyZWV6ZV9zdXBlcigpIGxlYWRpbmcgdG8KPj4gPiA+ICsgICAgKiBkZWFkbG9ja3MgYW5k
IG90aGVyIHByb2JsZW1zLgo+PiA+ID4gICAgICAqLwo+PiA+ID4gLSAgIHNtcF93bWIoKTsKPj4g
PiA+IC0gICBzYi0+c19mbGFncyB8PSBTQl9SRE9OTFk7Cj4+ID4KPj4gPiBIaSwKPj4gPgo+PiA+
IHNob3VsZG4ndCB0aGUgU0JfUkRPTkxZIHN0aWxsIGJlIHNldCAoaW4gX19leHQ0X3JlbW91bnQo
KSkgZm9yIHRoZSBjYXNlCj4+ID4gd2hlbiB1c2VyIHRyaWdnZXJzIHRoZSBhYm9ydCB3aXRoIG1v
dW50KC4uLCAiYWJvcnQiKT8gQmVjYXVzZSBub3cgd2Ugc2VlbQo+PiA+IHRvIGFsd2F5cyBoaXQg
dGhlIGNvbmRpdGlvbiB0aGF0IHJldHVybnMgRVJPRlMgdG8gdXNlci1zcGFjZS4KPj4KPj4gVGhh
bmtzIGZvciByZXBvcnQhIEkgYWdyZWUgcmV0dXJuaW5nIEVST0ZTIGZyb20gdGhlIG1vdW50IGFs
dGhvdWdoCj4+ICdhYm9ydGluZycgc3VjY2VlZGVkIGlzIGNvbmZ1c2luZyBhbmQgaXMgbW9zdGx5
IGFuIHVuaW50ZW5kZWQgc2lkZSBlZmZlY3QKPj4gdGhhdCBhZnRlciBhYm9ydGluZyB0aGUgZnMg
ZnVydGhlciBjaGFuZ2VzIHRvIG1vdW50IHN0YXRlIGFyZSBmb3JiaWRkZW4gYnV0Cj4+IHRoZSB0
ZXN0Y2FzZSBhZGRpdGlvbmFsbHkgd2FudHMgdG8gcmVtb3VudCB0aGUgZnMgcmVhZC1vbmx5Lgo+
Cj4gUmVnYXJkbGVzcyBvZiB3aGF0IGlzIHJpZ2h0IG9yIHdyb25nIHRvIGRvIGluIGV4dDQsIEkg
ZG9uJ3QgdGhpbmsgdGhhdCB0aGUgdGVzdAo+IHJlYWxseSBjYXJlcyBhYm91dCByZW1vdW50IHJl
YWQtb25seS4KPiBJIGRvbid0IHNlZSBhbnl0aGluZyBpbiB0aGUgdGVzdCB0aGF0IHJlcXVpcmVz
IGl0LiBHYWJyaWVsPwo+IElmIEkgcmVtb3ZlIE1TX1JET05MWSBmcm9tIHRoZSB0ZXN0IGl0IHdv
cmtzIGp1c3QgZmluZS4KCklmIEkgcmVjYWxsIGNvcnJlY3RseSwgbm8sIHRoZXJlIGlzIG5vIG5l
ZWQgZm9yIHRoZSBNU19SRE9OTFkuICBXZSBvbmx5CmNhcmUgYWJvdXQgZ2V0dGluZyB0aGUgZXZl
bnQgdG8gdGVzdCBGU19FUlJPUi4KClRoYW5rcywKCj4KPiBBbnkgb2JqZWN0aW9uIGZvciBMVFAg
bWFpbnRhaW5lcnMgdG8gYXBwbHkgdGhpcyBzaW1wbGUgdGVzdCBmaXg/Cj4KPiBUaGFua3MsCj4g
QW1pci4KPgo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkyMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eTIyLmMKPiBAQCAtNTcsNyArNTcsNyBAQCBzdGF0aWMgc3RydWN0IGZhbm90aWZ5X2ZpZF90IGJh
ZF9saW5rX2ZpZDsKPiAgc3RhdGljIHZvaWQgdHJpZ2dlcl9mc19hYm9ydCh2b2lkKQo+ICB7Cj4g
ICAgICAgICBTQUZFX01PVU5UKHRzdF9kZXZpY2UtPmRldiwgTU9VTlRfUEFUSCwgdHN0X2Rldmlj
ZS0+ZnNfdHlwZSwKPiAtICAgICAgICAgICAgICAgICAgTVNfUkVNT1VOVHxNU19SRE9OTFksICJh
Ym9ydCIpOwo+ICsgICAgICAgICAgICAgICAgICBNU19SRU1PVU5ULCAiYWJvcnQiKTsKPiAgfQoK
LS0gCkdhYnJpZWwgS3Jpc21hbiBCZXJ0YXppCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
