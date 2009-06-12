Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MEwtv-00042v-J0
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 02:53:55 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEwtt-0004P8-An
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 02:53:55 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2009 08:23:45 +0530
Message-Id: <1244775226.4982.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [003][RFC] [TESTING linux-2.6.30] TOMOYO Linux and
	pathname-based	security
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
To: Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Toshiharu Harada <haradats@nttdata.co.jp>
Cc: ltp-list <ltp-list@lists.sf.net>, Stephen Smalley <sds@tycho.nsa.gov>, Casey Schaufler <casey@schaufler-ca.com>, Serge Hallyn <serue@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>

Hello Kentaro-san,

With TOMOYO Linux emerging as alternative Mandatory Access Control
alongside SELinux & SMACK in linux-2.6.30, would you like to share the
testing infrastructure of TOMYO with The Linux Test Project
(http://ltp.sf.net).

We would like to inform you that we have some robust sets of testcases
for both SELinux, SMACK, IMA, etc at
http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/security/.
And i would express to have TOMYO being tested through LTP. If you agree
to contribute some test cases in this regard to LTP under GPLv2, we can
make a modest but great beginning. What do you say ?

Regards--
Subrata



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
