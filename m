Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Pf7B1-0005AT-0V
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 08:44:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf7Ay-0003JE-Oo
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 08:44:30 +0000
Message-ID: <4D35530F.7050503@redhat.com>
Date: Tue, 18 Jan 2011 16:45:03 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <1294339211-19449-1-git-send-email-czhang@redhat.com>	<4D354F53.8050600@redhat.com>
	<AANLkTin5SC-04QxrrFmAAYA49PZ0uu6wzVjv4=ckOrf0@mail.gmail.com>
In-Reply-To: <AANLkTin5SC-04QxrrFmAAYA49PZ0uu6wzVjv4=ckOrf0@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4] make pid_list dynamically sized with memory
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

T24gMDEvMTgvMjAxMSAwNDozMyBQTSwgR2FycmV0dCBDb29wZXIgd3JvdGU6Cj4gRG9lc24ndCBw
YXRjaDoKPiAKPiBQYXRjaGluZyBmaWxlIHRlc3RjYXNlcy9rZXJuZWwvbWVtL210ZXN0MDEvbXRl
c3QwMS5jIHVzaW5nIFBsYW4gQS4uLgo+IEh1bmsgIzEgZmFpbGVkIGF0IDQ0Lgo+IDEgb3V0IG9m
IDEgaHVua3MgZmFpbGVkLS1zYXZpbmcgcmVqZWN0cyB0bwo+IHRlc3RjYXNlcy9rZXJuZWwvbWVt
L210ZXN0MDEvbXRlc3QwMS5jLnJlago+IEhtbS4uLiAgSWdub3JpbmcgdGhlIHRyYWlsaW5nIGdh
cmJhZ2UuCj4gZG9uZQo+IAo+IEhhdmUgeW91IHVwZGF0ZWQgeW91ciBzb3VyY2VzIHJlY2VudGx5
PwoKT2guLi4gc29ycnkgSSBkaWRuJ3QuIEknbGwgd29yayBvdXQgYSB1cGRhdGVkIHZlcnNpb24g
c2hvcnRseS4KClRoYW5rcywKQ2FzcGFyCgotLSAKUXVhbGl0eSBBc3N1cmFuY2UgRW5naW5lZXIg
KEtlcm5lbCkgaW4KUmVkIEhhdCBTb2Z0d2FyZSAoQmVpamluZykgQ28uLCBSJkQgQnJhbmNoCgpU
RUw6ICs4Ni0xMC02MjYwODE1MApXRUI6IGh0dHA6Ly93d3cucmVkaGF0LmNvbS8KLS0KQy1BLVMt
UC1BLVIsIENhc3BhciAva8Omc3DJkTovIDstKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClByb3Rl
Y3QgWW91ciBTaXRlIGFuZCBDdXN0b21lcnMgZnJvbSBNYWx3YXJlIEF0dGFja3MKTGVhcm4gYWJv
dXQgdmFyaW91cyBtYWx3YXJlIHRhY3RpY3MgYW5kIGhvdyB0byBhdm9pZCB0aGVtLiBVbmRlcnN0
YW5kIAptYWx3YXJlIHRocmVhdHMsIHRoZSBpbXBhY3QgdGhleSBjYW4gaGF2ZSBvbiB5b3VyIGJ1
c2luZXNzLCBhbmQgaG93IHlvdSAKY2FuIHByb3RlY3QgeW91ciBjb21wYW55IGFuZCBjdXN0b21l
cnMgYnkgdXNpbmcgY29kZSBzaWduaW5nLgpodHRwOi8vcC5zZi5uZXQvc2Z1L29yYWNsZS1zZmRl
dm5sCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1s
aXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
