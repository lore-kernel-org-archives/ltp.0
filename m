Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Nn5Ln-0003q5-Qj
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 07:20:03 +0000
Received: from out05.sjc.mx.trendmicro.com ([216.99.131.18])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nn5Ll-0006oQ-Jv
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 07:20:03 +0000
Received: from out04.sjc.mx.trendmicro.com (unknown [216.99.131.8])
	by out05.sjc.mx.trendmicro.com (Postfix) with ESMTP id ED7C33AC77D
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Mar 2010 07:01:30 +0000 (UTC)
Received: from relay01.sjc.mx.trendmicro.com (unknown [10.30.239.27])
	by out04.sjc.mx.trendmicro.com (Postfix) with ESMTP id D8B2A58C4F8
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Mar 2010 07:01:24 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 2E060114B837
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Mar 2010 07:01:23 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 16:01:22 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 4 Mar 2010 16:01:22 +0900
Message-ID: <000301cabb68$7fb08c30$7f11a490$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Is there another method to download?
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

I tried to get source by using GIT.
But It failed with following message:

------------
# git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev
Initialized empty Git repository in /home/mitani/wk/ltp-dev/.git/
fatal: Unable to look up ltp.git.sourceforge.net (port 9418) (Temporary
failure in name resolution)
#
------------

It seems to be caused by the fact that port 9418 does not open.
This is a problem by me.
But I think that there are some companies which don't open a port 9418
due to the security. I think that it becomes the problem in those 
companies that GIT cannot be used.

I'm saved very much if there is the method to download via HTTP.


Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
