Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NxMIQ-0005Vh-LW
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 15:27:02 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxMIO-0008KR-G1
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 15:27:02 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o31FNrLv011983
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 09:23:53 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o31FQmEW159702
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 09:26:53 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o31FTMcO031006
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 09:29:23 -0600
Date: Thu, 1 Apr 2010 10:26:47 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100401152647.GH22648@us.ibm.com>
References: <000001cad173$3c32b200$b4981600$@co.jp>
	<20100401083510.GD13796@linux.vnet.ibm.com>
	<000101cad17c$ee4946d0$cadbd470$@co.jp>
	<20100401093511.GA25290@linux.vnet.ibm.com>
	<000001cad18d$ea091c60$be1b5520$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000001cad18d$ea091c60$be1b5520$@co.jp>
Subject: Re: [LTP] cap_bounds_r.c build failure
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Quoting Mitani (mitani@ryobi.co.jp):
> Hi Rishi,
> 
> I installed "libcap-devel", but after configure, build failed, too.
> 
> ------------
> [root@RHEL4-8 mitani]# rpm -qa | grep libcap
> libcap-devel-1.10-20
> libcap-1.10-20
> [root@RHEL4-8 mitani]#
> ------------
> 
> "libcap-1.10-20" version is normal version in my system (RHEL4.8 
> 2.6.9-89.ELsmp).
> In this version, capability.h doesn't have CAP_LAST_CAP definition.
> I try to upgrade version "2.11".

Yeah, you need libcap2 for these tests.  I guess we could stand
to add a rule to m4/ltp-cap.m4 to check for the existance of
libcap.so.2.X, X > oh say 12.

-serge

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
