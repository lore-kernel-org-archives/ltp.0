Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE966C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 11:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D20B3CBDB9
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 12:53:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EA6C3CBD8B
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 12:53:20 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77DB7600431
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 12:53:20 +0100 (CET)
Received: by mail-lf1-x12b.google.com with SMTP id b3so4513575lfv.2
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 03:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jal3/JFQ8LmBRW7V8wi0HA0IM1v4WHaSvNJjV4F6bHU=;
 b=hEr4dHsBKeVWswYf9ABkSViaHze43e9q2GBafLQwfS8uUJOCMz97bM6RkC+k6BfsiR
 PC0I4PZF/RCEsXW9OYuL1MV6IfTJUXNa0THOh9VuJZv3+fn1N/NbUJc1YlPDE0NOhzX5
 bFgyiHxxyy7N0QHqh4OYPuAbwEWeaU8rEZD33i9lA2QD/j4VwPRvwLHUdUEnPJEOFW0n
 DuAeHQkznf4QQTqYc6fvQfT6DI5xghS1t4rJPJ9JFcv6dU9ge65ocUAR8/LfFW20UgZN
 IKMR6wbHTzpHu5+pGHfNS+1wVqGPUwt/DWzZp/bOBCznGtpUkIMNhrZpPP9dVRsuUZkG
 Sglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jal3/JFQ8LmBRW7V8wi0HA0IM1v4WHaSvNJjV4F6bHU=;
 b=w97QiXhXPEfIhtw4+CwBot8FYG7HZlH/S2E2SEIfRjnI1QruEa95z4R/aI6in+Ol0y
 Obpg2pLdLcr7zOYCLzDqUQ/ZMbp7+IhB+yQR0a5xPwa9HfX6Jty6GGCHTC2gK75QQCdX
 oImiVOYtVL+Bbv+Wym4AjdcGACxcrj2s4FEXEwDzCM2/Cl1VQoTkzgoL8Apa8XrDqYtz
 adBqTN2bFQYGHujvixeZjrSQ+dO5MGynqDDrE6RT6w1SWuwjyMLnHgHbi4Cf+aF685t3
 tw8c+fzsNFSxQdKUtSF45PonQIE1/jABjBgcVR+jxLi8d2fIQVfn1/GF8/JOneBlVETr
 2Kzw==
X-Gm-Message-State: ANoB5pkQnXkSgvV96nDgcaf57Vq/k01rJ1eimicfhJZb4NNFnAppuN4I
 35yXc32GwwCi4enOovMg11Z8mRsRho64xP5GtZM=
X-Google-Smtp-Source: AA0mqf7sJYIEEoe7/Vh0gl1/42IApAVnDQa2xvz2s5uyn0k44BB+HxDBx/Ry3R3z6aFXXJppkFggZm7K9uLB8cwbOnI=
X-Received: by 2002:a19:690c:0:b0:4b5:834e:5091 with SMTP id
 e12-20020a19690c000000b004b5834e5091mr4597221lfc.386.1670932399731; Tue, 13
 Dec 2022 03:53:19 -0800 (PST)
MIME-Version: 1.0
References: <CAFQkDyZABHU38_LTvsv1eP8PvK4rHprfZrL45CYqMvav1-O8_A@mail.gmail.com>
 <87mt7su1dg.fsf@suse.de>
In-Reply-To: <87mt7su1dg.fsf@suse.de>
From: Xinkuan Yan <lucky33newman@gmail.com>
Date: Tue, 13 Dec 2022 19:53:08 +0800
Message-ID: <CAFQkDyahG5Y8_=WcB4Kz4QLOc32p0vhDb5tSEd3Xoo_OY79LwA@mail.gmail.com>
To: rpalethorpe@suse.de, Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Question about log format.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuCgpZb3VyIGFuc3dlcnMgaGVscGVkIG1lIHNv
IG11Y2ggZnJvbSBnZXR0aW5nIGxvc3QgaW4gbHRwLCB3b29vcHMsIHRoaXMKbWFzc2l2ZSBGcmFu
a2Vuc3RhaW4gbWFkZSBtZSBnbyBtYWQgd2hlbiBJIGRlc2lnbiB0aGUgY29yZSBwYXJzZXIgZnVu
Y3Rpb24uCgpXaXNoIHJ1bmx0cC1uZyB2ZXJzaW9uIGEgZ3JlYXQgam9iISBMb29raW5nIGZvcndh
cmQgdG8gc2VlIHRoYXQuCgpDaGVlcnMsCllhbgoKUmljaGFyZCBQYWxldGhvcnBlIDxycGFsZXRo
b3JwZUBzdXNlLmRlPiDkuo4yMDIy5bm0MTLmnIgxMuaXpeWRqOS4gCAyMjo0NeWGmemBk++8mgoK
PiBIZWxsbywKPgo+IFhpbmt1YW4gWWFuIDxsdWNreTMzbmV3bWFuQGdtYWlsLmNvbT4gd3JpdGVz
Ogo+Cj4gPiBIZWxsbyBsaXN0LAo+ID4KPiA+IEknbSB0cnlpbmcgdG8gZG8gYSBjb25jaXNlIHBh
cnNpbmcgb2YgdGhlIExUUCByZXBvcnQuCj4gPgo+ID4gSSBkb24ndCBoYXZlIG11Y2ggZXhwZXJp
ZW5jZSBhbmQgSSdtIG5vdCBmYW1pbGlhciB3aXRoIExUUCwgc28gSSdtIGdvaW5nCj4gdG8KPiA+
IHRha2UgI21hdGggYXMgYW4gZXhhbXBsZSwgZm9yIGl0IGlzIG5vdCBjb21wbGV4Lgo+ID4KPiA+
IFJ1biB0ZXN0IGNvbW1hbmQ6Cj4gPgo+ID4gLi9sdHAg4oCTZiBtYXRoIOKAk3EKPiA+Cj4gPiBJ
IGhhdmUgdGhyZWUgcXVlc3Rpb25zIG5vdywgIHRha2luZyB0aGUgb25lLWxpbmUgb3V0cHV0IHJl
c3VsdCBiZWxvdyBhcwo+IGFuCj4gPiBleGFtcGxlOgo+ID4KPiA+IGZsb2F0X2lwZXJiIDEgVFBB
U1M6IFRlc3QgcGFzc2VkCj4KPiBUaGlzIGlzIGEgdGVzdCB1c2luZyB0aGUgb2xkIEFQSSwgc28g
bm90IHRoZSBiZXN0IGV4YW1wbGUuCj4KPiA+Cj4gPiAxLCBJdCBpcyBjbGVhciB0aGF0IFRQQVNT
IG1lYW5zIGl0IHBhc3NlZCwgYnV0IHdoYXQgaXMgdGhlIG51bWJlciAxCj4gPiBzdGFuZGluZyBm
b3IuCj4KPiBJIGRvbid0IGtub3cgdG8gYmUgaG9uZXN0LiBJdCB3YXMgcmVtb3ZlZCBpbiB0aGUg
bmV3IHRlc3QgQVBJLgo+Cj4gPgo+ID4gMiwgV2h5IHRoaXMgbGluZSBzaG93ZWQgdXAgdHdpY2U/
ICggUFM6IEJldHdlZW4gdGhlc2UgdHdvIGxpbmVzIGFyZSBtYW55Cj4gPiBUSU5GTy4pCj4KPiBQ
b3NzaWJseSBiZWNhdXNlIHRoZXJlIGFyZSBtdWx0aXBsZSBpdGVyYXRpb25zIG9mIHRoZSB0ZXN0
LiBQb3NzaWJseQo+IHNvbWUgcGFyYW10ZXJzIGFyZSBjaGFuZ2VkIGJldHdlZW4gaXRlcmF0aW9u
cy4KPgo+IE9ubHkgd2F5IHRvIGZpbmQgb3V0IGlzIHRvIGxvb2sgZm9yIHRzdF9yZXNtIGNhbGxz
IGluIHRoZSBzb3VyY2UgY29kZS4KPgo+ID4KPiA+IDMsIFdoZXJlIHRvIGNoZWNrIHRob3NlIG91
dCBwdXQgc3RhbmRhcmRzLCB0YWtpbmcgeW9jdG8gcGFja2FnZSB0ZXN0IGFzIGEKPiA+IHNtYWxs
IGNvbXByZWhlbnNpb24sIHRoYXQgc3RhbmRhcmQgd2FzICggUEFTU3xGQUlMfFNLSVApOiBUZXN0
IGluZm8uIEhvdwo+IGlzCj4gPiBpdCBsaWtlIGluIExUUD8KPgo+Cj4gaHR0cHM6Ly9naXRodWIu
Y29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9DLVRlc3QtQVBJIzEyLWJhc2ljLXRlc3Qt
aW50ZXJmYWNlCj4KPiBOb3RlIHRhaHQgdGhlIG5ldyBBUEkgb3V0cHV0IGxvb2tzIG1vcmUgbGlr
ZSB0aGUgZm9sbG93aW5nOgo+Cj4gc2gtNS4yIyAuL2JwZl9wcm9nMDcKPiB0c3RfYnVmZmVycy5j
OjU1OiBUSU5GTzogVGVzdCBpcyB1c2luZyBndWFyZGVkIGJ1ZmZlcnMKPiB0c3RfdGFpbnQuYzox
MTY6IFRDT05GOiBJZ25vcmluZyBhbHJlYWR5IHNldCBrZXJuZWwgd2FybmluZyB0YWludAo+IHRz
dF90ZXN0LmM6MTU2MDogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCj4gYnBm
X2NvbW1vbi5jOjE3OiBUSU5GTzogUmFpc2luZyBSTElNSVRfTUVNTE9DSyB0byAxMDQ4NTc2MAo+
IHRzdF9jYXBhYmlsaXR5LmM6Mjk6IFRJTkZPOiBEcm9wcGluZyBDQVBfU1lTX0FETUlOKDIxKQo+
IHRzdF9jYXBhYmlsaXR5LmM6Mjk6IFRJTkZPOiBEcm9wcGluZyBDQVBfQlBGKDM5KQo+IGJwZl9j
b21tb24uYzozOTogVENPTkY6IEhpbnQ6IGNoZWNrIGFsc28KPiAvcHJvYy9zeXMva2VybmVsL3Vu
cHJpdmlsZWdlZF9icGZfZGlzYWJsZWQKPiBicGZfY29tbW9uLmM6NDE6IFRDT05GOiBicGYoKSBy
ZXF1aXJlcyBDQVBfU1lTX0FETUlOIG9yIENBUF9CUEYgb24gdGhpcwo+IHN5c3RlbTogRVBFUk0g
KDEpCj4KPiBTdW1tYXJ5Ogo+IHBhc3NlZCAgIDAKPiBmYWlsZWQgICAwCj4gYnJva2VuICAgMAo+
IHNraXBwZWQgIDMKPiB3YXJuaW5ncyAwCj4KPiBzaC01LjIjIC4vYnBmX3Byb2cwMQo+IHRzdF9i
dWZmZXJzLmM6NTU6IFRJTkZPOiBUZXN0IGlzIHVzaW5nIGd1YXJkZWQgYnVmZmVycwo+IHRzdF90
ZXN0LmM6MTU2MDogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCj4gYnBmX2Nv
bW1vbi5jOjE3OiBUSU5GTzogUmFpc2luZyBSTElNSVRfTUVNTE9DSyB0byAxMDQ4NTc2MAo+IGJw
Zl9jb21tb24uYzoxMTQ6IFRQQVNTOiBMb2FkZWQgcHJvZ3JhbQo+IGJwZl9wcm9nMDEuYzo5NTog
VFBBU1M6IHZhbCA9IDEKPiAuLi4KPgo+IFNvIHRoZSBmb3JtYXQgaXMgbGlrZToKPgo+IDxmaWxl
X25hbWU+OjxsaW5lPjogPHR0eXBlPjogPG1lc3NhZ2U+Cj4KPiAtLQo+IFRoYW5rIHlvdSwKPiBS
aWNoYXJkLgo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
