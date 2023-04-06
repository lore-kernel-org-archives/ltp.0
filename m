Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF1AC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 12:48:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45A8F3CDB94
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 14:48:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590653CC730
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 14:48:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 887EE1A009B9
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 14:48:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73ED21F895;
 Thu,  6 Apr 2023 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680785294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3C5gkwQ1NumD7u6UGVet6+3BAdJ6qwcljpnsMyFFlyE=;
 b=zFfqBs79etl2Qew8xWUBpcjC2YS5HzeKEFhoTzDEQH5kMmk2GU6+LPw0Eq31I1eW90hc0y
 aEfQn7ClQNJjUW8oL1NXz8/iU+ZQA2CSJqNQIGleAfTC3NThSCgieTVUFa1FnQTjHb0ep2
 S4XuviF68XyNDON0ax6khKM05AAm+II=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680785294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3C5gkwQ1NumD7u6UGVet6+3BAdJ6qwcljpnsMyFFlyE=;
 b=wnaEcb4fdgIUGmurtLSE0lUWHOr+VemWMxldkBQXiEYlfRcjgxScXFYI/OWp1z44Osrn/g
 HVe7ilsTwNwMzeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25723133E5;
 Thu,  6 Apr 2023 12:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6CsDCI6/LmTPcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 12:48:14 +0000
Date: Thu, 6 Apr 2023 14:48:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20230406124812.GA1589248@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: list of failures on 32bit and compat mode
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, llvm@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKPiBPbiBUaHUsIEFwciA2LCAyMDIzLCBhdCAxMjo1NiwgUGV0ciBWb3JlbCB3cm90
ZToKPiA+PiBPbiBUaHUsIEFwciA2LCAyMDIzLCBhdCAxMToxMSwgTmFyZXNoIEthbWJvanUgd3Jv
dGU6Cgo+ID4+ID4gbXFfdGltZWRyZWNlaXZlMDEKPiA+PiA+IG1xX3RpbWVkcmVjZWl2ZTAxLmM6
MTk3OiBUUEFTUzogbXFfdGltZWRyZWNlaXZlKCkgZmFpbGVkIGV4cGVjdGVkbHk6IEVJTlRSICg0
KQo+ID4+ID4gdHN0X3Rlc3QuYzoxNTgxOiBUQlJPSzogVGVzdCBraWxsZWQgYnkgU0lHU0VHViEK
Cj4gPj4gSSB0aGluayB0aGlzIGlzIHRoZSBzYW1lIHByb2JsZW0gYXMgZnN0YXRmczAyLCB3aGVy
ZSBsdHAgcGFzc2VzCj4gPj4gYW4gaW52YWxpZCBwb2ludGVyIGFuZCBleHBlY3RzIEVGQVVMVCwg
YnV0IG11c2wgdG91Y2hlcyB0aGUgZGF0YQo+ID4+IGZpcnN0IGluIG9yZGVyIHRvIGRvIHRoZSB0
aW1lNjQgY29udmVyc2lvbi4gTmVlZHMgdGhlIHNhbWUgZml4LgoKPiA+IEZZSSBtcV90aW1lZHJl
Y2VpdmUwMSBpcyBicm9rZW4gb24gMzJiaXQgc3lzdGVtcyB3aXRoIGdsaWJjCj4gPiAoaW4gY3Vy
cmVudCBMVFAgbWFzdGVyKToKCgo+ID4gRUlOVFIgKDQpCj4gPiB0c3RfdGVzdC5jOjE2MTg6IFRC
Uk9LOiBUZXN0IGtpbGxlZCBieSBTSUdTRUdWIQoKPiBSaWdodCwgSSBzZWUgdGhpcyBoYXMgdGhl
IHNhbWUgdGltZTY0IGxvZ2ljIGFzIG11c2wgbm93LgoKPiA+PiA+IHJlY3ZtbXNnMDEuYzo5Mjog
VFBBU1M6IHJlY3ZtbXNnKCkgb3ZlcmZsb3cgaW4gbmFub3NlY29uZHMgaW4gdGltZW91dAo+ID4+
ID4gOiBFSU5WQUwgKDIyKQo+ID4+ID4gdHN0X3Rlc3QuYzoxNTgxOiBUQlJPSzogVGVzdCBraWxs
ZWQgYnkgU0lHU0VHViEKCj4gPj4gU2FtZSB0aW1lNjQgY29udmVyc2lvbiBpc3N1ZSBhcyBhYm92
ZS4KCj4gPiBCZXNpZGVzIHRoZSBzYW1lIHByb2JsZW0gd2l0aCBzaG0gcGVybWlzc2lvbnMgb24g
bXVzbCBJIHNlZSBTSUdTRUdWIGFsc28gb24KPiA+IDY0Yml0IG11c2wgb24gY3VycmVudCBMVFAg
bWFzdGVyLgoKPiBBaCwgSSBzZWUuIFRoaXMgbXVzdCBiZSB0aGUgcGFkZGluZyBjb2RlIHRoZW4s
IG5vdCB0aGUgdGltZTY0Cj4gY29udmVyc2lvbjoKCj4gK2ludCByZWN2bW1zZyhpbnQgZmQsIHN0
cnVjdCBtbXNnaGRyICptc2d2ZWMsIHVuc2lnbmVkIGludCB2bGVuLCB1bnNpZ25lZCBpbnQgZmxh
Z3MsIHN0cnVjdCB0aW1lc3BlYyAqdGltZW91dCkKPiArewo+ICsjaWYgTE9OR19NQVggPiBJTlRf
TUFYCj4gKyAgICAgICBzdHJ1Y3QgbW1zZ2hkciAqbWggPSBtc2d2ZWM7Cj4gKyAgICAgICB1bnNp
Z25lZCBpbnQgaTsKPiArICAgICAgIGZvciAoaSA9IHZsZW47IGk7IGktLSwgbWgrKykKPiArICAg
ICAgICAgICAgICAgbWgtPm1zZ19oZHIuX19wYWQxID0gbWgtPm1zZ19oZHIuX19wYWQyID0gMDsK
PiArI2VuZGlmCgpJIHN1cHBvc2UgdGhpcyBpcyBhIHN1Z2dlc3Rpb24gZm9yIGZpeCBpbiBMVFAu
IEknZCBleHBlY3QgaXMgc2hvdWxkIGdvIGludG8KdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9z
ZW5kbW1zZy9zZW5kbW1zZ192YXIuaCBpbnRvIHN0YXRpYyBpbmxpbmUgaW50CnN5c19yZWN2bW1z
ZyguLi4pCgpCdXQgdGhhdCBhdCBsZWFzdCBvbiBnbGliYyA2NGJpdCBjb21waWxhdGlvbiBkb2Vz
IG5vdCBzZWUgX19wYWQxIG1lbWJlcjoKCi4uL3NlbmRtbXNnL3NlbmRtbXNnX3Zhci5oOiBJbiBm
dW5jdGlvbiDigJhzeXNfcmVjdm1tc2figJk6Ci4uL3NlbmRtbXNnL3NlbmRtbXNnX3Zhci5oOjQ3
OjI4OiBlcnJvcjog4oCYc3RydWN0IG1zZ2hkcuKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmF9f
cGFkMeKAmQogICA0NyB8ICAgICAgICAgICAgICAgICBtaC0+bXNnX2hkci5fX3BhZDEgPSBtaC0+
bXNnX2hkci5fX3BhZDIgPSAwOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
CktpbmQgcmVnYXJkcywKUGV0cgoKPiAgICAgICAgQXJuZAoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
