Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TP0FV-0005uQ-7k
	for ltp-list@lists.sourceforge.net; Fri, 19 Oct 2012 00:15:37 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TP0FU-0002wZ-4y
	for ltp-list@lists.sourceforge.net; Fri, 19 Oct 2012 00:15:37 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9J0FUcH008414
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 17:15:30 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 23E5D36466D
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Oct 2012 17:14:49 -0700 (PDT)
From: Chris Dearman <chris@mips.com>
Date: Thu, 18 Oct 2012 17:14:45 -0700
Message-ID: <20121019001356.19375.35847.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Subject: [LTP] [PATCH] repair damage to
	testcases/kernel/io/stress_floppy/dd_file
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

> @yaneurabeya <https://github.com/yaneurabeya>, I was looking at the 
> > patch, and while it looks mostly ok, I think the file
> > 
> > |testcases/kernel/io/stress_floppy/dd_file
> > |
> > 
> > Got damaged... could you verify please?

Good catch. Thanks for spotting this. The following patch should
revert the file to its previous state.

Thanks
Chris

-- 
Chris Dearman               Desk: +1 408 530 5092  Cell: +1 408 398 5531
MIPS Technologies Inc         955 East Arques Avenue, Sunnyvale CA 94085

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
