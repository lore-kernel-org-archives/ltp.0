Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PisJN-0001DB-9T
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 17:40:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PisJM-0008KE-2l
	for ltp-list@lists.sourceforge.net; Fri, 28 Jan 2011 17:40:41 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0SHeYal001803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 28 Jan 2011 12:40:34 -0500
Message-ID: <4D42FFBE.3080105@redhat.com>
Date: Sat, 29 Jan 2011 01:41:18 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030405090300030905070605"
Subject: [LTP] [PATCH] fix mail02,03 fail due to different sender names
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

This is a multi-part message in MIME format.
--------------030405090300030905070605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id
	p0SHeYal001803

Hi all, mail02 and mail03 tests non-existed host and non-existed
username in the test. However in some systems (at least in RHEL6),
they both fails because of the sender name of the returned letter is
"Mail Deliver System" instead of "Mail Delivery Subsys", which makes RC1
to be zero and fail the test. The patch fixes this issue.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/commands/mail/mail_tests.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/mail/mail_tests.sh
b/testcases/commands/mail/mail_tests.sh
index 53a5d90..c30e2c3 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -169,7 +169,7 @@ else
 		RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print match($3, "Mailer-Daemon")}'=
 \
 		    $LTPTMP/tst_mail.res)
 	else
-		RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print match($3 $4 $5,
"MailDeliverySubsys")}' \
+		RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print match($3 $4 $5,
"MailDelivery(Subsys|System)")}' \
 		    $LTPTMP/tst_mail.res)
 	fi

@@ -250,7 +250,7 @@ else
 		RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print match($3, "Mailer-Daemon")}'=
 \
 		    $LTPTMP/tst_mail.res)
 	else
-		RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print match($3 $4 $5,
"MailDeliverySubsys")}' \
+		RC1=3D$(awk '/^>N/ {IGNORECASE=3D1; print match($3 $4 $5,
"MailDelivery(Subsys|System)")}' \
 		    $LTPTMP/tst_mail.res)
 	fi
 	##################################################################
--=20
1.7.4.rc2


--=20
Quality Assurance Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch

TEL: +86-10-62608150
WEB: http://www.redhat.com/
--
C-A-S-P-A-R, Caspar /k=C3=A6sp=C9=91:/ ;-)

--------------030405090300030905070605
Content-Type: text/plain;
	name="0001-fix-mail02-03-fail-due-to-different-sender-names.patch"
Content-Disposition: attachment;
	filename*0="0001-fix-mail02-03-fail-due-to-different-sender-names.patch"
Content-Transfer-Encoding: base64

U3ViamVjdDogW1BBVENIXSBmaXggbWFpbDAyLDAzIGZhaWwgZHVlIHRvIGRpZmZlcmVudCBz
ZW5kZXIgbmFtZXMKCkhpIGFsbCwgbWFpbDAyIGFuZCBtYWlsMDMgdGVzdHMgbm9uLWV4aXN0
ZWQgaG9zdCBhbmQgbm9uLWV4aXN0ZWQKdXNlcm5hbWUgaW4gdGhlIHRlc3QuIEhvd2V2ZXIg
aW4gc29tZSBzeXN0ZW1zIChhdCBsZWFzdCBpbiBSSEVMNiksCnRoZXkgYm90aCBmYWlscyBi
ZWNhdXNlIG9mIHRoZSBzZW5kZXIgbmFtZSBvZiB0aGUgcmV0dXJuZWQgbGV0dGVyIGlzCiJN
YWlsIERlbGl2ZXIgU3lzdGVtIiBpbnN0ZWFkIG9mICJNYWlsIERlbGl2ZXJ5IFN1YnN5cyIs
IHdoaWNoIG1ha2VzIFJDMQp0byBiZSB6ZXJvIGFuZCBmYWlsIHRoZSB0ZXN0LiBUaGUgcGF0
Y2ggZml4ZXMgdGhpcyBpc3N1ZS4KClNpZ25lZC1vZmYtYnk6IENhc3BhciBaaGFuZyA8Y3po
YW5nQHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2NvbW1hbmRzL21haWwvbWFpbF90ZXN0
cy5zaCB8ICAgIDQgKystLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2NvbW1hbmRzL21haWwvbWFp
bF90ZXN0cy5zaCBiL3Rlc3RjYXNlcy9jb21tYW5kcy9tYWlsL21haWxfdGVzdHMuc2gKaW5k
ZXggNTNhNWQ5MC4uYzMwZTJjMyAxMDA3NTUKLS0tIGEvdGVzdGNhc2VzL2NvbW1hbmRzL21h
aWwvbWFpbF90ZXN0cy5zaAorKysgYi90ZXN0Y2FzZXMvY29tbWFuZHMvbWFpbC9tYWlsX3Rl
c3RzLnNoCkBAIC0xNjksNyArMTY5LDcgQEAgZWxzZQogCQlSQzE9JChhd2sgJy9ePk4vIHtJ
R05PUkVDQVNFPTE7IHByaW50IG1hdGNoKCQzLCAiTWFpbGVyLURhZW1vbiIpfScgXAogCQkg
ICAgJExUUFRNUC90c3RfbWFpbC5yZXMpCiAJZWxzZQotCQlSQzE9JChhd2sgJy9ePk4vIHtJ
R05PUkVDQVNFPTE7IHByaW50IG1hdGNoKCQzICQ0ICQ1LCAiTWFpbERlbGl2ZXJ5U3Vic3lz
Iil9JyBcCisJCVJDMT0kKGF3ayAnL14+Ti8ge0lHTk9SRUNBU0U9MTsgcHJpbnQgbWF0Y2go
JDMgJDQgJDUsICJNYWlsRGVsaXZlcnkoU3Vic3lzfFN5c3RlbSkiKX0nIFwKIAkJICAgICRM
VFBUTVAvdHN0X21haWwucmVzKQogCWZpCiAKQEAgLTI1MCw3ICsyNTAsNyBAQCBlbHNlCiAJ
CVJDMT0kKGF3ayAnL14+Ti8ge0lHTk9SRUNBU0U9MTsgcHJpbnQgbWF0Y2goJDMsICJNYWls
ZXItRGFlbW9uIil9JyBcCiAJCSAgICAkTFRQVE1QL3RzdF9tYWlsLnJlcykKIAllbHNlCi0J
CVJDMT0kKGF3ayAnL14+Ti8ge0lHTk9SRUNBU0U9MTsgcHJpbnQgbWF0Y2goJDMgJDQgJDUs
ICJNYWlsRGVsaXZlcnlTdWJzeXMiKX0nIFwKKwkJUkMxPSQoYXdrICcvXj5OLyB7SUdOT1JF
Q0FTRT0xOyBwcmludCBtYXRjaCgkMyAkNCAkNSwgIk1haWxEZWxpdmVyeShTdWJzeXN8U3lz
dGVtKSIpfScgXAogCQkgICAgJExUUFRNUC90c3RfbWFpbC5yZXMpCiAJZmkKIAkjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMKLS0gCjEuNy40LnJjMgoK
--------------030405090300030905070605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
--------------030405090300030905070605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030405090300030905070605--

