Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D43D1D88B
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 17:17:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDA9D3C675E
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 19:17:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5C673C5765
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 19:17:24 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BEB082082B6
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 19:17:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7EB81FB68;
 Tue, 15 Oct 2024 17:17:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3E1313A42;
 Tue, 15 Oct 2024 17:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +nhUJqKjDmeYOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Oct 2024 17:17:22 +0000
Date: Tue, 15 Oct 2024 19:17:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20241015171717.GA36237@pevik>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
 <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D7EB81FB68
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLCBMaSwgYWxsLAoKPiBIaSBBbGwsCgo+IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0
IDI6NDnigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6CgoKPiA+IEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4gd3JvdGU6Cgo+ID4gU2lnbmVk
LW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiA+
PiAtLS0KPiA+PiAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2FyYy5pbiAgICAgICAgIHwgIDQxICst
Cj4gPj4gIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hcm0uaW4gICAgICAgICB8IDgxOQo+ID4+ICsr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4gPj4gIGluY2x1ZGUvbGFwaS9zeXNj
YWxscy9hcm02NC5pbiAgICAgICB8ICAxOCArLQo+ID4+ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMv
aTM4Ni5pbiAgICAgICAgfCAgMTggKy0KPiA+PiAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2lhNjQu
aW4gICAgICAgIHwgIDEwICstCgoKCj4gPiBUaGUgbWFpbmxpbmUga2VybmVsIGhhcyBkcm9wcGVk
IHN1cHBvcnQgZm9yIEl0YW5pdW0gSUEtNjQgZnJvbSBrZXJuZWwtdjYuNwo+ID4gLgoKPiA+IGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC9jb21taXQvP2lkPWNmOGU4NjU4MTAwZDRlYWU4MGNlOWIyMWY3YTgxY2IwMjRkZDUw
NTcKCj4gPiBJJ20gd29uZGVyaW5nIGlmIHdlIHNob3VsZCByZW1vdmUgSUE2NCBzdXBwb3J0IGZv
ciBMVFAgYXMgd2VsbC4KCj4gPiBCdXQgd2hhdGV2ZXIgTFRQIGtlZXBzIHRoZSBjb2RlIGZvciBJ
QTY0IG9yIG5vdCwgbWF5YmUgd2UgZG9uJ3QKPiA+IG5lZWQgdGhlc2UgdXBkYXRlIGZvciBpYTY0
LCByaWdodD8KCgo+IEJUVywgVGhlIGJlbG93IGxpbmsgaGVyZSBtYXkgbm90IGJlIGRpcmVjdGx5
IHJlbGV2YW50IHRvIHlvdXIgcGF0Y2gsCj4gYnV0IEkgdGhpbmsgb2Ygd2UgaGF2ZSBkaXNjdXNz
ZWQgY2xlYW5pbmcgdXAgdGhlIElBNjQgY29kZSBpbiBMVFAgYmVmb3JlLgoKPiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNC1KYW51YXJ5LzAzNjYxMS5odG1sCgpZZXMs
IGl0J3MgdGltZSB0byBkcm9wIElBNjQgY29kZSAoYXMgYSBzZXBhcmF0ZSBlZmZvcnQsIHRoZXJl
IGFyZSAjaWZkZWYpLgoKSXQgd291bGQgYmUgY2xlYW5lciBpZiB5b3UgaW5zdGVhZCBvZiBtb2Rp
ZnlpbmcgaWE2NC5pbiBqdXN0IHJlbW92ZSB0aGUgZmlsZSBpbgphIHNlcGFyYXRlIGNvbW1pdCBi
ZWZvcmUgKHVucmVsYXRlZCBjaGFuZ2UpLiBCdXQgSSdtIG9rIGFsc28gd2l0aCBzaW5nbGUgY29t
bWl0CmlmIHlvdSdyZSBub3QgZ29pbmcgdG8gc2VuZCBhbm90aGVyIHZlcnNpb24uCgpJIGFsc28g
d29uZGVyIGlmIHdlIHNob3VsZCBhZGQgUEEtUklTQywgSFAgc3RvcCBzdXBwb3J0aW5nIHNlcnZl
cnMgaW4gMjAxMyBbMV0uClN1cmUsIGtlcm5lbCBpcyBzdGlsbCBjb250YWlucyB0aGlzIGFyY2gs
IGJ1dCBJIGRvdWJ0IGFueWJvZHkgdXNlcyBMVFAgZm9yCnRlc3RpbmcuIFRoZSBhcmNoIGlzIElN
SE8gbm90IHN1cHBvcnRlZCBkaXJlY3RseSBieSBhbnkgZGlzdHJvIChpdCB3YXMgZHJvcHBlZApm
cm9tIERlYmlhbiA2IHNxdWVlemUgWzJdLCB3aGljaCB3YXMgcmVsZWFzZWQgMjAxMSBhbmQgRU9M
IDIwMTYpLCBtb3ZlZCB0bwpEZWJpYW4gcG9ydHMgWzNdLiBUaGUgY29tbXVuaXR5IGlzIHN0aWxs
IHNvbWVob3cgYWN0aXZlLCBidXQgZmV3IHBlb3BsZSBqdXN0CmZpZ2h0IHRvIGZpeCBjb21waWxh
dGlvbiBpc3N1ZXMgWzRdLgoKU3VyZSwgaXQncyBqdXQgYSBzaW5nbGUgZmlsZSAocGFyaXNjLmlu
KSBhbmQgd2UgaGF2ZSBvdGhlciBsZWdhY3kgYXJjaGl0ZWN0dXJlcwp3aGljaCBhcmUgcGFzc2lu
ZyBhd2F5IGJ1dCBub3QgeWV0IHJlbW92ZWQgZnJvbSBrZXJuZWwgdHJlZSBkdWUgZmV3IHBlb3Bs
ZSB1c2luZwp0aGVtIChhdCBsZWFzdCBzaCwgczM5MCwgc3BhcmMpLiBIYXZpbmcgdGhlc2UgZmls
ZXMgd2Ugc3VnZ2VzdCBzb21lYm9keSBpcwphY3R1YWxseSB0YWtpbmcgY2FyZSBhYm91dCB0aGVz
ZSBhcmNocy4gQnV0IGFzIEkgc2FpZCwgcHJvYmFibHkgbm9ib2R5IGlzIHVzaW5nCkxUUCB0byB0
ZXN0IHRoZW0sIHRodXMgbWFueSB0ZXN0cyB3aWxsIGJlIGJyb2tlbi4KClsxXSBodHRwczovL2Vu
Lndpa2lwZWRpYS5vcmcvd2lraS9QQS1SSVNDClsyXSBodHRwczovL3d3dy5kZWJpYW4ub3JnL3Bv
cnRzL2hwcGEvClszXSBodHRwczovL2xpc3RzLmRlYmlhbi5vcmcvZGViaWFuLWhwcGEvCls0XSBo
dHRwczovL2xpc3RzLmRlYmlhbi5vcmcvZGViaWFuLWhwcGEvMjAyNC8wOS90aHJlYWRzLmh0bWwK
CkFsc28sIHRoaXMgNHRoIHBhdGNoIGFsc28gZG9lcyBub3QgYXBwbHkuIFVubGlrZSBmaXJzdCBj
b21taXQgdGhlcmUgYXJlIG1vcmUKY29uZmxpY3RzIChhcHBseWluZyBvZiBjb3Vyc2Ugb24gdGhl
IHRvcCBvZiB0aGUgMyBwcmV2aW91cyBwYXRjaGVzKToKCkRlc2NyaXB0aW9uOiBbdjQsNC80XSBV
cGRhdGUgc3lzY2FsbHMgZmlsZXMKQXBwbHlpbmc6IFVwZGF0ZSBzeXNjYWxscyBmaWxlcwplcnJv
cjogcGF0Y2ggZmFpbGVkOiBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvYXJtLmluOjEKZXJyb3I6IGlu
Y2x1ZGUvbGFwaS9zeXNjYWxscy9hcm0uaW46IHBhdGNoIGRvZXMgbm90IGFwcGx5CmVycm9yOiBw
YXRjaCBmYWlsZWQ6IGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hcm02NC5pbjoyOTQKZXJyb3I6IGlu
Y2x1ZGUvbGFwaS9zeXNjYWxscy9hcm02NC5pbjogcGF0Y2ggZG9lcyBub3QgYXBwbHkKZXJyb3I6
IHBhdGNoIGZhaWxlZDogaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2lhNjQuaW46MzQxCmVycm9yOiBp
bmNsdWRlL2xhcGkvc3lzY2FsbHMvaWE2NC5pbjogcGF0Y2ggZG9lcyBub3QgYXBwbHkKZXJyb3I6
IHBhdGNoIGZhaWxlZDogaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3g4Nl82NC5pbjozNDkKZXJyb3I6
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy94ODZfNjQuaW46IHBhdGNoIGRvZXMgbm90IGFwcGx5ClBh
dGNoIGZhaWxlZCBhdCAwMDAxIFVwZGF0ZSBzeXNjYWxscyBmaWxlcwoKS2luZCByZWdhcmRzLApQ
ZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
