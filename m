Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PYTin-0005Co-DF
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 01:23:57 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYTil-0006A0-W8
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 01:23:57 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBV1Nn2I004340
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Dec 2010 20:23:49 -0500
Date: Thu, 30 Dec 2010 20:23:49 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1971196114.100790.1293758629841.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <591220389.100787.1293758623717.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_100789_1064595553.1293758629840"
Subject: [LTP] [PATCH] cpuset01: fix pathname to remove underscore
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

------=_Part_100789_1064595553.1293758629840
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/cpuset/Makefile   |   25 +++++++++++++++++++++++++
 testcases/kernel/mem/cpuset/cpuset01.c |    6 +++---
 2 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/Makefile

diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
new file mode 100644
index 0000000..822e783
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= $(NUMA_LIBS) -lm
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 966e826..27e2d68 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -58,7 +58,7 @@ extern int Tst_count;
 #define MAXNODES		512
 #define CPATH			"/dev/cpuset"
 #define CPATH_NEW		"/dev/cpuset/1"
-#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+#define PATH_SYS_SYSTEM		"/sys/devices/system"
 
 static pid_t *pids;
 volatile int end;
@@ -298,7 +298,7 @@ long count_numa(void)
 {
 	int nnodes = 0;
 
-	while(path_exist(_PATH_SYS_SYSTEM "/node/node%d", nnodes))
+	while(path_exist(PATH_SYS_SYSTEM "/node/node%d", nnodes))
 		nnodes++;
 
 	return nnodes;
@@ -308,7 +308,7 @@ long count_cpu(void)
 {
 	int ncpus = 0;
 
-	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+	while(path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
 		ncpus++;
 
 	return ncpus;
-- 
1.7.3.2
------=_Part_100789_1064595553.1293758629840
Content-Type: text/x-patch;
	name=0001-cpuset01-fix-pathname-to-remove-underscore.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-cpuset01-fix-pathname-to-remove-underscore.patch

RnJvbSAzMWUzNDJhMzQyOTkxYzZkYmQ3Y2E0M2E0YzVlYzNlODM4MjI2ZDc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBG
cmksIDMxIERlYyAyMDEwIDA5OjA2OjI2ICswODAwClN1YmplY3Q6IFtQQVRDSF0gY3B1c2V0MDE6
IGZpeCBwYXRobmFtZSB0byByZW1vdmUgdW5kZXJzY29yZQoKClNpZ25lZC1vZmYtYnk6IENBSSBR
aWFuIDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vY3B1c2V0
L01ha2VmaWxlICAgfCAgIDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysKIHRlc3RjYXNlcy9r
ZXJuZWwvbWVtL2NwdXNldC9jcHVzZXQwMS5jIHwgICAgNiArKystLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvTWFrZWZpbGUKCmRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9jcHVzZXQvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVz
ZXQvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uODIyZTc4Mwot
LS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2NwdXNldC9NYWtlZmlsZQpA
QCAtMCwwICsxLDI1IEBACisjCisjICBDb3B5cmlnaHQgKEMpIDIwMTAgIFJlZCBIYXQsIEluYy4K
KyMKKyMgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5CisjICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5l
cmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorIyAgdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0CisjICB5
b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisjCisjICBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwgYnV0CisjICBXSVRI
T1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisj
ICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBT
ZWUgdGhlIEdOVQorIyAgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgor
IworIyAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UKKyMgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRl
IHRvIHRoZSBGcmVlIFNvZnR3YXJlCisjICBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBT
dHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BCisjICAwMjExMC0xMzAxLCBVU0EuCisjCisK
K3RvcF9zcmNkaXIgICAgICAgICAgICAgID89IC4uLy4uLy4uLy4uCisKK2luY2x1ZGUgJCh0b3Bf
c3JjZGlyKS9pbmNsdWRlL21rL3Rlc3RjYXNlcy5taworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2lu
Y2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5taworCitMRExJQlMgCQkJKz0gJChOVU1BX0xJ
QlMpIC1sbQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vY3B1c2V0L2NwdXNldDAx
LmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYwppbmRleCA5NjZlODI2
Li4yN2UyZDY4IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0
MDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYwpAQCAtNTgs
NyArNTgsNyBAQCBleHRlcm4gaW50IFRzdF9jb3VudDsKICNkZWZpbmUgTUFYTk9ERVMJCTUxMgog
I2RlZmluZSBDUEFUSAkJCSIvZGV2L2NwdXNldCIKICNkZWZpbmUgQ1BBVEhfTkVXCQkiL2Rldi9j
cHVzZXQvMSIKLSNkZWZpbmUgX1BBVEhfU1lTX1NZU1RFTQkiL3N5cy9kZXZpY2VzL3N5c3RlbSIK
KyNkZWZpbmUgUEFUSF9TWVNfU1lTVEVNCQkiL3N5cy9kZXZpY2VzL3N5c3RlbSIKIAogc3RhdGlj
IHBpZF90ICpwaWRzOwogdm9sYXRpbGUgaW50IGVuZDsKQEAgLTI5OCw3ICsyOTgsNyBAQCBsb25n
IGNvdW50X251bWEodm9pZCkKIHsKIAlpbnQgbm5vZGVzID0gMDsKIAotCXdoaWxlKHBhdGhfZXhp
c3QoX1BBVEhfU1lTX1NZU1RFTSAiL25vZGUvbm9kZSVkIiwgbm5vZGVzKSkKKwl3aGlsZShwYXRo
X2V4aXN0KFBBVEhfU1lTX1NZU1RFTSAiL25vZGUvbm9kZSVkIiwgbm5vZGVzKSkKIAkJbm5vZGVz
Kys7CiAKIAlyZXR1cm4gbm5vZGVzOwpAQCAtMzA4LDcgKzMwOCw3IEBAIGxvbmcgY291bnRfY3B1
KHZvaWQpCiB7CiAJaW50IG5jcHVzID0gMDsKIAotCXdoaWxlKHBhdGhfZXhpc3QoX1BBVEhfU1lT
X1NZU1RFTSAiL2NwdS9jcHUlZCIsIG5jcHVzKSkKKwl3aGlsZShwYXRoX2V4aXN0KFBBVEhfU1lT
X1NZU1RFTSAiL2NwdS9jcHUlZCIsIG5jcHVzKSkKIAkJbmNwdXMrKzsKIAogCXJldHVybiBuY3B1
czsKLS0gCjEuNy4zLjIKCg==
------=_Part_100789_1064595553.1293758629840
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_100789_1064595553.1293758629840
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_100789_1064595553.1293758629840--

