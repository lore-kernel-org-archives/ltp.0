Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SHstz-0003QD-AA
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 08:27:43 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SHstt-0000yf-C2
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 08:27:43 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q3B8RV6V029353
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Apr 2012 01:27:31 -0700 (PDT)
Message-ID: <4F85407A.9050204@windriver.com>
Date: Wed, 11 Apr 2012 16:27:38 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <1334030557-24170-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F853592.1010407@cn.fujitsu.com>
In-Reply-To: <4F853592.1010407@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mq_timedreceive:5-2: reduce the timeout to be
	compared
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

T24gMjAxMuW5tDA05pyIMTHml6UgMTU6NDEsIFdhbmxvbmcgR2FvIHdyb3RlOgo+IE9uIDA0LzEw
LzIwMTIgMTI6MDIgUE0sIFdhbmxvbmcgR2FvIHdyb3RlOgo+Cj4+IFdlIHVzZSAobmV3dGltZS1v
bGR0aW1lKSB0byBjb21wYXJlIHdpdGggdGhlIFRJTUVPVVQgaGVyZSwKPj4gYnV0IHRoZSBkaWZm
LXRpbWUgd2UgZ2V0IGhlcmUgaXMgbm90IGFjY3VyYXRlLCB0aGUgcmVzdHJpY3QKPj4gY29tcGFy
aW5nIGlzIG5vdCByZWFzb25hYmxlLgo+Cj4gQW55b25lIGNhbiBoZWxwIHJldmlld2luZyBvciB0
ZXN0aW5nPwoKVGVzdCBZb2N0byBMaW51eCAxLjIgb24gYXJjaCB4ODYtNjQgcHBjIGFuZCBtaXBz
IFBBU1MuCgpSZWdhcmRzLApLYWkKCj4KPiBUaGFua3MsCj4gV2FubG9uZyBHYW8KPgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBXYW5sb25nIEdhbzxnYW93YW5sb25nQGNuLmZ1aml0c3UuY29tPgo+PiAtLS0K
Pj4gICAuLi4vY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tcV90aW1lZHJlY2VpdmUvNS0yLmMgICAg
ICAgICAgICAgICAgICAgfCAgICA0ICsrLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5f
cG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfdGltZWRyZWNlaXZlLzUt
Mi5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFj
ZXMvbXFfdGltZWRyZWNlaXZlLzUtMi5jCj4+IGluZGV4IGU4MWQ4ZDUuLjkzNDIxYzAgMTAwNjQ0
Cj4+IC0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRl
cmZhY2VzL21xX3RpbWVkcmVjZWl2ZS81LTIuYwo+PiArKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tcV90aW1lZHJlY2VpdmUvNS0yLmMK
Pj4gQEAgLTMyLDcgKzMyLDcgQEAKPj4KPj4gICAjZGVmaW5lIE5BTUVTSVpFIDUwCj4+ICAgI2Rl
ZmluZSBCVUZGRVIgNDAKPj4gLSNkZWZpbmUgVElNRU9VVAkzCj4+ICsjZGVmaW5lIFRJTUVPVVQJ
Mgo+Pgo+PiAgIGludCBibG9ja2luZzsKPj4gICB2b2lkIGV4aXRfaGFuZGxlcihpbnQgc2lnbm8p
Cj4+IEBAIC03MCw3ICs3MCw3IEBAIGludCBtYWluKCkKPj4gICAJCXNpZ2VtcHR5c2V0KCZhY3Qu
c2FfbWFzayk7Cj4+ICAgCQlzaWdhY3Rpb24oU0lHQUJSVCwmYWN0LCAwKTsKPj4KPj4gLQkJdHMu
dHZfc2VjID0gdGltZShOVUxMKSArIFRJTUVPVVQ7Cj4+ICsJCXRzLnR2X3NlYyA9IHRpbWUoTlVM
TCkgKyBUSU1FT1VUICsgMTsKPj4gICAJCXRzLnR2X25zZWMgPSAwOwo+PiAgIAkJb2xkdGltZSA9
IHRpbWUoTlVMTCk7Cj4+ICAgCQltcV90aW1lZHJlY2VpdmUobXFkZXMsIG1zZ3J2LCBCVUZGRVIs
IE5VTEwsJnRzKTsKPgo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gQmV0dGVyIHRoYW4gc2Vj
PyBOb3RoaW5nIGlzIGJldHRlciB0aGFuIHNlYyB3aGVuIGl0IGNvbWVzIHRvCj4gbW9uaXRvcmlu
ZyBCaWcgRGF0YSBhcHBsaWNhdGlvbnMuIFRyeSBCb3VuZGFyeSBvbmUtc2Vjb25kCj4gcmVzb2x1
dGlvbiBhcHAgbW9uaXRvcmluZyB0b2RheS4gRnJlZS4KPiBodHRwOi8vcC5zZi5uZXQvc2Z1L0Jv
dW5kYXJ5LWRldjJkZXYKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IEx0cC1saXN0IG1haWxpbmcgbGlzdAo+IEx0cC1saXN0QGxpc3RzLnNvdXJjZWZv
cmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0
cC1saXN0CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkJldHRlciB0aGFuIHNlYz8gTm90aGluZyBp
cyBiZXR0ZXIgdGhhbiBzZWMgd2hlbiBpdCBjb21lcyB0bwptb25pdG9yaW5nIEJpZyBEYXRhIGFw
cGxpY2F0aW9ucy4gVHJ5IEJvdW5kYXJ5IG9uZS1zZWNvbmQgCnJlc29sdXRpb24gYXBwIG1vbml0
b3JpbmcgdG9kYXkuIEZyZWUuCmh0dHA6Ly9wLnNmLm5ldC9zZnUvQm91bmRhcnktZGV2MmRldgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBt
YWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
