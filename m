Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MJbQT-0001pY-KT
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 22:58:45 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJbQS-00083x-D5
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 22:58:45 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 409911AE67
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jun 2009 15:58:43 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9F51F.52524799"
Date: Wed, 24 Jun 2009 15:58:41 -0700
Message-ID: <8368651DACC1964480F951191B94A078BC0F0A@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] (no subject)
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

------_=_NextPart_001_01C9F51F.52524799
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Submitting a patch for the splice01 test. Previously the test was =
checking if the current working directory was NFS based as which the =
test. The patch changes this test to check whether the test directory is =
on NFS, as that is actually where the test gets run.=20

Henry Yei (QA)
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01C9F51F.52524799
Content-Type: application/octet-stream;
	name="splice01.patch"
Content-Transfer-Encoding: base64
Content-Description: splice01.patch
Content-Disposition: attachment;
	filename="splice01.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNlL3Nw
bGljZTAxLmMJMjAwOS0wMy0yMyAwNjozNjowNi4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9zcGxpY2UwMS5jCTIwMDktMDYtMjMgMTM6Mzc6
MzEuMDE3MzMzNjAwIC0wNzAwCkBAIC05NiwxMiArOTYsMTQgQEAKIAlzZXR1cCgpOwogCiAJLyoK
LQkgKiBjaGVjayBpZiB0aGUgY3VycmVudCBmaWxlc3lzdGVtIGlzIG5mcworCSAqIGNoZWNrIGlm
IHRoZSBjdXJyZW50IGZpbGVzeXN0ZW0gb2YgdGhlIHRlc3QgZGlyZWN0b3J5IGlzIG5mcwogCSAq
LworCXRzdF90bXBkaXIoKTsKIAlpZiAodHN0X2lzX2N3ZF9uZnMoKSkgewogCQl0c3RfYnJrbShU
Q09ORiwgY2xlYW51cCwKIAkJCSAiQ2Fubm90IGRvIHNwbGljZSBvbiBhIGZpbGUgbG9jYXRlZCBv
biBhbiBORlMgZmlsZXN5c3RlbSIpOwogCX0KKwl0c3Rfcm1kaXIoKTsKIAogCS8qCiAJICogY2hl
Y2sgbG9vcGluZyBzdGF0ZSBpZiAtYyBvcHRpb24gZ2l2ZW4K

------_=_NextPart_001_01C9F51F.52524799
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------_=_NextPart_001_01C9F51F.52524799
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01C9F51F.52524799--

