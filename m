Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MF7My-0001df-Gu
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 14:04:36 +0000
Received: from yw-out-1718.google.com ([74.125.46.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF7Mx-0000QV-KO
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 14:04:36 +0000
Received: by yw-out-1718.google.com with SMTP id 5so1334122ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Jun 2009 07:04:35 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jun 2009 19:07:56 +0530
Message-ID: <f5a7b3810906120637o57b17fb2t189886a4929198fc@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f17b0f18c13046c26d038
Subject: [LTP] [FIX PATCH] POSIX aio_write/8-1.c
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

--001e680f17b0f18c13046c26d038
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed failures under
testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-1.c
and fixed.
Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-1.c	2009-06-12
18:08:40.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/8-1.c	2009-06-12
18:00:21.000000000 +0530
@@ -40,6 +40,7 @@
 #define BUF_SIZE 512
 	char buf[BUF_SIZE];
 	struct aiocb aiocb;
+	int ret=0;

 #if _POSIX_ASYNCHRONOUS_IO != 200112L
 	exit(PTS_UNSUPPORTED);
@@ -51,13 +52,21 @@
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

--001e680f17b0f18c13046c26d038
Content-Type: application/octet-stream; name="ltp-posix-aio_write_8-1.patch"
Content-Disposition: attachment; filename="ltp-posix-aio_write_8-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvuxyeqy0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9haW9fd3JpdGUvOC0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fd3JpdGUvOC0xLmMKLS0tIGEvdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX3dyaXRlLzgt
MS5jCTIwMDktMDYtMTIgMTg6MDg6NDAuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9v
cGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL2Fpb193cml0ZS84LTEu
YwkyMDA5LTA2LTEyIDE4OjAwOjIxLjAwMDAwMDAwMCArMDUzMApAQCAtNDAsNiArNDAsNyBAQAog
I2RlZmluZSBCVUZfU0laRSA1MTIKIAljaGFyIGJ1ZltCVUZfU0laRV07CiAJc3RydWN0IGFpb2Ni
IGFpb2NiOworCWludCByZXQ9MDsKIAogI2lmIF9QT1NJWF9BU1lOQ0hST05PVVNfSU8gIT0gMjAw
MTEyTAogCWV4aXQoUFRTX1VOU1VQUE9SVEVEKTsKQEAgLTUxLDEzICs1MiwyMSBAQAogCWFpb2Ni
LmFpb19idWYgPSBidWY7CiAJYWlvY2IuYWlvX25ieXRlcyA9IEJVRl9TSVpFOwogCi0JaWYgKGFp
b193cml0ZSgmYWlvY2IpICE9IC0xKQorCS8qCisJICogRUJBREYgaXMgZW5jb3VudGVyZWQgYXQg
YSBsYXRlciBzdGFnZQorCSAqIGFuZCBzaG91bGQgYmUgY29sbGVjdGVkIGJ5IGFpb19lcnJvcigp
CisJICovIAorCQorCWlmIChhaW9fd3JpdGUoJmFpb2NiKSAhPSAwKQogCXsKIAkJcHJpbnRmKFRO
QU1FICIgYmFkIGFpb193cml0ZSByZXR1cm4gdmFsdWUoKVxuIik7CiAJCWV4aXQoUFRTX0ZBSUwp
OwogCX0KIAotCWlmIChlcnJubyAhPSBFQkFERikKKwl3aGlsZSAoYWlvX2Vycm9yKCZhaW9jYikg
PT0gRUlOUFJPR1JFU1MpOworCXJldCA9IGFpb19lcnJvcigmYWlvY2IpOworCisJaWYgKHJldCAh
PSBFQkFERikKIAl7CiAJCXByaW50ZihUTkFNRSAiIGVycm5vIGlzIG5vdCBFQkFERiAlc1xuIiwg
c3RyZXJyb3IoZXJybm8pKTsKIAkJZXhpdChQVFNfRkFJTCk7Cg==
--001e680f17b0f18c13046c26d038
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
--001e680f17b0f18c13046c26d038
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f17b0f18c13046c26d038--

