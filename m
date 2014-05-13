Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkBQo-0005LN-UB
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 12:03:38 +0000
Date: Tue, 13 May 2014 14:02:36 +0200
From: chrubis@suse.cz
Message-ID: <20140513120236.GC12144@rei>
References: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
	<1399906092-28901-2-git-send-email-mats.liljegren@enea.com>
	<20140512150329.GG4741@rei> <20140512171433.0ce9f681@mats-desktop>
	<20140512153405.GA6837@rei> <20140512175927.62b098ce@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140512175927.62b098ce@mats-desktop>
Subject: Re: [LTP] [PATCH 1/2] SAFE_POPEN: Added function to safe_stdio.h
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > > I've added missing return stream; here and pushed both patches,
> > > > thanks.
> > > 
> > > Whoa, did I really miss that? Wondering how my test could have
> > > run... Must have used the wrong version of the code when testing or
> > > something.
> > 
> > I've seen cases where such code was running fine because the register
> > used to return function value was the same that was allocated for the
> > temporary variable...
> 
> I thought about that alternative but discarded it as too unlikely, but
> apparently, I shouldn't have been so quick about it apparently...
> 
> > > Now you know why I really liked forcing people into using
> > > -Werror ;-) Could it be a good idea to actually use -Werror by
> > > default, and having a "production" flag for those who don't want
> > > it? Just to ensure that lazy people are those being best looked
> > > after...
> > 
> > I would be for reversing the logic, i.e. adding developer flag that
> > enables -Werror. Unfortunatelly LTP has tons of legacy code that
> > produces megatons of warnings and fixing all of these would be a big
> > effort.
> > 
> 
> Hmm, but a compromise could be this:
> 
> Let's say we have a "production flag" which then each module could make
> their mind up whether it should have any effect or not. If it should
> have an effect, then the effect should be to disable -Werror.

I'm still not convinced that enabling -Werror by default is a good idea.
Compiler warnings are quite unstable among different versions and code
that produces no warnings with one version is not guaranteed not to
produce anything with another, and there are false positives too.

Cloning LTP from git, running configure and make must not fail just
because you have different compiler version than developers.

> This way, you can fix warnings on one module at a time, no big bang
> change. When a module is fixed, you change it to use -Werror unless
> this "production flag" is used.

That sounds to me as too much work for not so much gain.

I guess that we can add a configure parameter that adds a variable into
config.mk something as WERROR which gets set to -Werror only if it's
supported by compiler and enabled by user. Then we can do
CFLAGS+=$(WERROR) in a few Makefiles.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
