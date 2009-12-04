Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1NGhwF-0000p4-7x
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 23:51:51 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGhw7-0000qq-EQ
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 23:51:51 +0000
Message-Id: <4B193E17020000E80005B102@sinclair.provo.novell.com>
Date: Fri, 04 Dec 2009 16:51:35 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [LTP] make and install errors with 20091130 build
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

I've had pretty good success in the past with previous builds of ltp, but have now hit several problems with the latest (20091130) build. 1)  I get compile failures in the initial make with missing libraries for cpuctl(controllers) and sctcp.  I can get around this by drilling down into the testcases sub-dir and 'make' the lib files first then the total make will succeed.  2) 'make install' is no longer installing the testcases/bin sub-dir so runltp fails to even start.  I'm hoping I've just missed something stupid, but a lot has changed in the last several builds around the build and install.

Thanks
Murlin


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
