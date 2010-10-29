Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chu24@llnl.gov>) id 1PBtjA-0004bK-S5
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 18:31:00 +0000
Received: from nspiron-2.llnl.gov ([128.115.41.82])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.69) id 1PBtj9-0005Jp-Mo
	for ltp-list@lists.sourceforge.net; Fri, 29 Oct 2010 18:31:00 +0000
Message-ID: <4CCB12DD.2080704@llnl.gov>
Date: Fri, 29 Oct 2010 11:30:53 -0700
From: Jonathan Chu <chu24@llnl.gov>
MIME-Version: 1.0
Subject: [LTP] [LSPP] Running misc_tests/proc_sys_perms test outside of LSPP
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
Cc: saebjornsen1@llnl.gov

Hi,

I'm working on some software which needs to be able to test syscall 117 
ipc. While we did not find any comprehensive tests within LTP and its 
bundled Open POSIX Testsuite, we found that LSPP has 
misc_tests/proc_sys_perms/testfileperms.c which we may be able to use. 
We are having some difficulty incorporating this into our own testsuite. 
Is it possible to run this test outside of the LSPP framework and 
without root privileges? Are there any other tests for ipc that we could 
use?

Thanks,
Jonathan

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
