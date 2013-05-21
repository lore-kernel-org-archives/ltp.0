Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Ueji8-0007Tn-62
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 10:22:28 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ueji6-0001Ee-8I
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 10:22:28 +0000
Date: Tue, 21 May 2013 06:22:00 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <464527248.5091039.1369131720554.JavaMail.root@redhat.com>
In-Reply-To: <519B35A9.8090300@cn.fujitsu.com>
References: <519B35A9.8090300@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] semctl01.c: Pass the correct parameter
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

CgoKCi0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0KPiBGcm9tOiAiREFOIExJIiA8bGkuZGFu
QGNuLmZ1aml0c3UuY29tPgo+IFRvOiAiTFRQIGxpc3QiIDxsdHAtbGlzdEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQ+Cj4gU2VudDogVHVlc2RheSwgMjEgTWF5LCAyMDEzIDEwOjUxOjUzIEFNCj4gU3Vi
amVjdDogW0xUUF0gIFtQQVRDSF0gc2VtY3RsMDEuYzogUGFzcyB0aGUgY29ycmVjdCBwYXJhbWV0
ZXIKPiAKPiAKPiBGb3IgU0VNX1NUQVQsIHRoZSBzZW1pZCBhcmd1bWVudCBpcyBub3QgYSBzZW1h
cGhvcmUgaWRlbnRpZmllciwgIGJ1dCBpbnN0ZWFkCj4gYW4KPiBpbmRleCBpbnRvIHRoZSBrZXJu
ZWzigJlzIGludGVybmFsIGFycmF5IHRoYXQgbWFpbnRhaW5zIGluZm9ybWF0aW9uIGFib3V0IGFs
bAo+IHNlbWFwaG9yZSBzZXRzIG9uIHRoZSBzeXN0ZW0uCj4gCj4gUGFzcyBhIGNvcnJlY3QgaW5k
ZXggb2YgdGhlIGtlcm5lbCcgaW50ZXJuYWwgYXJyYXkgaW50ZWFkIG9mIGEgc2VtYXBob3JlcyBp
ZAo+IHdoZW4KPiB0ZXN0aW5nIGZlYXR1cmUgU0VNX1NUQVQuCj4gCj4gU2lnbmVkLW9mZi1ieTog
REFOIExJIDxsaS5kYW5AY24uZnVqaXRzdS5jb20+Cj4gLS0tCgpIaSwKCnRoYXQgYmFja3VwL3Jl
c3RvcmUgb2YgZ2xvYmFsIHZhcmlhYmxlIGluIHNldHVwL2NsZWFudXAgZnVuY3MKYmV0d2VlbiB0
ZXN0Y2FzZXMgbG9va3MgYSBiaXQgb2RkIHRvIG1lLgoKSG93IGFib3V0IGFkZGluZyBuZXcgZmll
bGQgdG8gdGVzdF9jYXNlX3Q/Cgorc3RhdGljIGludCBzZW1faW5kZXggPSAwOwogc3RhdGljIHN0
cnVjdCB0ZXN0X2Nhc2VfdCB7CisgICAgICAgaW50ICpzZW1pZDsKLi4uCi0gICAgICAgICAgICAg
ICAgICAgICAgIFRFU1Qoc2VtY3RsKHNlbV9pZF8xLCBUQ1tpXS5zZW1udW0sIFRDW2ldLmNtZCwK
KyAgICAgICAgICAgICAgICAgICAgICAgVEVTVChzZW1jdGwoKihUQ1tpXS5zZW1pZCksIFRDW2ld
LnNlbW51bSwgVENbaV0uY21kLAoKVGhlc2UgeW91IGNvdWxkIGluaXRpYWxpc2UgaW4gVENbXSBk
ZWZpbml0aW9uIHRvIGVpdGhlciAmc2VtX2lkXzEgb3IgJnNlbV9pbmRleAphbmQgYXZvaWQgYWxs
IHRoYXQgYmFja3VwL3Jlc3RvcmUgb2Ygc2VtX2lkXzEuCgpXaGF0IGRvIHlvdSB0aGluaz8KClJl
Z2FyZHMsCkphbgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRyeSBOZXcgUmVsaWMgTm93ICYgV2Un
bGwgU2VuZCBZb3UgdGhpcyBDb29sIFNoaXJ0Ck5ldyBSZWxpYyBpcyB0aGUgb25seSBTYWFTLWJh
c2VkIGFwcGxpY2F0aW9uIHBlcmZvcm1hbmNlIG1vbml0b3Jpbmcgc2VydmljZSAKdGhhdCBkZWxp
dmVycyBwb3dlcmZ1bCBmdWxsIHN0YWNrIGFuYWx5dGljcy4gT3B0aW1pemUgYW5kIG1vbml0b3Ig
eW91cgpicm93c2VyLCBhcHAsICYgc2VydmVycyB3aXRoIGp1c3QgYSBmZXcgbGluZXMgb2YgY29k
ZS4gVHJ5IE5ldyBSZWxpYwphbmQgZ2V0IHRoaXMgYXdlc29tZSBOZXJkIExpZmUgc2hpcnQhIGh0
dHA6Ly9wLnNmLm5ldC9zZnUvbmV3cmVsaWNfZDJkX21heQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2x0cC1saXN0Cg==
