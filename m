Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D8DC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 13:18:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F06B3CDB97
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 15:18:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1E963C03AE
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 15:18:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8852A1A003D3
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 15:17:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EAB11FD76;
 Thu,  6 Apr 2023 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680787078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfC7CMPXeeRMiPKxLyM3C13TOXBtHVBske2Zh3FAELY=;
 b=jz4wQSjNwiTLPukTzWuoOY3ua0xRuJciJdXDRsbi9kNotTXtegJTpyHUDpAW9erXwGzNSk
 L66Rjygnz+Y0LaU/6wU43bNPjQHz2TW/EaraJ+U93a4phnG5AJO1if1ZP/6bUr2Ty5mYxa
 ryQmHMtNROJKsQ4cbTv4G7wkrnRp8Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680787078;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfC7CMPXeeRMiPKxLyM3C13TOXBtHVBske2Zh3FAELY=;
 b=GJxuSPA7soPWU8u482+5aSlrmq9WnEviWybvmmcG3PJJ+HGT5looaU/dsNoaWo+bPAErlP
 tTEGOP+6eIo8UzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37D64133E5;
 Thu,  6 Apr 2023 13:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vmNhCoXGLmTWBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Apr 2023 13:17:57 +0000
Date: Thu, 6 Apr 2023 15:17:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20230406131755.GA1608262@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
 <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
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

PiBPbiBUaHUsIEFwciA2LCAyMDIzLCBhdCAxNDo0OCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+PiBP
biBUaHUsIEFwciA2LCAyMDIzLCBhdCAxMjo1NiwgUGV0ciBWb3JlbCB3cm90ZToKCj4gPj4gQWgs
IEkgc2VlLiBUaGlzIG11c3QgYmUgdGhlIHBhZGRpbmcgY29kZSB0aGVuLCBub3QgdGhlIHRpbWU2
NAo+ID4+IGNvbnZlcnNpb246Cgo+ID4+ICtpbnQgcmVjdm1tc2coaW50IGZkLCBzdHJ1Y3QgbW1z
Z2hkciAqbXNndmVjLCB1bnNpZ25lZCBpbnQgdmxlbiwgdW5zaWduZWQgaW50IGZsYWdzLCBzdHJ1
Y3QgdGltZXNwZWMgKnRpbWVvdXQpCj4gPj4gK3sKPiA+PiArI2lmIExPTkdfTUFYID4gSU5UX01B
WAo+ID4+ICsgICAgICAgc3RydWN0IG1tc2doZHIgKm1oID0gbXNndmVjOwo+ID4+ICsgICAgICAg
dW5zaWduZWQgaW50IGk7Cj4gPj4gKyAgICAgICBmb3IgKGkgPSB2bGVuOyBpOyBpLS0sIG1oKysp
Cj4gPj4gKyAgICAgICAgICAgICAgIG1oLT5tc2dfaGRyLl9fcGFkMSA9IG1oLT5tc2dfaGRyLl9f
cGFkMiA9IDA7Cj4gPj4gKyNlbmRpZgoKPiA+IEkgc3VwcG9zZSB0aGlzIGlzIGEgc3VnZ2VzdGlv
biBmb3IgZml4IGluIExUUC4gSSdkIGV4cGVjdCBpcyBzaG91bGQgZ28gaW50bwo+ID4gdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zZW5kbW1zZy9zZW5kbW1zZ192YXIuaCBpbnRvIHN0YXRpYyBp
bmxpbmUgaW50Cj4gPiBzeXNfcmVjdm1tc2coLi4uKQoKPiA+IEJ1dCB0aGF0IGF0IGxlYXN0IG9u
IGdsaWJjIDY0Yml0IGNvbXBpbGF0aW9uIGRvZXMgbm90IHNlZSBfX3BhZDEgbWVtYmVyOgoKPiA+
IC4uL3NlbmRtbXNnL3NlbmRtbXNnX3Zhci5oOiBJbiBmdW5jdGlvbiDigJhzeXNfcmVjdm1tc2fi
gJk6Cj4gPiAuLi9zZW5kbW1zZy9zZW5kbW1zZ192YXIuaDo0NzoyODogZXJyb3I6IOKAmHN0cnVj
dCBtc2doZHLigJkgaGFzIG5vIG1lbWJlciAKPiA+IG5hbWVkIOKAmF9fcGFkMeKAmQo+ID4gICAg
NDcgfCAgICAgICAgICAgICAgICAgbWgtPm1zZ19oZHIuX19wYWQxID0gbWgtPm1zZ19oZHIuX19w
YWQyID0gMDsKPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKPiBTb3Jy
eSwgSSBzaG91bGQgaGF2ZSBiZWVuIGNsZWFyZXIsIHRoZSBzbmlwcGV0IEkgY2l0ZWQgaXMKPiBm
cm9tIHRoZSBtdXNsIHNvdXJjZXMsIGFuZCB0aGUgX19wYWQgYWNjZXNzIGlzIHdoYXQgY2F1c2Vz
IHRoZQo+IHNlZ2ZhdWx0LiBUaGUgZml4IGlzIHRvIGNhdGNoIHRoZSBmYXVsdCBvbiBsdHAsIHNh
bWUgYXMgZm9yIHRoZQo+IHRpbWU2NCBjb252ZXJzaW9ucy4KClRoYW5rcyEgSSd2ZSBqdXN0IHNl
YXJjaGVkIGluIG11c2wgYXMgd2VsbCwgYmVjYXVzZSBpdCBkaWRuJ3QgbWFrZSBzZW5zZSB0byBt
ZQppdCdkIGJlIGEgY29kZSBmb3IgTFRQLgoKInRvIGNhdGNoIHRoZSBmYXVsdCBvbiBsdHAiIEkg
d29uZGVyIGlmIGl0J3Mgbm90IGFjdHVhbGx5IG11c2wgYnVnLgoKS2luZCByZWdhcmRzLApQZXRy
CgoKPiAgICAgICBBcm5kCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
