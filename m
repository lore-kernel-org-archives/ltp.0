Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPUXb-000501-Cw
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 11:49:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPUXX-00069N-GG
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2015 11:49:55 +0000
Date: Wed, 12 Aug 2015 13:49:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150812114923.GC32393@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-19-git-send-email-alexey.kodanev@oracle.com>
	<20150811182857.GE24227@rei.suse.de> <55CB31E5.1050808@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55CB31E5.1050808@oracle.com>
Subject: Re: [LTP] [PATCH 18/23] network/virt: move checking for command
 support to virt_lib.sh
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > I would rather see the test doing TCONF for unsupported options and
> > skipping the actual test. And I know that getting TCONF for testcases
> > that only skip one test out of many is annoying, which is why I'm
> > pondering a plan to change bitflags in the test library (both C and bash
> > one) to counters so that we can say how much of the testcase was
> > actually skipped.
> 
> That is a great news! OK, I will use TCONF. Will counters be added in 
> the ltp-pan log file?

I hope so. I was thinking of producing logfiles in different standart
formats as well. There are at least TAP[1] that comes from perl
community and JUnit that comes from Jenkins.

[1] https://testanything.org/

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
