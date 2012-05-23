Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SX8bh-0008Sl-II
	for ltp-list@lists.sourceforge.net; Wed, 23 May 2012 10:15:53 +0000
Date: Wed, 23 May 2012 12:13:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120523101319.GB23311@saboteur.suse.cz>
References: <CAGH67wSN3uk5v5F=ZBsEGuNCZgEsfwNnQZmEjVPmCjY6fdRtqw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wSN3uk5v5F=ZBsEGuNCZgEsfwNnQZmEjVPmCjY6fdRtqw@mail.gmail.com>
Subject: Re: [LTP] "more-syscalls" branch
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
>     In order to get LTP more up to date and expand breadth of syscall
> requirements testing, I'm going to be working on adding more syscall
> tests to LTP over the next couple weeks. I started out with
> inotify(7), but I want to move on to newer syscalls that exercise MI
> (machine independent) functionality, while at the same time do not
> want to duplicate work being done by others elsewhere.
>     The long and short of it is that I want to update Linux compat in
> FreeBSD (or at least provide the tests to do that) and in order to
> achieve that, I need up-to-date testcases that pass on an older
> version of Fedora running 2.6 (say Fedora 10) and Fedora 17 (runs
> 3.3). The current testcases are ok, but not exhaustive in all areas
> and that's what I'm aiming to improve.

That is really good news. It kind of clashes with what Marios is doing
during GSOC, but I guess that there is enough room for both of you and
Marios will be, for a next couple of weeks, still working on cleaning up
the lib/*.

>     Thoughts on this and also an idea of where we need to add more
> exhaustive testcases (otherwise I'll have to work through the list and
> pore over manpages looking for my next "target" :)..)?

Hmm, I would start by fixing what is broken. We do have some testcases
that are very poorly implemented and even aren't executed in default run
(diff of runtest files and list of created binaries may help).

For example sig{timed}wait{info} testcases seems to be confused if they
are testing syscall or libcall (you can't get ENOSYS in case of libcall
as the arguments are dereferenced in userspace before passed to the
kernel). And the way several tests are created from one source depending
on -Dxxx passed on commandline is really confusing...

Also it may be better for you to fork the LTP repo on github for your
own development and pull changes to the main repo once you are sure it's
clean enough and working.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
