Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RqPpq-0002Dx-4D
	for ltp-list@lists.sourceforge.net; Thu, 26 Jan 2012 13:57:54 +0000
Date: Thu, 26 Jan 2012 15:10:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120126141035.GA6666@saboteur.suse.cz>
References: <1326106637-5173-1-git-send-email-markos.chandras@imgtec.com>
	<4F2127AE.6050906@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F2127AE.6050906@imgtec.com>
Subject: Re: [LTP] [PATCH] {tcp_cmds/echo,
 math/float}: Include missing usctest.h header
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > The tst_print function is using the TEST_ERRNO symbol which is declared
> > as 'extern int' on usctest.h header when _USC_LIB_ macro is used and as 'int'
> > when this macro is not defined. We need to include this header on float and
> > echoes tests to ensure that TEST_ERRNO has been defined before calling
> > the tst_print function. Without this header, the compilation will fail with
> > an undefined symbol error.
> > 
> > Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> > ---
> >  testcases/misc/math/float/main.c         |    1 +
> >  testcases/network/tcp_cmds/echo/echoes.c |    3 ++-
> >  2 files changed, 3 insertions(+), 1 deletions(-)
> > 
> > diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
> > index 8998c33..870661b 100644
> > --- a/testcases/misc/math/float/main.c
> > +++ b/testcases/misc/math/float/main.c
> > @@ -26,6 +26,7 @@
> >  #include "tfloat.h"
> >  
> >  #include "test.h"
> > +#include "usctest.h"
> >  
> >  #define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
> >  /* LTP status reporting */
> > diff --git a/testcases/network/tcp_cmds/echo/echoes.c b/testcases/network/tcp_cmds/echo/echoes.c
> > index 877cfa5..2ce7968 100644
> > --- a/testcases/network/tcp_cmds/echo/echoes.c
> > +++ b/testcases/network/tcp_cmds/echo/echoes.c
> > @@ -29,6 +29,7 @@
> >  #include <fcntl.h>
> >  #include "test.h"
> >  #include "netdefs.h"
> > +#include "usctest.h"
> >  
> >  #if INET6
> >  char *TCID = "echoes6";
> > @@ -372,4 +373,4 @@ void
> >  cleanup(int s)
> >  {
> >  	close(s);
> > -}
> > \ No newline at end of file
> > +}
> 
> Ping?
> 
> Any comments on that? Compilation fails without that when using UCLINUX=1

Strange, I've been unable to locate the original patch in the mailing
list...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
