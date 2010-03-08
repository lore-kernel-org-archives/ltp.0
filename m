Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Noe80-0002rq-VM
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 14:40:16 +0000
Date: Mon, 8 Mar 2010 15:43:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100308144319.GA30879@saboteur.suse.cz>
References: <20100205172438.GA2333@saboteur.suse.cz>
	<364299f41002051125x3fe2446dx2d67e5e4f687274f@mail.gmail.com>
	<20100218175018.GA29671@saboteur.suse.cz>
	<364299f41002181351s4c815216ld1911f0d6d522064@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002181351s4c815216ld1911f0d6d522064@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix buffer overflow in sem_getvalue tests
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Well, it's big enough to hold the string (I'm too lazy to figure out exact
> > maximal length for every possible architecture/compiler) and a few more bytes
> > should not kill anyone...
> 
> SEM_NAME_MAX (see
> http://publib.boulder.ibm.com/infocenter/iseries/v5r3/topic/apis/ipcsemo.htm
> )?
> 
> This doesn't appear to exist on older versions of Linux (RHEL 4.6 for
> instance...)
> 
> The logic required to determine SEM_NAME_MAX should be easy to grab,
> or you could follow the following logic from the sem_open manpage:
> 
>        ENAMETOOLONG
>               The length of the name argument exceeds {PATH_MAX} or  a  path-
>               name component is longer than {NAME_MAX}.

My manual dated as 20-02-2009 says just:


ENAMETOOLONG
	name was too long.


And 'man sem_overview' says we should use NAME_MAX - 4 (as on linux, named
semaphores are files created in /dev/shm/ virtual filesystem that starts with
'sem.' prefix). Is semname declared as 'char semname[NAME_MAX - 4];' okay?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
