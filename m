Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SzkWH-0004pu-8v
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:24:33 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzkWG-0006TB-6k
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 08:24:33 +0000
Date: Fri, 10 Aug 2012 04:24:25 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2014107378.3027931.1344587065940.JavaMail.root@redhat.com>
In-Reply-To: <5024BFF9.7050703@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH resend 5/6] mm: use new numa_helper
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIlpob3VwaW5nIExpdSIgPHps
aXVAcmVkaGF0LmNvbT4KPiBUbzogIkNhc3BhciBaaGFuZyIgPGNhc3BhckBjYXNwYXJ6aGFuZy5j
b20+Cj4gQ2M6ICJMVFAgTGlzdCIgPGx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldD4KPiBT
ZW50OiBGcmlkYXksIDEwIEF1Z3VzdCwgMjAxMiAxMDowMjowMSBBTQo+IFN1YmplY3Q6IFJlOiBb
TFRQXSBbUEFUQ0ggcmVzZW5kIDUvNl0gbW06IHVzZSBuZXcgbnVtYV9oZWxwZXIKPiAKCj4gPiAt
wrsgcmV0dXJuwrdubm9kZXM7Cj4gPiArwrsgcmV0wrc9wrdnZXRfYWxsb3dlZF9ub2RlcyhOSF9N
RU1TfE5IX0NQVVMswrcxLMK3Jm5kMSk7Cj4gCj4gQ2FzcGFyLCBJIGZvdW5kIGdldF9hX251bWFf
bm9kZSBhbHdheXMgcmV0dXJuIHRoZSBmaXJzdCBub2RlIGlkLAo+IHdoaWNoCj4gd2lsbCBtYWtl
IGFsbCBjYXNlcyBjYWxsZWQgdGhlIGZ1bmN0aW9uCj4gb25seSBydW4gaW4gdGhlIGZpcnN0IG5v
ZGUsIEkgZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2Qgd2F5LCBpdAo+IGRlY3JlYXNlCj4gdGhlIGNv
dmVyYWdlLgoKV2UgaGFkIGEgZGlzY3Vzc2lvbiB3aXRoIENhc3BhciBvbiB0aGlzIHRvcGljOgpo
dHRwOi8vYXJ0aWNsZS5nbWFuZS5vcmcvZ21hbmUubGludXgubHRwLzE2NDk1CgpDYW4geW91IGV4
cGxhaW4gd2h5IGEgc3BlY2lmaWMgbm9kZSBtYXR0ZXJzIGhlcmU/CgpSZWdhcmRzLApKYW4KCj4g
Cj4gd2Ugc2hvdWxkIHByZWZlciB0byBydW4gY2FzZXMgb24gdGhlIHNlY29uZCBub2RlLCB3ZSBj
YW4gY2hvc2UgdGhlCj4gZmlyc3QKPiBvbmx5IGlmIGl0IGp1c3Qgb25seSBoYXMKPiBvbmUgbm9k
ZSB3aXRoIE5IX01FTVN8TkhfQ1BVUy4gZG8geW91IHRoaW5rIHNvPwo+IAo+IGFuZCBvdGhlcnMg
aXMgZ29vZCBmb3IgbWUuCj4gCj4gVGhhbmtzLAo+IFpob3VwaW5nCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkxpdmUgU2VjdXJpdHkgVmlydHVhbCBDb25mZXJlbmNlCkV4Y2x1c2l2ZSBsaXZlIGV2
ZW50IHdpbGwgY292ZXIgYWxsIHRoZSB3YXlzIHRvZGF5J3Mgc2VjdXJpdHkgYW5kIAp0aHJlYXQg
bGFuZHNjYXBlIGhhcyBjaGFuZ2VkIGFuZCBob3cgSVQgbWFuYWdlcnMgY2FuIHJlc3BvbmQuIERp
c2N1c3Npb25zIAp3aWxsIGluY2x1ZGUgZW5kcG9pbnQgc2VjdXJpdHksIG1vYmlsZSBzZWN1cml0
eSBhbmQgdGhlIGxhdGVzdCBpbiBtYWx3YXJlIAp0aHJlYXRzLiBodHRwOi8vd3d3LmFjY2VsYWNv
bW0uY29tL2phdy9zZnJubDA0MjQyMDEyLzExNC81MDEyMjI2My8KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1s
aXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
