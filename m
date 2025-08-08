Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D67C87FCB
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 16:45:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1497C3CAC8D
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 18:45:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFA3A3CA312
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 18:45:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 087D11400060
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 18:45:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 235C233977;
 Fri,  8 Aug 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110C513A7E;
 Fri,  8 Aug 2025 16:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6qpEA7MplmjfWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 16:45:39 +0000
Date: Fri, 8 Aug 2025 18:45:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <20250808164537.GB485362@pevik>
References: <20250731065708.638005-1-florian.schmaus@codasip.com>
 <20250808140435.GB470368@pevik>
 <614059f8-983e-4f29-a730-3e0ceb541b9f@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <614059f8-983e-4f29-a730-3e0ceb541b9f@codasip.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 235C233977
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Check if signal 34 is available for
 musl compat
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

SGkgRmxvcmlhbiwKCj4gT24gMDgvMDgvMjAyNSAxNi4wNCwgUGV0ciBWb3JlbCB3cm90ZToKPiA+
IEhpIEZsb3JpYW4sCgo+IEhpIFBldHIsCgo+IHRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgp5dywg
dGhhbmtzIGZvciB5b3VyIHdvcmsgb24gTFRQIGZvciBtdXNsLgoKPiA+ID4gRG8gbm90IHNlbGVj
dCBzaWduYWwgMzQgd2hlbiB0aGUgdGVzdCBpcyBydW4gdXNpbmcgbXVzbC4gU2lnbmFsIDM0IGlz
Cj4gPiA+IHVzZWQgaW50ZXJuYWxseSBieSBtdXNsIGFzIFNJR1NZTkNDQUxMLiBDb25zZXF1ZW50
bHksIG11c2wncyBzaWduYWwoKQo+ID4gPiB3aWxsIHJldHVybiB3aXRoIGFuIGVycm9yIHN0YXR1
cyBhbmQgZXJybm8gc2V0IHRvIEVJTlZBTCB3aGVuIHRyeWluZwo+ID4gPiB0byBzZXR1cCBhIHNp
Z25hbCBoYW5kbGVyIGZvciBzaWduYWwgMzQsIGNhdXNpbmcgdGhlIHNpZ3JlbHNlMDEgdGVzdAo+
ID4gPiB0byBmYWlsLgoKPiA+ID4gU2luY2UgbXVzbCBwcm92aWRlcyBubyBwcmVwcm9jZXNzb3Ig
bWFjcm8sIHdlIGNoZWNrIGZvciB0aGUKPiA+ID4gYXZhaWxhYmlsaXR5IG9mIHNpZ25hbCAzNCBi
eSBhdHRlbXB0aW5nIHRvIHNldHVwIGEgc2lnbmFsIGhhbmRsZXIuIElmCj4gPiA+IHNpZ25hbCgp
IHJldHVybnMgU0lHX0VSUiB3aXRoIGVycm5vIHNldCB0byBFSU5WQUwgdGhlbiB3ZSBhc3N1bWUg
dGhlCj4gPiA+IHNpZ25hbCBpcyB1bmF2YWlsYWJsZS4gS25vd2luZyBzaWduYWwgMzQgaXMgYXZh
aWxhYmxlIHdpdGggZ2xpYmMsIHdlCj4gPiA+IHBlcmZvcm0gdGhpcyBjaGVjayBvbmx5IGlmIF9f
R0xJQkNfXyBpcyBub3QgZGVmaW5lZC4KCj4gPiAuLi4KPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zaWdyZWxzZS9zaWdyZWxzZTAxLmMKCj4gPiA+ICsjZGVmaW5lIF9HTlVf
U09VUkNFCgo+ID4gVW5mb3J0dW5hdGVseSArI2RlZmluZSBfR05VX1NPVVJDRSBjYXVzZXMgdGVz
dCB0byBoYW5nLCBhdCBsZWFzdCBvbiBnbGliYy4KCj4gSSBkb24ndCB0aGluayBpdCBoYW5ncywg
YnV0IHRha2VzIGFnZXMgdG8gY29tcGxldGUuIEF0IGxlYXN0LCB0aGF0IGlzIHdoYXQgSQo+IGZv
dW5kLgoKWWVhaCwgeW91J3JlIG1vcmUgcHJlY2lzZSA6KS4gTmV2ZXJ0aGVsZXNzIHRoZSByZXN1
bHQgZm9yIHRoZSBwYXRjaHNldCByZW1haW5zCj0+IE5BQ0sgd2hlbiBydW50aW1lIGRyYXN0aWNh
bGx5IGNoYW5nZXMgbGlrZSB0aGlzIDooLgoKCj4gPiBBbmQgSSBzZWUgZm9yIG11c2wgaXQgaXMg
bmVjZXNzYXJ5IHRvIGdldCBzaWdoYW5kbGVyX3QuCj4gPiBVbnRpbCB5b3UgZml4IGdsaWJjIHdp
dGggX0dOVV9TT1VSQ0UgTkFDSy4KCj4gSSB0aGluayBJIGNhbiBnZXQgcmlkIG9mIHRoZSBfR05V
X1NPVVJDRS4gSUlSQyBpdCB3YXMganVzdCBuZWVkZWQgdG8gdXNlIHRoZQo+IHNpZ2hhbmRsZXJf
dCB0eXBlLiBXaXRob3V0IF9HTlVfU09VUkNFLCBkZWNsYXJpbmcgdGhlIHJldHVybiB2YWx1ZSBv
Zgo+IHNpZ25hbCgpIGFzIHZvaWQqIHNob3VsZCBhbHNvIHdvcmsuCgpJIHN1c3BlY3QgdGhlcmUg
aXMgc29tZXRoaW5nIGVsc2UgZ29pbmcgd3JvbmcgKHRlc3Qgc2hvdWxkIG5vdCBzdGFydCBtYWdp
Y2FsbHkKdXNpbmcgc2lnaG9sZCgpIG9uIGdsaWJjKSwgYnV0IGxldCdzIHRyeSBhIHdvcmthcm91
bmQuCgoKPiA+IEJ1dCBvbiBnbGliYyBpdCBhbHNvIGJyb3VnaHQgYSB3YXJuaW5nLCB3aGljaCBt
ZWFucyBfR05VX1NPVVJDRSByZWFsbHkgc3dpdGNoZXMKPiA+IHNvbWV0aGluZyBvbjoKCj4gPiBz
aWdyZWxzZTAxLmM6IEluIGZ1bmN0aW9uIOKAmGNoaWxk4oCZOgo+ID4gc2lncmVsc2UwMS5jOjM5
NzozMzogd2FybmluZzog4oCYc2lnaG9sZOKAmSBpcyBkZXByZWNhdGVkOiBVc2UgdGhlIHNpZ3By
b2NtYXNrIGZ1bmN0aW9uIGluc3RlYWQgWy1XZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCj4gPiAg
ICAzOTcgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgocnYgPSBzaWdob2xk
KHNpZykpICE9IDApIHsKPiA+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn4KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvc3lzL3dhaXQuaDoz
NiwKPiA+ICAgICAgICAgICAgICAgICAgIGZyb20gc2lncmVsc2UwMS5jOjEwNDoKPiA+IC91c3Iv
aW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhlcmUKPiA+ICAgIDM1NSB8
IGV4dGVybiBpbnQgc2lnaG9sZCAoaW50IF9fc2lnKSBfX1RIUk9XCj4gPiAgICAgICAgfCAgICAg
ICAgICAgIF5+fn5+fn4KPiA+IHNpZ3JlbHNlMDEuYzo0NzI6MjU6IHdhcm5pbmc6IOKAmHNpZ3Jl
bHNl4oCZIGlzIGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVh
ZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10KPiA+ICAgIDQ3MiB8ICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmICgocnYgPSBzaWdyZWxzZShzaWcpKSAhPSAwKSB7Cj4gPiAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICBefgo+ID4gL3Vzci9pbmNsdWRlL3NpZ25hbC5oOjM1OTox
Mjogbm90ZTogZGVjbGFyZWQgaGVyZQo+ID4gICAgMzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAo
aW50IF9fc2lnKSBfX1RIUk9XCj4gPiAgICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+Cj4gPiBz
aWdyZWxzZTAxLmM6IEluIGZ1bmN0aW9uIOKAmHRpbWVvdXTigJk6Cj4gPiBzaWdyZWxzZTAxLmM6
Njc1OjI1OiB3YXJuaW5nOiB1bnVzZWQgcGFyYW1ldGVyIOKAmHNpZ+KAmSBbLVd1bnVzZWQtcGFy
YW1ldGVyXQo+ID4gICAgNjc1IHwgc3RhdGljIHZvaWQgdGltZW91dChpbnQgc2lnKQo+ID4gICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICB+fn5+Xn5+Cgo+ID4gQWxzbyB0aGlzIGlzIGEgdmVy
eSBvbGQgdGVzdCwgd2hpY2ggbmVlZHMgY2xlYW51cCBhbmQgcmV3cml0ZSB0byBuZXcgTFRQIEFQ
SQo+ID4gKGUuZy4gcmVtb3ZlIG9sZCB1bml4ZXMsIGUuZy4gVkFYIGFuZCBnZXQgdGVzdCBtb3Jl
IHJlbGlhYmxlKS4gSSBzdXBwb3NlCj4gPiBoYW5kbGluZyBzaWduYWxzIHdpdGggTFRQIGxlZ2Fj
eSBBUEkgaXMgYnJva2VuLgoKPiA+ID4gKwo+ID4gPiAgICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4K
PiA+ID4gICAjaW5jbHVkZSA8c3lzL3dhaXQuaD4KPiA+ID4gICAjaW5jbHVkZSA8ZXJybm8uaD4K
PiA+ID4gICAjaW5jbHVkZSA8ZmNudGwuaD4KPiA+ID4gICAjaW5jbHVkZSA8c2lnbmFsLmg+Cj4g
PiA+ICsjaW5jbHVkZSA8c3RkYm9vbC5oPgoKPiA+IG5pdDogSSB3b3VsZCBwb3N0cG9uZSB0aGlz
IGFmdGVyIGNvbnZlcnNpb24gdGhpcyB0byBuZXcgTFRQIEFQSS4KPiA+IFNjcmlwdCBhbHJlYWR5
IHVzZXMgbGVnYWN5IGRlZmluaXRpb25zCj4gPiAjZGVmaW5lIFRSVUUgMQo+ID4gI2RlZmluZSBG
QUxTRSAwCj4gPiBhbmQgb24gYSBkaWZmZXJlbnQgcGxhY2UgaGFwcGlseSByZXR1cm5zIDAgb3Ig
MS4KPiA+IE1peGluZyB0aGF0IHdpdGggPHN0ZGJvb2wuaD4gbWFrZXMgZXZlbiBtb3JlIG1lc3Mu
Cgo+IEFncmVlZC4KCj4gSSBhbSBnb2luZyBzZW5kIGEgdjIgdGhhdCBkb2VzIG5vdCB1c2UgX0dO
VV9TT1VSQ0Ugbm9yIHN0ZGJvb2wuaCBhZnRlcgo+IGNoZWNraW5nIHRoYXQgaXQgc3RpbGwgZml4
ZXMgbXVzbCBjb21wYXQgZm9yIHVzIHdoaWxlIG5vdCBpbnRyb2R1Y2luZyBhCj4gcmVncmVzc2lv
biBvbiBnbGliYy4KCisxLCBwbGVhc2UgZG9jdW1lbnQgdGhlIHJlYXNvbiBmb3IgYSB3b3JrYXJv
dW5kLgoKSWYgeW91IGhhZCBtb3JlIHRpbWUsIHRoZSBiZXN0IHdvdWxkIGJlIHRvIHJld3JpdGUg
dGhlIHRlc3QgdG8gdGhlIG5ldyBMVFAgQVBJLgpJIGJldCB0aGUgcHJvYmxlbSB3aXRoIF9HTlVf
U09VUkNFIHdvdWxkIGdvIGF3YXkuIEkgZG9uJ3QgZXhwZWN0IHlvdSBoYXZlIG1vcmUKdGltZSwg
YnV0IGlmIHlvdSBkbywgaGVyZSBhcmUgbGlua3M6CgpodHRwczovL2dpdGh1Yi5jb20vbGludXgt
dGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci9kb2Mvb2xkL0MtVGVzdC1BUEkuYXNjaWlkb2MK
aHR0cHM6Ly9saW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2RldmVs
b3BlcnMvYXBpX2NfdGVzdHMuaHRtbApodHRwczovL2xpbnV4LXRlc3QtcHJvamVjdC5yZWFkdGhl
ZG9jcy5pby9lbi9sYXRlc3QvZGV2ZWxvcGVycy90ZXN0X2Nhc2VfdHV0b3JpYWwuaHRtbAoKKFdl
IGFyZSBpbiB0aGUgbWlkZGxlIG9mIGEgZG9jIHRyYW5zaXRpb24gaW50byByZWFkdGhlZG9jcywg
SU1ITyB0aGUgb2xkIGRvYyBpcwpzdGlsbCB0aGUgYmVzdCB3aGF0IHdlIGhhdmUuKQoKQWxzbywg
MyB0ZXN0cyBldmVuIGRvbid0IGNvbXBpbGUgb24gbXVzbCwgaGVyZSBpcyB0aGUgY3VycmVudCBs
aXN0OgpodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rl
ci9jaS9hbHBpbmUuc2gjTDMyCgpIZWxwaW5nIHRvIGZpeCB0aGVtIGlzIG1vcmUgdGhhbiB3ZWxj
b21lLgoKS2luZCByZWdhcmRzLApQZXRyCgoKPiAtIEZsb3JpYW4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
