Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RlgfK-00073p-Qt
	for ltp-list@lists.sourceforge.net; Fri, 13 Jan 2012 12:55:30 +0000
Date: Fri, 13 Jan 2012 14:07:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120113130703.GA14943@saboteur.suse.cz>
References: <20120111125642.GD7143@saboteur.suse.cz>
	<aa1139e7-47d6-40d4-8406-4cef27343f29@zmail16.collab.prod.int.phx2.redhat.com>
	<20120111143418.GB7146@saboteur.suse.cz>
	<201201130101.06630.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201130101.06630.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
 duplicated output
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > There are two ways to fix this, either create tst_fork() that flushes
> > the buffers before forking. This may be problematic as there is a need
> > for replacing fork() with tst_fork() in several testcases.
> 
> if we wanted to be lazy, it would be easy to catch.  in our test.h:
> 	#define fork() tst_fork()
> then in the single file defining tst_fork(), we do:
> 	#undef fork
> or forcing it via:
> 	#define fork() __use_tst_fork()
> 
> but we already have to track in the ltp tests where fork() is used since this 
> breaks NOMMU builds (i.e. UCLINUX), so it's not like we don't already have 
> this issue.

I don't like idea of defining fork to tst_fork that's exactly the
magic that may take hours to figure out.

Forcing it, in this case, is probably good idea.

> > Or we could flush the output after each test message is printed with
> > tst_resm(). That is IMHO ideal solution. The only drawback is that this
> > may interfere with timings in some testcases (but testcases that expects
> > exacts timings are usually broken anyway).
> 
> i agree those tests are broken if the flushing causes issues due to a slow 
> down.  however, slow downs in general are not a good thing, especially when 
> these are only needed for apps that fork.  i'd like to think we could do 
> better.

Still I'm slighlty for this one. In general case, flushing the buffer
often is bad, but considering relatively rare usage of tst_resm() the
slowdowns woudn't be most likely measurable (and it's flushed after
every '\n' when you run the test in the terminal anyway).

Side effects of this are generally possitive too, the messages from
parent and child, or several threads wouldn't be so badly intermixed in
the output.

> a third option would be to use pthread_atfork().  no tracking needed in random 
> tests since we can call this in the common ltp init func.  downside is we'd 
> have to use -pthread in our CFLAGS.
> 
> $ cat test.c
> #include <pthread.h>
> #include <stdio.h>
> void prep(void) { fflush(stdout); }
> int main(){
> 	printf("foo\n");
> 	pthread_atfork(prep, NULL, NULL);
> 	fork();fork();fork();fork();
> 	return 0;
> }
> $ gcc -pthread test.c && ./a.out | cat
> foo

The -phtread changes several definitions in glibc headers so adding it
globally for all the tests seems wrong.

> a fourth option would be to include <bits/libc-lock.h> and use 
> __libc_atfork(), but this would be glibc specific :(.

Yeah, another no go option.

> a fifth option would be to use libdl, override the fork() symbol with our own 
> and then dlsym() to the direct fork() symbol.  but like the pthread solution, 
> this would require linking all apps with -ldl, and it would only work on ELF 
> based systems (so it would break embedded things like FLAT on NOMMU).

Not to mention, this is starting to fall into 'overcomplicated solutions'
category. I would like to keep things as simple as possible.

> so all in all, i think the tst_fork() is the best way to go.  if tracking 
> really gets out of hand, since the compile+link steps are in common .mk code, 
> it'd be easy to add a post-link test that looks to see if the ELF uses fork() 
> without calling tst_fork() ...

As I said above, I'm slightly for flushing buffers in the library code,
but generally either of these two would do.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
