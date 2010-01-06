Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NSb5x-0005yD-Oe
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 18:59:01 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSb5w-0002UN-ND
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 18:59:01 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o06IuFc9032255
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 11:56:15 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o06IwhZQ158916
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 11:58:44 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o06Iwg37023673
	for <ltp-list@lists.sourceforge.net>; Wed, 6 Jan 2010 11:58:43 -0700
Date: Wed, 6 Jan 2010 12:58:37 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100106185837.GA20097@us.ibm.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [LTP] regression:  selinux testsuite broken since October
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
To: Garrett Cooper <yanegomi@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> It seems the Makefile rewrite last October broke the selinux testsuite.
> Is it unreasonable to expect that someone who rewrote the Makefile would
> actually try running the testsuite?
> 
> Please, revert the changes or fix them.
> 
> See testcases/kernel/security/selinux-testsuite/README for the
> instructions.

Ok, Garrett, two particular scripts that are broken since the move
to running out of /opt/ltp are
	test_robind.sh
	test_selinux.sh

Guidance?

thanks,
-serge

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
