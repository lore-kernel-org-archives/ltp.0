Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SZ6Do-0002Ey-Kh
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 20:07:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SZ6Dn-0007OQ-GX
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 20:07:20 +0000
Date: Mon, 28 May 2012 16:07:13 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2089a443-4c1d-4d68-b457-e24be11df18b@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <CAGH67wRQ0rd1gZreTExEwcPLwF752ssa3nN40Xm4359Hn_mdLg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/4] mbind01: dont use hardcoded NUMA node ids
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkdhcnJldHQgQ29vcGVyIiA8
eWFuZWdvbWlAZ21haWwuY29tPgo+IFRvOiAiSmFuIFN0YW5jZWsiIDxqc3RhbmNla0ByZWRoYXQu
Y29tPgo+IENjOiBsdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQsICJKZWZmcmV5IEJ1cmtl
IiA8amJ1cmtlQHJlZGhhdC5jb20+Cj4gU2VudDogTW9uZGF5LCAyOCBNYXksIDIwMTIgODoyODoz
OSBQTQo+IFN1YmplY3Q6IFJlOiBbTFRQXSBbUEFUQ0ggMi80XSBtYmluZDAxOiBkb250IHVzZSBo
YXJkY29kZWQgTlVNQSBub2RlIGlkcwo+IAo+IE9uIE1vbiwgTWF5IDI4LCAyMDEyIGF0IDQ6Mzkg
QU0sIEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+IHdyb3RlOgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+ID4gLS0tCj4g
PiDCoHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWJpbmQvTWFrZWZpbGUgwqB8IMKgIMKgMyAr
LS0KPiA+IMKgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tYmluZC9tYmluZDAxLmMgfCDCoCAx
MCArKysrKysrKy0tCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+IAo+ICsJaWYgKChyZXQgPSBnZXRfYWxsb3dlZF9ub2RlcygxLCAmdGVzdF9u
b2RlKSkgPCAwKSB7Cj4gKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiZ2V0X2Fs
bG93ZWRfbm9kZXMoKTogJWQiLCByZXQpOwo+ICsJfQo+IAo+ICAgICBJcyB0aGlzIGFsd2F5cyBn
dWFyYW50ZWVkIHRvIHNldCBlcnJubyB0byBhIHNhbmUgdmFsdWU/CgpUaGFua3MgZm9yIHlvdXIg
cmV2aWV3cyBHYXJyZXR0LgoKRm9yIC0xIGFuZCAtMiwgbWFsbG9jKCkgYW5kIHN5c2NhbGwoKSBz
aG91bGQgdGFrZSBjYXJlIG9mIHRoYXQuCkJ1dCAtMyBzZWVtcyBsb29zZSBhdCB0aGUgbW9tZW50
LCBJIGNhbiBhZGQgdGhlcmU6CiAgICBlcnJubyA9IEVJTlZBTDsKClJlZ2FyZHMsCkphbgoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkxpdmUgU2VjdXJpdHkgVmlydHVhbCBDb25mZXJlbmNlCkV4Y2x1
c2l2ZSBsaXZlIGV2ZW50IHdpbGwgY292ZXIgYWxsIHRoZSB3YXlzIHRvZGF5J3Mgc2VjdXJpdHkg
YW5kIAp0aHJlYXQgbGFuZHNjYXBlIGhhcyBjaGFuZ2VkIGFuZCBob3cgSVQgbWFuYWdlcnMgY2Fu
IHJlc3BvbmQuIERpc2N1c3Npb25zIAp3aWxsIGluY2x1ZGUgZW5kcG9pbnQgc2VjdXJpdHksIG1v
YmlsZSBzZWN1cml0eSBhbmQgdGhlIGxhdGVzdCBpbiBtYWx3YXJlIAp0aHJlYXRzLiBodHRwOi8v
d3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZnJubDA0MjQyMDEyLzExNC81MDEyMjI2My8KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGlu
ZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
