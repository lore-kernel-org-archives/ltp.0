Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A21C28D13
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 13:28:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66FDD3CA389
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 15:28:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80B523C0895
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:28:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A52EE6008DB
 for <ltp@lists.linux.it>; Mon, 22 Aug 2022 15:28:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 152E1200BC;
 Mon, 22 Aug 2022 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661174904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LTBSON0VVsaEksFz09QXfjg2lOezcqfjQWds8MzXbg=;
 b=i4+gAdY1bCmxZJARkUxsFrzu0uq3DGw3Mjaon9SfzAeYvKYy9oCTl5wUrDa6jVekFAGgRV
 Puaqrg2OykD28SUauw+PBk7EFbXjjU5+nn0nAZRR56zhVvL8lCFpnnEctg4zgV0OpO5rpl
 RNqXLlUHS8nS+v9GQ4GtPjMSW9X0wfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661174904;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LTBSON0VVsaEksFz09QXfjg2lOezcqfjQWds8MzXbg=;
 b=0hTwACwfaLMTJPTHnh6kyFxphdZmtauImo+pFOgb5POLcNFiO1gAcrpk29YFqvbOdOvUEj
 wUhbC+dHAwQILmAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9A7913523;
 Mon, 22 Aug 2022 13:28:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jxGnLneEA2MuYwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 22 Aug 2022 13:28:23 +0000
Date: Mon, 22 Aug 2022 15:28:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YwOEdnogDY7/khfO@pevik>
References: <20220811135731.2228-1-pvorel@suse.cz>
 <765b4f35-2cd0-04e1-e405-04261b5ef645@fujitsu.com>
 <YvnqZfyByO42kAX9@pevik>
 <1e791bd1-2661-95b0-1f0b-e3ca82b6524f@fujitsu.com>
 <YvoDyrIGa3/BsqI3@pevik>
 <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f11fc30d-d875-0d60-6807-7bfa9998f21b@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSBQZXRyCgo+ID4gSGkgWHUsCgo+ID4gLi4uCj4gPj4+Pj4gLQlTQUZFX1JFQUQoMCwgb3Rm
ZCwgcmVhZGJ1Ziwgc2l6ZW9mKHJlYWRidWYpKTsKPiA+Pj4+PiArCW5vYm9keV91aWQgPSBsdHB1
c2VyLT5wd191aWQ7Cj4gPj4+Pj4gKwlub2JvZHlfZ2lkID0gbHRwdXNlci0+cHdfZ2lkOwoKPiA+
Pj4+PiAtCVNBRkVfRlNUQVQob3RmZCwgJmZpbGVfc3RhdCk7Cj4gPj4+Pj4gKwlzbnByaW50Zihm
aWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQsIFRFU1RCSU4pOwo+ID4+Pj4+ICsJVFNU
X1JFU09VUkNFX0NPUFkoTlVMTCwgVEVTVEJJTiwgZmlsZSk7Cgo+ID4+Pj4gSW4gZmFjdCwgb2xk
IHRlc3QgY2FzZSBjb3B5IHJlc291cmNlIGZpbGUgd2hlbiBtb3VudCBmaWxleXN0ZW0sIGJ1dCBu
b3csCj4gPj4+PiB5b3UgY2hhbmdlIHRoaXMuICBTbyBpbiB0ZXN0X25vc3VpZCBmdW5jdGlvbiwg
eW91IHRlc3Qgbm9zdWlkIGJlaGF2aW91cgo+ID4+Pj4gaW4gdG1wZGlyIGluc3RlYWQgb2YgZGlm
ZmVyZW50IGZpbGVzeXN0ZW1zLgoKPiA+Pj4gb2xkIGNvZGUgaW4gc2V0dXA6Cj4gPj4+ICAgICAg
IGZzX3R5cGUgPSB0c3RfZGV2X2ZzX3R5cGUoKTsKPiA+Pj4gICAgICAgZGV2aWNlID0gdHN0X2Fj
cXVpcmVfZGV2aWNlKGNsZWFudXApOwoKPiA+Pj4gICAgICAgaWYgKCFkZXZpY2UpCj4gPj4+ICAg
ICAgICAgICB0c3RfYnJrbShUQ09ORiwgY2xlYW51cCwgIkZhaWxlZCB0byBvYnRhaW4gYmxvY2sg
ZGV2aWNlIik7Cgo+ID4+PiAgICAgICB0c3RfbWtmcyhjbGVhbnVwLCBkZXZpY2UsIGZzX3R5cGUs
IE5VTEwsIE5VTEwpOwoKPiA+Pj4gICAgICAgU0FGRV9NS0RJUihjbGVhbnVwLCBtbnRwb2ludCwg
RElSX01PREUpOwoKPiA+Pj4gICAgICAgU0FGRV9NT1VOVChjbGVhbnVwLCBkZXZpY2UsIG1udHBv
aW50LCBmc190eXBlLCAwLCBOVUxMKTsKPiA+Pj4gICAgICAgVFNUX1JFU09VUkNFX0NPUFkoY2xl
YW51cCwgIm1vdW50MDNfc2V0dWlkX3Rlc3QiLCBwYXRoX25hbWUpOwoKPiA+Pj4gbmV3IGNvZGU6
Cj4gPj4+ICAgICAgIHNucHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMvJXMiLCBNTlRQT0lOVCwg
VEVTVEJJTik7Cj4gPj4+ICAgICAgIFNBRkVfQ1AoVEVTVEJJTiwgZmlsZSk7Cgo+ID4+PiBXZWxs
LCBMaSBpbiBoaXMgdjIgcmVtb3ZlZCB0aGUgY29kZSBiZWNhdXNlIHRoZXJlIGlzIC5tbnRwb2lu
dCA9IE1OVFBPSU5ULCBpbgo+ID4+PiBzdHJ1Y3QgdHN0X3Rlc3QsIHRoZXJlZm9yZSBNTlRQT0lO
VCBpcyBtb3VudGVkIGluIHRoZSBmaWxlc3lzdGVtLCByaWdodD8KCj4gPj4+IEJ1dCBoZSBhbHNv
IGRpZCBTQUZFX1NUQVQgYW5kIFNBRkVfQ0hNT0Qgb24gTU5UUE9JTlQsIHdoaWNoIGlzIElNSE8g
d3JvbmcKPiA+Pj4gKG9yIGF0IGxlYXN0IGRpZmZlcmVudCBmcm9tIHRoZSBvbGQgY29kZSkuCgo+
ID4+IFllcywgaXQgaXMgd3JvbmcuIEkgZ3Vlc3MgQ2hlbiBtaXN1bmRlcnRhbmQgbW50cG9pbnQg
dXNhZ2UoaXQganVzdAo+ID4+IGNyZWF0ZSBtbnRwb2ludCBpbnN0ZWFkIG1vdW50IGRldiB0byBh
IG1vdXRwb2ludCkuCgo+ID4+IFNvIGRvIHlvdSB3aWxsIGZpeCB0aGlz77yfCgo+ID4gWWVzLCBz
ZWUgdGhlIGRpZmYgYmVsb3cuIEknbSB3YWl0aW5nIGxpdHRsZSBsb25nZXIgaWYgYW55Ym9keSBl
bHNlIGhhcyBzb21lCj4gPiBjb21tZW50cyBiZWZvcmUgbWVyZ2luZyBpdC4KCj4gPiBUaGFua3Mg
Zm9yIHlvdXIgcmV2aWV3LgoKPiA+PiBCZXN0IFJlZ2FyZHMKPiA+PiBZYW5nIFh1Cgo+ID4gZGlm
ZiAtLWdpdCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYyB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMuYwo+ID4gaW5kZXggNzRiMDE4ZDc4Li45
YzU4NzgzZDcgMTAwNjQ0Cj4gPiAtLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tb3VudC9t
b3VudDAzLmMKPiA+ICsrKyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vdW50L21vdW50MDMu
Ywo+ID4gQEAgLTE1LDcgKzE1LDYgQEAKPiA+ICAgI2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ID4g
ICAjaW5jbHVkZSA8c3lzL3dhaXQuaD4KPiA+ICAgI2luY2x1ZGUgPHB3ZC5oPgo+ID4gLSNpbmNs
dWRlICJvbGRfcmVzb3VyY2UuaCIKPiA+ICAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gPiAgICNp
bmNsdWRlICJsYXBpL21vdW50LmgiCgo+ID4gQEAgLTE0NSw3ICsxNDQsNyBAQCBzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ID4gICAJbm9ib2R5X2dpZCA9IGx0cHVzZXItPnB3X2dpZDsKCj4gPiAg
IAlzbnByaW50ZihmaWxlLCBQQVRIX01BWCwgIiVzLyVzIiwgTU5UUE9JTlQsIFRFU1RCSU4pOwo+
ID4gLQlUU1RfUkVTT1VSQ0VfQ09QWShOVUxMLCBURVNUQklOLCBmaWxlKTsKPiA+ICsJU0FGRV9D
UChURVNUQklOLCBmaWxlKTsKCj4gSSBzdGlsbCB0aGluayB3ZSBzaG91bGQgdGVzdCBub3N1aWQg
YmVoYXZpb3VyIG9uIGRpZmZlcmVudCBmaWxlc3lzdGVtIAo+IGxpa2Ugb3RoZXIgdGVzdCBmdW5j
dGlvbiBiZWNhdXNlIHdlIGhhdmUgZXhwYW5kIGl0IHRvIGFsbCBmaWxlc3lzdGVtcy4KCj4gQWxz
byBpbmNsdWRlIHRtcGZzLCBzbyBTQUZFX0NQIHNob3VsZCBiZSBpbiB0ZXN0X25vc3VpZCBmdW5j
dGlvbiAKPiBvdGhlcndpc2UgbWF5IGhpdCBFTk9FTlQgcHJvYmxlbS4KCkFjdHVhbGx5LCBJIHJh
bmRvbWx5IGhpdCBFTk9FTlQsIHdoZW4gU0FGRV9DUCAqaXMqIGluIHRlc3Rfbm9zdWlkKCkuCk5v
dCBzdXJlIHdoYXQgaGFwcGVuIChmaWxlc3lzdGVtIG5vdCBzeW5jZWQ/IHN5bmMoKSBkb2VzIG5v
dCBoZWxwKS4KSXQgd29ya3Mgd2hlbiBrZXB0IGluIHRoZSBzZXR1cC4KCktpbmQgcmVnYXJkcywK
UGV0cgoKPiBkaWZmZXJlbnQgY29kZSBhcyBiZWxvdzoKCj4gW3Jvb3RAbG9jYWxob3N0IG1vdW50
XSMgZ2l0IGRpZmYgLgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21v
dW50L21vdW50MDMuYyAKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW91bnQvbW91bnQw
My5jCj4gaW5kZXggNzRiMDE4ZDc4Li5iMDU4MmM3NmIgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tb3VudC9tb3VudDAzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21vdW50L21vdW50MDMuYwo+IEBAIC0yMSw2ICsyMSw3IEBACgo+ICAgI2RlZmlu
ZSBNTlRQT0lOVCAgICAgICAgIm1udHBvaW50Igo+ICAgI2RlZmluZSBURVNUQklOICAgICAgICAi
bW91bnQwM19zZXR1aWRfdGVzdCIKPiArI2RlZmluZSBCSU5fUEFUSCAgICAgICAgICAgTU5UUE9J
TlQiLyJURVNUQklOCj4gICAjZGVmaW5lIFRFU1RfU1RSICJhYmNkZWZnaGlqa2xtbm9wcXJzdHV2
d3h5eiIKPiAgICNkZWZpbmUgRklMRV9NT0RFICAgICAgMDY0NAo+ICAgI2RlZmluZSBTVUlEX01P
REUgICAgICAwNTExCj4gQEAgLTc1LDEyICs3NiwxOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X25vc3Vp
ZCh2b2lkKQo+ICAgewo+ICAgICAgICAgIHBpZF90IHBpZDsKPiAgICAgICAgICBpbnQgc3RhdHVz
Owo+ICsgICAgICAgc3RydWN0IHN0YXQgc3Q7Cj4gKwo+ICsgICAgICAgc25wcmludGYoZmlsZSwg
UEFUSF9NQVgsICIlcy8lcyIsIE1OVFBPSU5ULCBURVNUQklOKTsKPiArICAgICAgIFNBRkVfQ1Ao
VEVTVEJJTiwgZmlsZSk7Cj4gKyAgICAgICBTQUZFX1NUQVQoZmlsZSwgJnN0KTsKPiArICAgICAg
IGlmIChzdC5zdF9tb2RlICE9IFNVSURfTU9ERSkKPiArICAgICAgICAgICAgICAgU0FGRV9DSE1P
RChmaWxlLCBTVUlEX01PREUpOwoKPiAgICAgICAgICBwaWQgPSBTQUZFX0ZPUksoKTsKPiAgICAg
ICAgICBpZiAoIXBpZCkgewo+ICAgICAgICAgICAgICAgICAgU0FGRV9TRVRHSUQobm9ib2R5X2dp
ZCk7Cj4gICAgICAgICAgICAgICAgICBTQUZFX1NFVFJFVUlEKC0xLCBub2JvZHlfdWlkKTsKPiAt
ICAgICAgICAgICAgICAgU0FGRV9FWEVDTFAoVEVTVEJJTiwgVEVTVEJJTiwgTlVMTCk7Cj4gKyAg
ICAgICAgICAgICAgIFNBRkVfRVhFQ0xQKEJJTl9QQVRILCBURVNUQklOLCBOVUxMKTsKPiAgICAg
ICAgICB9Cgo+ICAgICAgICAgIFNBRkVfV0FJVFBJRChwaWQsICZzdGF0dXMsIDApOwo+IEBAIC0x
MzgsMTggKzE0NiwxMCBAQCBzdGF0aWMgc3RydWN0IHRjYXNlIHsKCj4gICBzdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKQo+ICAgewo+IC0gICAgICAgc3RydWN0IHN0YXQgc3Q7Cj4gICAgICAgICAgc3Ry
dWN0IHBhc3N3ZCAqbHRwdXNlciA9IFNBRkVfR0VUUFdOQU0oIm5vYm9keSIpOwoKPiAgICAgICAg
ICBub2JvZHlfdWlkID0gbHRwdXNlci0+cHdfdWlkOwo+ICAgICAgICAgIG5vYm9keV9naWQgPSBs
dHB1c2VyLT5wd19naWQ7Cj4gLQo+IC0gICAgICAgc25wcmludGYoZmlsZSwgUEFUSF9NQVgsICIl
cy8lcyIsIE1OVFBPSU5ULCBURVNUQklOKTsKPiAtICAgICAgIFRTVF9SRVNPVVJDRV9DT1BZKE5V
TEwsIFRFU1RCSU4sIGZpbGUpOwo+IC0KPiAtICAgICAgIFNBRkVfU1RBVChmaWxlLCAmc3QpOwo+
IC0gICAgICAgaWYgKHN0LnN0X21vZGUgIT0gU1VJRF9NT0RFKQo+IC0gICAgICAgICAgIFNBRkVf
Q0hNT0QoZmlsZSwgU1VJRF9NT0RFKTsKPiAgIH0KCj4gICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZv
aWQpCj4gW3Jvb3RAbG9jYWxob3N0IG1vdW50XSMKCgo+IEJlc3QgUmVnYXJkcwo+IFlhbmcgWHUK
Cgo+ID4gICAJU0FGRV9TVEFUKGZpbGUsICZzdCk7Cj4gPiAgIAlpZiAoc3Quc3RfbW9kZSAhPSBT
VUlEX01PREUpCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
