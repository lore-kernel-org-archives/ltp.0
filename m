Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Md5HU-0007yd-Ln
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 16:42:00 +0000
Received: from mail-yx0-f174.google.com ([209.85.210.174])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Md5HP-0001KA-Sl
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 16:42:00 +0000
Received: by yxe4 with SMTP id 4so4075696yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Aug 2009 09:41:50 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 17 Aug 2009 22:11:50 +0530
Message-ID: <f5a7b3810908170941n6885b036ub45f9d14ec5c3768@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cdf13ca1bd552047159149b
Subject: [LTP] [FIX PATCH] ltp-fix-posix-sched_setparam_26-1 warning fix
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

--000e0cdf13ca1bd552047159149b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed build warnings for the following test case.
This patch will fix warnings by adding <string.h> header file.

I have attached patch and below
Please review the same

Best regards,
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Narub a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c	2009-08-17
20:48:10.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c	2009-08-17
20:46:10.000000000 +0530
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <pwd.h>
+#include <string.h>
 #include "posixtest.h"

--000e0cdf13ca1bd552047159149b
Content-Type: message/rfc822; name="ltp-fix-posix-sched_setparam_26-1.patch"
Content-Disposition: attachment; 
	filename="ltp-fix-posix-sched_setparam_26-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyhfj5js0


ZGlmZiAtTmFydWIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9zY2hlZF9zZXRwYXJhbS8yNi0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90
ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zY2hlZF9zZXRwYXJhbS8yNi0xLmMKLS0t
IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMv
c2NoZWRfc2V0cGFyYW0vMjYtMS5jCTIwMDktMDgtMTcgMjA6NDg6MTAuMDAwMDAwMDAwICswNTMw
CisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZh
Y2VzL3NjaGVkX3NldHBhcmFtLzI2LTEuYwkyMDA5LTA4LTE3IDIwOjQ2OjEwLjAwMDAwMDAwMCAr
MDUzMApAQCAtMTcsNiArMTcsNyBAQAogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSA8dW5p
c3RkLmg+CiAjaW5jbHVkZSA8cHdkLmg+CisjaW5jbHVkZSA8c3RyaW5nLmg+CiAjaW5jbHVkZSAi
cG9zaXh0ZXN0LmgiCiAKIAo=
--000e0cdf13ca1bd552047159149b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cdf13ca1bd552047159149b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cdf13ca1bd552047159149b--

