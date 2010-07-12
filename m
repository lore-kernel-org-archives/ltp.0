Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OYG9n-0005CA-Sg
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 10:22:39 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OYG9j-0006t0-MJ
	for ltp-list@lists.sourceforge.net; Mon, 12 Jul 2010 10:22:39 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 12 Jul 2010 15:52:07 +0530
Message-Id: <1278930128.18204.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] Latest GIT creates install error
Reply-To: subrata@linux.vnet.ibm.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi Garret,

Latest LTP git creates install error:

make -C open_posix_testsuite
top_srcdir=/root/ltp-dev/testcases/open_posix_testsuite install
make[2]: Entering directory
`/root/ltp-dev/testcases/open_posix_testsuite'
mkdir -p //opt/openposix_testsuite/bin/.
make[2]: *** No rule to make target `run.sh', needed by `install'.
Stop.
make[2]: Leaving directory
`/root/ltp-dev/testcases/open_posix_testsuite'
make[1]: *** [open_posix_testsuite-install] Error 2
make[1]: Leaving directory `/root/ltp-dev/testcases'
make: *** [testcases-install] Error 2

Regards--
Subrata



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
