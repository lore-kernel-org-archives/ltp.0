Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vlzwr-0001Tl-OH
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 11:39:57 +0000
Date: Thu, 28 Nov 2013 12:39:28 +0100
From: chrubis@suse.cz
Message-ID: <20131128113928.GC19263@rei.Home>
References: <1384784307-28731-1-git-send-email-alexey.kodanev@oracle.com>
	<1384784307-28731-2-git-send-email-alexey.kodanev@oracle.com>
	<20131127180449.GA8163@rei> <529725F3.6040002@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529725F3.6040002@oracle.com>
Subject: Re: [LTP] [PATCH v4 2/2] device-drivers: acpi: fixes
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
> >> +	while (i < TST_TOTAL) {
> >> +
> >> +		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
> >> +		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
> >> +
> >> +		tst_resm(res, "Test-case '%d'", i);
> >> +
> >> +		/*
> >> +		 * trigger ACPI_TRAVERSE test-case while we can
> >> +		 * get valid next device description.
> >> +		 */
> >> +		if (i == ACPI_TRAVERSE && next_acpi_str())
> >> +			continue;
> > The same goes for the tst_resm() here.
> >
> > I would write this part so that reading the sys_str file triggers
> > walking to next object with _STR argument, while writing to dev_tcase
> > will reset the walk to root and wrote a code as:
> >
> > 	SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
> > 	SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
> >
> > 	if (i == ACPI_TRAVERSE)
> > 		res = next_acpi_str();
> >
> > 	tst_resm(...);
> >
> > And the next_acpi_str() would loop on reading the dev_str while "null"
> > is returned. Or even better make the read returns zero size at the end,
> > (should be mapped to EOF in case of FILE*).
> OK
> > Also I would be more carefull and rather sanitized the result value, i.e.
> >
> > 	tst_resm(ret ? TFAIL : TPASS, "...");
> If I do that way, next_acpi_str could also return TCONF (kernel version 
> lower than 3.7) and then we would get TFAIL in the test-case result.

Ah, hmm, so what about:


	SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
	SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);

	res = res ? TFAIL : TPASS;

	if (i == ACPI_TRAVERSE)
		res = next_acpi_str();

	...


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
