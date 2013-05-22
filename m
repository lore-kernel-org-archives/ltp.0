Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Uf4rC-0001n7-1V
	for ltp-list@lists.sourceforge.net; Wed, 22 May 2013 08:57:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uf4r7-0005dY-TW
	for ltp-list@lists.sourceforge.net; Wed, 22 May 2013 08:57:13 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r4M8v0Rb010354
	for <ltp-list@lists.sourceforge.net>; Wed, 22 May 2013 16:57:00 +0800
Message-ID: <519C882B.40100@cn.fujitsu.com>
Date: Wed, 22 May 2013 16:56:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <519C24C9.9070807@cn.fujitsu.com>
In-Reply-To: <519C24C9.9070807@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V2] semctl01.c: Pass the correct parameter
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

T24gMDUvMjIvMjAxMyAwOTo1MiBBTSwgREFOIExJIHdyb3RlOgo+IEZvciBTRU1fU1RBVCwgdGhl
IHNlbWlkIGFyZ3VtZW50IGlzIG5vdCBhIHNlbWFwaG9yZSBpZGVudGlmaWVyLCAgYnV0IGluc3Rl
YWQgYW4KPiBpbmRleCBpbnRvIHRoZSBrZXJuZWzigJlzIGludGVybmFsIGFycmF5IHRoYXQgbWFp
bnRhaW5zIGluZm9ybWF0aW9uIGFib3V0IGFsbAo+IHNlbWFwaG9yZSBzZXRzIG9uIHRoZSBzeXN0
ZW0uCj4gCj4gUGFzcyBhIGNvcnJlY3QgaW5kZXggb2YgdGhlIGtlcm5lbCcgaW50ZXJuYWwgYXJy
YXkgaW50ZWFkIG9mIGEgc2VtYXBob3JlcyBpZCB3aGVuCj4gdGVzdGluZyBmZWF0dXJlIFNFTV9T
VEFULgo+IAo+IFNpZ25lZC1vZmYtYnk6IERBTiBMSSA8bGkuZGFuQGNuLmZ1aml0c3UuY29tPgoK
QXBwbGllZCwgdGhhbmsgeW91LgoKV2FubG9uZyBHYW8KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
VHJ5IE5ldyBSZWxpYyBOb3cgJiBXZSdsbCBTZW5kIFlvdSB0aGlzIENvb2wgU2hpcnQKTmV3IFJl
bGljIGlzIHRoZSBvbmx5IFNhYVMtYmFzZWQgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UgbW9uaXRv
cmluZyBzZXJ2aWNlIAp0aGF0IGRlbGl2ZXJzIHBvd2VyZnVsIGZ1bGwgc3RhY2sgYW5hbHl0aWNz
LiBPcHRpbWl6ZSBhbmQgbW9uaXRvciB5b3VyCmJyb3dzZXIsIGFwcCwgJiBzZXJ2ZXJzIHdpdGgg
anVzdCBhIGZldyBsaW5lcyBvZiBjb2RlLiBUcnkgTmV3IFJlbGljCmFuZCBnZXQgdGhpcyBhd2Vz
b21lIE5lcmQgTGlmZSBzaGlydCEgaHR0cDovL3Auc2YubmV0L3NmdS9uZXdyZWxpY19kMmRfbWF5
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0
IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
