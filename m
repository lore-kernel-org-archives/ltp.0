Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VJOBW-0000Om-3B
	for ltp-list@lists.sourceforge.net; Tue, 10 Sep 2013 13:40:50 +0000
Date: Tue, 10 Sep 2013 15:41:03 +0200
From: chrubis@suse.cz
Message-ID: <20130910134103.GA25190@rei.Home>
References: <1378729381-32706-1-git-send-email-alexey.kodanev@oracle.com>
	<20130909141126.GB9492@rei> <522DE321.5090701@oracle.com>
	<20130909152223.GA4586@rei> <20130910124732.GA24708@rei.Home>
	<522F2003.5010101@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <522F2003.5010101@oracle.com>
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
> > Note that I've renamed the rtc-test to rtc01 so that the binary name
> > matches the test name (TCID) and fixed the runtest entry (you had it
> > wrong anyway the first string is test name and the rest is the
> > commandline to execute).
> Thanks, I missed it :)
> I have a quick question concerning SUBDIRS in the 
> ..../device-drivers/Makefile: should we keep test directories in 
> alphabetical order?

Yes please.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
