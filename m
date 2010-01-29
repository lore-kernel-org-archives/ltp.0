Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Naj13-0005s5-Hp
	for ltp-list@lists.sourceforge.net; Fri, 29 Jan 2010 05:03:33 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Naj12-0000NE-6A
	for ltp-list@lists.sourceforge.net; Fri, 29 Jan 2010 05:03:33 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.23])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 3CC6123944F
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Jan 2010 05:03:25 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 73B2C95836
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Jan 2010 05:03:24 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Jan 2010 14:03:22 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 29 Jan 2010 14:03:22 +0900
Message-ID: <000001caa0a0$61792020$246b6060$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] 2010-01-29 cvs build problem
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

I tried to build 2010-01-29 cvs in RHEL4.8 system.

"make" and "make install" succeeded, but in "/opt/ltp" directory, there
were not "runltp". There were "bin", "share", "testcases" directories 
only.

With 2010-01-28 cvs, "make install" installed necessary files such as 
"runltp" to "/opt/ltp" directory as follows:

------------
[...]
install -m 00775 "/home/LTP/ltp-2010-01-28/tools/genload/stress"
"/opt/ltp/testcases/bin/stress"
make[2]: Leaving directory `/home/LTP/ltp-2010-01-28/tools/genload'
make[1]: Leaving directory `/home/LTP/ltp-2010-01-28/tools'
make -C "runtest" \
	-f "/home/LTP/ltp-2010-01-28/runtest/Makefile" install
make[1]: Entering directory `/home/LTP/ltp-2010-01-28/runtest'
test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/admin_tools"
"/opt/ltp/runtest/admin_tools"
test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/ballista"
"/opt/ltp/runtest/ballista"
test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/can"
"/opt/ltp/runtest/can"
test -d "/opt/ltp/runtest" || mkdir -p "/opt/ltp/runtest"
install -m 00644 "/home/LTP/ltp-2010-01-28/runtest/cap_bounds"
"/opt/ltp/runtest/cap_bounds"
[...]
install -m 00755 "/home/LTP/ltp-2010-01-28/runltplite.sh"
"//opt/ltp/runltplite.sh"
install -m 00755 "/home/LTP/ltp-2010-01-28/ver_linux" "//opt/ltp/ver_linux"
head -n 1 "/home/LTP/ltp-2010-01-28/ChangeLog" > "Version"
install -m 00644 "/home/LTP/ltp-2010-01-28/Version" "//opt/ltp/Version"
install -m 00755 "/home/LTP/ltp-2010-01-28/execltp" "//opt/ltp/bin/execltp"
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
------------

Just a quick note to tell you that.


Thank you--


-Tomonori Mitani



------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
