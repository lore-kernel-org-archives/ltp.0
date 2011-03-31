Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q5K57-0004yP-2D
	for ltp-list@lists.sourceforge.net; Thu, 31 Mar 2011 15:46:45 +0000
Date: Thu, 31 Mar 2011 18:09:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110331160953.GA6673@saboteur.suse.cz>
References: <4D80769F.70202@cn.fujitsu.com>
	<20110323163619.GA7438@saboteur.suse.cz>
	<4D8AA64A.30506@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D8AA64A.30506@cn.fujitsu.com>
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
> >>According to POSIX, many historical implementations (including Version 7
> >>and System V) allow an alarm to occur up to a second early. Other
> >>implementations allow alarms up to half a second or one clock tick early
> >>or do not allow them to occur early at all. That means, the SIGALRM sent
> >>by alarm() could arrive a little earlier. So, even if sem_wait() is
> >>blocked, test could still fail.
> >>Setting a range for time checking would be better. When sem_wait() is
> >>block and then be interrupted by SIGALRM, if the time is in this range,
> >>test is passed.
> >Out of curiosity, what system is this? The signal seems to arrives after
> >more than 1 second on all linux boxes that I have.
> My box is like the following:
> 
> OS: RHEL5.5 x86-64.
> Memory: 2GB
> CPU: Intel(R) Xeon(TM) CPU 3.00GHz (4 CPUs)
> 
> 
> Sometimes it worked normally, but sometimes I got the following messages:
> 
>   Ts: 1300437153.432960442  ->  1300437154.432457949
>   Test ../../../conformance/interfaces/sem_wait/13-1.c
>   FAILED: The sem_wait call did not block

Okay, I've did a little different fix. Now the alarm is set to wait for
two seconds and we expects it to last at least one.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
