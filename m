Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJli9-0006oV-IN
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:57:41 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJli5-0003Tm-P4
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:57:41 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906241944.DIF30774.QOHFFSLtFVJOMO@I-love.SAKURA.ne.jp>
References: <200906142044.ACJ21831.VHOJSFLtFOQOFM@I-love.SAKURA.ne.jp>
	<1245093386.4871.49.camel@subratamodak.linux.ibm.com>
	<1245346304.5041.37.camel@subratamodak.linux.ibm.com>
	<200906231953.IDF78463.HOJVFLQOtSMFFO@I-love.SAKURA.ne.jp>
	<1245768629.4860.89.camel@subratamodak.linux.ibm.com>
	<200906241944.DIF30774.QOHFFSLtFVJOMO@I-love.SAKURA.ne.jp>
Date: Thu, 25 Jun 2009 14:40:08 +0530
Message-Id: <1245921008.5542.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [003][RFC] [TESTING linux-2.6.30]
	TOMOYO	Linuxandpathname-basedsecurity
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

On Wed, 2009-06-24 at 19:44 +0900, Tetsuo Handa wrote: 
> Subrata Modak wrote:
> > On Tue, 2009-06-23 at 19:53 +0900, Tetsuo Handa wrote: 
> > > Hello.
> > > 
> > > I uploaded the programs to http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.2.x/kernel_test/?root=tomoyo .
> > > I'll notify you again when I added more testcases.
> > 
> > Great. I will see and investigate soon to find out the ways to integrate
> > them to LTP. Meanwhile, if you can help us with a Sign-off saying that
> > you do not have any issue(s) in integrating the above tests to LTP;
> > would be really necessary/helpful.
> 
> ccs-patch package (kernel patch for TOMOYO) and ccs-tools package (TOMOYO's
> userland programs) are released under the GPL. I have no license issues.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thanks again.

Regards--
Subrata

> 
> Regards.


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
