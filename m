Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1Wf3ej-0006gu-3I
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 08:44:49 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wf3ei-0002pi-3k
	for ltp-list@lists.sourceforge.net; Tue, 29 Apr 2014 08:44:49 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3T8ifZA012551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Apr 2014 08:44:42 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s3T8ietE006684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Apr 2014 08:44:41 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3T8ieHI001223
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Apr 2014 08:44:40 GMT
From: shuang.qiu@oracle.com
Date: Tue, 29 Apr 2014 16:44:26 +0800
Message-Id: <1398761066-3840-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] syscalls/clone08: Skip test_clone_stopped after
	kernel 2.6.25
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

RnJvbTogU2h1YW5nIFFpdSA8c2h1YW5nLnFpdUBvcmFjbGUuY29tPgoKQWNjb3JkaW5nIHRvIENM
T05FIG1hbnVhbCBwYWdlICJGcm9tIExpbnV4IDIuNi4yNSB0aGlzIGZsYWcgaXMKZGVwcmVjYXRl
ZC5Zb3UgcHJvYmFibHkgbmV2ZXIgd2FudGVkIHRvIHVzZSBpdCwgeW91IGNlcnRhaW5seSBzaG91
bGRu4oCZdApiZSB1c2luZyBpdCwgIGFuZCAgc29vbiAgaXQgIHdpbGwgIGdvIGF3YXkiLHNraXAg
dGVzdF9jbG9uZV9zdG9wcGVkCmFmdGVyIGtlcm5lbCAyLjYuMjUuCgpTaWduZWQtb2ZmLWJ5OiBT
aHVhbmcgUWl1IDxzaHVhbmcucWl1QG9yYWNsZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9jbG9uZS9jbG9uZTA4LmMgfCAgICA5ICsrKysrKysrKwogMSBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTA4LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Nsb25lL2Nsb25lMDguYwppbmRleCAxNGViZjYwLi42MTA5ODZkIDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMDguYworKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMDguYwpAQCAtODQsMTUgKzg0LDI0IEBAIGludCBt
YWluKGludCBhYywgY2hhciAqKmF2KQogewogCWNoYXIgKm1zZzsKIAlpbnQgaSwgbGM7CisJaW50
IGNsb25lX3N0b3BwZWQgPSAwOwogCiAJbXNnID0gcGFyc2Vfb3B0cyhhYywgYXYsIE5VTEwsIE5V
TEwpOwogCWlmIChtc2cgIT0gTlVMTCkKIAkJdHN0X2Jya20oVEJST0ssIE5VTEwsICJPUFRJT04g
UEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsKIAogCXNldHVwKCk7CisKKyNpZmRlZiBDTE9ORV9T
VE9QUEVECisJaWYgKHRzdF9rdmVyY21wKDIsIDYsIDI1KSA+IDApCisJCWNsb25lX3N0b3BwZWQg
PTE7CisjZW5kaWYKKwkJCiAJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsK
IAkJdHN0X2NvdW50ID0gMDsKIAkJZm9yIChpID0gMDsgaSA8IFRTVF9UT1RBTDsgaSsrKSB7CisJ
CQlpZiAoY2xvbmVfc3RvcHBlZCA9PSAxICYmIGkgPT0zKQorCQkJCWNvbnRpbnVlOwogCQkJdHN0
X3Jlc20oVElORk8sICJydW5uaW5nICVzIiwgdGVzdF9jYXNlc1tpXS5uYW1lKTsKIAkJCXRlc3Rf
Y2FzZXNbaV0udGVzdGZ1bmMoaSk7CiAJCX0KLS0gCjEuNy43CgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiJBY2NlbGVyYXRlIERldiBDeWNsZXMgd2l0aCBBdXRvbWF0ZWQgQ3Jvc3MtQnJvd3NlciBU
ZXN0aW5nIC0gRm9yIEZSRUUKSW5zdGFudGx5IHJ1biB5b3VyIFNlbGVuaXVtIHRlc3RzIGFjcm9z
cyAzMDArIGJyb3dzZXIvT1MgY29tYm9zLiAgR2V0IAp1bnBhcmFsbGVsZWQgc2NhbGFiaWxpdHkg
ZnJvbSB0aGUgYmVzdCBTZWxlbml1bSB0ZXN0aW5nIHBsYXRmb3JtIGF2YWlsYWJsZS4KU2ltcGxl
IHRvIHVzZS4gTm90aGluZyB0byBpbnN0YWxsLiBHZXQgc3RhcnRlZCBub3cgZm9yIGZyZWUuIgpo
dHRwOi8vcC5zZi5uZXQvc2Z1L1NhdWNlTGFicwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMu
c291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3Rp
bmZvL2x0cC1saXN0Cg==
