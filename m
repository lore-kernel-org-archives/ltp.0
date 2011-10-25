Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RIWNX-0000PJ-Co
	for ltp-list@lists.sourceforge.net; Tue, 25 Oct 2011 02:04:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RIWNV-0001ho-KF
	for ltp-list@lists.sourceforge.net; Tue, 25 Oct 2011 02:04:35 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id A471617011E
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Oct 2011 10:04:21 +0800 (CST)
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p9P24JXe015436
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Oct 2011 10:04:20 +0800
Message-ID: <4EA618E7.90002@cn.fujitsu.com>
Date: Tue, 25 Oct 2011 10:03:19 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4E9BF106.8000906@petalogix.com>
In-Reply-To: <4E9BF106.8000906@petalogix.com>
Subject: Re: [LTP] lseek03 - v3.1-rc1
Reply-To: gaowanlong@cn.fujitsu.com
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

T24gMTAvMTcvMjAxMSAwNToxMCBQTSwgTWljaGFsIFNpbWVrIHdyb3RlOgoKPiBIaSwKPiAKPiBJ
IHNlZSB0aGF0IHRoZXJlIGlzIHByb2JsZW0gd2l0aCBsc2VlazAzIHRlc3QgY2FzZSBjYXVzZWQg
YnkKPiBrZXJuZWwgY29tbWl0IOKAnGZzOiBhZGQgU0VFS19IT0xFIGFuZCBTRUVLX0RBVEEgZmxh
Z3PigJwgKHNoYTE6IDk4MmQ4MTY1ODFlZWVhY2ZlNWIyYjdjNmQ0N2QxM2ExNTc2MTZlZmYpLgo+
IEl0IHdhcyBhZGRlZCB0byBrZXJuZWwgaW4gdjMuMSBtZXJnZSB3aW5kb3cuCj4gCj4gQ2FuIHNv
bWVvbmUgY29uZmlybSB0aGUgdGVzdCBmYWlsdXJlPwo+IAo+IFRoYW5rcywKPiBNaWNoYWwKPiAK
PiAKCgpZZWFoLCBJIHNlZWsgdGhhdC4KCmFuZCBJIGhhZCBzZW5kIGEgcGF0Y2ggdG8gZml4IHRo
aXMuIApodHRwOi8vc291cmNlZm9yZ2UubmV0L21haWxhcmNoaXZlL21lc3NhZ2UucGhwP21zZ19p
ZD0yODI3NTU5MgoKSSB0aGluayB3ZSBqdXN0IGNoYW5nZSAqNCogdG8gKjUqIGJlY2F1c2UgdGhl
IFNFRUtfTUFYIGNoYW5nZSAqMiogdG8gKjQqLgoKTWF5YmUganVzdCBuZWVkIHRoZSBzaW1wbGUg
Zml4LgoKClRoYW5rcwotV2FubG9uZyBHYW8KCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGUgZGVt
YW5kIGZvciBJVCBuZXR3b3JraW5nIHByb2Zlc3Npb25hbHMgY29udGludWVzIHRvIGdyb3csIGFu
ZCB0aGUKZGVtYW5kIGZvciBzcGVjaWFsaXplZCBuZXR3b3JraW5nIHNraWxscyBpcyBncm93aW5n
IGV2ZW4gbW9yZSByYXBpZGx5LgpUYWtlIGEgY29tcGxpbWVudGFyeSBMZWFybmluZ0BDaXNjbyBT
ZWxmLUFzc2Vzc21lbnQgYW5kIGxlYXJuIAphYm91dCBDaXNjbyBjZXJ0aWZpY2F0aW9ucywgdHJh
aW5pbmcsIGFuZCBjYXJlZXIgb3Bwb3J0dW5pdGllcy4gCmh0dHA6Ly9wLnNmLm5ldC9zZnUvY2lz
Y28tZGV2MmRldgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
