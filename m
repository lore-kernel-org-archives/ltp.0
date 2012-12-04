Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1TfoeE-00052b-UX
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 09:18:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tfoe9-00053g-CA
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 09:18:38 +0000
Message-ID: <50BDBFC3.1010702@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 17:17:55 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <1354605716-4747-1-git-send-email-penght@cn.fujitsu.com>
	<1354605716-4747-3-git-send-email-penght@cn.fujitsu.com>
	<50BDA8C3.4070802@casparzhang.com>
In-Reply-To: <50BDA8C3.4070802@casparzhang.com>
Subject: Re: [LTP] [PATCH 3/4] at_allow01: Use lib to restart atd service
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Ck9uIDEyLzA0LzIwMTIgMDM6MzkgUE0sIENhc3BhciBaaGFuZyB3cm90ZToKPiBPbiAxMi8wNC8y
MDEyIDAzOjIxIFBNLCBQZW5nIEhhaXRhbyB3cm90ZToKPj4gKyA4NMK7IC7Ct2NtZGxpYi5zaAo+
IAo+IFBhdGNoIHNlcmllcyBsb29rcyBnb29kIHRvIG1lIGV4Y2VwdCB0aGlzLgo+IAo+IHNvdXJj
aW5nIGEgbGliIGluc2lkZSBhIGZ1bmN0aW9uIHNlZW1zIG5vdCBzbyBnb29kLiBZZXQgSSBkb24n
dCBzZWUgYW55IGNvZGUgc3R5bGUgcnVsZXMgdGVsbGluZyB3aGljaCBpcyB0aGUgY29ycmVjdCBw
bGFjZSB0byBwdXQgYSBzaGVsbCBsaWIgc291cmNlIChjb21tb25seSBJIHRoaW5rIGl0IHdvdWxk
IGJlIHRoZSB0b3AgaW4gdGhlIGZpbGUpCj4gCgkKWWVhaC4gSSB0aGluayBzbywgdG9vLiAKSWYg
c291cmNpbmcgYSBsaWIgaW4gdGhlIHRvcCBvZiB0aGUgZmlsZSwgdGhlIGNhc2Ugd2lsbCBmYWls
LgpCZWNhdXNlIHRoZSBjYXNlIHdpbGwgdXNlIHN1IHh4eCAtbGMgdG8gZXhlY3V0ZSBpdHNlbGYg
aW4geHh4J3MgaG9tZSBkaXJlY3RvcnkuCkJ1dCBjbWRsaWIuc2ggaXMgaW4gL29wdC9sdHAvdGVz
dGNhc2VzL2Jpbi8sIG5vdCBpbiB4eHgncyBob21lIGRpcmVjdG9yeS4KCgpUaGlzIGhhcyBhbm90
aGVyIG1ldGhvZCwgYWRkIHRoZSBmb2xsb3dpbmcgY29udGVudCBpbiB0b3Agb2YgdGhlIGZpbGU6
CgppZiBbICIkKGlkIC1ydSkiID0gMCBdOyB0aGVuCiAgICAgICAgLiBjbWRsaWIuc2gKZmkKCkkg
dGhpbmsgYWRkIGluc2lkZSBhIGZ1bmN0aW9uIGlzIHNpbXBsZTopCklmIHlvdSB0aGluayBhZGQg
aW4gdG9wIG9mIHRoZSBmaWxlIHdpbGwgYmV0dGVyLCBJIHdpbGwgcmVzZW5kIGl0LgpUaGFua3Mu
CgotLSAKQmVzdCBSZWdhcmRzLApQZW5nCgo+IFRoYW5rcywKPiBDYXNwYXIKPiAKPj4gKyA4NcK7
IHJlc3RhcnRfZGFlbW9uwrdhdGQKPiAKPiAKPiAKPiAKCi0tIApCZXN0IFJlZ2FyZHMsClBlbmcK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMb2dNZUluIFJlc2N1ZTogQW55d2hlcmUsIEFueXRpbWUg
UmVtb3RlIHN1cHBvcnQgZm9yIElULiBGcmVlIFRyaWFsClJlbW90ZWx5IGFjY2VzcyBQQ3MgYW5k
IG1vYmlsZSBkZXZpY2VzIGFuZCBwcm92aWRlIGluc3RhbnQgc3VwcG9ydApJbXByb3ZlIHlvdXIg
ZWZmaWNpZW5jeSwgYW5kIGZvY3VzIG9uIGRlbGl2ZXJpbmcgbW9yZSB2YWx1ZS1hZGQgc2Vydmlj
ZXMKRGlzY292ZXIgd2hhdCBJVCBQcm9mZXNzaW9uYWxzIEtub3cuIFJlc2N1ZSBkZWxpdmVycwpo
dHRwOi8vcC5zZi5uZXQvc2Z1L2xvZ21laW5fMTIzMjlkMmQKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9sdHAtbGlzdAo=
