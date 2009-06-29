Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MLK6W-0002Xg-Oa
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 16:53:16 +0000
Received: from mail-yx0-f196.google.com ([209.85.210.196])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLK6V-0002WZ-Pw
	for ltp-list@lists.sourceforge.net; Mon, 29 Jun 2009 16:53:16 +0000
Received: by yxe34 with SMTP id 34so4553149yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Jun 2009 09:53:11 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 29 Jun 2009 22:23:11 +0530
Message-ID: <f5a7b3810906290953k7326b82ds617ee7bfdac92e48@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f101c7fd3fa046d7f86d8
Subject: [LTP] [FIX-PATCH]Build-issue-cacheflush01.c on MIPS
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
Cc: Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

--001e680f101c7fd3fa046d7f86d8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed build error for cacheflush01.c on MIPS.
There is edit issue from Windows to Linux text file.
Now build issue is resolved.
Please find attached patch and below.

Best Regards
Naresh Kamboju

Build-Error:

cacheflush01.c  -L../../../../lib -lltp -o cacheflush01
cacheflush01.c: In function 'cacheflush':
cacheflush01.c:52: error: 'B' undeclared (first use in this function)
cacheflush01.c:52: error: (Each undeclared identifier is reported only once
cacheflush01.c:52: error: for each function it appears in.)
cacheflush01.c:52: error: expected ';' before 'B'
cacheflush01.c:53: warning: control reaches end of non-void function
make: *** [cacheflush01] Error 1

	
Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/cacheflush/cacheflush01.c
b/testcases/kernel/syscalls/cacheflush/cacheflush01.c
--- a/testcases/kernel/syscalls/cacheflush/cacheflush01.c	2009-04-15
12:02:35.000000000 +0530
+++ b/testcases/kernel/syscalls/cacheflush/cacheflush01.c	2009-06-29
21:38:42.000000000 +0530
@@ -49,7 +49,7 @@
 #include <asm/cachectl.h>
 int cacheflush(char *addr, int nbytes, int cache)
 {
-B  B  B  B return syscall(__NR_cacheflush, addr, nbytes, cache);
+           return syscall(__NR_cacheflush, addr, nbytes, cache);
 }
 #endif /* __mips__ */

--001e680f101c7fd3fa046d7f86d8
Content-Type: application/octet-stream; name="ltp-fix-cacheflush01.patch"
Content-Disposition: attachment; filename="ltp-fix-cacheflush01.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwjf85vt0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NhY2hlZmx1c2gvY2FjaGVm
bHVzaDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NhY2hlZmx1c2gvY2FjaGVmbHVz
aDAxLmMKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jYWNoZWZsdXNoL2NhY2hlZmx1
c2gwMS5jCTIwMDktMDQtMTUgMTI6MDI6MzUuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvY2FjaGVmbHVzaC9jYWNoZWZsdXNoMDEuYwkyMDA5LTA2LTI5IDIx
OjM4OjQyLjAwMDAwMDAwMCArMDUzMApAQCAtNDksNyArNDksNyBAQAogI2luY2x1ZGUgPGFzbS9j
YWNoZWN0bC5oPgogaW50IGNhY2hlZmx1c2goY2hhciAqYWRkciwgaW50IG5ieXRlcywgaW50IGNh
Y2hlKQogewotQiAgQiAgQiAgQiByZXR1cm4gc3lzY2FsbChfX05SX2NhY2hlZmx1c2gsIGFkZHIs
IG5ieXRlcywgY2FjaGUpOworICAgICAgICAgICByZXR1cm4gc3lzY2FsbChfX05SX2NhY2hlZmx1
c2gsIGFkZHIsIG5ieXRlcywgY2FjaGUpOwogfQogI2VuZGlmIC8qIF9fbWlwc19fICovCiAK
--001e680f101c7fd3fa046d7f86d8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--001e680f101c7fd3fa046d7f86d8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f101c7fd3fa046d7f86d8--

