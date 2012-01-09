Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RkD65-0003zJ-3H
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 11:09:01 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RkD5z-0002UJ-FB
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 11:09:01 +0000
Message-ID: <4F0ACAC0.6010309@imgtec.com>
Date: Mon, 9 Jan 2012 11:08:48 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Subject: [LTP] Split UCLIBC and UCLINUX test cases
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

Hello,

Right now the use of UCLINUX implies the use of __UCLIBC__ as well. Even 
though this is true from UCLINUX's perspective, it is not valid from the 
uclibc's one. A non-uclinux system can perfectly work with uclibc. What 
I suggest is to keep the UCLINUX option as is, but also add a new option 
called UCLIBC which will enable us to avoid all the restrictions imposed 
by the use of UCLINUX macro (especially the disabled tests in 
testcases/kernel/systecall/Makefile).

-- 
markos


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
