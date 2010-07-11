Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXxNI-0002hv-GG
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:19:20 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXxNH-0005iS-Md
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:19:20 +0000
Received: by qwg8 with SMTP id 8so54801qwg.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 07:19:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1278854732.8660.34.camel@sumit>
References: <1278854732.8660.34.camel@sumit>
From: Sumit Dhoot <sumitbd@linsyssoft.com>
Date: Sun, 11 Jul 2010 19:48:54 +0530
Message-ID: <AANLkTikm0i8xOwFa040XXamt3MXBSwkhFLBOrMGpwK9o@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/3] MAKEFILE: testcases/network/Makefile - bug
	fixing
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
aGlzLgoKT24gU3VuLCBKdWwgMTEsIDIwMTAgYXQgNjo1NSBQTSwgIDxzdW1pdGJkQGxpbnN5c3Nv
ZnQuY29tPiB3cm90ZToKPiBIaSwKPgo+IFRlc3RjYXNlICJuZnMwMiIgZmFpbHMgYXMgc2NyaXB0
IGRvZXMgbm90IGFibGUgdG8gZmluZCDCoGZvbGxvd2luZyBmaWxlcwo+IGFzY2lpLmptYgo+IGFz
Y2lpLmxnCj4gYXNjaWkubWVkCj4gYXNjaWkuc20KPiBUaGlzIGlzIGJlY2F1c2UgbHRwJ3MgdGVz
dGNhc2VzL25ldHdvcmsvTWFrZWZpbGUgZG9lc24ndCBpbnN0YWxsZWQKPiB0aG9zZS4gSXQgaXMg
Zml4ZWQgd2l0aCBmb2xsb3dpbmcgcGF0Y2guCj4KClNpZ25lZC1vZmYtYnk6ICBTdW1pdCBEaG9v
dCA8c3VtaXRiZEBsaW5zeXNzb2Z0LmNvbT4KCj09PT09PT09PT09PT09PT0KPiBJbmRleDogbHRw
LWZ1bGwtMjAxMDA2MzAvdGVzdGNhc2VzL25ldHdvcmsvTWFrZWZpbGUKPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4g
LS0tIGx0cC1mdWxsLTIwMTAwNjMwLm9yaWcvdGVzdGNhc2VzL25ldHdvcmsvTWFrZWZpbGUKPiAr
KysgbHRwLWZ1bGwtMjAxMDA2MzAvdGVzdGNhc2VzL25ldHdvcmsvTWFrZWZpbGUKPiBAQCAtMzEs
NiArMzEsNyBAQCBDTEVBTl9UQVJHRVRTIMKgIMKgIMKgIMKgICs9ICQoRElSKQo+IMKgSU5TVEFM
TF9ESVIgwqAgwqAgwqAgwqAgwqAgwqA6PSB0ZXN0Y2FzZXMvYmluCj4KPiDCoElOU1RBTExfVEFS
R0VUUyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDo9ICQoYWRkcHJlZml4ICQoRElSKS9iaW4uLHNt
IG1lZCBsZyBqbWIpCj4gK0lOU1RBTExfVEFSR0VUUyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCs9
ICQoYWRkcHJlZml4ICQoRElSKS9hc2NpaS4sc20gbWVkIGxnIGptYikKPgo+IMKgUk0gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKz0gLXIKCj09PT09PT09PT09PT09PT0KPgo+Cj4gVGhh
bmtzICYgUmVnYXJkcwo+IFN1bWl0IERob290Cj4gU3lzdGVtIEFkbWluaXN0cmF0b3IKPiBMaW5z
eXNzb2Z0IFRlY2hub2xvZ2llcyBQdnQuIEx0ZC4KPiBzdW1pdGJkQGxpbnN5c3NvZnQuY29tCj4K
Pgo+Cj4KCi0tIApUaGFua3MgJiBSZWdhcmRzClN1bWl0IERob290CgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IFNwcmludApXaGF0IHdpbGwg
eW91IGRvIGZpcnN0IHdpdGggRVZPLCB0aGUgZmlyc3QgNEcgcGhvbmU/ClZpc2l0IHNwcmludC5j
b20vZmlyc3QgLS0gaHR0cDovL3Auc2YubmV0L3NmdS9zcHJpbnQtY29tLWZpcnN0Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcg
bGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
