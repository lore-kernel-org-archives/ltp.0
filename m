Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RiHaq-0004vI-V7
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 03:32:48 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiHap-0004zO-Fy
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 03:32:48 +0000
Message-ID: <4F03C84B.80906@windriver.com>
Date: Wed, 4 Jan 2012 11:32:27 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <4EFAF5BB.2030407@windriver.com> <4F03AD5E.4000003@jp.fujitsu.com>
	<4F03B406.8050808@cn.fujitsu.com> <4F03BE7E.7060408@jp.fujitsu.com>
	<4F03C02A.8090304@cn.fujitsu.com>
In-Reply-To: <4F03C02A.8090304@cn.fujitsu.com>
Subject: Re: [LTP] Posix test case mmap/31-1 fails on Linux/eglibc
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
To: gaowanlong@cn.fujitsu.com, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

T24gMjAxMuW5tDAx5pyIMDTml6UgMTA6NTcsIFdhbmxvbmcgR2FvIHdyb3RlOgo+IE9uIDAxLzA0
LzIwMTIgMTA6NTAgQU0sIFlhc3Vha2kgSXNoaW1hdHN1IHdyb3RlOgo+Cj4+IEhpIEdhbywKPj4K
Pj4gMjAxMi8wMS8wNCAxMTowNSwgV2FubG9uZyBHYW8gd3JvdGU6Cj4+PiBPbiAwMS8wNC8yMDEy
IDA5OjM3IEFNLCBZYXN1YWtpIElzaGltYXRzdSB3cm90ZToKPj4+Cj4+Pj4gSGkgS2FpLAo+Pj4+
Cj4+Pj4gMjAxMS8xMi8yOCAxOTo1NSwgS2FuZyBLYWkgd3JvdGU6Cj4+Pj4+IEhpIGFsbCwKPj4+
Pj4KPj4+Pj4gSSBydW4gbW1hcC8zMS0xIGZhaWxlZCB3aXRoIEVOT01FTSBvbiBsaW51eCwgd2l0
aCBlcnJvciBtZXNzYWdlOgo+Pj4+PiBvZmY6IGZmZmZmZmZmZmZmZmYwMDAsIGxlbjogZmZmZmZm
ZmZmZmZmZjAwMAo+Pj4+PiBUZXN0IEZBSUw6IGV4cGVjdCBFT1ZFUkZMT1cgYnV0IGdldCBvdGhl
ciBlcnJvcjogQ2Fubm90IGFsbG9jYXRlIG1lbW9yeQo+Pj4+Pgo+Pj4+PiBCdXQgY29tcGFyZSB0
byBtbWFwLzI0LTIsIGl0IG1tYXAoKSB0aGUgc2FtZSBsZW5ndGggYnV0IHBhc3MuIEl0cyBvdXRw
dXQ6Cj4+Pj4+IGF2YWlsYWJsZSBtZW1vcnk6IDE4NDQ2NzQ0MDczNzA5NTUxNjE1Cj4+Pj4+IGFk
ZHI6IDdmNzhjNTRmYTAwMCwgbGVuOiBmZmZmZmZmZmZmZmZmZmZmCj4+Pj4+IGFkZHI6IDdmNzhj
NTRmYTAwMCwgbGVuOiBmZmZmZmZmZmZmZmZmMDAwCj4+Pj4+IFRlc3QgUGFzczogbW1hcC8yNC0y
LmMgR2V0IEVOT01FTTogQ2Fubm90IGFsbG9jYXRlIG1lbW9yeQo+Pj4+Pgo+Pj4+PiBTbyBJIHN1
cHBvc2UgdGhhdCBtbWFwLzMxLTEgbWF5IG5lZWQgdXBkYXRlLCBidXQgSSBkb24ndCBrbm93IGhv
dyB0bwo+Pj4+PiBtYWtlIG1tYXAoKSBvdmVyZmxvdyBhcyBleHBlY3QuCj4+Pj4+IEFueSBzdWdn
ZXN0aW9uIGlzIGFwcHJlY2lhdGVkLgo+Pj4+IEkgZG9uJ3QgdGhpbmsgbW1hcC8zMS0xIG5lZWQg
dXBkYXRlIHNpbmNlIGl0IGlzIExpbnV4IEtlcm5lbCdzIHByb2JsZW0sCj4+Pj4gbm90IHRoZSB0
ZXN0J3MgcHJvYmxlbS4gVGhlIHByb2JsZW0gaXMgYmVpbmcgZGlzY3Vzc2VkIG9uIExLTUwuCj4+
Pj4KPj4+PiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxMS8xMi8yMi84NQo+Pj4KPj4+IEJ1dCBp
dCBzZWVtcyB0aGF0IHRoZSBwYXRjaCB3YXMgbm90IGFjY2VwdGFibGUuCj4+IEFzIHlvdSBzYXks
IGl0IGhhcyBub3QgYmVlbiBhY2NlcHRlZCB5ZXQuCj4+IEJ1dCBJIHRoaW5rIExpbnV4IHdpbGwg
YmUgZml4ZWQgdG8gcmV0dXJuIEVPVkVSRkxPVyBpbiBtbWFwLzMxLTEncyB0ZXN0Cj4+IGluIHRo
ZSBuZWFyIGZ1dHVyZS4KPgo+IFllYWgsIGFncmVlLCBzbyB3ZSBuZWVkIG5vdCB1cGRhdGUgdGhp
cyB0ZXN0IGNhc2Ugbm93IGFuZCB3YWl0IGZvciBhIHdoaWxlCj4gdG8gbGV0IHRoZSBrZXJuZWwg
YnVnIHRvIGJlIGZpeGVkLgoKT0ssIHRoYW5rIHlvdSB2ZXJ5IG11Y2ghCgo+Cj4+IFJlZ2FyZHMs
Cj4+IFlhc3Vha2kgSXNoaW1hdHN1Cj4+Cj4+PiBUaGFua3MKPj4+IC1XYW5sb25nIEdhbwo+Pj4K
Pj4+PiBSZWdhcmRzLAo+Pj4+IFlhc3Vha2kgSXNoaW1hdHN1Cj4+Pj4KPj4+Pj4gUmVnYXJkcywK
Pj4+Pj4gS2FpCj4+Pgo+Pj4KPj4+Cj4+Cj4KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUmlkaWN1
bG91c2x5IGVhc3kgVkRJLiBXaXRoIENpdHJpeCBWREktaW4tYS1Cb3gsIHlvdSBkb24ndCBuZWVk
IGEgY29tcGxleAppbmZyYXN0cnVjdHVyZSBvciB2YXN0IElUIHJlc291cmNlcyB0byBkZWxpdmVy
IHNlYW1sZXNzLCBzZWN1cmUgYWNjZXNzIHRvCnZpcnR1YWwgZGVza3RvcHMuIFdpdGggdGhpcyBh
bGwtaW4tb25lIHNvbHV0aW9uLCBlYXNpbHkgZGVwbG95IHZpcnR1YWwgCmRlc2t0b3BzIGZvciBs
ZXNzIHRoYW4gdGhlIGNvc3Qgb2YgUENzIGFuZCBzYXZlIDYwJSBvbiBWREkgaW5mcmFzdHJ1Y3R1
cmUgCmNvc3RzLiBUcnkgaXQgZnJlZSEgaHR0cDovL3Auc2YubmV0L3NmdS9DaXRyaXgtVkRJaW5h
Ym94Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1s
aXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
