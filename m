Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TsAJr-0001wE-2P
	for ltp-list@lists.sourceforge.net; Mon, 07 Jan 2013 10:52:39 +0000
Date: Mon, 7 Jan 2013 11:52:47 +0100
From: chrubis@suse.cz
Message-ID: <20130107105247.GA4812@rei>
References: <27EF8FABF41315449203A213FE20131355341D7F@BLR-SJP-MBX-4.wipro.com>
	<20130103112356.GC4780@rei.Home>
	<EAFD815A-FF7B-4FCE-B88D-B1077401C753@gmail.com>
	<27EF8FABF41315449203A213FE201313553430FD@BLR-SJP-MBX-4.wipro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27EF8FABF41315449203A213FE201313553430FD@BLR-SJP-MBX-4.wipro.com>
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
> Thanks for the response, I want to test sound driver releated testing to do playback and capture where, User needs to confirm playback and capture functionlity.
> 
> So, based on User feedback I want flag the testcase pass or fail.

What about physically plugging the output cable to the capture input?
That way you can check that you have recorded something similar to the
sound that has been played. Exact matching would be really hard, but if
you play something like 1Hz sine wave you can simply use fftw library to
match the frequency...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
