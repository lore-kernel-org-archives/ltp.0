Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Md5Cy-0007vT-Lj
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 16:37:20 +0000
Received: from mail-gx0-f212.google.com ([209.85.217.212])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Md5Ct-0001ek-Q1
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 16:37:20 +0000
Received: by gxk8 with SMTP id 8so3940091gxk.9
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Aug 2009 09:37:09 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 17 Aug 2009 22:07:09 +0530
Message-ID: <f5a7b3810908170937u516ee718yd6db8df547752bc4@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd2898e6453f00471590367
Subject: [LTP] [FIX PATCHE]ltp-fix-posix-mq_send_5-1 warning
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Brandon Philips <bphilips@suse.de>

--000e0cd2898e6453f00471590367
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed build warnings for the following test case.
This patch will fix warnings by removing unused variables in test code.

I have attached patch and below
Please review the same

Best regards,
Naresh Kamboju

/*************************************************************************/
Results:

Before Patch:
conformance/interfaces/mq_send/5-1.test:execution:PASS

After Patch:
conformance/interfaces/mq_send/5-1.test:execution:PASS
/*************************************************************************/

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Narub a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c	2009-08-17
20:24:38.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_send/5-1.c	2009-08-17
20:25:42.000000000 +0530
@@ -102,9 +102,7 @@
 		}
 	} else {
 		/* parent here */
-		struct sigaction act;
 		int j;
-		int r;

 		/* wait for child to reach MAXMSG */
 		for (j = 0; j < MAXMSG; j++) {
diff -Narub a/testcases/open_posix_testsuite/include/mq_send.h
b/testcases/open_posix_testsuite/include/mq_send.h
--- a/testcases/open_posix_testsuite/include/mq_send.h	2009-08-17
20:24:38.000000000 +0530
+++ b/testcases/open_posix_testsuite/include/mq_send.h	2009-08-17
20:34:39.000000000 +0530
@@ -46,7 +46,6 @@

 int sync_pipe_wait_select(int fd[], long tv_sec)
 {
-        char buf;
         int r;
        fd_set rfds;
        struct timeval tv;

--000e0cd2898e6453f00471590367
Content-Type: message/rfc822; name="ltp-fix-posix-mq_send_5-1.patch"
Content-Disposition: attachment; filename="ltp-fix-posix-mq_send_5-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyhf9rq00


ZGlmZiAtTmFydWIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tcV9zZW5kLzUtMS5jIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbXFfc2VuZC81LTEuYwotLS0gYS90ZXN0Y2FzZXMvb3Bl
bl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tcV9zZW5kLzUtMS5jCTIw
MDktMDgtMTcgMjA6MjQ6MzguMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bv
c2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21xX3NlbmQvNS0xLmMJMjAwOS0w
OC0xNyAyMDoyNTo0Mi4wMDAwMDAwMDAgKzA1MzAKQEAgLTEwMiw5ICsxMDIsNyBAQAogCQl9CiAJ
fSBlbHNlIHsKIAkJLyogcGFyZW50IGhlcmUgKi8KLQkJc3RydWN0IHNpZ2FjdGlvbiBhY3Q7CiAJ
CWludCBqOwotCQlpbnQgcjsKIAogCQkvKiB3YWl0IGZvciBjaGlsZCB0byByZWFjaCBNQVhNU0cg
Ki8KIAkJZm9yIChqID0gMDsgaiA8IE1BWE1TRzsgaisrKSB7CmRpZmYgLU5hcnViIGEvdGVzdGNh
c2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2luY2x1ZGUvbXFfc2VuZC5oIGIvdGVzdGNhc2VzL29w
ZW5fcG9zaXhfdGVzdHN1aXRlL2luY2x1ZGUvbXFfc2VuZC5oCi0tLSBhL3Rlc3RjYXNlcy9vcGVu
X3Bvc2l4X3Rlc3RzdWl0ZS9pbmNsdWRlL21xX3NlbmQuaAkyMDA5LTA4LTE3IDIwOjI0OjM4LjAw
MDAwMDAwMCArMDUzMAorKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvaW5jbHVk
ZS9tcV9zZW5kLmgJMjAwOS0wOC0xNyAyMDozNDozOS4wMDAwMDAwMDAgKzA1MzAKQEAgLTQ2LDcg
KzQ2LDYgQEAKIAogaW50IHN5bmNfcGlwZV93YWl0X3NlbGVjdChpbnQgZmRbXSwgbG9uZyB0dl9z
ZWMpCiB7Ci0gICAgICAgIGNoYXIgYnVmOwogICAgICAgICBpbnQgcjsKICAgICAgICBmZF9zZXQg
cmZkczsKICAgICAgICBzdHJ1Y3QgdGltZXZhbCB0djsK
--000e0cd2898e6453f00471590367
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd2898e6453f00471590367
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd2898e6453f00471590367--

