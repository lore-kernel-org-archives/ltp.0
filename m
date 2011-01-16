Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PeQRN-0000EI-Ps
	for ltp-list@lists.sourceforge.net; Sun, 16 Jan 2011 11:06:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PeQRM-0007mK-IG
	for ltp-list@lists.sourceforge.net; Sun, 16 Jan 2011 11:06:33 +0000
Message-ID: <4D32D102.4040506@redhat.com>
Date: Sun, 16 Jan 2011 19:05:38 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <1294339211-19449-1-git-send-email-czhang@redhat.com>
In-Reply-To: <1294339211-19449-1-git-send-email-czhang@redhat.com>
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

T24gMDEvMDcvMjAxMSAwMjo0MCBBTSwgY3poYW5nQHJlZGhhdC5jb20gd3JvdGU6Cj4gV2UgZ2V0
IHNlZ2ZhdWx0cyBkdXJpbmcgdGVzdGluZyBtdGVzdDAxIG9uIGEgNVRCIG1lbW9yeSBtYWNoaW5l
LCB0aGUKPiBwcm9ibGVtIHdhcyB0cmFjZWQgdG8gdGhlIGFycmF5IHBpZF9saXN0W10gd2VudCB0
byBvdmVyZmxvdyBhbmQKPiBjb3JydXB0ZWQgbWVtb3J5LiBUaGlzIGZpeCBtYWtlcyBwaWRfbGlz
dCBkeW5hbWljYWxseSBzaXplZCB3aXRoCj4gY29ycmVjdCBtZW1vcnkgc2l6ZSB0byBhdm9pZCBv
dmVyZmxvdy4KPiAKPiB2Mjogbm90IHNwbGl0IGludG8gZGlmZmVyZW50IGJpdHMgd2hlbiBhbGxv
Y2F0aW5nIHBpZF9saXN0Lgo+IHYzOiAxKSBmaXggb3B0YXJnczogLWIgYW5kIC1wIHNob3VsZCBu
b3QgYmUgdXNlZCBhdCB0aGUgc2FtZSB0aW1lLgo+ICAgICAyKSBwcmVfbWVtIG1heWJlIG5vdCBp
bml0aWFsaXplZCBiZWZvcmUgdXNpbmcgaWYgLXAgb3B0aW9uIG5vdCB1c2VkLgo+ICAgICAgICBm
aXggaXQgYnkgbW92aW5nIGl0IG91dHNpZGUgYGBpZihtYXhwZXJjZW50KScnIGJsb2NrLgo+IHY0
OiBmaXggY29kZSBmb3JtYXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2FzcGFyIFpoYW5nIDxjemhh
bmdAcmVkaGF0LmNvbT4KCkhpIEdhcnJldHQsIHdvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoaXMg
cGF0Y2g/IFRoYW5rcyEKCkNhc3BhcgoKLS0gClF1YWxpdHkgQXNzdXJhbmNlIEFzc29jaWF0ZSAo
S2VybmVsKSBpbgpSZWQgSGF0IFNvZnR3YXJlIChCZWlqaW5nKSBDby4sIFImRCBCcmFuY2gKClRF
TDogKzg2LTEwLTYyNjA4MTUwCldFQjogaHR0cDovL3d3dy5yZWRoYXQuY29tLwotLQpDLUEtUy1Q
LUEtUiwgQ2FzcGFyIC9rw6ZzcMmROi8gOy0pCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUHJvdGVj
dCBZb3VyIFNpdGUgYW5kIEN1c3RvbWVycyBmcm9tIE1hbHdhcmUgQXR0YWNrcwpMZWFybiBhYm91
dCB2YXJpb3VzIG1hbHdhcmUgdGFjdGljcyBhbmQgaG93IHRvIGF2b2lkIHRoZW0uIFVuZGVyc3Rh
bmQgCm1hbHdhcmUgdGhyZWF0cywgdGhlIGltcGFjdCB0aGV5IGNhbiBoYXZlIG9uIHlvdXIgYnVz
aW5lc3MsIGFuZCBob3cgeW91IApjYW4gcHJvdGVjdCB5b3VyIGNvbXBhbnkgYW5kIGN1c3RvbWVy
cyBieSB1c2luZyBjb2RlIHNpZ25pbmcuCmh0dHA6Ly9wLnNmLm5ldC9zZnUvb3JhY2xlLXNmZGV2
bmwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxp
c3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
