Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UmnGs-0003Dx-33
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 15:47:38 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UmnGq-0003zN-Od
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 15:47:38 +0000
Date: Wed, 12 Jun 2013 11:47:29 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <602677798.1890199.1371052049559.JavaMail.root@redhat.com>
In-Reply-To: <CANXECd7uzb9Rc2H1LMDuBXcExC6RHbHhJ2rv-tEz9uOcDW+Vhw@mail.gmail.com>
References: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
	<880296419.1609038.1371019910126.JavaMail.root@redhat.com>
	<CANXECd7uzb9Rc2H1LMDuBXcExC6RHbHhJ2rv-tEz9uOcDW+Vhw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] Help compiling in AIX 6.1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Ismael =?utf-8?Q?Farf=C3=A1n?= <sulfurfff@gmail.com>
Cc: ltp-list@lists.sourceforge.net

CgoKLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+IEZyb206ICJJc21hZWwgRmFyZsOhbiIg
PHN1bGZ1cmZmZkBnbWFpbC5jb20+Cj4gVG86ICJKYW4gU3RhbmNlayIgPGpzdGFuY2VrQHJlZGhh
dC5jb20+Cj4gQ2M6IGx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IFNlbnQ6IFdlZG5l
c2RheSwgMTIgSnVuZSwgMjAxMyA0OjM0OjI0IFBNCj4gU3ViamVjdDogUmU6IFtMVFBdIEhlbHAg
Y29tcGlsaW5nIGluIEFJWCA2LjEKPiAKPiBUaGFua3MgZm9yIHRoZSBhbnN3ZXIuCj4gCj4gU2lu
Y2UgY29uZmlndXJlIGRpZG4ndCBmYWlsIEkgdGhvdWdodCBpdCBkaWRuJ3QgbWluZCBhIGZldyBt
aXNzaW5nCj4gaGVhZGVycy4gCgo8U05JUD4KClJpZ2h0LCBJIGFsc28gZG9uJ3Qgc2VlIGFueXRo
aW5nIHN1c3BpY2lvdXMuIFlvdXIgb3V0cHV0IHNob3dzCnRoYXQgaW5jbHVkZS5tayBpcyBjcmVh
dGVkLCBzbyB0aGUgb25seSBvdGhlciB0aGluZyB0aGF0IGNvbWVzIHRvIG1pbmQKaXMgdGhhdCAk
KGFic190b3BfYnVpbGRkaXIpIGlzIHdyb25nLgoKWW91IGNhbiB0cnkgbWFraW5nIGNoYW5nZSBh
Y2NvcmRpbmcgdG8gZGlmZiBiZWxvdyBhbmQgcmUtcnVubmluZyBnbWFrZS4KSWYgZXZlcnl0aGlu
ZyB3b3JrcyBPSywgdGhpcyBzaG91bGQgYmUgd2FybmluZyB3aXRoIHBhdGg6IC90bXAvbHRwLWZ1
bGwtMjAxMzAxMDkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL21rL2Vudl9wcmUubWsgYi9pbmNsdWRl
L21rL2Vudl9wcmUubWsKaW5kZXggZjE1ODRhOC4uMWQyODRlYSAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9tay9lbnZfcHJlLm1rCisrKyBiL2luY2x1ZGUvbWsvZW52X3ByZS5tawpAQCAtNzQsNiArNzQs
OCBAQCBlbHNlCiBhYnNfdG9wX2J1aWxkZGlyICAgICAgICAgICAgICAgOj0gJChhYnNwYXRoICQo
dG9wX2J1aWxkZGlyKSkKIGVuZGlmCgorJCh3YXJuaW5nIGFicyBkaXJzOiAkKGFic190b3Bfc3Jj
ZGlyKSAkKGFic190b3BfYnVpbGRkaXIpKQorCiAjIFdoZXJlJ3MgdGhlIHJvb3Qgb2JqZWN0IGRp
cmVjdG9yeT8KIGJ1aWxkZGlyICAgICAgICAgICAgICAgICAgICAgICA6PSAuCgpSZWdhcmRzLApK
YW4KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQg
YnkgV2luZG93czoKCkJ1aWxkIGZvciBXaW5kb3dzIFN0b3JlLgoKaHR0cDovL3Auc2YubmV0L3Nm
dS93aW5kb3dzLWRldjJkZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlz
dAo=
