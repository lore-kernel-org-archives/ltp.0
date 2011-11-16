Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RQUmh-0006Ru-TA
	for ltp-list@lists.sourceforge.net; Wed, 16 Nov 2011 01:59:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RQUmd-0006O3-CV
	for ltp-list@lists.sourceforge.net; Wed, 16 Nov 2011 01:59:31 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 11D63170095
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Nov 2011 09:59:21 +0800 (CST)
Received: from mailserver.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id pAG1xKGa029023
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Nov 2011 09:59:20 +0800
Message-ID: <4EC318BA.9060106@cn.fujitsu.com>
Date: Wed, 16 Nov 2011 09:58:18 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <e9647cdbda675e315776948ed7731ceb68757dd7.1321364606.git.caspar@casparzhang.com>
In-Reply-To: <e9647cdbda675e315776948ed7731ceb68757dd7.1321364606.git.caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] safe_macros.h: fix warning
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

T24gMTEvMTUvMjAxMSAwOTo0MyBQTSwgQ2FzcGFyIFpoYW5nIHdyb3RlOgoKPiAKPiBUaGUgZm9s
bG93aW5nIHdhcm5pbmcgaXMgZ2l2ZW4gd2hlbiBjb21waWxpbmcgdGVzdGNhc2VzIHdpdGgKPiBz
YWZlX21hY3Jvcy5oIGluY2x1ZGVkOgo+IAo+IC4uLi9zYWZlX21hY3Jvcy5oOjYyOiB3YXJuaW5n
OiDigJhzdHJ1Y3QgcnVzYWdl4oCZIGRlY2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIgbGlzdAo+IC4u
Li9zYWZlX21hY3Jvcy5oOjYyOiB3YXJuaW5nOiBpdHMgc2NvcGUgaXMgb25seSB0aGlzIGRlZmlu
aXRpb24gb3IgZGVjbGFyYXRpb24sIHdoaWNoIGlzIHByb2JhYmx5IG5vdCB3aGF0IHlvdSB3YW50
Cj4gCj4gVGhpcyBwYXRjaCBkb2VzIGEgcXVpY2sgZml4IHRvIGdldCByaWQgb2YgdGhlIHdhcm5p
bmcuCgoKU3VyZS4KCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2FzcGFyIFpoYW5nIDxjYXNwYXJAY2Fz
cGFyemhhbmcuY29tPgoKUmV2aWV3ZWQtYnk6IFdhbmxvbmcgR2FvIDxnYW93YW5sb25nQGNuLmZ1
aml0c3UuY29tPgoKPiAtLS0KPiAgaW5jbHVkZS9zYWZlX21hY3Jvcy5oIHwgICAgMSArCj4gIDEg
ZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQo+IAo+IAo+IAo+
IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IFJTQShSKSBDb25mZXJlbmNlIDIwMTIKPiBTYXZl
ICQ3MDAgYnkgTm92IDE4Cj4gUmVnaXN0ZXIgbm93Cj4gaHR0cDovL3Auc2YubmV0L3NmdS9yc2Et
c2ZkZXYyZGV2MQo+IAo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gTHRwLWxpc3QgbWFpbGluZyBsaXN0Cj4gTHRwLWxpc3RAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbHRwLWxpc3QKCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClJTQShSKSBDb25mZXJlbmNlIDIw
MTIKU2F2ZSAkNzAwIGJ5IE5vdiAxOApSZWdpc3RlciBub3cKaHR0cDovL3Auc2YubmV0L3NmdS9y
c2Etc2ZkZXYyZGV2MQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
