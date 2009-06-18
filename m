Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTH-0007dv-4p
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:19 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTB-0000Ae-CK
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:19 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245093386.4871.49.camel@subratamodak.linux.ibm.com>
References: <1244775226.4982.3.camel@subratamodak.linux.ibm.com>
	<200906142044.ACJ21831.VHOJSFLtFOQOFM@I-love.SAKURA.ne.jp>
	<1245093386.4871.49.camel@subratamodak.linux.ibm.com>
Date: Thu, 18 Jun 2009 23:01:43 +0530
Message-Id: <1245346304.5041.37.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [003][RFC] [TESTING linux-2.6.30] TOMOYO
	Linux	and	pathname-basedsecurity
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ltp-list@lists.sf.net, haradats@nttdata.co.jp, sds@tycho.nsa.gov, casey@schaufler-ca.com, serue@linux.vnet.ibm.com, zohar@linux.vnet.ibm.com, takedakn@nttdata.co.jp

On Tue, 2009-06-16 at 00:46 +0530, Subrata Modak wrote: 
> On Sun, 2009-06-14 at 20:44 +0900, Tetsuo Handa wrote: 
> > Hello.
> > 
> > Sorry for late response. I had no internet access for three days.
> > 
> > Subrata Modak wrote:
> > > We would like to inform you that we have some robust sets of testcases
> > > for both SELinux, SMACK, IMA, etc at
> > > http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/.
> > > And i would express to have TOMYO being tested through LTP. If you agree
> > > to contribute some test cases in this regard to LTP under GPLv2, we can
> > > make a modest but great beginning. What do you say ?
> > 
> > Yes, we are willing to contribute TOMOYO's test cases to LTP.
> 
> Great to hear that.
> 
> > Currently, we are using testing programs available at
> > http://sourceforge.jp/projects/tomoyo/svn/view/trunk/1.6.x/ccs-tools/ccstools/kernel_test/?root=tomoyo
> > But they are not some shell scripting programs.
> > Thus, I need to remake these programs to follow LTP conventions.
> > Can I have some documentation regarding how to write LTP testing programs?
> 
> Sure. Why not. Please see:
> 
> http://ltp.sourceforge.net/
> http://ltp.sourceforge.net/documentation/how-to/ltp.php
> http://ltp.sourceforge.net/documentation/technical_papers/

Hi,

Do you feel the above information is sufficient for your to write tests
for LTP ? Please feel free to ask us questions regarding anything to LTP
tests.

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> > 
> > Regards.
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
