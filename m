Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SL4X6-00070d-16
	for ltp-list@lists.sourceforge.net; Fri, 20 Apr 2012 03:29:16 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SL4X5-0007XH-0a
	for ltp-list@lists.sourceforge.net; Fri, 20 Apr 2012 03:29:15 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q3K3T8nS028938
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 19 Apr 2012 20:29:08 -0700 (PDT)
Message-ID: <4F90D809.7050809@windriver.com>
Date: Fri, 20 Apr 2012 11:29:13 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Pls. help on POSIX test case mlockall/3-6 on MIPS
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

The POSIX cases mlockall/3-6 3-7 fail on routerstation(arch MIPS), and 
the OS is linux 3.0.24.
It seems that after mlockall() that not all the share memories have been 
set LOCK flag.
Does anyone meet the question before or know what is the root cause?

Thanks a lot.

Regards,
Kai


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
