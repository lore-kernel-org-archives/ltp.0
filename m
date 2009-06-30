Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MLY01-0006kd-14
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:43:29 +0000
Received: from [74.125.92.145] (helo=qw-out-1920.google.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY00-0002M3-3O
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:43:28 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1767223qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2009 00:42:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Jun 2009 13:12:57 +0530
Message-ID: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=0015175cb1ca8b8b13046d8bf401
Subject: [LTP] [FIX PATCHES] ltp-mq_unlink_speculative_7-2
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
Cc: Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

--0015175cb1ca8b8b13046d8bf401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed failure under open_posix_testsuite for
mq_unlink/speculative/7-2.c and fixed.
After changing the uninitialized to initialized char array of mqname[]
test case got PASSED.

I have attached patch and below.
Please review the same.


Best Regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
2005-06-03 22:00:59.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/speculative/7-2.c
2009-06-30 12:37:35.000000000 +0530
@@ -28,7 +28,7 @@

 int main()
 {
-       char mqname[50];
+       char mqname[50]="/123";

 //     sprintf(mqname, FUNCTION "_" TEST "_%d", getpid());

--0015175cb1ca8b8b13046d8bf401
Content-Type: application/octet-stream; 
	name="ltp-mq_unlink_speculative_7-2.patch"
Content-Disposition: attachment; 
	filename="ltp-mq_unlink_speculative_7-2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwkb07ka0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tcV91bmxpbmsvc3BlY3VsYXRpdmUvNy0yLmMgYi90ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tcV91bmxpbmsvc3BlY3VsYXRp
dmUvNy0yLmMKLS0tIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNl
L2ludGVyZmFjZXMvbXFfdW5saW5rL3NwZWN1bGF0aXZlLzctMi5jCTIwMDUtMDYtMDMgMjI6MDA6
NTkuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9j
b25mb3JtYW5jZS9pbnRlcmZhY2VzL21xX3VubGluay9zcGVjdWxhdGl2ZS83LTIuYwkyMDA5LTA2
LTMwIDEyOjM3OjM1LjAwMDAwMDAwMCArMDUzMApAQCAtMjgsNyArMjgsNyBAQAogCiBpbnQgbWFp
bigpCiB7Ci0JY2hhciBtcW5hbWVbNTBdOworCWNoYXIgbXFuYW1lWzUwXT0iLzEyMyI7CiAKIC8v
CXNwcmludGYobXFuYW1lLCBGVU5DVElPTiAiXyIgVEVTVCAiXyVkIiwgZ2V0cGlkKCkpOwogCg==
--0015175cb1ca8b8b13046d8bf401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0015175cb1ca8b8b13046d8bf401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0015175cb1ca8b8b13046d8bf401--

