Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mmox2-0005hl-HR
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:08 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mmowv-0002EJ-Fb
	for ltp-list@lists.sourceforge.net; Sun, 13 Sep 2009 13:17:08 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Sun, 13 Sep 2009 18:46:26 +0530
Message-Id: <1252847788.5357.33.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [Testing 2.6.31] smack: implement logging V3
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
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Eric Paris <eparis@redhat.com>, Etienne Basset <etienne.basset@numericable.fr>, James Morris <jmorris@namei.org>

Hi Casey,

Would you like to revisit the LTP SMACK tests after 2.6.31 is released
with the following SMACK changes for both 2.6.30 and 2.6.31:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6e837fb152410e571a81aaadbd9884f0bc46a55e,
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ecfcc53fef3c357574bb6143dce6631e6d56295c,

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
