Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBECD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 12:51:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42443CE4E2
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 14:51:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D23C3C9CCB
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 14:50:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8784B1A002C4
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 14:50:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 966C01FE9B
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695041444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeRSjfFQMqIA/G6Y4Thamvp6HdzXaT94viDEbe8Hqjg=;
 b=jecZJ3EH1KrkM8LOg6+pUnUNU79XBKiuo4YjfvsF2MoPIE0A947COZctkLS4KLiMIYKfK1
 4Wcaz5vmiFAR+E7/ZqxydCatli+kdZG3WstO/phS2QH6qI5hIJG4ug7KTC5v17zgTP+8Uh
 +gvAOFQtMeJXhd6p2F5yNG14OW/DkH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695041444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeRSjfFQMqIA/G6Y4Thamvp6HdzXaT94viDEbe8Hqjg=;
 b=lKgs6TjHHsQ7sT2i8bKPR5jXvLljBKiEZFV1FkOyZPnpDGrI1WdPWxn/Of7kWRC+c3s6h6
 qnsxrB5zmhbL+HBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 869471358A
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id egXfH6RHCGWKBAAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 12:50:44 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 14:50:44 +0200
Message-ID: <8272498.T7Z3S40VBb@linux-9lzf>
In-Reply-To: <d67de760-ba11-4b28-9959-5ba0ebb1771a@suse.com>
References: <20230915114503.30942-1-mkittler@suse.de>
 <d67de760-ba11-4b28-9959-5ba0ebb1771a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Port `getxattr01.c` to new test API
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QW0gRnJlaXRhZywgMTUuIFNlcHRlbWJlciAyMDIzLCAxNjoxMDoxMSBDRVNUIHNjaHJpZWIgQW5k
cmVhIENlcnZlc2F0byB2aWEgCmx0cDoKPiA+ICsKPiA+ICsJLyogY3JlYXRlIHRlc3QgZmlsZSBh
bmQgc2V0IHhhdHRyICovCj4gPiArCXN0cnVjdCB0ZXN0X2Nhc2UgKnRjID0gJnRjYXNlc1tpXTsK
PiA+ICsJc25wcmludGYodGMtPmZuYW1lLCBCVUZTSVosICJnZXR4YXR0cjAxdGVzdGZpbGUtJXUi
LCBpKTsKPiA+ICsJaW50IGZkID0gU0FGRV9DUkVBVCh0Yy0+Zm5hbWUsIDA2NDQpOwo+ID4gKwlT
QUZFX0NMT1NFKGZkKTsKPiA+ICsJVEVTVChzZXR4YXR0cih0Yy0+Zm5hbWUsIFhBVFRSX1RFU1Rf
S0VZLCBYQVRUUl9URVNUX1ZBTFVFLAo+ID4gKwkJCQkgIHN0cmxlbihYQVRUUl9URVNUX1ZBTFVF
KSwgClhBVFRSX0NSRUFURSkpOwo+IAo+IEhlcmUgeW91IGNhbiB1c2UgVFNUX0VYUF9QQVNTIGlu
c3RlYWQgb2YgVEVTVAo+IAoKSSB3b3VsZG4ndCBrbm93IGhvdy4gSWYgdGhpcyBmdW5jdGlvbiBm
YWlscyB3aXRoIEVOT1RTVVAgc3BlY2lmaWNhbGx5LCB0aGVuIHRoZSAKcmVzdWx0IHNob3VsZCBi
ZSBUQ09ORi4gSSBkb24ndCB0aGluayB1c2luZyBUU1RfRVhQX1BBU1MgYWxsb3dzIHRoYXQuIApB
ZGRpdGlvbmFsbHksIGlmIHRoaXMgZnVuY3Rpb24gZmFpbHMgdGhlIHJlbWFpbmluZyB0ZXN0cyBm
b3IgdGhpcyBpdGVyYXRpb24gCnNob3VsZCBiZSBza2lwcGVkLgoKPiA+ICsKPiA+ICsJLyogcmVh
ZCB4YXR0ciBiYWNrICovCj4gPiArCVRFU1QoZ2V0eGF0dHIodGMtPmZuYW1lLCB0Yy0+a2V5LCB0
Yy0+dmFsdWUsIHRjLT5zaXplKSk7Cj4gPiArCWlmIChUU1RfRVJSID09IHRjLT5leHBfZXJyKSB7
Cj4gPiArCQl0c3RfcmVzKFRQQVNTIHwgVFRFUlJOTywgImV4cGVjdGVkIGdldHhhdHRyKCkgcmV0
dXJuIApjb2RlIik7Cj4gPiArCX0gZWxzZSB7Cj4gPiArCQl0c3RfcmVzKFRGQUlMIHwgVFRFUlJO
TywgInVuZXhwZWN0ZWQgZ2V0eGF0dHIoKSAKcmV0dXJuIGNvZGUiCj4gPiArCQkJCSIgLSBleHBl
Y3RlZCBlcnJubyAlZCIsIHRjLQo+ZXhwX2Vycik7Cj4gPiAKPiA+ICAgCX0KPiAKPiBBbHNvIGhl
cmUgeW91IGNhbiB1c2UgVFNUX0VYUF9QQVNTIGluc3RlYWQgb2YgVEVTVAoKQWxzbyBoZXJlIEkg
d291bGRuJ3Qga25vdyBob3cgdGhhdCBpcyBwb3NzaWJsZS4gVGhlcmUgYXJlIHRlc3QgY2FzZXMg
d2hlcmUgYW4gCmVycm9yIGlzIGFjdHVhbGx5IGV4cGVjdGVkLgoKPiA+IAo+ID4gLQl0c3RfYnJr
bShUQ09ORiwgTlVMTCwgIjxzeXMveGF0dHIuaD4gZG9lcyBub3QgZXhpc3QuIik7Cj4gPiArI2lm
ZGVmIEhBVkVfU1lTX1hBVFRSX0gKPiA+ICsJY2hhciAqY3dkID0gU0FGRV9HRVRDV0QoTlVMTCwg
MCk7Cj4gPiArCXdvcmtkaXIgPSBTQUZFX01BTExPQyhzdHJsZW4oY3dkKSArIHN0cmxlbihNTlRQ
T0lOVCkgKyAyKTsKPiA+ICsJc3ByaW50Zih3b3JrZGlyLCAiJXMvJXMiLCBjd2QsIE1OVFBPSU5U
KTsKPiA+ICsJZnJlZShjd2QpOwo+IAo+IEhlcmUgeW91IGNhbiBqdXN0IFNBRkVfVE9VQ0ggdGhl
IGZpbGUgaWYgeW91IGFpbSB0byBjcmVhdGUgb25lLgo+IAoKVXNpbmcgU0FGRV9UT1VDSCgpIG1h
a2VzIHNlbnNlIGJ1dCBJIGd1ZXNzIHRoZSBmaWxlIGNyZWF0aW9uIG5lZWRzIHRvIGJlIGluIApy
dW4oKSBiZWNhdXNlIGEgZmlsZSBuZWVkcyB0byBiZSBjcmVhdGVkIHBlciBtb3VudC4gQWRkaXRp
b25hbGx5LCBvbmUgdGhlbiBoYWQgCnRvIGNyZWF0ZSBhIGxvb3AgZm9yIGFsbCB0ZXN0IGNhc2Vz
LgoKPiBJbiB5b3VyIGNhc2UsIHRvIHVuZGVyc3RhbmQgTFRQIEFQSSBhIGJpdCBiZXR0ZXIsIEkg
d291bGQgdGFrZQo+IGZ4Z2V0YXR0cjAxIGFzIHJlZmVyZW5jZSwgbW9yZSBvciBsZXNzLgoKVGhh
dCB0ZXN0IHNlZW1zIHZlcnkgc2ltaWxhciwgaW5kZWVkLiBEbyB5b3Ugd2FudCBtZSB0byBmb2xs
b3cgc29tZSBwYXR0ZXJucyAKZnJvbSB0aGVyZSBzcGVjaWZpY2FsbHk/IE5vdGUgdGhhdCB0aGlz
IHRlc3QgYWxzbyB1c2VzIGp1c3QgIlRFU1Qo4oCmKSIgc2ltaWxhcmx5IAp0byBteSBjb2RlLgoK
SXQgZG9lcyBhIHNpbXBsaWZpY2F0aW9uIGJ5IHVzaW5nIFNBRkVfRlNFVFhBVFRSIGFuZCBoZXJl
IEkgY291bGQgdXNlIApTQUZFX1NFVFhBVFRSLiBIb3dldmVyLCB0aGVuIHdlIHdvdWxkIGxvc2Ug
dGhlIEVOT1RTVVAgY2FzZSB3aGljaCBJJ20gbm90IHN1cmUgCndlIHdhbnQvc2hvdWxkIGxvc2Ug
KGVzcGVjaWFsbHkgc2luY2UgSSdtIG1haW5seSBwb3J0aW5nL3JlZmFjdG9yaW5nIGl0IG1pZ2h0
IApub3QgYmUgZGVzaXJhYmxlIHRvIHJlbW92ZSBiZWhhdmlvciBhdCB0aGUgc2FtZSB0aW1lKS4K
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
