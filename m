Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Odo76-0005Bi-Vc
	for ltp-list@lists.sourceforge.net; Tue, 27 Jul 2010 17:38:48 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Odo75-0000Xk-Vw
	for ltp-list@lists.sourceforge.net; Tue, 27 Jul 2010 17:38:48 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 27 Jul 2010 18:26:39 +0530
Message-Id: <1280235406.5076.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] LTP Build also compiling OPEN_POSIX !!
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Garrett,

LTP Build is also compiling OPEN_POSIX_TESTSUITE. I think it is better
to put it outside the purview of Default LTP build. Let it be built
standalone as and when required by user. The Open_Posix build is taking
much time to complete and hence delaying other LTP builds :-(

Regards--
Subrata



------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share 
of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
