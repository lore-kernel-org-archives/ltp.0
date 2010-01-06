Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NSXrr-00056B-NT
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 15:32:15 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSXrp-00019K-EP
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 15:32:15 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 06 Jan 2010 10:25:48 -0500
Message-Id: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: [LTP] regression:  selinux testsuite broken since October
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
To: ltp-list@lists.sourceforge.net
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

It seems the Makefile rewrite last October broke the selinux testsuite.
Is it unreasonable to expect that someone who rewrote the Makefile would
actually try running the testsuite?

Please, revert the changes or fix them.

See testcases/kernel/security/selinux-testsuite/README for the
instructions.

-- 
Stephen Smalley
National Security Agency


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
