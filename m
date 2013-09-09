Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VIzrw-0005su-H0
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 11:43:00 +0000
Date: Mon, 9 Sep 2013 13:43:13 +0200
From: chrubis@suse.cz
Message-ID: <20130909114313.GC18849@rei>
References: <1378318684-29558-1-git-send-email-alexey.kodanev@oracle.com>
	<20130905100351.GB2770@rei> <52286FC2.7000609@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52286FC2.7000609@oracle.com>
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
> > Linux-2.6.37 is quite old, does it compile with Linux-3.10?
> >
> > Ideally it should work with broad range of kernels but that would likely
> > require great number of ifdefs...
> >
> >
> It works fine with 3.10..., 2.6.37 version is just starting point of the 
> range of kernels where it compiles.

That sounds good.

> > It would be better to convert this code to full LTP test so we can drop
> > the ltpapci.sh script.
> >
> > Also there doesn't seem to be any success/failure logic. It looks like
> > the program just opens the device and does some ioctls(). Do you have an
> > idea what is the purpose of this test?
> >
> I have only one intention of this patch - at least, make it compile and 
> run on the latest kernels, but subsequent patches can do the rest, e.g. 
> we can drop ltpacpi.sh, and make use of tst_module_* functions, also 
> return some general status of the acpi functions.

Ok. That is better than nothing. Still we need somebody to look into the
purpose of the test and what assertions it should make.

> It seems the test is checking ACPI kernel API... but I didn't get why 
> this test uses block device... and what is returning from 
> acpi_driver_data(). The test declares its own 'acpi_ec' structure and 
> trying to cast return pointer from acpi_driver_data() to it. But in the 
> kernel, this structure is slightly different (may be it wasn't in kernel 
> 2.6.27) and defined internally. That's why I've commented any use of 
> this structure in the test.
> 
> I'd appreciate any ideas.

Unfortunately I do not have any ideas here. I would try to contact the
original author and/or Linux ACPI maintainers, at least they should know
what to test and why (feel free to CC LTP ML).

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
