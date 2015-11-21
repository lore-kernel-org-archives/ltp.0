From: Nicolas Joly <njoly@pasteur.fr>
Date: Sat, 21 Nov 2015 10:41:24 +0100
Subject: [LTP] [PATCH] Cleanup syscalls/utime test messages
In-Reply-To: <20151119160051.GF28969@rei.lan>
References: <20151115100916.GA24895@issan.sis.pasteur.fr>
 <20151119160051.GF28969@rei.lan>
Message-ID: <20151121094124.GA16808@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 19, 2015 at 05:00:51PM +0100, Cyril Hrubis wrote:
> > diff --git a/testcases/kernel/syscalls/utime/utime01.c b/testcases/kernel/syscalls/utime/utime01.c
> > index 4bb33e9..2eb49d4 100644
> > --- a/testcases/kernel/syscalls/utime/utime01.c
> > +++ b/testcases/kernel/syscalls/utime/utime01.c
> > @@ -131,8 +131,7 @@ int main(int ac, char **av)
> >  		TEST(utime(TEMP_FILE, NULL));
> >  
> >  		if (TEST_RETURN == -1) {
> > -			tst_resm(TFAIL, "utime(%s) Failed, errno=%d : %s",
> > -				 TEMP_FILE, TEST_ERRNO, strerror(TEST_ERRNO));
> > +			tst_resm(TFAIL|TTERRNO, "utime(%s) failed", TEMP_FILE);
> >  		} else {
> >  			/*
> >  			 * Sleep for a second so that mod time and
> > @@ -146,10 +145,9 @@ int main(int ac, char **av)
> >  			 * utime(2)
> >  			 */
> >  			if ((pres_time = time(&tloc)) < 0) {
> > -				tst_brkm(TFAIL, cleanup, "time() "
> > +				tst_brkm(TFAIL|TERRNO, cleanup, "time() "
> >  					 "failed to get present time "
> > -					 "after utime, error=%d",
> > -					 errno);
> > +					 "after utime");
> 
> This part of code is not 100% correct, since time() returns precisely
> (time_t)-1 on failure. If time_t is typedefed in system to unsigned it
> will never be true. And it looks like it's defined to be long int at the
> moment hence 4 bytes on 32bit arch and 8 bytes on 64bit arch, but that
> may change because of 2038. Heh, and the test fails if you set time
> before 01-01-1970 (yep, looks like it could be done since time_t is
> signed type), not that it matters that much though.
> 
> Lookig at the time man page the only error defined for time is EFAULT
> when you pass wrong pointer to it. So I would just remove the check for
> failure for all time() calls. What do you think?

Fine. My cleanup was mostly mecanical to remove most errno direct use
... I did not check for anything else ;)

> > @@ -157,9 +155,8 @@ int main(int ac, char **av)
> >  			 * temporary file using stat(2).
> >  			 */
> >  			if (stat(TEMP_FILE, &stat_buf) < 0) {
> > -				tst_brkm(TFAIL, cleanup, "stat(2) of "
> > -					 "%s failed, error:%d",
> > -					 TEMP_FILE, TEST_ERRNO);
> > +				tst_brkm(TFAIL|TERRNO, cleanup, "stat(2) of "
> > +					 "%s failed", TEMP_FILE);
> >  			}
> 
> Hint: we have safe macros so this could be easily done with just:
> 
>       SAFE_STAT(cleanup, TEMP_FILE, &stat_buf);
> 
>       And the same for creat(), close(), etc.

That's even simplier indeed.

Will try to setup a new version that include both.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
