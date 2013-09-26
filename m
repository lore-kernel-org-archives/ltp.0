Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VP9W9-0008E9-Hr
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 11:13:57 +0000
Date: Thu, 26 Sep 2013 13:14:17 +0200
From: chrubis@suse.cz
Message-ID: <20130926111417.GB14003@rei.suse.cz>
References: <52330323.6020702@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52330323.6020702@oracle.com>
Subject: Re: [LTP] ACPI test
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
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> I'm reviewing Linux Test Project's test concerning ACPI and a little bit 
> lost with the following test: 
> https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/device-drivers/acpi. 
> It's quite outdated...
> 
> Pardon my technical knowledge on this subject but could you guide me to 
> solve the following questions about the test and ACPI:
> 
> * Is it necessary to use block device to test ACPI functionality as test 
> does?
> 
> * How can I verify data which I get from acpi_driver_data() using random 
> acpi device handle? The test is using its own 'acpi_ec' structure and 
> trying to cast return void pointer from that function to it, but in the 
> kernel, this structure is slightly different and defined internally.
> 
> May be you have some thoughts how ACPI test should look like? Any help 
> is appreciated.

I guess that we are being ignored, that is sad.

Let's commit at least the patch that makes the code compile and left it
there for now. Perhaps somebody will come and do something with the code
later. Are you OK with that?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
