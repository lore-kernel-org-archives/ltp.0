Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <wangyong2009@cn.fujitsu.com>) id 1MOpMh-0006QK-0d
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 08:52:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOpMZ-0007SC-2l
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 08:52:26 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id B9A20170130
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2009 15:46:45 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n6983A8r003478
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2009 16:03:10 +0800
Received: from [127.0.0.1] (unknown [10.167.141.107])
	by fnst.cn.fujitsu.com (Postfix) with ESMTP id D97C5D4036
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2009 15:34:11 +0800 (CST)
Message-ID: <4A559DB3.6030000@cn.fujitsu.com>
Date: Thu, 09 Jul 2009 15:35:15 +0800
From: Wang Yong <wangyong2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] Fix failure of the utimes01 test
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

V2hlbmV2ZXIgc3lzdGVtIGNhbGxlZCB1dGltZXMsIHRoZSBlcnJvciBtZXNzYWdlIHJldHVybmVk
IHdhcyBFSU5WQUwsCmJlY2F1c2UgdGhlIG1lbWJlciB2YXJpYWJsZSBvZiBzdHJ1Y3QgdGltZXZh
bCB3YXMgbm90IGluaXRpYWxpemVkLApzbyBpbml0aWFsaXplIGl0LgoKU2lnbmVkLW9mZi1ieTrj
gIBXYW5nWW9uZ+OAgDx3YW5neW9uZzIwMDlAY24uZnVqaXRzdS5jb20+CgpkaWZmIC1OdXJwIGx0
cC1mdWxsLTIwMDkwNjMwL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVzL3V0aW1lczAx
LmMKbHRwLWZ1bGwtMjAwOTA2MzAubmV3L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVz
L3V0aW1lczAxLmMKLS0tIGx0cC5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVz
L3V0aW1lczAxLmMgMjAwOS0wNy0wMQoxNzoyMDoxMi4wMDAwMDAwMDAgKzA4MDAKKysrIGx0cC90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1lcy91dGltZXMwMS5jICAyMDA5LTA3LTA4CjE3
OjIwOjM4LjAwMDAwMDAwMCArMDgwMApAQCAtMjQ4LDYgKzI0OCw3IEBAIHN0YXRpYyBpbnQgZG9f
dGVzdChzdHJ1Y3QgdGVzdF9jYXNlICp0YykKICAgICAgICAgIC8qCiAgICAgICAgICAgKiBFeGVj
dXRlIHN5c3RlbSBjYWxsCiAgICAgICAgICAgKi8KKyAgICAgICAgbWVtc2V0KHR2LCAwLCAyICog
c2l6ZW9mKHN0cnVjdCB0aW1ldmFsKSk7CiAgICAgICAgICB0dlswXS50dl9zZWMgPSB0Yy0+YV9z
ZWM7CiAgICAgICAgICB0dlsxXS50dl9zZWMgPSB0Yy0+bV9zZWM7CiAgICAgICAgICBURVNUKGxl
biA9IHN0cmxlbihmcGF0aCkpOwoKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRW50ZXIgdGhlIEJs
YWNrQmVycnkgRGV2ZWxvcGVyIENoYWxsZW5nZSAgClRoaXMgaXMgeW91ciBjaGFuY2UgdG8gd2lu
IHVwIHRvICQxMDAsMDAwIGluIHByaXplcyEgRm9yIGEgbGltaXRlZCB0aW1lLCAKdmVuZG9ycyBz
dWJtaXR0aW5nIG5ldyBhcHBsaWNhdGlvbnMgdG8gQmxhY2tCZXJyeSBBcHAgV29ybGQoVE0pIHdp
bGwgaGF2ZQp0aGUgb3Bwb3J0dW5pdHkgdG8gZW50ZXIgdGhlIEJsYWNrQmVycnkgRGV2ZWxvcGVy
IENoYWxsZW5nZS4gU2VlIGZ1bGwgcHJpemUgIApkZXRhaWxzIGF0OiBodHRwOi8vcC5zZi5uZXQv
c2Z1L0NoYWxsZW5nZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
