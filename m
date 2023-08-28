Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5F8C71153
	for <ltp@archiver.kernel.org>; Mon, 28 Aug 2023 10:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 221843CC1C9
	for <ltp@archiver.kernel.org>; Mon, 28 Aug 2023 12:03:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8113CB708
 for <ltp@lists.linux.it>; Mon, 28 Aug 2023 12:02:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 895801A01084
 for <ltp@lists.linux.it>; Mon, 28 Aug 2023 12:02:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F15B1F390;
 Mon, 28 Aug 2023 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693216968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rCMojA0Y/37SdfHbpoTcdpobcqSmr3ZWzw9sVUhdtE=;
 b=SFpdPQroW/nE5J9Bjm6kC+32IQPxAUWNdaWhfNcdN/9kl8pohD+40aQYfOQMkcibUf3vD0
 6DdDn89eF2EGBkKSQuIcWmTUcqZ+PmAjpqDSXwD2dehhJV1hrevr6FtA00NbNVQUayG42k
 F3mDQPuyMMyzUmoSB3U5DYdsTLuTNE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693216968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rCMojA0Y/37SdfHbpoTcdpobcqSmr3ZWzw9sVUhdtE=;
 b=0yk0dvgnIy0geK47pXQCo4Iro4KCiIm4L4mdL0zooeX687NfOCSsLoKFI006QmXsb2JRD0
 x77NpRHtuhdItsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EDBA139CC;
 Mon, 28 Aug 2023 10:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Hk+FB8hw7GSTRgAAMHmgww
 (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 10:02:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id B0A53A0774; Mon, 28 Aug 2023 12:02:47 +0200 (CEST)
Date: Mon, 28 Aug 2023 12:02:47 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20230828100247.2njvvupgfgsyivsv@quack3>
References: <20230825122753.4721-1-jack@suse.cz>
 <CAOQ4uxjhSix9-nWBb+CvovDjkGHhdeT5tTiOZs5WeV55vNuHQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjhSix9-nWBb+CvovDjkGHhdeT5tTiOZs5WeV55vNuHQg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify22: Make tests not depend on behavior of
 shutdown filesystem
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpIDI1LTA4LTIzIDE3OjEyOjE3LCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBGcmks
IEF1ZyAyNSwgMjAyMyBhdCAzOjI44oCvUE0gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JvdGU6
Cj4gPgo+ID4gVGhlIHRlc3RzIGluIGZhbm90aWZ5MjIgaW1wbGljaXRlbHkgZGVwZW5kZWQgb24g
dGhlIGZhY3QgdGhhdCBmaWxlc3lzdGVtCj4gPiBzaHV0ZG93biB3aXRoICdhYm9ydCcgbW91bnQg
b3B0aW9uIGtlZXBzIHJlcG9ydGluZyBmdXJ0aGVyIGVycm9ycyBhbmQKPiA+IGZ1cnRoZXIgbW91
bnRzIHdpdGggJ2Fib3J0JyBvcHRpb24uIFRoaXMgaXMgaG93ZXZlciB0b28gc3RyaWN0IChtb3N0
bHkgYQo+ID4gYnVnIGluIGV4dDQgaW1wbGVtZW50YXRpb24pIGFuZCBpbiBwcmluY2lwbGUgcmVw
b3J0aW5nIGVycm9ycyBhZnRlciB0aGUKPiA+IGZpbGVzeXN0ZW0gaXMgc2h1dGRvd24gaXMganVz
dCBhIHBvaW50bGVzcyBub2lzZS4gRXh0NCByZWNlbnRseSBtb2RpZmllZAo+ID4gdGhlIGJlaGF2
aW9yIG9mICdhYm9ydCcgbW91bnQgb3B0aW9uIHRvIGJlaGF2ZSB0aGUgc2FtZSBhcyBmaWxlc3lz
dGVtCj4gPiBzaHV0ZG93biBhbmQgdGh1cyBhbHNvIHN0b3AgcmVwb3J0aW5nIGZ1cnRoZXIgZmls
ZXN5c3RlbSBlcnJvcnMuIE1vZGlmeQo+ID4gdGhlIHRlc3RzIHRvIHVubW91bnQgYW5kIG1vdW50
IHRoZSBmaWxlc3lzdGVtIGFmdGVyIGVhY2ggdGVzdCB0byBnZXQgaXQKPiA+IG91dCBvZiB0aGUg
c2h1dGRvd24gc3RhdGUgZm9yIHRoZSBmb2xsb3dpbmcgdGVzdHMgYW5kIGFsc28gcmVwbGFjZSBh
Cj4gPiB0ZXN0IHRlc3RpbmcgYmVoYXZpb3IgYWZ0ZXIgbW91bnRpbmcgd2l0aCAnYWJvcnQnIG1v
dW50IG9wdGlvbiB3aXRoIGEKPiA+IHRlc3QgdGVzdGluZyB0d28gZGlmZmVyZW50IGZpbGVzeXN0
ZW0gY29ycnVwdGlvbiBlcnJvcnMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGph
Y2tAc3VzZS5jej4KPiA+IC0tLQo+ID4gIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFu
b3RpZnkyMi5jICAgICB8IDE5ICsrKysrKysrKysrKysrKystLS0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjIuYwo+ID4gaW5kZXggMTEwNTE3
MmJiMjY5Li40NzUxNTViOWY1OGEgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjIuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKPiA+IEBAIC00Miw2ICs0Miw3IEBACj4gPiAg
I2RlZmluZSBNT1VOVF9QQVRIICJ0ZXN0X21udCIKPiA+ICAjZGVmaW5lIEJBU0VfRElSICJpbnRl
cm5hbF9kaXIiCj4gPiAgI2RlZmluZSBCQURfRElSIEJBU0VfRElSIi9iYWRfZGlyIgo+ID4gKyNk
ZWZpbmUgQkFEX0xJTksgQkFTRV9ESVIiL2JhZF9saW5rIgo+ID4KPiA+ICAjaWZkZWYgSEFWRV9O
QU1FX1RPX0hBTkRMRV9BVAo+ID4KPiA+IEBAIC01MSw2ICs1Miw3IEBAIHN0YXRpYyBpbnQgZmRf
bm90aWZ5Owo+ID4gIC8qIFRoZXNlIGV4cGVjdGVkIEZJRHMgYXJlIGNvbW1vbiB0byBtdWx0aXBs
ZSB0ZXN0cyAqLwo+ID4gIHN0YXRpYyBzdHJ1Y3QgZmFub3RpZnlfZmlkX3QgbnVsbF9maWQ7Cj4g
PiAgc3RhdGljIHN0cnVjdCBmYW5vdGlmeV9maWRfdCBiYWRfZmlsZV9maWQ7Cj4gPiArc3RhdGlj
IHN0cnVjdCBmYW5vdGlmeV9maWRfdCBiYWRfbGlua19maWQ7Cj4gPgo+ID4gIHN0YXRpYyB2b2lk
IHRyaWdnZXJfZnNfYWJvcnQodm9pZCkKPiA+ICB7Cj4gPiBAQCAtNzgsNyArODAsMTMgQEAgc3Rh
dGljIHZvaWQgdGNhc2UyX3RyaWdnZXJfbG9va3VwKHZvaWQpCj4gPgo+ID4gIHN0YXRpYyB2b2lk
IHRjYXNlM190cmlnZ2VyKHZvaWQpCj4gPiAgewo+ID4gLSAgICAgICB0cmlnZ2VyX2ZzX2Fib3J0
KCk7Cj4gPiArICAgICAgIGludCByZXQ7Cj4gPiArCj4gPiArICAgICAgIC8qIFNBRkVfT1BFTiBj
YW5ub3QgYmUgdXNlZCBoZXJlIGJlY2F1c2Ugd2UgZXhwZWN0IGl0IHRvIGZhaWwuICovCj4gPiAr
ICAgICAgIHJldCA9IG9wZW4oTU9VTlRfUEFUSCIvIkJBRF9MSU5LLCBPX1JET05MWSwgMCk7Cj4g
PiArICAgICAgIGlmIChyZXQgIT0gLTEgJiYgZXJybm8gIT0gRVVDTEVBTikKPiA+ICsgICAgICAg
ICAgICAgICB0c3RfcmVzKFRGQUlMLCAiVW5leHBlY3RlZCBvcGVuIHJlc3VsdCglZCkgb2YgJXMg
KCVkIT0lZCkiLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0LCBCQURfTElOSywgZXJy
bm8sIEVVQ0xFQU4pOwo+ID4gICAgICAgICB0Y2FzZTJfdHJpZ2dlcl9sb29rdXAoKTsKPiA+ICB9
Cj4gCj4gVG8gbWFrZSBpdCBtb3JlIGNsZWFyIHRoYXQgdGhpcyBpcyBhIG11bHRpcGxlIGVycm9y
IHRyaWdnZXIsIEkgd291bGQgY29uc2lkZXIKPiAKPiAxLiB1c2UgaGVscGVyIHRyaWdnZXJfYmFk
X2xpbmtfbG9va3VwKCkKPiAyLiBzL3RjYXNlMl90cmlnZ2VyX2xvb2t1cC90cmlnZ2VyX2JhZF9m
aWxlX2xvb2t1cAo+IAo+IEFORAo+IAo+IHN0YXRpYyB2b2lkIHRjYXNlM190cmlnZ2VyKHZvaWQp
Cj4gewo+ICAgICAgICB0cmlnZ2VyX2JhZF9saW5rX2xvb2t1cCgpOwo+ICAgICAgICB0cmlnZ2Vy
X2JhZF9maWxlX2xvb2t1cCgpOwo+IH0KPiAKPiBXaXRoIHRoYXQgbml0IGZpeCwgeW91IG1heSBh
ZGQ6Cj4gCj4gUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
CgpUaGFua3MgZm9yIHJldmlldyEgSSBkaWQgYWxsIHRoZSBjaGFuZ2VzLCBzdWJtaXR0aW5nIHYy
IHNob3J0bHkuCgoJCQkJCQkJCUhvbnphCi0tIApKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4KU1VT
RSBMYWJzLCBDUgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
