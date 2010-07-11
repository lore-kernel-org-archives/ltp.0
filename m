Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXxPK-0000Oi-QN
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:21:26 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXxPJ-00014Y-Ta
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:21:26 +0000
Received: by vws3 with SMTP id 3so4657392vws.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 07:21:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1278855268.8660.44.camel@sumit>
References: <1278855268.8660.44.camel@sumit>
From: Sumit Dhoot <sumitbd@linsyssoft.com>
Date: Sun, 11 Jul 2010 19:50:58 +0530
Message-ID: <AANLkTikfCl19jt_BQyJWXGvF-nrjaWW4Wk7QGAPb5zYq@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/3] nfs02: testcases/network/nfs/nfs02/nfs02
	script - bug fixing
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
To: ltp-list@lists.sourceforge.net

SGkgQWxsLAoKSSBmYWlsZWQgdG8gYWRkICJTaWduZWQtb2ZmLWJ5Ii4gQXBvbG9naWVzIGZvciB0
aGlzLgoKT24gU3VuLCBKdWwgMTEsIDIwMTAgYXQgNzowNCBQTSwgIDxzdW1pdGJkQGxpbnN5c3Nv
ZnQuY29tPiB3cm90ZToKPgo+IEhpLAo+Cj4gVGVzdGNhc2UgIm5mczAyIiBmYWlscyB3aXRoIGZv
bGxvd2luZyBtZXNzYWdlCj4gIlRlc3QgRmFpbGVkOiBSZW1vdmFsIG9mIHdyaXRlIHBlcm1pc3Np
b25zIG5vdCBob25vcmVkIG9uIGFzY2lpLnNtIgo+IFRoaXMgaXMgYmVjYXVzZSBhc2NpaS5zbSBo
YXMgYSByd3ggZmlsZSBwZXJtaXNzaW9uIGZvciBvdGhlcnMgd2hlbiBJdAo+IGdvdCBpbnN0YWxs
ZWQuIFRoZSBzY3JpcHQgZmlyc3QgdHJpZWQgdG8gcmVtb3ZlIG9ubHkgd3JpdGUgcGVybWlzc2lv
bgo+IGZvciBvdGhlcnMgYW5kIHRoZW4gaXQgdGVzdHMgaXQgd2l0aCB0aGUgci0tIHBlcm1pc3Np
b24gc28gdGVzdCBnZXQKPiBmYWlscyBhcyBpdCBoYXMgci14IHBlcm1pc3Npb24gZm9yIG90aGVy
cy4KPgo+IFRoaXMgaXMgZml4ZWQgd2l0aCBmb2xsb3dpbmcgcGF0Y2guCj4KU2lnbmVkLW9mZi1i
eTogIFN1bWl0IERob290IDxzdW1pdGJkQGxpbnN5c3NvZnQuY29tPgoKPT09PT09Cgo+IEluZGV4
OiBsdHAtZnVsbC0yMDEwMDYzMC90ZXN0Y2FzZXMvbmV0d29yay9uZnMvbmZzMDIvbmZzMDIKPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Cj4gLS0tIGx0cC1mdWxsLTIwMTAwNjMwLm9yaWcvdGVzdGNhc2VzL25ldHdvcmsv
bmZzL25mczAyL25mczAyCj4gKysrIGx0cC1mdWxsLTIwMTAwNjMwL3Rlc3RjYXNlcy9uZXR3b3Jr
L25mcy9uZnMwMi9uZnMwMgo+IEBAIC0xNzksNyArMTc5LDcgQEAgZG9fdGVzdDMoKQo+IMKgewo+
IMKgJHRyYWNlX2xvZ2ljCj4gwqAgwqBlY2hvICJkb190ZXN0MyAkVEMgIgo+IC0gwqAgY2htb2Qg
YS13ICRUQ3RtcC9hc2NpaS5zbSAmCj4gKyDCoCBjaG1vZCBhLXd4ICRUQ3RtcC9hc2NpaS5zbSAm
Cj4gwqAgwqB3YWl0ICQhCj4gwqAgwqBscyAtbCAkVEN0bXAvYXNjaWkuc20gfCBncmVwICJyLS0i
Cj4gwqAgwqBbICQ/IC1lcSAwIF0gfHwgZW5kX3Rlc3RjYXNlICJSZW1vdmFsIG9mIHdyaXRlIHBl
cm1pc3Npb25zIG5vdAo+IGhvbm9yZWQgb24gYXNjaWkuc20iCj4KPgo9PT09PT0KCj4gVGhhbmtz
ICYgUmVnYXJkcwo+IFN1bWl0IERob290Cj4gU3lzdGVtIEFkbWluaXN0cmF0b3IKPiBMaW5zeXNz
b2Z0IFRlY2hub2xvZ2llcyBQdnQuIEx0ZC4KPiBzdW1pdGJkQGxpbnN5c3NvZnQuY29tCj4KPgo+
CgoKCi0tIApUaGFua3MgJiBSZWdhcmRzClN1bWl0IERob290CgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IFNwcmludApXaGF0IHdpbGwgeW91
IGRvIGZpcnN0IHdpdGggRVZPLCB0aGUgZmlyc3QgNEcgcGhvbmU/ClZpc2l0IHNwcmludC5jb20v
Zmlyc3QgLS0gaHR0cDovL3Auc2YubmV0L3NmdS9zcHJpbnQtY29tLWZpcnN0Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlz
dApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
