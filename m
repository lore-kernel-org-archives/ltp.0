Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <john.maxin@nokia.com>) id 1Pp0aL-0005nR-26
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 15:43:33 +0000
Received: from smtp.nokia.com ([147.243.128.24] helo=mgw-da01.nokia.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Pp0aJ-0006cy-88
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 15:43:33 +0000
Received: from [172.21.22.250] (helruo-dhcp022250.ntc.nokia.com
	[172.21.22.250])
	by mgw-da01.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	p1EFhMSf027235
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Feb 2011 17:43:22 +0200
Message-ID: <4D595C00.5050508@nokia.com>
Date: Mon, 14 Feb 2011 17:44:48 +0100
From: maxin <john.maxin@nokia.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]  Fix compilation warning for tools/rand_lines.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


Hi,

This one is a trivial fix for the compilation warnings in 'tools/rand_lines.c'

Signed-off-by: Maxin John<john.maxin@nokia.com>

----
diff --git a/tools/rand_lines.c b/tools/rand_lines.c
index e1b2d0a..e2c3bb9 100644
--- a/tools/rand_lines.c
+++ b/tools/rand_lines.c
@@ -99,6 +99,7 @@
   **************************************************************/

  #include<errno.h>
+#include<err.h>
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>
----

Warm Regards,
Maxin B. John


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
