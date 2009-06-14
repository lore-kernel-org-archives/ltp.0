Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1MFpXM-0000mS-3K
	for ltp-list@lists.sourceforge.net; Sun, 14 Jun 2009 13:14:16 +0000
Received: from wine.ocn.ne.jp ([122.1.235.145] helo=smtp.wine.ocn.ne.jp)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MFpXH-0000Jx-PG
	for ltp-list@lists.sourceforge.net; Sun, 14 Jun 2009 13:14:16 +0000
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1244775226.4982.3.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1244775226.4982.3.camel@subratamodak.linux.ibm.com>
Message-Id: <200906142044.ACJ21831.VHOJSFLtFOQOFM@I-love.SAKURA.ne.jp>
Date: Sun, 14 Jun 2009 20:44:34 +0900
Mime-Version: 1.0
Subject: Re: [LTP] [003][RFC] [TESTING linux-2.6.30] TOMOYO Linux and
	pathname-basedsecurity
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

Hello.

Sorry for late response. I had no internet access for three days.

Subrata Modak wrote:
> We would like to inform you that we have some robust sets of testcases
> for both SELinux, SMACK, IMA, etc at
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/.
> And i would express to have TOMYO being tested through LTP. If you agree
> to contribute some test cases in this regard to LTP under GPLv2, we can
> make a modest but great beginning. What do you say ?

Yes, we are willing to contribute TOMOYO's test cases to LTP.
Currently, we are using testing programs available at
http://sourceforge.jp/projects/tomoyo/svn/view/trunk/1.6.x/ccs-tools/ccstools/kernel_test/?root=tomoyo
But they are not some shell scripting programs.
Thus, I need to remake these programs to follow LTP conventions.
Can I have some documentation regarding how to write LTP testing programs?

Regards.

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
