Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Pov03-0006nH-3z
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 09:45:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pov00-0006HP-4K
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 09:45:43 +0000
Message-ID: <4D58F9CF.6000203@cn.fujitsu.com>
Date: Mon, 14 Feb 2011 17:45:51 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D3017F9.7060307@cn.fujitsu.com> <4D427D32.8020801@cn.fujitsu.com>
In-Reply-To: <4D427D32.8020801@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] Fix a building error.
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

SGkgR2FycmV0dCwKCkFueSByZXNwb25zZe+8nwoKVGhlIElOU1RBTEwgZmlsZSBzYXkgZmxleCBj
YW4gYmUgb2J0YWluZWQgaGVyZToKLSBodHRwOi8vZG93bmxvYWRzLnNvdXJjZWZvcmdlLm5ldC9w
cm9qZWN0L2ZsZXgvZmxleC9mbGV4LTIuNS4zMy9mbGV4LTIuNS4zMy50YXIuYnoyCgpBcmUgeW91
IG1lYW4gdGhlIGZsZXggdmVyc2lvbiBpcyBzdXJlIGZsZXgtMi41LjMzK++8nwoKPiAgIFdvdWxk
IHlvdSBsaWtlIHRvIGFwcGx5IHRoaXMgcGF0Y2g/IAo+IAo+ICAgIiVvcHRpb24gbm9sZXgtY29t
cGF0IiBtYWtlIHRoZSBnbG9iYWwgdmFyaWFibGUgInl5bGluZW5vIiB1bmRlY2xhcmVkLCAKPiB0
aGlzIHdpbGwgcmVzdWx0IGluIGJ1aWxkIGVycm9yIGluIFJIRUw0LjggYW5kIFJIRUw1LjUuCj4g
Cj4gICBUaGUgZW52aXJvbm1lbnRzIGFyZSBhcyBmb2xsb3dzOgo+ICAgLSBSSEVMNC44IC0tLSB4
ODZfNjQKPiAgIC0gZmxleCAgICAtLS0gdmVyc2lvbiAyLjUuNAo+IAo+ICAgLSBSSEVMNS41IC0t
LSAoeDg2LCB4ODZfNjQsIGlhNjQpCj4gICAtIGZsZXggICAgLS0tIHZlcnNpb24gMi41LjQKPiAK
PiAKPiBQZW5nIEhhaXRhbyBzYWlkIHRoZSBmb2xsb3dpbmcgb24gMjAxMS0xLTE0IDE3OjMxOgo+
PiBIaSBHYXJyZXR0LAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEhhaXRhbyA8cGVuZ2h0QGNu
LmZ1aml0c3UuY29tPgo+PiAtLS0KPj4gIHBhbi9zY2FuLmwgfCAgICAxICsKPj4gIDEgZmlsZXMg
Y2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvcGFuL3NjYW4ubCBiL3Bhbi9zY2FuLmwKPj4gaW5kZXggOTY5NjUzMS4uY2M0N2JkZiAxMDA2
NDQKPj4gLS0tIGEvcGFuL3NjYW4ubAo+PiArKysgYi9wYW4vc2Nhbi5sCj4+IEBAIC05MSw2ICs5
MSw3IEBAIHN0YXRpYyBpbnQgY2hlY2tfbW9kZShpbnQsIGludCwgLi4uKTsKPj4gICVvcHRpb24g
bm9pbnB1dAo+PiAgJW9wdGlvbiBub2xleC1jb21wYXQKPj4gICVvcHRpb24gbm91bnB1dAo+PiAr
JW9wdGlvbiB5eWxpbmVubwo+PiAgCj4+ICBVSSAgICAgIFswLTldKwo+PiAgQSAgICAgICBbYS16
QS1aXSsKPiAKCi0tIApCZXN0IFJlZ2FyZHMsClBlbmcgSGFpdGFvCgoKLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tClRoZSB1bHRpbWF0ZSBhbGwtaW4tb25lIHBlcmZvcm1hbmNlIHRvb2xraXQ6IEludGVs
KFIpIFBhcmFsbGVsIFN0dWRpbyBYRToKUGlucG9pbnQgbWVtb3J5IGFuZCB0aHJlYWRpbmcgZXJy
b3JzIGJlZm9yZSB0aGV5IGhhcHBlbi4KRmluZCBhbmQgZml4IG1vcmUgdGhhbiAyNTAgc2VjdXJp
dHkgZGVmZWN0cyBpbiB0aGUgZGV2ZWxvcG1lbnQgY3ljbGUuCkxvY2F0ZSBib3R0bGVuZWNrcyBp
biBzZXJpYWwgYW5kIHBhcmFsbGVsIGNvZGUgdGhhdCBsaW1pdCBwZXJmb3JtYW5jZS4KaHR0cDov
L3Auc2YubmV0L3NmdS9pbnRlbC1kZXYyZGV2ZmViCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vbHRwLWxpc3QK
