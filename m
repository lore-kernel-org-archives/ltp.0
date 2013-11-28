Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vm0Po-0007vF-IQ
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 12:09:52 +0000
Date: Thu, 28 Nov 2013 13:09:23 +0100
From: chrubis@suse.cz
Message-ID: <20131128120923.GD19263@rei.Home>
References: <1384784307-28731-1-git-send-email-alexey.kodanev@oracle.com>
	<1384784307-28731-2-git-send-email-alexey.kodanev@oracle.com>
	<20131127180449.GA8163@rei> <529725F3.6040002@oracle.com>
	<20131128113928.GC19263@rei.Home> <52972F1C.3020504@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52972F1C.3020504@oracle.com>
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
> All right, something like this is OK?
> 
> for (i = 0; i < TST_TOTAL; ++i) {
> 
> 	if (i == ACPI_TRAVERSE) {
> 		res = tc_acpi_str();
> 	} else {
> 		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i);
> 		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &res);
> 		res = res ? TFAIL : TPASS;
> 	}
> 
> 	tst_resm(res, "Test-case '%d'", i);
> }
> 
> And tc_acpi_str will have a loop to read the dev_str file until NULL, 
> because fgets returns a pointer.

Sounds good.

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
