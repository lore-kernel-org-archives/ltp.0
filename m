Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UaROI-0003sb-S1
	for ltp-list@lists.sourceforge.net; Thu, 09 May 2013 14:00:14 +0000
Date: Thu, 9 May 2013 16:01:17 +0200
From: chrubis@suse.cz
Message-ID: <20130509140117.GD4255@rei.suse.cz>
References: <201305082355.14183.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201305082355.14183.vapier@gentoo.org>
Subject: Re: [LTP] new sub-project proposal of utility commands for poking
 funcs/syscalls directly
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> i wrote a testsuite for the Gentoo sandbox project.  for people unfamiliar 
> with this project, it's similar to fakeroot.  a readme with more details:
> http://git.overlays.gentoo.org/gitweb/?p=proj/sandbox.git;a=blob;f=README
> 
> in order to test this project, i need to be able to easily & quickly run 
> specific C library funcs and syscalls.  writing small C files with the right 
> args is a pain and doesn't scale at all.  so i wrote a framework from scratch 
> which allows poking funcs from the command line:
> http://git.overlays.gentoo.org/gitweb/?p=proj/sandbox.git;a=tree;f=tests
> 
> strace has need of pretty much the same thing.  atm, it's running higher level 
> tools like `stat` and `dd` and `find`, but this gets unmanageable quickly as we 
> try to scale to more arches and tests.
> 
> rather than hosting the tests in the sandbox or the strace repo (and trying to 
> import into the other), it seemed more natural to start a new sub-project 
> under the LTP umbrella.  we wouldn't want it to be in the main LTP repo since 
> we can't check out subdirs w/git, so it'd have to be a new one.

From a technical point it's quite easy, we can create a repo on github
under linux-test-project and possibly link it as git submodule to the
main LTP git. But you probably have a solution like this in mind.

> what do people think ?  any suggestions on a name ?  how about "foker", the 
> function poker ?

It seems to be nice tool. And the name is fine (it's slightly negative
according to urban dict, but not as bad as Gimp).

It may be off topic, but similar system could be used to generate quite
a lot of LTP testcases. There are far too many cases where the test just
calls a function and checks that it succeded and actually did what it
should. Given the definition of the API are in separate files (perhaps
slightly edhanced) generating LTP testcases should be as easy as
including different skeleton. We can even anotate negative testcases as
well, for example in case invalid fd is passed, make sure the call
returns EBADFD (which may be even usefull for generating strace tests).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
