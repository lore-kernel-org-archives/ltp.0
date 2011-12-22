Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RdiG1-0003by-RY
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 13:00:25 +0000
Date: Thu, 22 Dec 2011 14:10:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222131006.GC29787@saboteur.suse.cz>
References: <1324006260-10122-1-git-send-email-kai.kang@windriver.com>
	<1324006260-10122-2-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324006260-10122-2-git-send-email-kai.kang@windriver.com>
Subject: Re: [LTP] [PATCH] pthread_mutex_lock/3-1: make sure install signal
 hanldler first
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
To: Kang Kai <kai.kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Import a new semphore semsync2 to sync thread parent and child thread
> 'th_work', so that signal handlers are installed before receive signal
> USR1 and USR2.

Commited, as this is better than the previous state.

However the testcase implementation is quite questionable. It's trying
to hammer the loop with pthread_mutex_lock()/pthread_mutext_unlock()
with signals and the probability of signal arriving at the right time is
not really high.

Far better implementation would lock in the mutex for some time while
the second thread would send the signals meanwhile.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
