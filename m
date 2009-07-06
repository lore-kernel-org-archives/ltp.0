Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MNvpv-0000Ge-IT
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:34:55 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNvpn-0006wI-A6
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 21:34:55 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 2FEFC1AF40
	for <ltp-list@lists.sourceforge.net>;
	Mon,  6 Jul 2009 14:34:46 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9FE81.7FD78E28"
Date: Mon, 6 Jul 2009 14:34:08 -0700
Message-ID: <8368651DACC1964480F951191B94A078D0102F@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] controllers/cpuset tests: use CC variable isntead of
	hardcoded cc to fix cross compiling
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

------_=_NextPart_001_01C9FE81.7FD78E28
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am submitting patches for the Makefiles of the following tests: =
cpuset_memory_pressure_test, cpuset_memory_spread_test , and =
cpuset_memory_test. Instead of using cc (host compiler), use $(CC) for =
provide for cross compiling.

Henry Yei
MontaVista Software, Inc.
hyei@mvista.com


=20

------_=_NextPart_001_01C9FE81.7FD78E28
Content-Type: application/octet-stream;
	name="cpuset_memory_test-Makefile.patch"
Content-Transfer-Encoding: base64
Content-Description: cpuset_memory_test-Makefile.patch
Content-Disposition: attachment; filename="cpuset_memory_test-Makefile.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0
L2NwdXNldF9tZW1vcnlfdGVzdC9NYWtlZmlsZQkyMDA5LTA1LTExIDAzOjAyOjQ3LjAwMDAwMDAw
MCAtMDcwMAorKysgbHRwL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNl
dF9tZW1vcnlfdGVzdC9NYWtlZmlsZQkyMDA5LTA3LTA2IDE0OjI3OjM1LjU1Mzg0ODgwMCAtMDcw
MApAQCAtNiw3ICs2LDcgQEAKIGFsbDogY3B1c2V0X21lbW9yeV90ZXN0CiAKIGNwdXNldF9tZW1v
cnlfdGVzdDogY3B1c2V0X21lbW9yeV90ZXN0Lm8gJChMSUJPQkpFQ1RTKQotCWNjIGNwdXNldF9t
ZW1vcnlfdGVzdC5vICQoTElCT0JKRUNUUykgLW8gY3B1c2V0X21lbW9yeV90ZXN0IC1scHRocmVh
ZAorCSQoQ0MpIGNwdXNldF9tZW1vcnlfdGVzdC5vICQoTElCT0JKRUNUUykgLW8gY3B1c2V0X21l
bW9yeV90ZXN0IC1scHRocmVhZAogCiBjbGVhbjoKIAlybSAtZiBjcHVzZXRfbWVtb3J5X3Rlc3Qg
Y3B1c2V0X21lbW9yeV90ZXN0Lm8K

------_=_NextPart_001_01C9FE81.7FD78E28
Content-Type: application/octet-stream;
	name="cpuset_memory_spread_test-Makefile.patch"
Content-Transfer-Encoding: base64
Content-Description: cpuset_memory_spread_test-Makefile.patch
Content-Disposition: attachment;
	filename="cpuset_memory_spread_test-Makefile.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0
L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3QvTWFrZWZpbGUJMjAwOS0wNS0xMSAwMzowMjo0Ny4w
MDAwMDAwMDAgLTA3MDAKKysrIGx0cC90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNl
dC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0L01ha2VmaWxlCTIwMDktMDctMDYgMTQ6Mjc6MTAu
Njk0NzkyMDAwIC0wNzAwCkBAIC0zLDcgKzMsNyBAQAogYWxsOiBjcHVzZXRfbWVtX2hvZwogCiBj
cHVzZXRfbWVtX2hvZzogY3B1c2V0X21lbV9ob2cubwotCWNjIGNwdXNldF9tZW1faG9nLm8gLW8g
Y3B1c2V0X21lbV9ob2cKKwkkKENDKSBjcHVzZXRfbWVtX2hvZy5vIC1vIGNwdXNldF9tZW1faG9n
CiAKIGNsZWFuOgogCXJtIC1mIGNwdXNldF9tZW1faG9nLm8gY3B1c2V0X21lbV9ob2cK

------_=_NextPart_001_01C9FE81.7FD78E28
Content-Type: application/octet-stream;
	name="cpuset_memory_pressure_test-Makefile.patch"
Content-Transfer-Encoding: base64
Content-Description: cpuset_memory_pressure_test-Makefile.patch
Content-Disposition: attachment;
	filename="cpuset_memory_pressure_test-Makefile.patch"

LS0tIGx0cC1mdWxsLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0
L2NwdXNldF9tZW1vcnlfcHJlc3N1cmVfdGVzdC9NYWtlZmlsZQkyMDA5LTA1LTExIDAzOjAyOjQ3
LjAwMDAwMDAwMCAtMDcwMAorKysgbHRwL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1
c2V0L2NwdXNldF9tZW1vcnlfcHJlc3N1cmVfdGVzdC9NYWtlZmlsZQkyMDA5LTA3LTA2IDE0OjI2
OjI3Ljc4OTA5MTIwMCAtMDcwMApAQCAtMyw3ICszLDcgQEAKIGFsbDogY3B1c2V0X21lbW9yeV9w
cmVzc3VyZQogCiBjcHVzZXRfbWVtb3J5X3ByZXNzdXJlOiBjcHVzZXRfbWVtb3J5X3ByZXNzdXJl
Lm8KLQljYyBjcHVzZXRfbWVtb3J5X3ByZXNzdXJlLm8gLW8gY3B1c2V0X21lbW9yeV9wcmVzc3Vy
ZQorCSQoQ0MpIGNwdXNldF9tZW1vcnlfcHJlc3N1cmUubyAtbyBjcHVzZXRfbWVtb3J5X3ByZXNz
dXJlCiAKIGNsZWFuOgogCXJtIC1mIGNwdXNldF9tZW1vcnlfcHJlc3N1cmUubyBjcHVzZXRfbWVt
b3J5X3ByZXNzdXJlCg==

------_=_NextPart_001_01C9FE81.7FD78E28
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------_=_NextPart_001_01C9FE81.7FD78E28
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01C9FE81.7FD78E28--

