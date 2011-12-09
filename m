Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RZ09o-0008Vj-7V
	for ltp-list@lists.sourceforge.net; Fri, 09 Dec 2011 13:06:32 +0000
Date: Fri, 9 Dec 2011 14:15:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111209131504.GB6208@saboteur.suse.cz>
References: <4EE1DC85.3060301@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EE1DC85.3060301@windriver.com>
Subject: Re: [LTP] Question about priority of pthread rwlock on linux
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am working on Yocto( a kind of  embedded linux) to make POSIX test
> cases pass. It uses kernel 3.0 and eglibc 2.3.
> 
> There are 3 failed test cases about pthread rwlock:
> pthread_rwlock_rdlock/2-1 pthread_rwlock_rdlock/2-2
> pthread_rwlock_unlock/3-1
> 
> In pthread_rwlock_rdlock/2-1,  main thread*read lock* a rwlock,
> child thread1 *write lock* the rwlock with a medium priority, so it
> should be blocked. child thread2 try to *read lock *the rwlock with
> low priority, the case says child thread2 should block too. But in
> Yocto linux child thread2 doesn't block and then read lock the
> rwlock, that make test case fail.
> 
> In eglibc nptl implementation, rwlock has a element "__flags" to
> identify prefer write lock or read lock, default is to prefer read
> lock. If change __flags to prefer write lock, the test case will
> pass.
> 
> My questions are:
> 1 What is the test case base on? I checked the  POSIX.1-2008 but
> didn't find description priority about the pthread rwlock? Could
> anyone give me a source that make me to understand it better?
> 2 Which C library or platform can make this case pass? So that I can
> compare it with eglibc.

These doesn't work with glibc either, see:

http://old.nabble.com/pthread_rwlock_rdlock%28%29-p32423548.html

I haven't got any reply though :(.

The newer POSIX explicitly says that reader thread acquires the lock if
no writer is holding the lock and no writers are locked on the lock. And
it seems that previous standards specified the case of locked writing
threads as implementation defined...

http://pubs.opengroup.org/onlinepubs/007904975/functions/pthread_rwlock_rdlock.html


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point of 
discussion for anyone considering optimizing the pricing and packaging model 
of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
