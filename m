Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PmQFx-0002gT-I6
	for ltp-list@lists.sourceforge.net; Mon, 07 Feb 2011 12:31:49 +0000
Date: Mon, 7 Feb 2011 13:50:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110207125034.GA5014@saboteur.suse.cz>
References: <20110204170556.GA30962@saboteur.suse.cz>
	<AANLkTimOpGBzw7Ud2KgafUovCMD1V0zLOHUv75onSan=@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTimOpGBzw7Ud2KgafUovCMD1V0zLOHUv75onSan=@mail.gmail.com>
Subject: Re: [LTP] [PATCH] style guide note about writing signal handlers
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
> > Patch with note about writing signal handlers attached.
> >
> > Garrett feel free to rewrite it to match the rest of the style guide.
> 
> Patch is fine minus one typo (s/singal/signal/). The more complicated
> part is that the majority of our libltp based infrastructure does use
> non-async safe functions in signal handlers to crash and burn
> testcases (tst_sig is built on tst_brkm, which uses fprintf, fflush,
> etc).

Well yes the libltp interface is far too complicated and would probably
gain from simplification, it would be much easier to do it correctly
then.  The real problem is a number of testcases using it.

The downside of signal handler and non-async safe functions is that you
will never know, when they fail, they usually fail with relatively small
probability and on some system they run just fine, because of different
libc internals etc. Such behaviour often results in false-possitive
regressions. And the only way to avoid this is not to complicate your
signal handler.

If I remember correctly the problem with printf is that it may use
malloc for allocating the buffer, that if called, while there is malloc
or free running in the main loop, could cause problems. Which is not
likely, at least most of the time.

> I agree with you that doing stuff in signal handlers is non-kosher,
> and some testcases should be fixed, but some concession might need to
> be made for the crash and burn logic in other testcases and the
> infrastructure proper.

I've seen the libltp code and I agree that, as it is now, there is no
better way. Actually I was thinking of playing with the api for some
time to eliminate useless functions and rewrite some of the code and may
be change parts of the api. But so far I haven't had enough time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The modern datacenter depends on network connectivity to access resources
and provide services. The best practices for maximizing a physical server's
connectivity to a physical network are well understood - see how these
rules translate into the virtual world? 
http://p.sf.net/sfu/oracle-sfdevnlfb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
