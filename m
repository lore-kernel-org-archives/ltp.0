Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MF6oX-0008MP-4q
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:29:01 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF6oV-0002Je-4Z
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:29:01 +0000
Received: by gxk3 with SMTP id 3so9255988gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Jun 2009 06:28:58 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jun 2009 18:58:57 +0530
Message-ID: <f5a7b3810906120628g793d0bd6xea608e96690a70c7@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f173cd2f2c3046c26b088
Subject: [LTP] [FIX PATCH] POSIX aio_error/3-1.c
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

--001e680f173cd2f2c3046c26b088
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed failures under
testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
and fixed.
Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2009-06-12
18:03:14.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c	2009-06-12
18:00:21.000000000 +0530
@@ -36,29 +36,55 @@

 int main()
 {
-	struct aiocb bad;
-	int ret;
+
+        char tmpfname[256];
+#define BUF_SIZE 512
+        char buf[BUF_SIZE];
+        int fd;
+        struct aiocb aiocb;
+	int ret=0;

 #if _POSIX_ASYNCHRONOUS_IO != 200112L
-	return PTS_UNSUPPORTED;
+        exit(PTS_UNSUPPORTED);
 #endif

-	memset (&bad, 0, sizeof (struct aiocb));
+        snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",
+                  getpid());
+        unlink(tmpfname);
+        fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
+                  S_IRUSR | S_IWUSR);
+        if (fd == -1)
+        {
+                printf(TNAME " Error at open(): %s\n",
+                       strerror(errno));
+                exit(PTS_UNRESOLVED);
+        }
+
+        unlink(tmpfname);
+
+	memset (&aiocb, 0, sizeof (struct aiocb));

-	ret = aio_error(&bad);
-	if (ret != -1)
+        aiocb.aio_fildes = fd;
+        aiocb.aio_buf = buf;
+        aiocb.aio_reqprio = -1;
+        aiocb.aio_nbytes = BUF_SIZE;
+
+        if (aio_write(&aiocb) != 0)
 	{
-		printf(TNAME " bad aio_error return value; %d\n", ret);
-		return PTS_FAIL;
+                printf(TNAME " bad aio_read return value()\n");
+                exit(PTS_FAIL);
 	}

-	if (errno != EINVAL)
+	while (aio_error (&aiocb) == EINPROGRESS);
+	ret = aio_error(&aiocb);
+
+	if (ret != EINVAL)
 	{
 		printf(TNAME " errno is not EINVAL %s\n", strerror(errno));
 		return PTS_FAIL;
 	}

-
+	close(fd);
 	printf ("Test PASSED\n");
 	return PTS_PASS;
 }

--001e680f173cd2f2c3046c26b088
Content-Type: application/octet-stream; name="ltp-posix-aio_error_3-1.patch"
Content-Disposition: attachment; filename="ltp-posix-aio_error_3-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvuxmo570

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9haW9fZXJyb3IvMy0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fZXJyb3IvMy0xLmMKLS0tIGEvdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX2Vycm9yLzMt
MS5jCTIwMDktMDYtMTIgMTg6MDM6MTQuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9v
cGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL2Fpb19lcnJvci8zLTEu
YwkyMDA5LTA2LTEyIDE4OjAwOjIxLjAwMDAwMDAwMCArMDUzMApAQCAtMzYsMjkgKzM2LDU1IEBA
CiAKIGludCBtYWluKCkKIHsKLQlzdHJ1Y3QgYWlvY2IgYmFkOwotCWludCByZXQ7CisKKyAgICAg
ICAgY2hhciB0bXBmbmFtZVsyNTZdOworI2RlZmluZSBCVUZfU0laRSA1MTIKKyAgICAgICAgY2hh
ciBidWZbQlVGX1NJWkVdOworICAgICAgICBpbnQgZmQ7CisgICAgICAgIHN0cnVjdCBhaW9jYiBh
aW9jYjsKKwlpbnQgcmV0PTA7CiAKICNpZiBfUE9TSVhfQVNZTkNIUk9OT1VTX0lPICE9IDIwMDEx
MkwKLQlyZXR1cm4gUFRTX1VOU1VQUE9SVEVEOworICAgICAgICBleGl0KFBUU19VTlNVUFBPUlRF
RCk7CiAjZW5kaWYKIAotCW1lbXNldCAoJmJhZCwgMCwgc2l6ZW9mIChzdHJ1Y3QgYWlvY2IpKTsK
KyAgICAgICAgc25wcmludGYodG1wZm5hbWUsIHNpemVvZih0bXBmbmFtZSksICIvdG1wL3B0c19h
aW9fZXJyb3JfM18xXyVkIiwKKyAgICAgICAgICAgICAgICAgIGdldHBpZCgpKTsKKyAgICAgICAg
dW5saW5rKHRtcGZuYW1lKTsKKyAgICAgICAgZmQgPSBvcGVuKHRtcGZuYW1lLCBPX0NSRUFUIHwg
T19SRFdSIHwgT19FWENMLAorICAgICAgICAgICAgICAgICAgU19JUlVTUiB8IFNfSVdVU1IpOwor
ICAgICAgICBpZiAoZmQgPT0gLTEpCisgICAgICAgIHsKKyAgICAgICAgICAgICAgICBwcmludGYo
VE5BTUUgIiBFcnJvciBhdCBvcGVuKCk6ICVzXG4iLAorICAgICAgICAgICAgICAgICAgICAgICBz
dHJlcnJvcihlcnJubykpOworICAgICAgICAgICAgICAgIGV4aXQoUFRTX1VOUkVTT0xWRUQpOwor
ICAgICAgICB9CisKKyAgICAgICAgdW5saW5rKHRtcGZuYW1lKTsKKworCW1lbXNldCAoJmFpb2Ni
LCAwLCBzaXplb2YgKHN0cnVjdCBhaW9jYikpOwogCi0JcmV0ID0gYWlvX2Vycm9yKCZiYWQpOwot
CWlmIChyZXQgIT0gLTEpCisgICAgICAgIGFpb2NiLmFpb19maWxkZXMgPSBmZDsKKyAgICAgICAg
YWlvY2IuYWlvX2J1ZiA9IGJ1ZjsKKyAgICAgICAgYWlvY2IuYWlvX3JlcXByaW8gPSAtMTsKKyAg
ICAgICAgYWlvY2IuYWlvX25ieXRlcyA9IEJVRl9TSVpFOworCisgICAgICAgIGlmIChhaW9fd3Jp
dGUoJmFpb2NiKSAhPSAwKQogCXsKLQkJcHJpbnRmKFROQU1FICIgYmFkIGFpb19lcnJvciByZXR1
cm4gdmFsdWU7ICVkXG4iLCByZXQpOwotCQlyZXR1cm4gUFRTX0ZBSUw7CisgICAgICAgICAgICAg
ICAgcHJpbnRmKFROQU1FICIgYmFkIGFpb19yZWFkIHJldHVybiB2YWx1ZSgpXG4iKTsKKyAgICAg
ICAgICAgICAgICBleGl0KFBUU19GQUlMKTsKIAl9CiAKLQlpZiAoZXJybm8gIT0gRUlOVkFMKQor
CXdoaWxlIChhaW9fZXJyb3IgKCZhaW9jYikgPT0gRUlOUFJPR1JFU1MpOworCXJldCA9IGFpb19l
cnJvcigmYWlvY2IpOworCisJaWYgKHJldCAhPSBFSU5WQUwpCiAJewogCQlwcmludGYoVE5BTUUg
IiBlcnJubyBpcyBub3QgRUlOVkFMICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwogCQlyZXR1cm4g
UFRTX0ZBSUw7CiAJfQogCi0KKwljbG9zZShmZCk7CiAJcHJpbnRmICgiVGVzdCBQQVNTRURcbiIp
OwogCXJldHVybiBQVFNfUEFTUzsKIH0K
--001e680f173cd2f2c3046c26b088
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
--001e680f173cd2f2c3046c26b088
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f173cd2f2c3046c26b088--

