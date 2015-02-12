Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YLvJZ-0007aa-0u
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 15:04:25 +0000
Date: Thu, 12 Feb 2015 16:04:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150212150401.GA27909@rei>
References: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
	<1415206150-12848-1-git-send-email-mmarhefk@redhat.com>
	<20141202164235.GA22135@rei.suse.de>
	<1962544618.7994595.1417604885928.JavaMail.zimbra@redhat.com>
	<20141217141028.GA17634@rei>
	<939621071.8375320.1423670135099.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <939621071.8375320.1423670135099.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2] containers: added mountns/mountns05.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >There are a few things I do not like about this solution:
> >
> >* There is a static IPC key compiled in the source
> >  - we cannot run two instances of the test at once
> >  - it may interfere with the rest of the system
> 
> Agree on that, I should rewrite it to use ftok() to get a key.

ftok() on a a path under tst_tmpdir() should be reasonably random, but
still it's a global resource...

> >
> >* There are no timeouts, if something fails the parent may end up
> >  waiting forever
> >
> 
> This shouldn't happen as whole code contains error checking. If something
> fails it also removes the message queue and according to the man page removing
> the message queue also does "awakening all waiting reader and writer processes
> (with an error return and errno set to EIDRM)".

Missed that. This should work fine in this case.

> >Internally we can just reuse the tst_checkpoint_child_wait() and
> >tst_checkpoint_signal_parent() code (move it to separate static
> >functions and add a parameter with the character to be send/received).
> >
> >Would that solve the problem here or are there any other obstacles?
> >
> 
> In this case 3 pipes would have to be used anyway. The solution
> with only one sysv message queue seems just better at least for me
> plus it's just for this one specific test case.

I've sumarized my points in:
https://sourceforge.net/p/ltp/mailman/message/33204261/

The major point is to avoid sysv ipc in testcases that does not test
sysv ipc.

But we may be able to build something better than fifos with POSIX
shared memory (shm_open()) and futexes. I've looked into this recently.
The code would be quite easy to write as all we need is a page of shared
memory that would provide space for 128 futexes and implementing
timeouts is as easy as passing struct timespec to the FUTEX_WAIT
function.

So we will have one init function to create shared memory page and then
a pair of wait and wake functions with an offset to the page (selects
which futex to wait for).

The only scenario that would be a bit more complicated is the case where
code that waits is needed after exec(). For this case we need to open
and map the same shared memory segment, i.e. need to know the name to
pass to the shm_open() but we can pass it to the child as a parameter.

I will try to prototype the code and test it on older distributions
hopefully soon enough.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
