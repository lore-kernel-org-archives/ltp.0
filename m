Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MF6gc-0007YY-8o
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:20:50 +0000
Received: from mail-yx0-f186.google.com ([209.85.210.186])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF6gb-0005uY-FW
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:20:50 +0000
Received: by yxe16 with SMTP id 16so47334yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Jun 2009 06:20:48 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jun 2009 18:50:48 +0530
Message-ID: <f5a7b3810906120620r2e8a8e63t60b1d5cbf961d557@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f17b0a91a02046c269370
Subject: [LTP] [FIX PATCH] POSIX aio_cancel/3-1.c
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

--001e680f17b0a91a02046c269370
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed failures under
ltp/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
and fixed.
Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c	2005-06-03
22:00:17.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_cancel/3-1.c	2009-06-12
18:00:21.000000000 +0530
@@ -128,6 +128,7 @@
 		aiocb->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
 		aiocb->aio_sigevent.sigev_signo = SIGRTMIN+1;
 		aiocb->aio_sigevent.sigev_value.sival_ptr = aiocb;
+		aiocb->aio_reqprio = 0;

 		if (aio_write(aiocb) == -1)
 		{

--001e680f17b0a91a02046c269370
Content-Type: application/octet-stream; name="ltp-posix-aio_cancel_3-1.patch"
Content-Disposition: attachment; filename="ltp-posix-aio_cancel_3-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvuxcnu60

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9haW9fY2FuY2VsLzMtMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1
aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX2NhbmNlbC8zLTEuYwotLS0gYS90ZXN0Y2Fz
ZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fY2FuY2Vs
LzMtMS5jCTIwMDUtMDYtMDMgMjI6MDA6MTcuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNl
cy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL2Fpb19jYW5jZWwv
My0xLmMJMjAwOS0wNi0xMiAxODowMDoyMS4wMDAwMDAwMDAgKzA1MzAKQEAgLTEyOCw2ICsxMjgs
NyBAQAogCQlhaW9jYi0+YWlvX3NpZ2V2ZW50LnNpZ2V2X25vdGlmeSA9IFNJR0VWX1NJR05BTDsK
IAkJYWlvY2ItPmFpb19zaWdldmVudC5zaWdldl9zaWdubyA9IFNJR1JUTUlOKzE7CiAJCWFpb2Ni
LT5haW9fc2lnZXZlbnQuc2lnZXZfdmFsdWUuc2l2YWxfcHRyID0gYWlvY2I7CisJCWFpb2NiLT5h
aW9fcmVxcHJpbyA9IDA7CiAKIAkJaWYgKGFpb193cml0ZShhaW9jYikgPT0gLTEpCiAJCXsK
--001e680f17b0a91a02046c269370
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
--001e680f17b0a91a02046c269370
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f17b0a91a02046c269370--

