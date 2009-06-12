Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MF7On-0001Sk-HW
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 14:06:29 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF7Om-0005lN-Mp
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 14:06:29 +0000
Received: by gxk3 with SMTP id 3so9349758gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Jun 2009 07:06:28 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jun 2009 19:10:21 +0530
Message-ID: <f5a7b3810906120640u7a290abcrd8fa52c36d82f754@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f119890a28e046c26d972
Subject: [LTP] [FIX PATCH] POSIX aio_write/8-2.c
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
Cc: maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, rohit.170309@gmail.com, naresh.kernel@gmail.com

--001e680f119890a28e046c26d972
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed failures under
testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
and fixed.
Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c	2009-06-12
18:10:32.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-2.c	2009-06-12
18:00:21.000000000 +0530
@@ -42,6 +42,7 @@
 	char buf[BUF_SIZE];
 	int fd;
 	struct aiocb aiocb;
+	int ret=0;

 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -67,13 +68,21 @@
 	aiocb.aio_buf = buf;
 	aiocb.aio_nbytes = BUF_SIZE;

-	if (aio_write(&aiocb) != -1)
+	/*
+	 * EBADF is encountered at a later stage
+	 * and should be collected by aio_error()
+	 */
+	
+	if (aio_write(&aiocb) != 0)
 	{
 		printf(TNAME " bad aio_write return value()\n");
 		exit(PTS_FAIL);
 	}

-	if (errno != EBADF)
+	while (aio_error(&aiocb) == EINPROGRESS);
+	ret = aio_error(&aiocb);
+	
+	if (ret != EBADF)
 	{
 		printf(TNAME " errno is not EBADF %s\n", strerror(errno));
 		exit(PTS_FAIL);

--001e680f119890a28e046c26d972
Content-Type: application/octet-stream; name="ltp-posix-aio_write_8-2.patch"
Content-Disposition: attachment; filename="ltp-posix-aio_write_8-2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvuy40eo0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9haW9fd3JpdGUvOC0yLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fd3JpdGUvOC0yLmMKLS0tIGEvdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX3dyaXRlLzgt
Mi5jCTIwMDktMDYtMTIgMTg6MTA6MzIuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9v
cGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL2Fpb193cml0ZS84LTIu
YwkyMDA5LTA2LTEyIDE4OjAwOjIxLjAwMDAwMDAwMCArMDUzMApAQCAtNDIsNiArNDIsNyBAQAog
CWNoYXIgYnVmW0JVRl9TSVpFXTsKIAlpbnQgZmQ7CiAJc3RydWN0IGFpb2NiIGFpb2NiOworCWlu
dCByZXQ9MDsKIAogI2lmIF9QT1NJWF9BU1lOQ0hST05PVVNfSU8gIT0gMjAwMTEyTAogCWV4aXQo
UFRTX1VOU1VQUE9SVEVEKTsKQEAgLTY3LDEzICs2OCwyMSBAQAogCWFpb2NiLmFpb19idWYgPSBi
dWY7CiAJYWlvY2IuYWlvX25ieXRlcyA9IEJVRl9TSVpFOwogCi0JaWYgKGFpb193cml0ZSgmYWlv
Y2IpICE9IC0xKQorCS8qCisJICogRUJBREYgaXMgZW5jb3VudGVyZWQgYXQgYSBsYXRlciBzdGFn
ZQorCSAqIGFuZCBzaG91bGQgYmUgY29sbGVjdGVkIGJ5IGFpb19lcnJvcigpCisJICovIAorCQor
CWlmIChhaW9fd3JpdGUoJmFpb2NiKSAhPSAwKQogCXsKIAkJcHJpbnRmKFROQU1FICIgYmFkIGFp
b193cml0ZSByZXR1cm4gdmFsdWUoKVxuIik7CiAJCWV4aXQoUFRTX0ZBSUwpOwogCX0KIAotCWlm
IChlcnJubyAhPSBFQkFERikKKwl3aGlsZSAoYWlvX2Vycm9yKCZhaW9jYikgPT0gRUlOUFJPR1JF
U1MpOworCXJldCA9IGFpb19lcnJvcigmYWlvY2IpOworCQorCWlmIChyZXQgIT0gRUJBREYpCiAJ
ewogCQlwcmludGYoVE5BTUUgIiBlcnJubyBpcyBub3QgRUJBREYgJXNcbiIsIHN0cmVycm9yKGVy
cm5vKSk7CiAJCWV4aXQoUFRTX0ZBSUwpOwo=
--001e680f119890a28e046c26d972
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--001e680f119890a28e046c26d972
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f119890a28e046c26d972--

