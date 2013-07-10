Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwxKv-0005z4-PF
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 16:33:49 +0000
Date: Wed, 10 Jul 2013 18:35:26 +0200
From: chrubis@suse.cz
Message-ID: <20130710163525.GA20440@rei.Home>
References: <1373467521-2291-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373467521-2291-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/4] pthread_cond_timedwait/2-4: allow
 pthread_mutex_trylock return EDEADLK
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> POSIX said: (Sure it is unclear)
> The pthread_mutex_lock() function shall fail if:
> 
> [EDEADLK]
>     The mutex type is PTHREAD_MUTEX_ERRORCHECK and the current thread already owns the mutex.
> 
> The pthread_mutex_trylock() function shall fail if:
> 
> [EBUSY]
>     The mutex could not be acquired because it was already locked.
> 
> So we should allow pthread_mutex_trylock return EDEADLK or EBUSY
> when the mutex is already owned.

Looking at the POSIX spec the EDEADLK is specified as possible error
__only__ for pthread_mutex_lock().

So if pthread_mutex_trylock() returned EDEADLK your libc is buggy. Where
have you seen this happen? 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
