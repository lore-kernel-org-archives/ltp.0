Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VjFeG-0002VJ-0o
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 21:49:24 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3C209A7B44
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Nov 2013 22:49:16 +0100 (CET)
Date: Wed, 20 Nov 2013 22:48:57 +0100
From: chrubis@suse.cz
Message-ID: <20131120214857.GA1106@rei.my-cloud.eu>
References: <20131120095902.GB30274@quack.suse.cz>
	<20131120122505.GB2168@rei.nue.novell.com>
	<20131120203951.GE30274@quack.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131120203951.GE30274@quack.suse.cz>
Subject: Re: [LTP] fanotify tests
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > +static void setup(void)
> > > +{
> > > +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > > +
> > > +	TEST_PAUSE;
> > > +
> > > +	tst_tmpdir();
> > > +
> > > +	sprintf(fname, "tfile_%d", getpid());
> > 
> > You don't have to do this, the tst_tmpdir() creates an unique temp
> > directory and changes the program working directory to it.
>   I know, but it's not really any harder to generate filename like this and
> I also use fname as a source buffer for write() and verify I can read it back
> later correctly from fanotify() file descriptors so the uniqueness of the
> file contents is nice.

Ok.

> > > +		/* If we expected failure there's nothing to clean up */
> > > +		if (expect == -1)
> > > +			return;
> > > +
> > > +		if (test_event)
> > > +			test_event(file);
> > > +
> > > +		if (myfanotify_mark(fd_notify, FAN_MARK_REMOVE | flag,
> > > +				    FAN_OPEN, AT_FDCWD, file) < 0) {
> > > +			tst_brkm(TBROK | TERRNO, cleanup,
> > > +		    	    "fanotify_mark (%d, FAN_MARK_REMOVE | %s, "
> > > +			    "FAN_OPEN, AT_FDCWD, \"%s\") failed",
> > > +			    fd_notify, flagstr, file);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +#define check_mark(file, flag, expect, func) __check_mark(file, flag, #flag, expect, func)
> > > +
> > > +static void __do_open(char *file, int flag, char *flagstr)
> > > +{
> > > +	int fd;
> > > +
> > > +	if ((fd = open(file, O_RDONLY | flag)) < 0) {
> > > +		tst_brkm(TBROK | TERRNO, cleanup,
> > > +		    "open(%s, O_RDONLY | %s) failed", file, flagstr);
> > > +	}
> > > +	if (close(fd) < 0) {
> > > +		tst_brkm(TBROK | TERRNO, cleanup,
> > > +		    "close(%s) failed", file);
> > > +	}
> > > +}
> > 
> > We don't use identificators with double underscores in userspace, these
> > are reserved for glibc and may cause failures in future. Especially
> > names like __do_open may clash.
>   Ah right, didn't write anything serious in userspace for a while :) I've
> changed that to a single underscore.

That wouldn't do either, I've looked up the GNU manual that says that
all functions or variables that begin with underscore are reserved.

http://www.gnu.org/software/libc/manual/html_node/Reserved-Names.html

I will look at the v2 patch tomorrow.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
