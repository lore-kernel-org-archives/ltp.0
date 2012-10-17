Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TOY6U-0000jW-LP
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 18:12:26 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TOY6T-0006Z1-TY
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 18:12:26 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9HICKew000954
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Oct 2012 11:12:20 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 20313364656
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Oct 2012 11:12:16 -0700 (PDT)
From: Chris Dearman <chris@mips.com>
Date: Wed, 17 Oct 2012 11:12:15 -0700
Message-ID: <20121017181033.12482.53855.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/2] Cleanup trailing whitespace and missing \n at EOF
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

These two patches are a general cleanup of files in the tree to remove
trailing whitespace at end of line and add missing \n at end of file.

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
