Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Timothy.Bird@am.sony.com>) id 1MUPia-0005zh-HO
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 18:42:08 +0000
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=IE1EHSOBE003.bigfish.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.69) id 1MUPiW-0005Ma-Sb
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 18:42:08 +0000
Message-ID: <4A69FCD3.9070707@am.sony.com>
Date: Fri, 24 Jul 2009 11:26:27 -0700
From: Tim Bird <tim.bird@am.sony.com>
MIME-Version: 1.0
References: <f5a7b3810907240831t75a058a2m96abdc28a28c4365@mail.gmail.com>	
	<200907241349.58754.vapier@gentoo.org>
	<f5a7b3810907241104g498b00a6i60c8858b8805091a@mail.gmail.com>
In-Reply-To: <f5a7b3810907241104g498b00a6i60c8858b8805091a@mail.gmail.com>
Subject: Re: [LTP] Char Limit issue on 2.6.29 kernels
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

bmFyZXNoIGthbWJvanUgd3JvdGU6Cj4gSGkgTWlrZSwKPiAKPiBPbiBGcmksIEp1bCAyNCwgMjAw
OSBhdCAxMToxOSBQTSwgTWlrZSBGcnlzaW5nZXI8dmFwaWVyQGdlbnRvby5vcmc+IHdyb3RlOgo+
PiBPbiBGcmlkYXkgMjQgSnVseSAyMDA5IDExOjMxOjU5IG5hcmVzaCBrYW1ib2p1IHdyb3RlOgo+
Pj4gSSBoYXZlIGNvbWUgYWNyb3NzIHdpdGggY2hhciBMaW1pdCBpc3N1ZSBvbiAyLjYuMjkga2Vy
bmVscy4KPj4+Cj4+Pgo+Pj4gU0lHRkFVTFQ6Cj4+Pgo+Pj4gI2RlZmluZSBTSVpFIO+/vSDvv70g
77+9IO+/vSDvv70g77+9ODA1Mzc1OQo+Pj4gY2hhciBidWYxW1NJWkVdIDsKPj4+Cj4+PiBOTyBT
SUdGQVVMVDoKPj4+Cj4+PiAjZGVmaW5lIFNJWkUg77+9IO+/vSDvv70g77+9IO+/vSDvv704MDUz
NzU4Cj4+PiBjaGFyIGJ1ZjFbU0laRV0gOwo+Pj4KPj4+IFRoaXMgU0lHRkFVTFQgbm90IG9ic2Vy
dmVkIG9uIDIuNi4yMyBrZXJuZWxzLgo+PiAtRU5PSU5GTwo+Pgo+PiBwb3N0IHNvbWUgYWN0dWFs
IGNvZGUgcmF0aGVyIHRoYW4gc2F5aW5nICJpIGRlY2xhcmVkIGEgbGFyZ2UgYnVmZmVyIGFuZCB0
aGluZ3MKPj4gY3Jhc2hlZCIuCj4gCj4gY3VycmVudGx5IGkgYW0gZGVidWdnaW5nIHRoaXMgaXNz
dWUuCj4gaSdsbCBjb21lIHVwIHdpdGggbW9yZSBkZXRhaWxzLgoKU29tZSBtb3JlIGZlZWRiYWNr
Li4uCgpJdCdzIFNFR0ZBVUxUIC0gc2hvcnQgZm9yICJTZWdtZW50YXRpb24gRmF1bHQiLCBub3Qg
U0lHRkFVTFQuCgpQbGVhc2UgaW5jbHVkZSBpbiB5b3VyIGRldGFpbHMgYXQgbGVhc3QgdGhlIGZv
bGxvd2luZzoKICogd2hhdCBzb2Z0d2FyZSB0aGlzIGlzIGluIChpcyB0aGlzIGRlY2xhcmF0aW9u
IGluIHRoZSBrZXJuZWw/LCBhIGxpYnJhcnksIGEKIHVzZXIgc3BhY2UgcHJvZ3JhbSwgZXRjLikK
ICogd2hhdCBvcGVyYXRpb24gaXMgYmVpbmcgcGVyZm9ybWVkIHdoZW4gdGhlIFNFR0ZBVUxUIG9j
Y3Vycy4KICogd2hhdCBjb21waWxlciB5b3UgYXJlIHVzaW5nLgogKiB0aGUgY29kZSBzdXJyb3Vu
ZGluZyB0aGUgb3BlcmF0aW9uIHdoZW4gdGhlIGZhdWx0IG9jY3VycwoKSWYgeW91IGNhbiwgbWFr
ZSB0aGUgc21hbGxlc3QgcG9zc2libGUgcHJvZ3JhbSB0aGF0IHJlcHJvZHVjZXMgdGhpcyBlcnJv
ciwKYW5kIHNlbmQgdGhlIGNvbXBsZXRlIHNvdXJjZSBmb3IgdGhhdC4KIC0tIFRpbQoKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KVGltIEJpcmQKQXJjaGl0ZWN0dXJlIEdyb3VwIENoYWly
LCBDRSBMaW51eCBGb3J1bQpTZW5pb3IgU3RhZmYgRW5naW5lZXIsIFNvbnkgQ29ycG9yYXRpb24g
b2YgQW1lcmljYQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PQoKCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
dHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
