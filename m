Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1C0D61015
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 13:29:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084993CC154
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 14:29:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A0E63CC154
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 14:29:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EDCC114000E8
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 14:29:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 889035BCCB;
 Thu, 29 Jan 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 533FD3EA61;
 Thu, 29 Jan 2026 13:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mi5QE55ge2ngHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jan 2026 13:29:02 +0000
Date: Thu, 29 Jan 2026 14:28:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260129132856.GA104003@pevik>
References: <20260129100011.72437-1-liwang@redhat.com>
 <CAEemH2fppgf4iJE4h1n3XSMw9v-hMF11BZAYjz_-9dHgKv0iFg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fppgf4iJE4h1n3XSMw9v-hMF11BZAYjz_-9dHgKv0iFg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 889035BCCB
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2017-17052: tolerate ENOMEM during test
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpbIENjIG90aGVycyBhcyBpdCdzIGEgcHJlLXJlbGVhc2UgXQoKPiBPbiBUaHUsIEph
biAyOSwgMjAyNiBhdCA2OjAw4oCvUE0gTGkgV2FuZyB2aWEgbHRwIDxsdHBAbGlzdHMubGludXgu
aXQ+IHdyb3RlOgoKPiA+IEFzIGVhY2ggaXRlcmF0aW9uIG9mIG1tYXBfdGhyZWFkKCkgZ3JhYnMg
YSBmcmVzaCAxNuKAr01pQiBNQVBfUE9QVUxBVEUKPiA+IHJlZ2lvbiBhbmQgbmV2ZXIgcmVsZWFz
ZXMgaXQuIEFzIHRoZSBsb29wIHJ1bnMsIHRob3NlIHJlZ2lvbnMKPiA+IGFjY3VtdWxhdGUgY29u
c3VtaW5nIGJvdGggdmlydHVhbCBhZGRyZXNzIHNwYWNlIGFuZCBjb21taXR0ZWQgcGh5c2ljYWwK
PiA+IG1lbW9yeSByaWdodCBhd2F5IGluc3RlYWQgb2YgbGF6aWx5LgoKPiA+IEVhc2lseSBtbWFw
KCkgZmFpbHMgd2l0aCBFTk9NRU0gb24gc21hbGxlci9saW1pdCBSQU0gcmVzb3VyY2Ugc3lzdGVt
LgoKPiA+IEVycm9yIExvZzoKCj4gPiAgIGN2ZS0yMDE3LTE3MDUyLmM6NDg6IFRCUk9LOiBtbWFw
KChuaWwpLDE2Nzc3MjE2LFBST1RfUkVBRCgxKSwzMjgwMiwtMSwwKSBmYWlsZWQ6IEVOT01FTSAo
MTIpCj4gPiAgIHRzdF90ZXN0LmM6NDc5OiBUSU5GTzogQ2hpbGQgcHJvY2VzcyByZXBvcnRlZCBU
QlJPSyBraWxsaW5nIHRoZSB0ZXN0Cj4gPiAgIHRzdF90ZXN0LmM6MTkwOTogVElORk86IEtpbGxl
ZCB0aGUgbGVmdG92ZXIgZGVzY2VuZGFudCBwcm9jZXNzZXMKCj4gPiBDb25zaWRlciB0aGVyZSBp
cyBubyBwcmFjdGljYWwgdXBwZXIgYm91bmQgb24gdGhpcyBhbGxvY2F0aW9uIHBhdHRlcm4sCj4g
PiBzbyBzZXR0aW5nIC50ZXN0Lm1pbl9tZW1fYXZhaWwgbWF5IG5vdCBoZWxwcy4gSGVyZSB3ZSBq
dXN0IHRvbGVyYXRlCj4gPiBFTk9NRU0gZHVyaW5nIHRoZSBtbWFwX3RocmVhZCgpIGxvb3Bpbmcu
Cgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0K
PiA+ICB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE3LTE3MDUyLmMgfCA5ICsrKysrKysrLQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCj4gPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1Mi5jIGIvdGVzdGNhc2VzL2N2ZS9jdmUt
MjAxNy0xNzA1Mi5jCj4gPiBpbmRleCA3MDBlYjc4MmUuLjYxMDMyYzE5NyAxMDA2NDQKPiA+IC0t
LSBhL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTctMTcwNTIuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2N2
ZS9jdmUtMjAxNy0xNzA1Mi5jCj4gPiBAQCAtNDQsOSArNDQsMTYgQEAgc3RhdGljIHZvaWQgY2xl
YW51cCh2b2lkKQoKPiA+ICBzdGF0aWMgdm9pZCAqbW1hcF90aHJlYWQodm9pZCAqYXJnKQo+ID4g
IHsKPiA+ICsgICAgICAgdm9pZCAqcHRyOwo+ID4gKwo+ID4gICAgICAgICBmb3IgKDs7KSB7Cj4g
PiAtICAgICAgICAgICAgICAgU0FGRV9NTUFQKE5VTEwsIDB4MTAwMDAwMCwgUFJPVF9SRUFELAo+
ID4gKyAgICAgICAgICAgICAgIHB0ciA9IG1tYXAoTlVMTCwgMHgxMDAwMDAwLCBQUk9UX1JFQUQs
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BUF9QT1BVTEFURXxNQVBfQU5P
TllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7Cj4gPiArCj4gPiArICAgICAgICAgICAgICAgaWYg
KChwdHIgPT0gTUFQX0ZBSUxFRCkgJiYgKGVycm5vID09IEVOT01FTSkpIHsKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHVzbGVlcCgxMDAwKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOwo+ID4gKyAgICAgICAgICAgICAgIH0KCj4gT29wcywgSSBmb3Jnb3QgdG8gaGFu
ZGxlIHRoZSBvdGhlciBmYWlsdXJlcywgc28gdGhlIHBhdGNoIHNob3VsZCBiZToKCj4gLS0tIGEv
dGVzdGNhc2VzL2N2ZS9jdmUtMjAxNy0xNzA1Mi5jCj4gKysrIGIvdGVzdGNhc2VzL2N2ZS9jdmUt
MjAxNy0xNzA1Mi5jCj4gQEAgLTQ0LDkgKzQ0LDE5IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9p
ZCkKCj4gIHN0YXRpYyB2b2lkICptbWFwX3RocmVhZCh2b2lkICphcmcpCj4gIHsKPiArICAgICAg
IHZvaWQgKnB0cjsKPiArCj4gICAgICAgICBmb3IgKDs7KSB7Cj4gLSAgICAgICAgICAgICAgIFNB
RkVfTU1BUChOVUxMLCAweDEwMDAwMDAsIFBST1RfUkVBRCwKPiArICAgICAgICAgICAgICAgcHRy
ID0gbW1hcChOVUxMLCAweDEwMDAwMDAsIFBST1RfUkVBRCwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIE1BUF9QT1BVTEFURXxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFLCAtMSwg
MCk7Cj4gKwo+ICsgICAgICAgICAgICAgICBpZiAocHRyID09IE1BUF9GQUlMRUQpIHsKPiArICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoZXJybm8gPT0gRU5PTUVNKSB7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1c2xlZXAoMTAwMCk7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsKPiArICAgICAgICAgICAgICAgICAgICAgICB9Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSyB8IFRURVJSTk8sICJVbmV4cGVjdGVkIG1t
YXAoKSBlcnJvciIpOwo+ICsgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cgo+ICAgICAgICAg
cmV0dXJuIGFyZzsKClBhdGNoZWQgdmVyc2lvbiBMR1RNLgpSZXZpZXdlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+CgpPdXQgb2YgY3VyaW9zaXR5IGhvdyBtdWNoIFJBTSBpcyBub3Qg
ZW5vdWdoIGZvciB0aGlzPyBJIHRyaWVkIDQwMCBNQiArIGVhdGluZwpvdGhlciBSQU0gYnV0IHdh
cyBub3QgYWJsZSB0byB0cmlnZ2VyLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
