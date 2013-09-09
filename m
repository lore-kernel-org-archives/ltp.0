Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VJ3IL-0001Yf-Bq
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 15:22:29 +0000
Date: Mon, 9 Sep 2013 17:22:23 +0200
From: chrubis@suse.cz
Message-ID: <20130909152223.GA4586@rei>
References: <1378729381-32706-1-git-send-email-alexey.kodanev@oracle.com>
	<20130909141126.GB9492@rei> <522DE321.5090701@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <522DE321.5090701@oracle.com>
Subject: Re: [LTP] [PATCH] device-drivers: rtc: minor updates
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
> > Hi!
> >> Makefile updated.
> >> Added .gitignore file.
> >> Added root check and rtc device check.
> > The changes looks good, what about adding the test into kernel_misc
> > runtest file?
> >
> I thought I can do it in separate patches. We have to add device-drivers 
> directory to .../testcases/kernel/Makefile and then  include this test 
> in .../device-drivers/Makefile to build it automatically.
> I've recently sent a patch which is adding Makefile to device-drivers 
> directory, is it OK?

I would split it to patch that adds Makefile into device drivers
directory and adds device-drivers directory into the kernel/Makefile
(assuming that Makefile with empty SUBDIRS is noop) And for each fixed
test a patch that enables subdirectory once test is fixed along with
updating the runtest entry (which is a bit unfortunate as this may
generate collisions if you work on more than one subdir which means that
this patch should be done only once the test fix is acked). If you are
OK with that, let's start with rtc test.

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
