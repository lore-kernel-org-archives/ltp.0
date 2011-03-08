Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <mwenzel@novell.com>) id 1Pwz5a-0005nX-A1
	for ltp-list@lists.sourceforge.net; Tue, 08 Mar 2011 15:44:46 +0000
Received: from novprvoes0310.provo.novell.com ([137.65.248.74])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pwz5Z-00047C-D1
	for ltp-list@lists.sourceforge.net; Tue, 08 Mar 2011 15:44:46 +0000
Message-Id: <4D75E7B9020000E800071530@novprvoes0310.provo.novell.com>
Date: Tue, 08 Mar 2011 08:24:25 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [LTP] pidns errors
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
To: ltp-list <ltp-list@lists.sf.net>

Are there still known issues with the pidns tests and 20110228 stable release?  I've got the same failure on 2 unrelated pieces of hardware but both running SLE11SP1 (2.6.32) kernel.  The pidns tests just hang with multiple child processes.  I haven't started debugging yet, but it looks like a signal problem in the child processes.

Thanks
Murlin


------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
