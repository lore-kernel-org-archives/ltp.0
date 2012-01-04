Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiR0a-0007tu-FS
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 13:36:00 +0000
Date: Wed, 4 Jan 2012 14:46:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120104134651.GA14739@saboteur.suse.cz>
References: <4F02CC46.9000106@imgtec.com>
	<201201031356.11319.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201201031356.11319.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 03/21] test.h/tst_brkm: Drop
 __attribute__((noreturn)) since tst_brk can return to caller
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
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> the tst_brk() API has gotten annoying.  it is designed to not return to the 
> original caller which is why it had the "noreturn" attribute.  but Garret re-
> rewrote it to be re-entrant presumably so the cleanup() func could itself call 
> tst_brk().  but i'm not sure how useful that actually is in practice ...

The original problem here is that tests use tst_brkm() in cleanup
functions where you don't want to exit before you do all the cleanups.
That was previously working as tst_brkm() with cleanup set to NULL
wasn't calling tst_exit() (and obviously you would never add cleanup
pointer to tst_brkm() when you are in cleanup function otherwise you are
in infinite loop).

The original behavior was IMHO wrong and now it's little better. And I
think that best solution would be to fix tests to use tst_resm() instead
of tst_brkm() when the test doesn't want to exit immediately.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
