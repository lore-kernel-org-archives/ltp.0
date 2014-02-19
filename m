Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WG8w6-0001bv-Ql
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 15:19:46 +0000
Date: Wed, 19 Feb 2014 16:19:31 +0100
From: chrubis@suse.cz
Message-ID: <20140219151931.GA22336@rei>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<5757763.zAWEHsmlGc@vapier> <52FC98EC.80406@oracle.com>
	<2020103.1jVMlSvdbW@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2020103.1jVMlSvdbW@vapier>
Subject: Re: [LTP] [PATCH 4/4] lib: add tst_res_r.c
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
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > > random note: never never never use () with functions.  always always
> > > always
> > > use (void).  i'm guessing you're not aware, but what you've written here
> > > may> 
> > > be called (warning free!) like so:
> > > 	get_tst_count(1, 2, 3);
> > > 
> > > yes, even with -W -Wall -Wextra.  please stamp this horrible habit out of
> > > your code.
> > 
> > Thank you for explanation!
> > There is a trick to try g++ to compile the code, it will throw an error
> > on that and stops compilation.
> 
> yeah, C++ fixed this historical wart of C.  sorry for not clarifying.
> 
> iiuc (and i could be wrong as i'm not old enough to have lived through it), 
> this dates back to when C (ANSI?) didn't have prototypes.  with a lot of code 
> out there relying on the behavior, gcc never stopped accepting it.

That would be K&R C that dates back to UNIX days (at least from what
I've read about the history, haven't lived these days either).

> i wonder if we could argue for like a newer GNU standard to reject it.

That would be nice. Although there is a lot of code that dates back to
the old days, quite a lot of test in LTP as well so there is no way to
get this mandatory for existing projects, we simply have no manpower to
rewrite all the sources in a week or so. On the other way it would be
nice to instruct the compiler to abort on any new code that includes
old-style declarations.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
