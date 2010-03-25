Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Nurd6-0000Mu-Ly
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 18:18:04 +0000
Date: Thu, 25 Mar 2010 19:22:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100325182245.GA30410@saboteur.suse.cz>
References: <b9d696240909211602o51c38c2ei41a8622d3250f06b@mail.gmail.com>
	<200909241423.45226.jpalecek@web.de>
	<b9d696240909241155x5be217a3t4564e6b1bb64a9be@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9d696240909241155x5be217a3t4564e6b1bb64a9be@mail.gmail.com>
Subject: Re: [LTP] Buffer Overflow with ftest03 and ftest07
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list@lists.sourceforge.net

Hi!
> After that I tested them. Both ftest03.c and ftest07.c passes when run from
> the command line. But when executed by runltp, they fail with return code
> 11. This is identical to the behavior without your patch.

Well, they PASS every time when executed by hand, because TDIRECTORY defaults
to plain "/tmp/" in this case. When executing tests with runltp TDIRECTORY is
se to something like "/tmp/ltp-qnZVs21494/" and then fuss[] is sometimes not
big enough to hold the string and this causes the segfault. Try for yourself:

TDIRECTORY="/tmp/this_name_is_just_too_long" ./ftest03

However deleting the code that creates temporary directories works for me, at
least for ftest03.c. I'll test Jiri's patch asap and try to fix the remaining
corner cases.

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
