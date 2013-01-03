Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Tqitq-0001u4-C4
	for ltp-list@lists.sourceforge.net; Thu, 03 Jan 2013 11:23:50 +0000
Date: Thu, 3 Jan 2013 12:23:57 +0100
From: chrubis@suse.cz
Message-ID: <20130103112356.GC4780@rei.Home>
References: <27EF8FABF41315449203A213FE20131355341D7F@BLR-SJP-MBX-4.wipro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27EF8FABF41315449203A213FE20131355341D7F@BLR-SJP-MBX-4.wipro.com>
Subject: Re: [LTP] Getting User input data not working
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
To: subashchandra.bose@wipro.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am using LTP drop released on ltp-full-20120104 version.
> I have written a testcase to get user input data and call that testcase using "runltp", the command I use to get user input data is "read -t 10 response"
> But, when enter user input after running "runltp" it is not working. The same testcase is working fine getting user input from command line.
> Can any one help me why it is not working in LTP, is there any work around on this?

Apart form this being a silly idea (LTP is automatic testsuite, you
install it, run it and go away till it's finished) the tests are
executed by the test driver process (ltp-pan) that is a process group
leader so there is no way they could read from standard in.

[This is second attempt to send this mail, the first seems to have
disapeared somewhere between our mailserver and ltp mailing list]

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
