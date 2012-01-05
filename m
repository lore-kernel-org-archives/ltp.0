Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RipxZ-0004wT-SA
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 16:14:33 +0000
Date: Thu, 5 Jan 2012 17:25:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105162526.GB22435@saboteur.suse.cz>
References: <1324869052-22433-1-git-send-email-jin.li@windriver.com>
	<20111230143413.GA29431@saboteur.suse.cz>
	<4F050549.3060805@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F050549.3060805@windriver.com>
Subject: Re: [LTP] [PATCH] This fix make sure the function "setpgid" get
 invoked in the right time in setpgid03 test02.
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
To: Jin Li <Jin.Li@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I'm afraid that I don't agree with you. The child and father get the
> same schedule priority. So during the 5s sleeping of father, the
> child have enough time to run "setpgid". Here is just a execution
> sync-up that make sure the "execlp" is invoked  just  before the
> "setpgid" get invoked in father.

Well yes and no. This is exactly the case where the tests would work
fine most of the time, but may generate false regressions from time to
time.

You can't really say that some process will be schedulled during some
time on multitasking system, you may only say that it's likely.

-- 
Cyril Hrubis
chrubis@suse.cz

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
