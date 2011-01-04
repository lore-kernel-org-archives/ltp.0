Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1Pa9ik-0000Px-2R
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 16:26:50 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pa9ii-0004lU-U3
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 16:26:50 +0000
Message-ID: <4D234A2B.5050203@redhat.com>
Date: Wed, 05 Jan 2011 00:26:19 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <1294158071-18027-1-git-send-email-czhang@redhat.com>
In-Reply-To: <1294158071-18027-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH v3] make pid_list dynamically sized with memory
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

T24gMDEvMDUvMjAxMSAxMjoyMSBBTSwgY3poYW5nQHJlZGhhdC5jb20gd3JvdGU6Cj4gV2UgZ2V0
IHNlZ2ZhdWx0cyBkdXJpbmcgdGVzdGluZyBtdGVzdDAxIG9uIGEgNVRCIG1lbW9yeSBtYWNoaW5l
LCB0aGUKPiBwcm9ibGVtIHdhcyB0cmFjZWQgdG8gdGhlIGFycmF5IHBpZF9saXN0W10gd2VudCB0
byBvdmVyZmxvdyBhbmQKPiBjb3JydXB0ZWQgbWVtb3J5LiBUaGlzIGZpeCBtYWtlcyBwaWRfbGlz
dCBkeW5hbWljYWxseSBzaXplZCB3aXRoCj4gY29ycmVjdCBtZW1vcnkgc2l6ZSB0byBhdm9pZCBv
dmVyZmxvdy4KPiAKPiB2Mjogbm90IHNwbGl0IGludG8gZGlmZmVyZW50IGJpdHMgd2hlbiBhbGxv
Y2F0aW5nIHBpZF9saXN0Lgo+IHYzOiAxKSBmaXggb3B0YXJnczogLWIgYW5kIC1wIHNob3VsZCBu
b3QgYmUgdXNlZCBhdCB0aGUgc2FtZSB0aW1lLgo+ICAgICAyKSBwcmVfbWVtIG1heWJlIG5vdCBp
bml0aWFsaXplZCBiZWZvcmUgdXNpbmcgaWYgLXAgb3B0aW9uIG5vdCB1c2VkLgo+ICAgICBmaXgg
aXQgYnkgbW92aW5nIGl0IG91dHNpZGUgYGBpZihtYXhwZXJjZW50KScnIGJsb2NrLgo+IAo+IFNp
Z25lZC1vZmYtYnk6IENhc3BhciBaaGFuZyA8Y3poYW5nQHJlZGhhdC5jb20+CgpIaSBHYXJyZXR0
LCBwbGVhc2UgcmV2aWV3IHYzLCB0aGUgdXAtdG8tZGF0ZSB2ZXJzaW9uLgoKVGhhbmtzLApDYXNw
YXIKCi0tIApRdWFsaXR5IEFzc3VyYW5jZSBBc3NvY2lhdGUgKEtlcm5lbCkgaW4KUmVkIEhhdCBT
b2Z0d2FyZSAoQmVpamluZykgQ28uLCBSJkQgQnJhbmNoCgpURUw6ICs4Ni0xMC02MjYwODE1MApX
RUI6IGh0dHA6Ly93d3cucmVkaGF0LmNvbS8KLS0KQy1BLVMtUC1BLVIsIENhc3BhciAva8Omc3DJ
kTovIDstKQoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxlYXJuIGhvdyBPcmFjbGUgUmVhbCBBcHBs
aWNhdGlvbiBDbHVzdGVycyAoUkFDKSBPbmUgTm9kZSBhbGxvd3MgY3VzdG9tZXJzCnRvIGNvbnNv
bGlkYXRlIGRhdGFiYXNlIHN0b3JhZ2UsIHN0YW5kYXJkaXplIHRoZWlyIGRhdGFiYXNlIGVudmly
b25tZW50LCBhbmQsIApzaG91bGQgdGhlIG5lZWQgYXJpc2UsIHVwZ3JhZGUgdG8gYSBmdWxsIG11
bHRpLW5vZGUgT3JhY2xlIFJBQyBkYXRhYmFzZSAKd2l0aG91dCBkb3dudGltZSBvciBkaXNydXB0
aW9uCmh0dHA6Ly9wLnNmLm5ldC9zZnUvb3JhY2xlLXNmZGV2bmwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1s
aXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
