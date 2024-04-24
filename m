Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD0EC07E8E
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:18:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DC663CFFF5
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:17:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB67B3CE530
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 14:17:43 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E6D6A60B02D
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 14:17:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 676A93F118;
 Wed, 24 Apr 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CB581393C;
 Wed, 24 Apr 2024 12:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ACwrEmX4KGbfagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Apr 2024 12:17:41 +0000
Date: Wed, 24 Apr 2024 14:17:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240424121740.GA227922@pevik>
References: <20240423132823.194179-1-pvorel@suse.cz>
 <20240423132823.194179-2-pvorel@suse.cz>
 <CAASaF6wWtdmG6nWpWcTv=AnzJn8vSe71RQsSkcF-1wHbPb_Mjw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wWtdmG6nWpWcTv=AnzJn8vSe71RQsSkcF-1wHbPb_Mjw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 676A93F118
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/fs: Include lapi/fcntl.h + define
 _GNU_SOURCE
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

SGkgSmFuLAoKPiBPbiBUdWUsIEFwciAyMywgMjAyNCBhdCAzOjI44oCvUE0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+IFRoaXMgZml4ZXMgYnVpbGQgZXJyb3Igb24gbXVz
bCAoYWxwaW5lKToKCj4gPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gdW5saW5rMDkuYzoxODoKPiA+
IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mcy5oOjU4OjE1OiBlcnJvcjogdW5rbm93biB0eXBl
IG5hbWUgJ2xvZmZfdCcKPiA+ICAgIDU4IHwgc3RhdGljIGlubGluZSBsb2ZmX3QgdHN0X21heF9s
ZnNfZmlsZXNpemUodm9pZCkKCj4gPiBsb2ZmX3QgaXMgZGVmaW5lZCBpbiA8ZmNudGwuaD4gKGJ1
dCBndWFyZGVkIF9HTlVfU09VUkNFKSwgYnV0IGp1c3QgZm9yCj4gPiBzYWZldHkgaW5jbHVkZSBs
YXBpL2ZjbnRsLmggaW4gY2FzZSBsYXBpL2ZzLmggaXMgaW5jbHVkZWQgaW4gdGVzdCB3aGljaAo+
ID4gbmVlZHMgZmFsbGJhY2sgZGVmaW5pdGlvbnMgZnJvbSBsYXBpL2ZzLmguCgo+IFlvdSBwcm9i
YWJseSBtZWFudCBsYXBpL2ZjbnRsLmggaGVyZSBeXgoKKzEKCj4gPiBCZWNhdXNlIHdlIHJlcXVp
cmUgX0dOVV9TT1VSQ0UgZGVmaW5pdGlvbiBmb3IgY29kZSBpbiBsYXBpL2ZzLmgsIHRoYXQncwo+
ID4gd2h5IHRoZXJlIGlzIHRoZSBkZWZpbml0aW9uIGluIGJvdGggdW5saW5rMDkuYyAodGhlIGFj
dHVhbCBmaXgpIGFuZAo+ID4gbGFwaS9mcy5oIGZvciB2aXNpYmlsaXR5IG9mIHRoZSBwcm9ibGVt
LgoKPiA+IEZpeGVzOiAyY2Y3OGY0N2EgKCJ1bmxpbms6IEFkZCBlcnJvciB0ZXN0cyBmb3IgRVBF
Uk0gYW5kIEVST0ZTIikKPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6Pgo+ID4gLS0tCj4gPiAjZGVmaW5lIF9HTlVfU09VUkNFIHBhaW4gYWdhaW4uIFdvdWxkIHlv
dSBzb2x2ZSBpdCBkaWZmZXJlbnRseT8KCj4gSSdkIGxpa2VseSBnbyBzaW1pbGFyIHJvdXRlLCBi
dXQgSSdkIGRyb3AgdGhlIGh1bmsgZnJvbSB1bmxpbmswOS5jLgo+IFRoZSB0ZXN0IGlzIG5vdCB1
c2luZyBsb2ZmX3QgZGlyZWN0bHksIGl0IGluY2x1ZGVzIGEgaGVhZGVyLCBzbyBpdAo+IHNob3Vs
ZCBiZSB1cCB0bwoKRmlyc3QsIHRoYW5rcyBhIGxvdCBmb3IgeW91ciByZXZpZXchCgpPSywgdGhp
cyB3aWxsIHdvcmssIGp1c3QgbGFwaS9mcy5oIG11c3QgYmUgbG9hZGVkIGJlZm9yZSB0c3RfdGVz
dC5oLApvdGhld2lzZSBpdCB3b3VsZCBmYWlsIG9uIEFscGluZToKCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSB1bmxpbmswOS5jOjIwOgouLi8uLi8uLi8uLi9pbmNsdWRlL2xhcGkvZnMuaDo2MToxNTog
ZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdsb2ZmX3QnCiAgIDYxIHwgc3RhdGljIGlubGluZSBs
b2ZmX3QgdHN0X21heF9sZnNfZmlsZXNpemUodm9pZCkKICAgICAgfCAgICAgICAgICAgICAgIF5+
fn5+fgouLi8uLi8uLi8uLi9pbmNsdWRlL2xhcGkvZnMuaDogSW4gZnVuY3Rpb24gJ3RzdF9tYXhf
bGZzX2ZpbGVzaXplJzoKLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzLmg6NjQ6MTc6IGVycm9y
OiAnbG9mZl90JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5
b3UgbWVhbiAnb2ZmX3QnPwogICA2NCB8ICAgICAgICAgcmV0dXJuIChsb2ZmX3QpTExPTkdfTUFY
OwogICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAg
b2ZmX3QKLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2ZzLmg6NjQ6MTc6IG5vdGU6IGVhY2ggdW5k
ZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlv
biBpdCBhcHBlYXJzIGluCi4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mcy5oOjY0OjI0OiBlcnJv
cjogZXhwZWN0ZWQgJzsnIGJlZm9yZSBudW1lcmljIGNvbnN0YW50CiAgIDY0IHwgICAgICAgICBy
ZXR1cm4gKGxvZmZfdClMTE9OR19NQVg7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICBe
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICA7Cm1ha2U6ICoqKiBbLi4vLi4vLi4vLi4v
aW5jbHVkZS9tay9ydWxlcy5tazo0NTogdW5saW5rMDldIEVycm9yIDEKCihnbGliYyBoaWRlcyBs
b2ZmX3QgYmVoaW5kIF9fVVNFX01JU0MsIHdoaWNoIEkgdGhvdWdodCBpdCBpdCdzIGluIHRoZSBl
bmQKX0dOVV9TT1VSQ0UsIGJ1dCBvYnZpb3VzbHkgbm90KS4KCkFuZCB1c2luZyBpbmNsdWRlL2xh
cGkvZnMuaCBhbmQgbW9zdCBvZiBsYXBpIGhlYWRlcnMgaXQncyBvayB0byB1c2UgdGhlbSBiZWZv
cmUKdHN0X3Rlc3QuaCAoc29tZSBvZiB0aGVtIGFyZSBzdGlsbCB1c2VkIGZvciB0aGUgb2xkIEFQ
SSkuIEJ1dAppbmNsdWRlL2xhcGkvZ2V0cmFuZG9tLmggd2lsbCBicmVhayB0aGlzIGFzc3VtcHRp
b24gYW5kIGl0IGNhbiBjYXVzZSB0aGUKdHJvdWJsZXMgaWYgaW5jbHVkZS9sYXBpL2dldHJhbmRv
bS5oIG5lZWRzIGluY2x1ZGUvbGFwaS9mY250bC5oIG9yIDxmY250bC5oPikuCgpBbHNvIG15IG5v
dC15ZXQtZmluaXNoZWQgZWZmb3J0IHdpdGggc2FmZV9mYWxsb2NhdGUoKSBbMV0gaGFkIHRoaXMg
cHJvYmxlbQoocmVxdWlyZXMgPGZjbnRsLmg+KSwgYnV0IEknbGwgc29sdmUgdGhpcyB3aXRoIHBy
b3ZpZGluZyBmYWxsb2NhdGUoKSBkZWNsYXJhdGlvbgphcyB5b3Ugc3VnZ2VzdGVkLgoKPiB0aGF0
IGhlYWRlciB0byB3b3JrIHdpdGhvdXQgcHJlLWV4aXN0aW5nIGRlZmluZXMuCgoKPiA+ICBpbmNs
dWRlL2xhcGkvZnMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNSArKysrLQo+ID4gIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rL3VubGluazA5LmMgfCAyICsrCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9sYXBpL2ZzLmggYi9pbmNsdWRlL2xhcGkvZnMuaAo+ID4gaW5kZXggYzE5
ZWU4MjFkLi40NjgwZjAwOTAgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xhcGkvZnMuaAo+ID4g
KysrIGIvaW5jbHVkZS9sYXBpL2ZzLmgKPiA+IEBAIC05LDE1ICs5LDE4IEBACj4gPiAgI2lmbmRl
ZiBMQVBJX0ZTX0hfXwo+ID4gICNkZWZpbmUgTEFQSV9GU19IX18KCj4gPiArI2RlZmluZSBfR05V
X1NPVVJDRSAvKiBsb2ZmX3QgaW4gPGZjbnRsLmg+ICovCgo+IEknZCBhbHNvIGFkZCB0byBjb21t
ZW50IGhlcmUgdGhhdCBpdCdzIGluY2x1ZGVkIHZpYSBsYXBpL2ZjbnRsLmgKCisxCgpLaW5kIHJl
Z2FyZHMsClBldHIKClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNDA0MTIxMTQ2
MTYuR0I0Mjc3NDZAcGV2aWsvCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
