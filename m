Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V74fR-0002wI-QK
	for ltp-list@lists.sourceforge.net; Wed, 07 Aug 2013 14:24:49 +0000
Date: Wed, 7 Aug 2013 16:24:45 +0200
From: chrubis@suse.cz
Message-ID: <20130807142445.GA7331@rei>
References: <20130807102427.GA4389@rei>
	<1375874575-29198-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130807121028.GB4761@rei> <52023F30.9000401@oracle.com>
	<20130807125522.GC4761@rei> <520252CC.9050900@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <520252CC.9050900@oracle.com>
Subject: Re: [LTP] [PATCH] tst_run_cmd: const correctness
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, alexey.kodanev@oracle.com

Hi!
> >> I think that casting mod_name to (char *) is easier than casting array
> >> before it gets to execvp(). And it doesn't require
> >> any changes of tst_run_cmd interfaces (ie they accepts argv the same way
> >> as execvp does)...
> >>
> >> Maybe leave everything as is and just cast mod_name to (char *)?
> > That is easier for one testcase, but will require the cast in each
> > testcase that will use the interface. From this point of view cast in
> > the library is better. Not elegant solution though. :(
> I google-ed the following:
> http://pubs.opengroup.org/onlinepubs/009604499/functions/exec.html 
> section RATIONALE
> 
> So as I understood from this document execvp expects 'char *const 
> argv[]'  to prevent 'non-expert' users from
> casting argv, envp from "char *[]" to "const char *[]".

Not exactly, it looks like this was choosen to be backward compatible
with older code that declared the array as char *argv[] which couldn't
be automatically casted to const char *const argv[]. So they simple
choose variant that has at least one const and allows automatic cast
from char *argv[].

...
Specifying two levels of const- qualification for the argv[] and envp[]
parameters for the exec functions may seem to be the natural choice,
given that these functions do not modify either the array of pointers or
the characters to which the function points, but this would disallow
existing correct code. Instead, only the array of pointers is noted as
constant. The table of assignment compatibility for dst= src derived
from the ISO C standard summarizes the compatibility:

<snip>

Since all existing code has a source type matching the first row, the
column that gives the most valid combinations is the third column. The
only other possibility is the fourth column, but using it would require
a cast on the argv or envp arguments. It is unfortunate that the fourth
column cannot be used, because the declaration a non-expert would
naturally use would be that in the second row.
...

They are actually complaining that as the type exec functions use is
char *const[] it couldn't be automatically casted from const char *[]
as the array would loose the const attribute. Too bad C cannot gain two
const attributes and cast from char *[] to const char *const[] is not
possible that way exec fuction could have take any string array...

Looks like I've learned something new today ;).

> Given this information and:
> > But in the end any of the solutions will work...
> I vote for a "standard" way i.e. casting array elements to (char *) 
> before calling tst_run_cmd or execvp.

Given that we do not have any existing code passing char *[] array to
the tst_run_cmd() I think that we can declare the array as const char
*const[] and cast it in the library.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
