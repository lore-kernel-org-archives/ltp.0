Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MmoxF-0005iT-Mn
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:21 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mmox7-0007EJ-I3
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:21 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sun, 13 Sep 2009 18:46:37 +0530
Message-Id: <1252847799.5357.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [Testing 2.6.31] SELinux: Permissive domain in userspace
	object	manager
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, Eric Paris <eparis@redhat.com>, KaiGai Kohei <kaigai@ak.jp.nec.com>

Hi Stephen,

I am aware that you had done huge changes to the LTP SELinux test suite
few months back. I am just eager to know if you would like to add
something into it due to changes in 2.6.31 kernel:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8a6f83afd0c5355db6d11394a798e94950306239,

Regards--
Subrata



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
