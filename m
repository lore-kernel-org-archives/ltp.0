Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmmJB-0004wS-Gm
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 15:50:29 +0000
Date: Tue, 20 May 2014 17:50:18 +0200
From: chrubis@suse.cz
Message-ID: <20140520155018.GA30538@rei.suse.cz>
References: <1398159613.2772.7.camel@G08JYZSD130126>
	<1398159660.2772.8.camel@G08JYZSD130126>
	<64087164.7823458.1398172479616.JavaMail.zimbra@redhat.com>
	<1398225094.3850.1.camel@G08JYZSD130126>
	<1398225176.3850.3.camel@G08JYZSD130126>
	<229210287.8574143.1398252556096.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <229210287.8574143.1398252556096.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/2] sbrk/sbrk02.c: add ENOMEM errno test
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> looks good to me. I saw sbrk02 taking up to couple seconds
> to complete on some systems, but that seems acceptable.
> If anyone objects, we could change setup() to increment
> even more rapidly.

Generally the testrun should be as fast as possible (think of a farm of
kernel builders that gets latest kernel git, compiles it and runs
tests). So ideally each testcase should not run longer than is needed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
