Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VVgsy-00085F-5k
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 12:04:32 +0000
Date: Mon, 14 Oct 2013 14:04:19 +0200
From: chrubis@suse.cz
Message-ID: <20131014120419.GB4593@rei>
References: <1380029829-8113-1-git-send-email-alexey.kodanev@oracle.com>
	<1380029829-8113-2-git-send-email-alexey.kodanev@oracle.com>
	<20131002141537.GA727@rei.suse.cz> <5253F867.3030307@oracle.com>
	<20131014100332.GA1278@rei> <525BD42C.1050703@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <525BD42C.1050703@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] device-drivers: pci: fixes
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
> >>> So the while cycle runs for all pci devices? How does this works?
> >>>
> >>> It seems to run all tests then increment pci_device until test number
> >>> zero fails. This needs to cleaned up so that the codeflow is less
> >>> cryptic. Or at least deserves a comment what is done and why.
> >>>
> >> Yes, my intention was to perform all test-cases with all available
> >> pci-devices, not just with the first found. This behavior managed by
> >> user-space test, so may be add a cmd-line option like test all or first
> >> found pci-device(s)?
> > No need for that. What I do not like on the test is that there is no
> > correspondence between the pci device number in the userspace and in the
> > test module, i.e. the pci_number is incremented automagically in the
> > module once all tests are executed. This is hard to figure out. It would
> > be better if we had explicit mechanism for that, for example sysfs file
> > you write the number to (and get -EINVAL if the number is out of range).
> OK, I'll make "bus_dev" sysfs file, 0-7 bits for device number, 8 - 15 
> bits for bus number... is it ok?

Sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
