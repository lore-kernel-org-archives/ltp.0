From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Oct 2019 12:39:44 +0200
Subject: [LTP] [PATCH] Convert ptrace01.c to new library
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BF7B1@USCULXMSG01.am.sony.com>
References: <20191001070111.31369-1-jcronenberg@suse.de>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BF7B1@USCULXMSG01.am.sony.com>
Message-ID: <20191003103944.GA1858@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > /**********************************************************
> > - *
> > - *    TEST IDENTIFIER	: ptrace01
> > - *
> > - *    EXECUTED BY	: anyone
> > - *
> > - *    TEST TITLE	: functionality test for ptrace(2)
> > - *
> > - *    TEST CASE TOTAL	: 2
> > - *
> > - *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
> > - *
> > - *    SIGNALS
> > - * 	Uses SIGUSR1 to pause before test if option set.
> > - * 	(See the parse_opts(3) man page).
> > - *
> > - *    DESCRIPTION
> > + * DESCRIPTION
> >   *	This test case tests the functionality of ptrace() for
> >   *	PTRACE_TRACEME & PTRACE_KILL requests.
> >   *	Here, we fork a child & the child does ptrace(PTRACE_TRACEME, ...).
> > @@ -44,243 +21,114 @@
> >   * 		In both cases, child should stop & notify parent on reception
> >   * 		of SIGUSR2
> >   *
> > - * 	Setup:
> > - * 	  Setup signal handling.
> > - *	  Pause for SIGUSR1 if option specified.
> > - *
> > - * 	Test:
> > - *	 Loop if the proper options are given.
> > - *	 setup signal handler for SIGUSR2 signal
> > - *	 fork a child
> > - *
> > - *	 CHILD:
> > - *		setup signal handler for SIGUSR2 signal
> > - *		call ptrace() with PTRACE_TRACEME request
> > - *		send SIGUSR2 signal to self
> > - *	 PARENT:
> > - *		wait() for child.
> > - *		if parent is notified when child gets a signal through wait(),
> > - *		then
> > - *			do  ptrace(PTRACE_KILL, ..) on child
> > - * 			wait() for child to finish,
> > - * 			if child exited abnormaly,
> > - *				TEST passed
> > - * 			else
> > - * 				TEST failed
> > - *		else
> > - *			TEST failed
> > - *
> > - * 	Cleanup:
> > - * 	  Print errno log and/or timing stats if options given
> > - *
> > - * USAGE:  <for command-line>
> > - *  ptrace01 [-c n] [-e] [-i n] [-I x] [-P x] [-t] [-h] [-f] [-p]
> > - *			where,  -c n : Run n copies concurrently.
> > - *				-e   : Turn on errno logging.
> > - *				-h   : Show help screen
> > - *				-f   : Turn off functional testing
> > - *				-i n : Execute test n times.
> > - *				-I x : Execute test for x seconds.
> > - *				-p   : Pause for SIGUSR1 before starting
> > - *				-P x : Pause for x seconds between iterations.
> > - *				-t   : Turn on syscall timing.
> > - *
> > -
> > **********************************************************
> > ******/
> > + */
> 
> It looks like the old comment had some nicely structured meta-data.  I'm not
> familiar with the process for converting to the new library.  Is it intentional to
> eliminate this meta-data?  (This is more of a question for the LTP leaders
> than for Jorik).

Well most of the old data is unfortunatelly garbage, for instance it
lists the USAGE lists flags implemented in the test library, repeating
these in each test is actually doing a harm. So we tend to keep carefuly
selected subset.

I suspect that there was some kind of silly template that had to be
filled up in order to get test accepted in the old days, which resulted
in long and mostly useless comments on the top of the testcases.

> I know that Cyril is working on a new meta-data system.  If this meta-data is eliminated
> now, does it make adding it back into the new system harder?
> 
> Personally, I find it useful to see the pseudo-code outline when I'm debugging a
> test.  So I hate to see those be eliminated.  But maybe those are hard to trust
> as they tend to not be maintained along with the code?

Well in this case the patch actually keeps the test description, which
is the same as the pseudo-code but in a paragraph of a text, so as far
as I can tell it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
