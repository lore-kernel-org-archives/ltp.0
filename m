Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFIjh-0000nV-CT
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:26:25 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFIjg-0005Cx-Kj
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:26:25 +0000
Received: by pbcum15 with SMTP id um15so647287pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:26:18 -0700 (PDT)
Date: Tue, 3 Apr 2012 22:22:25 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204032220270.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="967339439-1832249950-1333516946=:25027"
Subject: [LTP] [PATCH 2/4] Install .awk files
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
To: ltp-list@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--967339439-1832249950-1333516946=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Install .awk files

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
  tools/Makefile |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


--------------1.7.9.4
Content-Type: text/x-patch; name="0002-Install-.awk-files.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-Install-.awk-files.patch"

diff --git a/tools/Makefile b/tools/Makefile
index bbc2c0b..dee4148 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -28,7 +28,7 @@ include $(top_srcdir)/include/mk/testcases.mk
  # reorganization..
  FILTER_OUT_DIRS		:= netpipe% pounder21 top-LTP

-INSTALL_TARGETS		:= *.pl *.sh html_report_header.txt
+INSTALL_TARGETS		:= *awk *.pl *.sh html_report_header.txt

  INSTALL_DIR		:= bin
--967339439-1832249950-1333516946=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=0002-Install-.awk-files.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204032222250.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment; filename=0002-Install-.awk-files.patch

RnJvbSA3NzI3OTNiNTFmZjQxZjVjNWYzYmExODQyMDY0OWFmY2VlYmNjOGMz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFR1ZSwgMyBBcHIgMjAx
MiAyMDoxMzoyMiAtMDcwMA0KU3ViamVjdDogW1BBVENIIDIvNF0gSW5zdGFs
bCAuYXdrIGZpbGVzDQpNSU1FLVZlcnNpb246IDEuMA0KQ29udGVudC1UeXBl
OiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSItLS0tLS0tLS0tLS0xLjcu
OS40Ig0KDQpUaGlzIGlzIGEgbXVsdGktcGFydCBtZXNzYWdlIGluIE1JTUUg
Zm9ybWF0Lg0KLS0tLS0tLS0tLS0tLS0xLjcuOS40DQpDb250ZW50LVR5cGU6
IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTg7IGZvcm1hdD1maXhlZA0KQ29u
dGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdA0KDQoNClNpZ25lZC1vZmYt
Ynk6IEdhcnJldHQgQ29vcGVyIDx5YW5lZ29taUBnbWFpbC5jb20+DQotLS0N
CiB0b29scy9NYWtlZmlsZSB8ICAgIDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KDQotLS0tLS0tLS0t
LS0tLTEuNy45LjQNCkNvbnRlbnQtVHlwZTogdGV4dC94LXBhdGNoOyBuYW1l
PSIwMDAyLUluc3RhbGwtLmF3ay1maWxlcy5wYXRjaCINCkNvbnRlbnQtVHJh
bnNmZXItRW5jb2Rpbmc6IDhiaXQNCkNvbnRlbnQtRGlzcG9zaXRpb246IGF0
dGFjaG1lbnQ7IGZpbGVuYW1lPSIwMDAyLUluc3RhbGwtLmF3ay1maWxlcy5w
YXRjaCINCg0KZGlmZiAtLWdpdCBhL3Rvb2xzL01ha2VmaWxlIGIvdG9vbHMv
TWFrZWZpbGUNCmluZGV4IGJiYzJjMGIuLmRlZTQxNDggMTAwNjQ0DQotLS0g
YS90b29scy9NYWtlZmlsZQ0KKysrIGIvdG9vbHMvTWFrZWZpbGUNCkBAIC0y
OCw3ICsyOCw3IEBAIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21r
L3Rlc3RjYXNlcy5taw0KICMgcmVvcmdhbml6YXRpb24uLg0KIEZJTFRFUl9P
VVRfRElSUwkJOj0gbmV0cGlwZSUgcG91bmRlcjIxIHRvcC1MVFANCiANCi1J
TlNUQUxMX1RBUkdFVFMJCTo9ICoucGwgKi5zaCBodG1sX3JlcG9ydF9oZWFk
ZXIudHh0DQorSU5TVEFMTF9UQVJHRVRTCQk6PSAqYXdrICoucGwgKi5zaCBo
dG1sX3JlcG9ydF9oZWFkZXIudHh0DQogDQogSU5TVEFMTF9ESVIJCTo9IGJp
bg0KIA0KDQotLS0tLS0tLS0tLS0tLTEuNy45LjQtLQ0KDQoNCg==

--967339439-1832249950-1333516946=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-1832249950-1333516946=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-1832249950-1333516946=:25027--

