Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mmowu-0004w3-49
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:00 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mmowm-0002Cu-RO
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:00 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sun, 13 Sep 2009 18:46:22 +0530
Message-Id: <1252847784.5357.32.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [Testing 2.6.31] Minimal IMA policy and boot param for TCB
	IMA	policy
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
To: Mimi Zohar <zohar@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>

Hi Mimi,

I remember talking to you for IMA test cases evaluation during 2.6.30
release. Now, with the above changes in IMA policies under 2.6.31
kernel, would you like to submit some fresh patches for the LTP IMA test
cases ?

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5789ba3bd0a3cd20df5980ebf03358f2eb44fd67,
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=659aaf2bb5496a425ba14036b5b5900f593e4484,

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
