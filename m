Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VLaK7-00077o-KN
	for ltp-list@lists.sourceforge.net; Mon, 16 Sep 2013 15:02:47 +0000
Date: Mon, 16 Sep 2013 17:03:02 +0200
From: chrubis@suse.cz
Message-ID: <20130916150302.GA31089@rei.suse.cz>
References: <1378895508-28703-1-git-send-email-alexey.kodanev@oracle.com>
	<1378895508-28703-2-git-send-email-alexey.kodanev@oracle.com>
	<20130916130318.GA19644@rei.suse.cz> <523714C8.1090504@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <523714C8.1090504@oracle.com>
Subject: Re: [LTP] [PATCH v2 2/2] device-drivers: block: fixes
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
> > Now that we have more uses of this Make recipe I would love to see it
> > moved to a file under include/mk/ to avoid duplication.
> >
> module.mk is OK?

OK

> > Hmm, wouldn't this print FAIL and the SUCCESS in case the test failed?
> > (as the main loop prints SUCCESS unconditionally)
> In case of insmod error, tst_module_load() will call cleanup function 
> (we're passing tst_fail()) and then test exit with TBROK and it will 
> never print PASS.
> > Shouldn't we rather set a flag here (reset it before each test) and
> > print PASS/FALL accordingly?
> >
> This function will be called after test-case failure only once.

Ah, so we abort the testing after first failure due to the
tst_brkm(TBROK, ...) in tst_run_cmd(). This is not 100% correct as the
test exit value would say both TBROK and TFAIL (if I'm not mistaken
these would be simply added to the return mask and reported to the upper
layer, i.e. ltp-pan). It would be better to report failure only, but
that would either require changes to the test reporting (probably file
in sysfs or debugfs) or new test function such as tst_try_load_module()
or similar.

> > How do we distinguish missing module (due to possible compilation
> > failure) and test failure?
> dmesg output can be inspected. If test fail module will print message 
> with description.

I see that this is settled in the tst_module_load() that calls
tst_module_exists() first, so if there is no module the result is TCONF,
so this works well without any further effort. I should have checked
that myself before asking.

> >> +}
> >> +
> >> +static void test_run(void)
> >> +{
> >> +	int off = 0;
> >> +	int test_case[] = { 1, 2, 5, 3, 4, 10, 6, 7, 8 };
> > What a strange sequence. Is this order of testcases required? Why we
> > have testcase 10 but not testcase 9?
> >
> I think this is a sequence where test-cases's harmless decreasing to the 
> end. Perhaps, there were more test-cases earlier... I'm not an author of 
> this test, so I can only guess.

That makes sense but I guess that we can simply renumber them and get
rid of the magic translation table...

> >> +	/*
> >> +	 * test-cases #7 and #8 can crash the kernel.
> >> +	 * We have to wait for kernel fix where register_blkdev()&
> >> +	 * unregister_blkdev() checks the input device name parameter
> >> +	 * against NULL pointer.
> >> +	 */
> >> +	if (!run_all_testcases)
> >> +		off = 2;
> > Are you working on fix with kernel devs?
> >
> Not me, patch sent to upstream: 
> http://www.gossamer-threads.com/lists/linux/kernel/1780670

Ok.

Looking at the patch, is calling with NULL name even supported, given
that the code causes Oops I would say no. But let's wait for resolution
from kernel guys.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
