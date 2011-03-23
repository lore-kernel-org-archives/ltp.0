Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q2Qgv-0006KM-MF
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 16:13:49 +0000
Date: Wed, 23 Mar 2011 17:36:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110323163619.GA7438@saboteur.suse.cz>
References: <4D80769F.70202@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D80769F.70202@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH] sem_wait: Setting a range for time
 checking.
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> According to POSIX, many historical implementations (including Version 7 
> and System V) allow an alarm to occur up to a second early. Other 
> implementations allow alarms up to half a second or one clock tick early 
> or do not allow them to occur early at all. That means, the SIGALRM sent 
> by alarm() could arrive a little earlier. So, even if sem_wait() is 
> blocked, test could still fail.
> Setting a range for time checking would be better. When sem_wait() is 
> block and then be interrupted by SIGALRM, if the time is in this range, 
> test is passed.

Out of curiosity, what system is this? The signal seems to arrives after
more than 1 second on all linux boxes that I have.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
