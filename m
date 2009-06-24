Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1MJPyt-0004Gp-1S
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 10:45:31 +0000
Received: from wine.ocn.ne.jp ([122.1.235.145] helo=smtp.wine.ocn.ne.jp)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJPyB-0000Hw-KA
	for ltp-list@lists.sourceforge.net; Wed, 24 Jun 2009 10:45:30 +0000
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <200906142044.ACJ21831.VHOJSFLtFOQOFM@I-love.SAKURA.ne.jp>
	<1245093386.4871.49.camel@subratamodak.linux.ibm.com>
	<1245346304.5041.37.camel@subratamodak.linux.ibm.com>
	<200906231953.IDF78463.HOJVFLQOtSMFFO@I-love.SAKURA.ne.jp>
	<1245768629.4860.89.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1245768629.4860.89.camel@subratamodak.linux.ibm.com>
Message-Id: <200906241944.DIF30774.QOHFFSLtFVJOMO@I-love.SAKURA.ne.jp>
Date: Wed, 24 Jun 2009 19:44:36 +0900
Mime-Version: 1.0
Subject: Re: [LTP] [003][RFC] [TESTING linux-2.6.30] TOMOYO
	Linuxandpathname-basedsecurity
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, haradats@nttdata.co.jp, sds@tycho.nsa.gov, casey@schaufler-ca.com, serue@linux.vnet.ibm.com, zohar@linux.vnet.ibm.com, takedakn@nttdata.co.jp

Subrata Modak wrote:
> On Tue, 2009-06-23 at 19:53 +0900, Tetsuo Handa wrote: 
> > Hello.
> > 
> > I uploaded the programs to http://sourceforge.jp/projects/tomoyo/svn/view/trunk/2.2.x/kernel_test/?root=tomoyo .
> > I'll notify you again when I added more testcases.
> 
> Great. I will see and investigate soon to find out the ways to integrate
> them to LTP. Meanwhile, if you can help us with a Sign-off saying that
> you do not have any issue(s) in integrating the above tests to LTP;
> would be really necessary/helpful.

ccs-patch package (kernel patch for TOMOYO) and ccs-tools package (TOMOYO's
userland programs) are released under the GPL. I have no license issues.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Regards.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
