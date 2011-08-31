Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qyk0H-0006y5-9J
	for ltp-list@lists.sourceforge.net; Wed, 31 Aug 2011 12:34:49 +0000
Date: Wed, 31 Aug 2011 14:34:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110831123445.GB28807@saboteur.suse.cz>
References: <201006061713.BGF64500.OtOHFJVQLOSFFM@I-love.SAKURA.ne.jp>
	<201108292342.IBI64522.FJOFMVSOLQOtHF@I-love.SAKURA.ne.jp>
	<20110831102620.GA32395@saboteur.suse.cz>
	<201108312011.FFF00576.FFLOHOSQOJtMFV@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201108312011.FFF00576.FFLOHOSQOJtMFV@I-love.SAKURA.ne.jp>
Subject: Re: [LTP] [linux-3.1] TOMOYO Linux update
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
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > * Please next time send the patch attached to the mail, ideally inlined
> >   as well as attachement. It's much easier for me to review it that way.
> >   Or even better If you had a git repository on sf.net I could pull
> >   changes directly from there.
> 
> I think this patch was too large. Does this ML accept such a large patch?
> Or, should I split into smaller patches for this ML?

Not sure about the ML settings, but it should work, the worse that could
happen is being hold for moderator to approve the mail.

Yes ideally I would like to see the patches being split into reasonable
bits. Its easier to keep track what has changed and why this way.

> > * Including <linux/sched.h> instead of <sched.h> may introduce problems
> >   in future.
> > 
> >   Look here how to fix the problem with sched.h:
> 
> Two weeks ago I received a report from Clemens Fischer that tomoyo-tools does
> not build on Arch-Linux system with rolling releases
> ('uname -rms' -> Linux 3.0.1-spott i686) because CLONE_NEWNS is not defined by
> including <sched.h> . Thus, I added including <linux/sched.h> if CLONE_NEWNS is
> not defined by including <sched.h> (as shown below).
> I'll contact Clemens to try _GNU_SOURCE instead of including <linux/sched.h> .

Defining _GNU_SOURCE should do the trick, just keep in mind that this
must be defined before you include any libc headers.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
