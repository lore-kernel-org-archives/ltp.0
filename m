Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFVff-0001uj-BD
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 19:15:07 +0000
Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFVfe-0003B5-NT
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 19:15:07 +0000
Received: by vbbfr13 with SMTP id fr13so728652vbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 12:15:01 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 4 Apr 2012 12:15:01 -0700
Message-ID: <CAGH67wR5EdvGqHN60n=gRYXz0qV5MWQ2PX_mTdE4e5DssZ4cvw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=20cf3071c7e06f559704bcdf3da0
Subject: [LTP] [PATCH 2/4 v2]
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
To: LTP list <ltp-list@lists.sourceforge.net>

--20cf3071c7e06f559704bcdf3da0
Content-Type: text/plain; charset=ISO-8859-1

Install .awk files

The previous patch would have globbed all files that ended in ``awk``.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
 tools/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


--------------1.7.2.5
Content-Type: text/x-patch; name="0001-Install-.awk-files.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-Install-.awk-files.patch"

diff --git a/tools/Makefile b/tools/Makefile
index bbc2c0b..efd68a0 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -28,7 +28,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 # reorganization..
 FILTER_OUT_DIRS		:= netpipe% pounder21 top-LTP

-INSTALL_TARGETS		:= *.pl *.sh html_report_header.txt
+INSTALL_TARGETS		:= *.awk *.pl *.sh html_report_header.txt

 INSTALL_DIR		:= bin

--20cf3071c7e06f559704bcdf3da0
Content-Type: application/octet-stream; name="0002-Install-.awk-files.patch"
Content-Disposition: attachment; filename="0002-Install-.awk-files.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0mra2u30

RnJvbSA0MjVlOGYxN2Y5NjllOWQwMjJiN2Y1YTI3MTRiZmFmZGVhMDQwODRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHYXJyZXR0IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDMgQXByIDIwMTIgMjA6MTM6MjIgLTA3MDAKU3ViamVjdDogW1BBVENIIDEvM10g
SW5zdGFsbCAuYXdrIGZpbGVzCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogbXVsdGlw
YXJ0L21peGVkOyBib3VuZGFyeT0iLS0tLS0tLS0tLS0tMS43LjIuNSIKClRoaXMgaXMgYSBtdWx0
aS1wYXJ0IG1lc3NhZ2UgaW4gTUlNRSBmb3JtYXQuCi0tLS0tLS0tLS0tLS0tMS43LjIuNQpDb250
ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTg7IGZvcm1hdD1maXhlZApDb250ZW50
LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgoKU2lnbmVkLW9mZi1ieTogR2FycmV0dCBDb29wZXIg
PHlhbmVnb21pQGdtYWlsLmNvbT4KLS0tCiB0b29scy9NYWtlZmlsZSB8ICAgIDIgKy0KIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKCi0tLS0tLS0tLS0t
LS0tMS43LjIuNQpDb250ZW50LVR5cGU6IHRleHQveC1wYXRjaDsgbmFtZT0iMDAwMS1JbnN0YWxs
LS5hd2stZmlsZXMucGF0Y2giCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKQ29udGVu
dC1EaXNwb3NpdGlvbjogYXR0YWNobWVudDsgZmlsZW5hbWU9IjAwMDEtSW5zdGFsbC0uYXdrLWZp
bGVzLnBhdGNoIgoKZGlmZiAtLWdpdCBhL3Rvb2xzL01ha2VmaWxlIGIvdG9vbHMvTWFrZWZpbGUK
aW5kZXggYmJjMmMwYi4uZWZkNjhhMCAxMDA2NDQKLS0tIGEvdG9vbHMvTWFrZWZpbGUKKysrIGIv
dG9vbHMvTWFrZWZpbGUKQEAgLTI4LDcgKzI4LDcgQEAgaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2lu
Y2x1ZGUvbWsvdGVzdGNhc2VzLm1rCiAjIHJlb3JnYW5pemF0aW9uLi4KIEZJTFRFUl9PVVRfRElS
UwkJOj0gbmV0cGlwZSUgcG91bmRlcjIxIHRvcC1MVFAKIAotSU5TVEFMTF9UQVJHRVRTCQk6PSAq
LnBsICouc2ggaHRtbF9yZXBvcnRfaGVhZGVyLnR4dAorSU5TVEFMTF9UQVJHRVRTCQk6PSAqLmF3
ayAqLnBsICouc2ggaHRtbF9yZXBvcnRfaGVhZGVyLnR4dAogCiBJTlNUQUxMX0RJUgkJOj0gYmlu
CiAKCi0tLS0tLS0tLS0tLS0tMS43LjIuNS0tCgoK
--20cf3071c7e06f559704bcdf3da0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--20cf3071c7e06f559704bcdf3da0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--20cf3071c7e06f559704bcdf3da0--

