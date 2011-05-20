Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QNPpy-0004Oi-R4
	for ltp-list@lists.sourceforge.net; Fri, 20 May 2011 13:33:54 +0000
Date: Fri, 20 May 2011 15:29:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110520132945.GA18020@saboteur.suse.cz>
References: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
	<20110519174003.GF2333@saboteur.suse.cz>
	<BANLkTi=m96RBZeFuRaOA5Sb_QANhgo4yCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BANLkTi=m96RBZeFuRaOA5Sb_QANhgo4yCA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] [syscalls] getrusage03: test ru_maxrss
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
>     [Un]fortunately we don't (I say that because writing something
> functional would be kind of a pain because we'd need to replicate what
> tar does with that file mode, permissions bits, and other fun security
> attributes in order to be complete).
>     Does this need to be run from the current working directory, or
> can it be picked up from $PATH ? If the latter is ok, then all you
> need to do is add $LTPROOT/testcases/bin to $PATH (which should be
> done already by runltp) and use execvp, or you could play tricks and
> lookup the dirname of the realpath, etc of the testcase (argv[0]), and
> use that in the execle, etc call.

All the child does here is allocating memory, so I would say execvp() is
good enough in this case. (And adding note about this into style-guide
would be great).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
