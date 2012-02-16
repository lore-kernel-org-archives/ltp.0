Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RxubS-0003jz-O6
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 06:14:02 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxubO-0003gq-Tt
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 06:14:02 +0000
Message-ID: <4F3C9EA0.1050308@windriver.com>
Date: Thu, 16 Feb 2012 14:13:52 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <1329360067-14421-1-git-send-email-kai.kang@windriver.com>
	<4F3C7747.4090403@cn.fujitsu.com>
In-Reply-To: <4F3C7747.4090403@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] aio_cancel/3-1: call aio_read before aio_cancel
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

T24gMjAxMuW5tDAy5pyIMTbml6UgMTE6MjUsIFdhbmxvbmcgR2FvIHdyb3RlOgoKSGkgV2FuTG9u
ZywKCj4gT24gMDIvMTYvMjAxMiAxMDo0MSBBTSwgS2FuZyBLYWkgd3JvdGU6Cj4KPj4gVGhlIGNh
c2UgY2FsbHMgYWlvX2Vycm9yKCkgd2l0aCBhbiBpbnZhbGlkIGFpb2NicCwgYnV0IGl0IHNob3Vs
ZCBkbwo+PiBzb21lIGFzeW5jaHJvbm91cyBJL08gb3BlcmF0aW9ucyBmaXJzdCwgc28gY2FsbCBh
aW9fcmVhZCgpIGFuZCB0aGVuCj4+IHRlc3QgdGhlIGFpb19lcnJvcigpLgo+Cj4gTkFDSy4gSWYg
c28sIHRoZSBlcnJvciBpcyBmcm9tIGFpb19yZWFkIGJ1dCBub3QgZnJvbSBhaW9fZXJyb3IuCj4g
VGhpcyB3YXMgZGlzY3Vzc2VkIGxvbmcgdGltZSBhZ28sIHBsZWFzZSByZWZlciB0byB0aGUgbWFp
bCBhcmNoaXZlLgo+Cj4gVGhpcyB0ZXN0IGNhc2UgaXMgcmlnaHQsIGJ1dCB0aGlzIEZBSUwgaXMg
bm90IGhhcmQgaW4gUE9TSVgsCj4gc28gd2UgY2hhbmdlZCB0aGUgcmVzdWx0IGZyb20gRkFJTCB0
byBVTlJFU09MVkVEIG5vdy4KT0ssIEkgZ290IGl0LgpUaGFua3MuCgpLYWkKCj4KPiBTbywganVz
dCBsZXQgaXQgVU5SRVNPTFZFRC4gOykKPgo+IFRoYW5rcwo+IC1XYW5sb25nIEdhbwo+Cj4+IFNp
Z25lZC1vZmYtYnk6IEthbmcgS2FpPGthaS5rYW5nQHdpbmRyaXZlci5jb20+Cj4+IC0tLQo+PiAg
IC4uLi9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL2Fpb19lcnJvci8zLTEuYyAgICAgICAgIHwgICAg
NSArKysrLQo+PiAgIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2Nv
bmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX2Vycm9yLzMtMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9z
aXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX2Vycm9yLzMtMS5jCj4+IGlu
ZGV4IDhiNmMyZjUuLjY2NjVkYTEgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL2Fpb19lcnJvci8zLTEuYwo+PiArKysg
Yi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9h
aW9fZXJyb3IvMy0xLmMKPj4gQEAgLTY4LDYgKzY4LDkgQEAgaW50IG1haW4oKQo+PiAgIAlhaW9j
Yi5haW9fcmVxcHJpbyA9IC0xOwo+PiAgIAlhaW9jYi5haW9fbmJ5dGVzID0gQlVGX1NJWkU7Cj4+
Cj4+ICsJLyogSnVzdCBkbyBhaW9fcmVhZCgpIG9yIGFpb193cml0ZSAqLwo+PiArCWFpb19yZWFk
KCZhaW9jYik7Cj4+ICsKPj4gICAJcmV0ID0gYWlvX2Vycm9yKCZhaW9jYik7Cj4+Cj4+ICAgCWlm
IChyZXQgIT0gRUlOVkFMKQo+PiBAQCAtODAsNCArODMsNCBAQCBpbnQgbWFpbigpCj4+ICAgCWNs
b3NlKGZkKTsKPj4gICAJcHJpbnRmICgiVGVzdCBQQVNTRURcbiIpOwo+PiAgIAlyZXR1cm4gUFRT
X1BBU1M7Cj4+IC19Cj4+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQo+PiArfQo+CgoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tClZpcnR1YWxpemF0aW9uICYgQ2xvdWQgTWFuYWdlbWVudCBVc2lu
ZyBDYXBhY2l0eSBQbGFubmluZwpDbG91ZCBjb21wdXRpbmcgbWFrZXMgdXNlIG9mIHZpcnR1YWxp
emF0aW9uIC0gYnV0IGNsb3VkIGNvbXB1dGluZyAKYWxzbyBmb2N1c2VzIG9uIGFsbG93aW5nIGNv
bXB1dGluZyB0byBiZSBkZWxpdmVyZWQgYXMgYSBzZXJ2aWNlLgpodHRwOi8vd3d3LmFjY2VsYWNv
bW0uY29tL2phdy9zZm5sLzExNC81MTUyMTIyMy8KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9sdHAtbGlzdAo=
