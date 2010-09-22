Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OyKrq-0001T8-8q
	for ltp-list@lists.sourceforge.net; Wed, 22 Sep 2010 08:39:54 +0000
Received: from out15.sjc.mx.trendmicro.com ([216.99.131.72])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OyKro-0005af-Jk
	for ltp-list@lists.sourceforge.net; Wed, 22 Sep 2010 08:39:54 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.22])
	by out15.sjc.mx.trendmicro.com (Postfix) with ESMTP id 1AAA1980418
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Sep 2010 08:39:46 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 73EC695810
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Sep 2010 08:39:45 +0000 (UTC)
Message-ID: <000601cb5a30$d47c0a20$7d741e60$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 22 Sep 2010 17:33:27 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_17_33_29_Wednesday_September_22_2010_24989"
Content-Language: ja
Subject: [LTP] [PATCH] fix "memcg_stress" test
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
Cc: =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_17_33_29_Wednesday_September_22_2010_24989
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

I noticed that "memcg_stress" test failed in my RHEL5.5/RHEL4.8 systems:
------------(RHEL4.8)
cgroup_regression_test   10  TCONF  :  Remaining cases not appropriate for
configuration
grep: /proc/cgroups: No such file or directory
memcg_regression_test    1  TCONF  :  Either memory resource controller
kernel support absent
memcg_regression_test    1  TCONF  :  or feature is not enabled; skipping
all memcgroup testcases.
grep: /proc/cgroups: No such file or directory
WARNING:
Either Kernel does not support for memory resource controller or feature not
enabled
Skipping all memcgroup testcases....
/opt/ltp/testcases/bin/memcg_stress_test.sh:
/opt/ltp/testcases/bin/memcg_stress_test.sh: cannot execute binary file
grep: /proc/cgroups: No such file or directory
WARNING:
Either kernel does not support memory resource controller or feature not
enabled
Skipping all memcg_control testcases....
------------

------------(RHEL5.5)
cgroup_regression_test   10  TCONF  :  Remaining cases not appropriate for
configuration
grep: /proc/cgroups: No such file or directory
memcg_regression_test    1  TCONF  :  Either memory resource controller
kernel support absent
memcg_regression_test    1  TCONF  :  or feature is not enabled; skipping
all memcgroup testcases.
grep: /proc/cgroups: No such file or directory
WARNING:
Either Kernel does not support for memory resource controller or feature not
enabled
Skipping all memcgroup testcases....
★/opt/ltp/testcases/bin/memcg_stress_test.sh: line 1: ・ソ#!: command not
found
grep: /proc/cgroups: No such file or directory
WARNING:
Either Kernel does not support for memory resource controller or feature not
enabled
Skipping all memcgroup testcases....
grep: /proc/cgroups: No such file or directory
WARNING:
Either kernel does not support memory resource controller or feature not
enabled
Skipping all memcg_control testcases....
------------

In RHEL4.8, the shell file is recognized as binary file.
In RHEL5.5, the first command line of the shell cannnt be recognized.

By following patch, BOM (Byte Order Mark) was set to "memcg_stress_test.sh":
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commitdiff
;h=9b9a6bb10258bc975bd1707b418699264d3bdcef#patch1

I noticed BOM in the shell by using "less memcg_stress_test.sh" command.

I removed this BOM and this test passed.

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
============
---
a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2010
-09-20 23:22:34.000000000 +0900
+++
b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh	2010
-09-22 10:30:50.000000000 +0900
@@ -1,4 +1,4 @@
-・ソ#! /bin/sh
+#! /bin/sh


############################################################################
####
 ##
##
============



Thank you--

-Tomonori Mitani

----=_NextPart_ST_17_33_29_Wednesday_September_22_2010_24989
Content-Type: application/octet-stream;
	name="memcg_stress_test.sh.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="memcg_stress_test.sh.patch"

--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh=092010=
-09-20 23:22:34.000000000 +0900=0A+++ b/testcases/kernel/controllers/memcg/=
stress/memcg_stress_test.sh=092010-09-22 10:30:50.000000000 +0900=0A@@ -1,4=
 +1,4 @@=0A-=EF=BB=BF#! /bin/sh=0A+#! /bin/sh=0A =0A ######################=
##########################################################=0A ##           =
                                                                 ##=0A
----=_NextPart_ST_17_33_29_Wednesday_September_22_2010_24989
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
----=_NextPart_ST_17_33_29_Wednesday_September_22_2010_24989
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_17_33_29_Wednesday_September_22_2010_24989--

