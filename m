Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2134BC7618D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 12:53:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDF453CDB9A
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 14:53:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AD353CA360
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 14:53:38 +0200 (CEST)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 52A0F1400059
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 14:53:36 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 9B3D2320092F;
 Thu,  6 Apr 2023 08:53:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Thu, 06 Apr 2023 08:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1680785614; x=1680872014; bh=NrHJgzbhqZ7+MztyMMTX6mfrSilLvQqi2tw
 u3lH9TZs=; b=e9Fd2cZYpOb4VJc7jWL8RogUKySG330vw8tWyyL8zQViTpAq+hi
 5Zc0VIkNIBbSqiuPqB2Kv/8YF4dfq+BtuMTxNSWcn8idT/g0B4EtsydObgf9IuLJ
 p7x3+5LQpwW+beJAWeIEbfgDm21bm/e/wUxGRqY0i+Pf+ZRRMwbIE5wvDVBRJkyI
 /xK8yNaeQSVCFoV5Ws0vm5hnpXL/2W2XWwIKemhFYifKfg6QH3R60KYUtp1X1zKw
 4+nBaaj69/2LZlGFlhNkva4GM3WoqfMRPFSbqdfWlcAbg/wMYcNa1/z87S5v5PDk
 ENDUi92Z6ufAPxX6A9pHx0pNv4FPKjL87vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1680785614; x=1680872014; bh=NrHJgzbhqZ7+MztyMMTX6mfrSilLvQqi2tw
 u3lH9TZs=; b=F8TjLH4FM0It22AdoHcSpQN14joDlbLNsohsuwUqiQP0S09Gl4m
 RSREHKVGtP+dzcPlTKuiWgwnTksJfSE7RuK1EOZxB/I7RzGtyG5SbPn0Xb2h09Ea
 ECegtsxClzdeYCZ7YZ9YG+JGSzLrITwDPbm7GwcJ3A5e+5h4F4dEFRzakyVRJ0mL
 0lofbKRvUdWBlWmcAXH7Dvb0w/ptCQOnseSU8AxEC7tgVuuyTMsOoE4VG0K3fV99
 k+pyYBUVRyjIT6Tf/swiNyK9lG5r3CfxRVGorcPsAXTXRK3Pdj2yImdmZVCDtXPF
 9O3TMXXCXDVaRd+7GvHMgiKPF7LWJmmYAPg==
X-ME-Sender: <xms:zcAuZJUYFEjY3sjPbxw6y0a9GujFN_A76rt7A2yNG88-LZRQrZhelA>
 <xme:zcAuZJlx9uWQUNOy0waUhp8ZM_qcZFBl0GwcR1qoYYvFeNMigldoian-gBev3eQOz
 WsUL47pmQ_R71Rs6wA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgheegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
 gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zcAuZFYsarJ6iJ_zAqXKZdZ9dy_JyL-ASHDcEaJPUOkizFHzA9PvHQ>
 <xmx:zcAuZMWQNRO4601yuAsYy5auiCge4Ss7OZV4TgzANRSeMSRfF-zICQ>
 <xmx:zcAuZDlmv9VgrW_UnQW2lYypO7LRlwOu02dQ5KZMghQepz4E3EUqMg>
 <xmx:zsAuZF7W9K93fPjbIJFlZyYVA2eOTd910-a2gcZgwqyjUwZolJZQsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7425FB60093; Thu,  6 Apr 2023 08:53:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <3c2ba6f9-bea1-4510-8fbb-6521fab74a9d@app.fastmail.com>
In-Reply-To: <20230406124812.GA1589248@pevik>
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com>
 <20230406105646.GB1545779@pevik>
 <7234b8ab-db5c-4f4a-bb9e-ddef9f1a50d3@app.fastmail.com>
 <20230406124812.GA1589248@pevik>
Date: Thu, 06 Apr 2023 14:53:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Petr Vorel" <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: Benjamin Copeland <ben.copeland@linaro.org>, llvm@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgNiwgMjAyMywgYXQgMTQ6NDgsIFBldHIgVm9yZWwgd3JvdGU6Cj4+IE9uIFRo
dSwgQXByIDYsIDIwMjMsIGF0IDEyOjU2LCBQZXRyIFZvcmVsIHdyb3RlOgoKPj4gQWgsIEkgc2Vl
LiBUaGlzIG11c3QgYmUgdGhlIHBhZGRpbmcgY29kZSB0aGVuLCBub3QgdGhlIHRpbWU2NAo+PiBj
b252ZXJzaW9uOgo+Cj4+ICtpbnQgcmVjdm1tc2coaW50IGZkLCBzdHJ1Y3QgbW1zZ2hkciAqbXNn
dmVjLCB1bnNpZ25lZCBpbnQgdmxlbiwgdW5zaWduZWQgaW50IGZsYWdzLCBzdHJ1Y3QgdGltZXNw
ZWMgKnRpbWVvdXQpCj4+ICt7Cj4+ICsjaWYgTE9OR19NQVggPiBJTlRfTUFYCj4+ICsgICAgICAg
c3RydWN0IG1tc2doZHIgKm1oID0gbXNndmVjOwo+PiArICAgICAgIHVuc2lnbmVkIGludCBpOwo+
PiArICAgICAgIGZvciAoaSA9IHZsZW47IGk7IGktLSwgbWgrKykKPj4gKyAgICAgICAgICAgICAg
IG1oLT5tc2dfaGRyLl9fcGFkMSA9IG1oLT5tc2dfaGRyLl9fcGFkMiA9IDA7Cj4+ICsjZW5kaWYK
Pgo+IEkgc3VwcG9zZSB0aGlzIGlzIGEgc3VnZ2VzdGlvbiBmb3IgZml4IGluIExUUC4gSSdkIGV4
cGVjdCBpcyBzaG91bGQgZ28gaW50bwo+IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2VuZG1t
c2cvc2VuZG1tc2dfdmFyLmggaW50byBzdGF0aWMgaW5saW5lIGludAo+IHN5c19yZWN2bW1zZygu
Li4pCj4KPiBCdXQgdGhhdCBhdCBsZWFzdCBvbiBnbGliYyA2NGJpdCBjb21waWxhdGlvbiBkb2Vz
IG5vdCBzZWUgX19wYWQxIG1lbWJlcjoKPgo+IC4uL3NlbmRtbXNnL3NlbmRtbXNnX3Zhci5oOiBJ
biBmdW5jdGlvbiDigJhzeXNfcmVjdm1tc2figJk6Cj4gLi4vc2VuZG1tc2cvc2VuZG1tc2dfdmFy
Lmg6NDc6Mjg6IGVycm9yOiDigJhzdHJ1Y3QgbXNnaGRy4oCZIGhhcyBubyBtZW1iZXIgCj4gbmFt
ZWQg4oCYX19wYWQx4oCZCj4gICAgNDcgfCAgICAgICAgICAgICAgICAgbWgtPm1zZ19oZHIuX19w
YWQxID0gbWgtPm1zZ19oZHIuX19wYWQyID0gMDsKPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KClNvcnJ5LCBJIHNob3VsZCBoYXZlIGJlZW4gY2xlYXJlciwgdGhlIHNuaXBw
ZXQgSSBjaXRlZCBpcwpmcm9tIHRoZSBtdXNsIHNvdXJjZXMsIGFuZCB0aGUgX19wYWQgYWNjZXNz
IGlzIHdoYXQgY2F1c2VzIHRoZQpzZWdmYXVsdC4gVGhlIGZpeCBpcyB0byBjYXRjaCB0aGUgZmF1
bHQgb24gbHRwLCBzYW1lIGFzIGZvciB0aGUKdGltZTY0IGNvbnZlcnNpb25zLgoKICAgICAgQXJu
ZAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
