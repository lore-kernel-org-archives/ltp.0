Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vz2JY-0000yI-G0
	for ltp-list@lists.sourceforge.net; Fri, 03 Jan 2014 10:49:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vz2JX-0007Aj-Om
	for ltp-list@lists.sourceforge.net; Fri, 03 Jan 2014 10:49:16 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s03An8KJ012936
	for <ltp-list@lists.sourceforge.net>; Fri, 3 Jan 2014 18:49:09 +0800
Message-ID: <1388746143.1609.19.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 03 Jan 2014 18:49:03 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] dup3/dup3_02.c: fix O_CLOEXEC undeclared
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
To: ltp-list <ltp-list@lists.sourceforge.net>

T19DTE9FWEVDIGlzIG5vdCBkZWZpbmVkIGluIFJIRUw1LiBXaGVuIGV4ZWN1dGUgbWFrZSwKImR1
cDNfMDIuYzo1NTogZXJyb3I6IOKAmE9fQ0xPRVhFQ+KAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBp
biBhIGZ1bmN0aW9uKSIKd2lsbCBiZSBvdXRwdXRlZC4KClNpZ25lZC1vZmYtYnk6IFplbmcgTGlu
Z2dhbmcgPHplbmdsZy5qeUBjbi5mdWppdHN1LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2R1cDMvZHVwM18wMi5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2R1cDMvZHVwM18w
Mi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kdXAzL2R1cDNfMDIuYwppbmRleCAwNDAx
ZGRjLi45ZDVlZjE1IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2R1cDMv
ZHVwM18wMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZHVwMy9kdXAzXzAyLmMK
QEAgLTM3LDYgKzM3LDkgQEAKICNpbmNsdWRlICJzYWZlX21hY3Jvcy5oIgogI2luY2x1ZGUgImxp
bnV4X3N5c2NhbGxfbnVtYmVycy5oIgogCisjaWZuZGVmIE9fQ0xPRVhFQworIyBkZWZpbmUgT19D
TE9FWEVDIDAyMDAwMDAwCisjZW5kaWYKIAogc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7CiBzdGF0
aWMgdm9pZCBjbGVhbnVwKHZvaWQpOwotLSAKMS44LjIuMQoKCgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tClJhcGlkbHkgdHJvdWJsZXNob290IHByb2JsZW1zIGJlZm9yZSB0aGV5IGFmZmVjdCB5b3Vy
IGJ1c2luZXNzLiBNb3N0IElUIApvcmdhbml6YXRpb25zIGRvbid0IGhhdmUgYSBjbGVhciBwaWN0
dXJlIG9mIGhvdyBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZSAKYWZmZWN0cyB0aGVpciByZXZlbnVl
LiBXaXRoIEFwcER5bmFtaWNzLCB5b3UgZ2V0IDEwMCUgdmlzaWJpbGl0eSBpbnRvIHlvdXIgCkph
dmEsLk5FVCwgJiBQSFAgYXBwbGljYXRpb24uIFN0YXJ0IHlvdXIgMTUtZGF5IEZSRUUgVFJJQUwg
b2YgQXBwRHluYW1pY3MgUHJvIQpodHRwOi8vcHViYWRzLmcuZG91YmxlY2xpY2submV0L2dhbXBh
ZC9jbGs/aWQ9ODQzNDk4MzEmaXU9LzQxNDAvb3N0Zy5jbGt0cmsKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1s
aXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
