Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3181AC28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 13:35:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 260EC3CA323
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 15:35:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C9883C1BC6
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:35:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C8205200978
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:35:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9124634ABB;
 Mon, 22 Aug 2022 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661175330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khEVqV9Pw4rB+KJ788T+WLBUhXsr0zoSaIAI6b1GISM=;
 b=P1pRGpClrqLlybGGAT7xhP/acXoX+GFU4vPeXIYpFAtyYc1d9P06nV2RbL3XD1SegpHEdA
 0P1S1BlBaCp+iYs8Hi9KF23EtUcTKWBNv748ZRWCVsXbLB1JQmnBdGuwuoLZl1FXtPvMcD
 objBXkGfxK+uQ3nWuT9DhddjyiayjXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661175330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khEVqV9Pw4rB+KJ788T+WLBUhXsr0zoSaIAI6b1GISM=;
 b=9EADT9CIrVQu3WW/tmAy2WGvC9JKc09zdqgcvtmTdr8qyRbjKIpqQvJD9hwhZrstx/abZZ
 csI1N6vUcLWIhsAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6379B13523;
 Mon, 22 Aug 2022 13:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vDd8FiKGA2NwZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 22 Aug 2022 13:35:30 +0000
Date: Mon, 22 Aug 2022 15:35:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <YwOGID+XrCMrpdYB@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
 <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
 <YwOEdnogDY7/khfO@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwOEdnogDY7/khfO@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiA+IEhpIFBldHIKCj4gPiA+IEhpIFh1LAoKPiA+ID4gLi4uCj4gPiA+Pj4+PiAtCVNBRkVfUkVB
RCgwLCBvdGZkLCByZWFkYnVmLCBzaXplb2YocmVhZGJ1ZikpOwo+ID4gPj4+Pj4gKwlub2JvZHlf
dWlkID0gbHRwdXNlci0+cHdfdWlkOwo+ID4gPj4+Pj4gKwlub2JvZHlfZ2lkID0gbHRwdXNlci0+
cHdfZ2lkOwoKPiA+ID4+Pj4+IC0JU0FGRV9GU1RBVChvdGZkLCAmZmlsZV9zdGF0KTsKPiA+ID4+
Pj4+ICsJc25wcmludGYoZmlsZSwgUEFUSF9NQVgsICIlcy8lcyIsIE1OVFBPSU5ULCBURVNUQklO
KTsKPiA+ID4+Pj4+ICsJVFNUX1JFU09VUkNFX0NPUFkoTlVMTCwgVEVTVEJJTiwgZmlsZSk7Cgo+
ID4gPj4+PiBJbiBmYWN0LCBvbGQgdGVzdCBjYXNlIGNvcHkgcmVzb3VyY2UgZmlsZSB3aGVuIG1v
dW50IGZpbGV5c3RlbSwgYnV0IG5vdywKPiA+ID4+Pj4geW91IGNoYW5nZSB0aGlzLiAgU28gaW4g
dGVzdF9ub3N1aWQgZnVuY3Rpb24sIHlvdSB0ZXN0IG5vc3VpZCBiZWhhdmlvdXIKPiA+ID4+Pj4g
aW4gdG1wZGlyIGluc3RlYWQgb2YgZGlmZmVyZW50IGZpbGVzeXN0ZW1zLgoKPiA+ID4+PiBvbGQg
Y29kZSBpbiBzZXR1cDoKPiA+ID4+PiAgICAgICBmc190eXBlID0gdHN0X2Rldl9mc190eXBlKCk7
Cj4gPiA+Pj4gICAgICAgZGV2aWNlID0gdHN0X2FjcXVpcmVfZGV2aWNlKGNsZWFudXApOwoKPiA+
ID4+PiAgICAgICBpZiAoIWRldmljZSkKPiA+ID4+PiAgICAgICAgICAgdHN0X2Jya20oVENPTkYs
IGNsZWFudXAsICJGYWlsZWQgdG8gb2J0YWluIGJsb2NrIGRldmljZSIpOwoKPiA+ID4+PiAgICAg
ICB0c3RfbWtmcyhjbGVhbnVwLCBkZXZpY2UsIGZzX3R5cGUsIE5VTEwsIE5VTEwpOwoKPiA+ID4+
PiAgICAgICBTQUZFX01LRElSKGNsZWFudXAsIG1udHBvaW50LCBESVJfTU9ERSk7Cgo+ID4gPj4+
ICAgICAgIFNBRkVfTU9VTlQoY2xlYW51cCwgZGV2aWNlLCBtbnRwb2ludCwgZnNfdHlwZSwgMCwg
TlVMTCk7Cj4gPiA+Pj4gICAgICAgVFNUX1JFU09VUkNFX0NPUFkoY2xlYW51cCwgIm1vdW50MDNf
c2V0dWlkX3Rlc3QiLCBwYXRoX25hbWUpOwoKPiA+ID4+PiBuZXcgY29kZToKPiA+ID4+PiAgICAg
ICBzbnByaW50ZihmaWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQsIFRFU1RCSU4pOwo+
ID4gPj4+ICAgICAgIFNBRkVfQ1AoVEVTVEJJTiwgZmlsZSk7Cgo+ID4gPj4+IFdlbGwsIExpIGlu
IGhpcyB2MiByZW1vdmVkIHRoZSBjb2RlIGJlY2F1c2UgdGhlcmUgaXMgLm1udHBvaW50ID0gTU5U
UE9JTlQsIGluCj4gPiA+Pj4gc3RydWN0IHRzdF90ZXN0LCB0aGVyZWZvcmUgTU5UUE9JTlQgaXMg
bW91bnRlZCBpbiB0aGUgZmlsZXN5c3RlbSwgcmlnaHQ/Cgo+ID4gPj4+IEJ1dCBoZSBhbHNvIGRp
ZCBTQUZFX1NUQVQgYW5kIFNBRkVfQ0hNT0Qgb24gTU5UUE9JTlQsIHdoaWNoIGlzIElNSE8gd3Jv
bmcKPiA+ID4+PiAob3IgYXQgbGVhc3QgZGlmZmVyZW50IGZyb20gdGhlIG9sZCBjb2RlKS4KCj4g
PiA+PiBZZXMsIGl0IGlzIHdyb25nLiBJIGd1ZXNzIENoZW4gbWlzdW5kZXJ0YW5kIG1udHBvaW50
IHVzYWdlKGl0IGp1c3QKPiA+ID4+IGNyZWF0ZSBtbnRwb2ludCBpbnN0ZWFkIG1vdW50IGRldiB0
byBhIG1vdXRwb2ludCkuCgo+ID4gPj4gU28gZG8geW91IHdpbGwgZml4IHRoaXPvvJ8KCj4gPiA+
IFllcywgc2VlIHRoZSBkaWZmIGJlbG93LiBJJ20gd2FpdGluZyBsaXR0bGUgbG9uZ2VyIGlmIGFu
eWJvZHkgZWxzZSBoYXMgc29tZQo+ID4gPiBjb21tZW50cyBiZWZvcmUgbWVyZ2luZyBpdC4KCj4g
PiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgo+ID4gPj4gQmVzdCBSZWdhcmRzCj4gPiA+PiBZ
YW5nIFh1Cgo+ID4gPiBkaWZmIC0tZ2l0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQv
bW91bnQwMy5jIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQwMy5jCj4gPiA+
IGluZGV4IDc0YjAxOGQ3OC4uOWM1ODc4M2Q3IDEwMDY0NAo+ID4gPiAtLS0gdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDAzLmMKPiA+ID4gKysrIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbW91bnQvbW91bnQwMy5jCj4gPiA+IEBAIC0xNSw3ICsxNSw2IEBACj4gPiA+ICAg
I2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ID4gPiAgICNpbmNsdWRlIDxzeXMvd2FpdC5oPgo+ID4g
PiAgICNpbmNsdWRlIDxwd2QuaD4KPiA+ID4gLSNpbmNsdWRlICJvbGRfcmVzb3VyY2UuaCIKPiA+
ID4gICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiA+ID4gICAjaW5jbHVkZSAibGFwaS9tb3VudC5o
IgoKPiA+ID4gQEAgLTE0NSw3ICsxNDQsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4g
PiAgIAlub2JvZHlfZ2lkID0gbHRwdXNlci0+cHdfZ2lkOwoKPiA+ID4gICAJc25wcmludGYoZmls
ZSwgUEFUSF9NQVgsICIlcy8lcyIsIE1OVFBPSU5ULCBURVNUQklOKTsKPiA+ID4gLQlUU1RfUkVT
T1VSQ0VfQ09QWShOVUxMLCBURVNUQklOLCBmaWxlKTsKPiA+ID4gKwlTQUZFX0NQKFRFU1RCSU4s
IGZpbGUpOwoKPiA+IEkgc3RpbGwgdGhpbmsgd2Ugc2hvdWxkIHRlc3Qgbm9zdWlkIGJlaGF2aW91
ciBvbiBkaWZmZXJlbnQgZmlsZXN5c3RlbSAKPiA+IGxpa2Ugb3RoZXIgdGVzdCBmdW5jdGlvbiBi
ZWNhdXNlIHdlIGhhdmUgZXhwYW5kIGl0IHRvIGFsbCBmaWxlc3lzdGVtcy4KCj4gPiBBbHNvIGlu
Y2x1ZGUgdG1wZnMsIHNvIFNBRkVfQ1Agc2hvdWxkIGJlIGluIHRlc3Rfbm9zdWlkIGZ1bmN0aW9u
IAo+ID4gb3RoZXJ3aXNlIG1heSBoaXQgRU5PRU5UIHByb2JsZW0uCgo+IEFjdHVhbGx5LCBJIHJh
bmRvbWx5IGhpdCBFTk9FTlQsIHdoZW4gU0FGRV9DUCAqaXMqIGluIHRlc3Rfbm9zdWlkKCkuCj4g
Tm90IHN1cmUgd2hhdCBoYXBwZW4gKGZpbGVzeXN0ZW0gbm90IHN5bmNlZD8gc3luYygpIGRvZXMg
bm90IGhlbHApLgo+IEl0IHdvcmtzIHdoZW4ga2VwdCBpbiB0aGUgc2V0dXAuCkJlc2lkZXMgaXQn
cyByZWFsbHkgd3JvbmcgdG8gaGF2ZSBpdCBpbiB0aGUgc2V0dXAgKG1vdW50IGlzIGRvbGUgbGF0
ZXIgaW4KcnVuKCkpLCBpdCBhbHNvIGRvZXMgbm90IHdvcmsgKGFnYWluLCByYW5kb21seSBFTk9F
TlQpLgoKS2luZCByZWdhcmRzLApQZXRyCgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCgo+ID4gZGlm
ZmVyZW50IGNvZGUgYXMgYmVsb3c6Cgo+ID4gW3Jvb3RAbG9jYWxob3N0IG1vdW50XSMgZ2l0IGRp
ZmYgLgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91
bnQwMy5jIAo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYwo+
ID4gaW5kZXggNzRiMDE4ZDc4Li5iMDU4MmM3NmIgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9tb3VudC9tb3VudDAzLmMKPiA+IEBAIC0yMSw2ICsyMSw3IEBACgo+ID4gICAj
ZGVmaW5lIE1OVFBPSU5UICAgICAgICAibW50cG9pbnQiCj4gPiAgICNkZWZpbmUgVEVTVEJJTiAg
ICAgICAgIm1vdW50MDNfc2V0dWlkX3Rlc3QiCj4gPiArI2RlZmluZSBCSU5fUEFUSCAgICAgICAg
ICAgTU5UUE9JTlQiLyJURVNUQklOCj4gPiAgICNkZWZpbmUgVEVTVF9TVFIgImFiY2RlZmdoaWpr
bG1ub3BxcnN0dXZ3eHl6Igo+ID4gICAjZGVmaW5lIEZJTEVfTU9ERSAgICAgIDA2NDQKPiA+ICAg
I2RlZmluZSBTVUlEX01PREUgICAgICAwNTExCj4gPiBAQCAtNzUsMTIgKzc2LDE5IEBAIHN0YXRp
YyB2b2lkIHRlc3Rfbm9zdWlkKHZvaWQpCj4gPiAgIHsKPiA+ICAgICAgICAgIHBpZF90IHBpZDsK
PiA+ICAgICAgICAgIGludCBzdGF0dXM7Cj4gPiArICAgICAgIHN0cnVjdCBzdGF0IHN0Owo+ID4g
Kwo+ID4gKyAgICAgICBzbnByaW50ZihmaWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQs
IFRFU1RCSU4pOwo+ID4gKyAgICAgICBTQUZFX0NQKFRFU1RCSU4sIGZpbGUpOwo+ID4gKyAgICAg
ICBTQUZFX1NUQVQoZmlsZSwgJnN0KTsKPiA+ICsgICAgICAgaWYgKHN0LnN0X21vZGUgIT0gU1VJ
RF9NT0RFKQo+ID4gKyAgICAgICAgICAgICAgIFNBRkVfQ0hNT0QoZmlsZSwgU1VJRF9NT0RFKTsK
Cj4gPiAgICAgICAgICBwaWQgPSBTQUZFX0ZPUksoKTsKPiA+ICAgICAgICAgIGlmICghcGlkKSB7
Cj4gPiAgICAgICAgICAgICAgICAgIFNBRkVfU0VUR0lEKG5vYm9keV9naWQpOwo+ID4gICAgICAg
ICAgICAgICAgICBTQUZFX1NFVFJFVUlEKC0xLCBub2JvZHlfdWlkKTsKPiA+IC0gICAgICAgICAg
ICAgICBTQUZFX0VYRUNMUChURVNUQklOLCBURVNUQklOLCBOVUxMKTsKPiA+ICsgICAgICAgICAg
ICAgICBTQUZFX0VYRUNMUChCSU5fUEFUSCwgVEVTVEJJTiwgTlVMTCk7Cj4gPiAgICAgICAgICB9
Cgo+ID4gICAgICAgICAgU0FGRV9XQUlUUElEKHBpZCwgJnN0YXR1cywgMCk7Cj4gPiBAQCAtMTM4
LDE4ICsxNDYsMTAgQEAgc3RhdGljIHN0cnVjdCB0Y2FzZSB7Cgo+ID4gICBzdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKQo+ID4gICB7Cj4gPiAtICAgICAgIHN0cnVjdCBzdGF0IHN0Owo+ID4gICAgICAg
ICAgc3RydWN0IHBhc3N3ZCAqbHRwdXNlciA9IFNBRkVfR0VUUFdOQU0oIm5vYm9keSIpOwoKPiA+
ICAgICAgICAgIG5vYm9keV91aWQgPSBsdHB1c2VyLT5wd191aWQ7Cj4gPiAgICAgICAgICBub2Jv
ZHlfZ2lkID0gbHRwdXNlci0+cHdfZ2lkOwo+ID4gLQo+ID4gLSAgICAgICBzbnByaW50ZihmaWxl
LCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQsIFRFU1RCSU4pOwo+ID4gLSAgICAgICBUU1Rf
UkVTT1VSQ0VfQ09QWShOVUxMLCBURVNUQklOLCBmaWxlKTsKPiA+IC0KPiA+IC0gICAgICAgU0FG
RV9TVEFUKGZpbGUsICZzdCk7Cj4gPiAtICAgICAgIGlmIChzdC5zdF9tb2RlICE9IFNVSURfTU9E
RSkKPiA+IC0gICAgICAgICAgIFNBRkVfQ0hNT0QoZmlsZSwgU1VJRF9NT0RFKTsKPiA+ICAgfQoK
PiA+ICAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ID4gW3Jvb3RAbG9jYWxob3N0IG1vdW50
XSMKCgo+ID4gQmVzdCBSZWdhcmRzCj4gPiBZYW5nIFh1CgoKPiA+ID4gICAJU0FGRV9TVEFUKGZp
bGUsICZzdCk7Cj4gPiA+ICAgCWlmIChzdC5zdF9tb2RlICE9IFNVSURfTU9ERSkKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
