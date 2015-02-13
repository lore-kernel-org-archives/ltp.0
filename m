Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YMJ7Y-0006FY-8H
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 16:29:36 +0000
Date: Fri, 13 Feb 2015 17:29:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150213162915.GA8996@rei.suse.de>
References: <20150212165921.GA27008@rei>
 <54DDD96D.3020304@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54DDD96D.3020304@redhat.com>
Subject: Re: [LTP] prototyping new library synchronization
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Some notes;
> 
> I assume you used syscall(SYS_futex, ..) instead of pthread_mutex (which
> uses it internally) because of the linking simplicity, right?
> Fair tradeoff.

Not only. As far as I know pthread_mutexes use private futexes and as
far as I understand these these will not work with forked processes. Or
at least are not expected to be used that way I haven't actually tried
it.

> No idea what you're going to use for the final code, but I'd default to
> 
>   perror("open()");
> 
> instead of
> 
>   fprintf(stderr, "open(): %s\n", strerror(errno));
> 
> (you also don't need errno.h for the former one).

The code is just quick test. I will desing proper library functions
later.

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
