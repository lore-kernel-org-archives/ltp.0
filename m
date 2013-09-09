Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VJ24L-0004tw-QO
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 14:03:57 +0000
Date: Mon, 9 Sep 2013 16:04:10 +0200
From: chrubis@suse.cz
Message-ID: <20130909140410.GA9492@rei>
References: <1378318684-29558-1-git-send-email-alexey.kodanev@oracle.com>
	<20130905100351.GB2770@rei> <52286FC2.7000609@oracle.com>
	<20130909114313.GC18849@rei> <522DC023.2090902@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <522DC023.2090902@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: acpi: update for Linux kernel
 2.6.37+
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> It seems the test is checking ACPI kernel API... but I didn't get why
> >> this test uses block device... and what is returning from
> >> acpi_driver_data(). The test declares its own 'acpi_ec' structure and
> >> trying to cast return pointer from acpi_driver_data() to it. But in the
> >> kernel, this structure is slightly different (may be it wasn't in kernel
> >> 2.6.27) and defined internally. That's why I've commented any use of
> >> this structure in the test.
> >>
> >> I'd appreciate any ideas.
> > Unfortunately I do not have any ideas here. I would try to contact the
> > original author and/or Linux ACPI maintainers, at least they should know
> > what to test and why (feel free to CC LTP ML).
> >
> It would be great!

I'm not sure that we understand each other well here. I proposed that,
in your place, I would try to contact the devs. I can send the email
myself but as you started to work on the code in question you are better
qualified to ask.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
