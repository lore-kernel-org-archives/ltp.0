Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1TAtGa-0001eS-AO
	for ltp-list@lists.sourceforge.net; Mon, 10 Sep 2012 01:58:24 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TAtGZ-0000ck-2Y
	for ltp-list@lists.sourceforge.net; Mon, 10 Sep 2012 01:58:24 +0000
Message-ID: <504D494A.8040705@windriver.com>
Date: Mon, 10 Sep 2012 09:58:34 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <1346925057-5511-1-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1346925057-5511-1-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] V3: mq_open/16-1: use tmp file to share info
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

T24gMjAxMuW5tDA55pyIMDbml6UgMTc6NTAsIEthbmcgS2FpIHdyb3RlOgo+IEhpLAoKSGkgSmFu
LAoKPgo+IFYzIHNpbXBsaWZ5IHRoZSBjbGVhbnVwIHdvcmsuCkhvdyBhYm91dCB0aGlzIHZlcnNp
b24/CgpUaGFua3MsCkthaQoKPgo+IFYyIGp1c3QgcmVtb3ZlIHRoZSB2YXIgYnVmW10sIGFuZCB3
cml0ZSBmbmFtZVtdIHRvIHRoZSB0bXAgZmlsZS4KPiBBbmQgbW9yZSBjbGVhbnVwIHdvcmsgd2hl
biB0ZXN0IGZhaWxzLgo+Cj4KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBMaXZlIFNlY3VyaXR5
IFZpcnR1YWwgQ29uZmVyZW5jZQo+IEV4Y2x1c2l2ZSBsaXZlIGV2ZW50IHdpbGwgY292ZXIgYWxs
IHRoZSB3YXlzIHRvZGF5J3Mgc2VjdXJpdHkgYW5kCj4gdGhyZWF0IGxhbmRzY2FwZSBoYXMgY2hh
bmdlZCBhbmQgaG93IElUIG1hbmFnZXJzIGNhbiByZXNwb25kLiBEaXNjdXNzaW9ucwo+IHdpbGwg
aW5jbHVkZSBlbmRwb2ludCBzZWN1cml0eSwgbW9iaWxlIHNlY3VyaXR5IGFuZCB0aGUgbGF0ZXN0
IGluIG1hbHdhcmUKPiB0aHJlYXRzLiBodHRwOi8vd3d3LmFjY2VsYWNvbW0uY29tL2phdy9zZnJu
bDA0MjQyMDEyLzExNC81MDEyMjI2My8KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IEx0cC1saXN0IG1haWxpbmcgbGlzdAo+IEx0cC1saXN0QGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2x0cC1saXN0Cj4KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTGl2ZSBTZWN1cml0eSBW
aXJ0dWFsIENvbmZlcmVuY2UKRXhjbHVzaXZlIGxpdmUgZXZlbnQgd2lsbCBjb3ZlciBhbGwgdGhl
IHdheXMgdG9kYXkncyBzZWN1cml0eSBhbmQgCnRocmVhdCBsYW5kc2NhcGUgaGFzIGNoYW5nZWQg
YW5kIGhvdyBJVCBtYW5hZ2VycyBjYW4gcmVzcG9uZC4gRGlzY3Vzc2lvbnMgCndpbGwgaW5jbHVk
ZSBlbmRwb2ludCBzZWN1cml0eSwgbW9iaWxlIHNlY3VyaXR5IGFuZCB0aGUgbGF0ZXN0IGluIG1h
bHdhcmUgCnRocmVhdHMuIGh0dHA6Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3Nmcm5sMDQyNDIw
MTIvMTE0LzUwMTIyMjYzLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0
Cg==
