Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfD1O-0006BC-OL
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:58:58 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfD1N-0001oh-Hg
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:58:58 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IEwpOZ031938
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 09:58:51 -0500
Date: Tue, 18 Jan 2011 09:58:51 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1959408122.37181.1295362731739.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <317848093.37178.1295362728341.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37180_1447275492.1295362731739"
Subject: [LTP] [PATCH 3/3] add a missing Makefile
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_37180_1447275492.1295362731739
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/lib/Makefile |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/lib/Makefile

diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib/Makefile
new file mode 100644
index 0000000..dd978a7
--- /dev/null
+++ b/testcases/kernel/mem/lib/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LIB			:= libmem.a
+
+include $(top_srcdir)/include/mk/lib.mk
-- 
1.7.3.2
------=_Part_37180_1447275492.1295362731739
Content-Type: text/x-patch; name=0003-add-a-missing-Makefile.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0003-add-a-missing-Makefile.patch

RnJvbSBiYWQyYWFjZDZjNzU3YjI2Nzg4ZGJiMmNkMmI5ZTdhOWYwM2Q4MThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDE3OjIzOjQ0ICswODAwClN1YmplY3Q6IFtQQVRDSCAzLzNdIGFkZCBh
IG1pc3NpbmcgTWFrZWZpbGUKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRo
YXQuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9NYWtlZmlsZSB8ICAgMjUgKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVt
L2xpYi9NYWtlZmlsZQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9NYWtl
ZmlsZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEw
MDY0NAppbmRleCAwMDAwMDAwLi5kZDk3OGE3Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vbGliL01ha2VmaWxlCkBAIC0wLDAgKzEsMjUgQEAKKyMKKyMgIENvcHlyaWdo
dCAoQykgMjAxMCAgUmVkIEhhdCwgSW5jLgorIworIyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisjICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQorIyAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3IKKyMgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisjCisjICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3
aWxsIGJlIHVzZWZ1bCwKKyMgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorIyAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlCisjICB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZl
ZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisjICBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyMgIEZv
dW5kYXRpb24sIEluYy4sIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BIDAy
MTExLTEzMDcgVVNBCisjCisKK3RvcF9zcmNkaXIgICAgICAgICAgICAgID89IC4uLy4uLy4uLy4u
CisKK2luY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2Vudl9wcmUubWsKKworTElCCQkJ
Oj0gbGlibWVtLmEKKworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvbGliLm1rCi0t
IAoxLjcuMy4yCgo=
------=_Part_37180_1447275492.1295362731739
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_37180_1447275492.1295362731739
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37180_1447275492.1295362731739--

