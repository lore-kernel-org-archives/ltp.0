Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1XW4A1-0008Pc-72
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 14:00:13 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1XW49y-0001Hp-KB
	for ltp-list@lists.sourceforge.net; Mon, 22 Sep 2014 14:00:12 +0000
Date: Mon, 22 Sep 2014 15:47:42 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140922154742.71edd101@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] Failed out of tree compile
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

I tried to build the latest version of LTP, cloned a couple of hours
ago. But the build failed. I followed the instructions found in the
INSTALL file for out of tree builds. But when executing the actual make
command, the build fails. The command and the fail message is as
follows:

$  make -f ../git/ltp-clean/Makefile top_srcdir=/homes/mlil/git/ltp-clean top_builddir=$(pwd)

...

configure: creating ./config.status
 cd /homes/mlil/build && /bin/bash ./config.status Makefile depfiles
config.status: error: invalid argument: `Makefile'
make[2]: *** [Makefile] Error 1
make[2]: Leaving directory `/homes/mlil/build/utils/ffsb-6.0-rc2'
make[1]: *** [ffsb-6.0-rc2/ffsb] Error 2
make[1]: Leaving directory `/homes/mlil/build/utils'
make: *** [utils-all] Error 2

Am I doing something wrong here?

/Mats

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
