Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YPu54-000727-Ej
	for ltp-list@lists.sourceforge.net; Mon, 23 Feb 2015 14:33:54 +0000
Date: Mon, 23 Feb 2015 15:33:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150223143316.GB24365@rei>
References: <f0b16dcce340d36b9d60df2155371bfeb623982e.1424687402.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f0b16dcce340d36b9d60df2155371bfeb623982e.1424687402.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] difftime/1-1: avoid running on second boundary
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
> index 97bf443..2872e08 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/difftime/1-1.c
> @@ -15,14 +15,31 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <sys/time.h>
>  #include "posixtest.h"
>  
>  int main(void)
>  {
>  	time_t time1, time0;
> -
>  	double time_diff;
> -	time_diff = 0;
> +	struct timeval t1;
> +
> +	/*
> +	 * Quoting https://lkml.org/lkml/2015/2/19/384
> +	 *  "The idea that time() would be ok as being HZ granular, and its
> +	 *  been this way since 2.6.23.  Thus you have a < HZ sized window
> +	 *  where gettimeofday() will return the next second before time()
> +	 *  gets updated by the tick."
> +	 *
> +	 * Avoid running this test on second boundary as there is small
> +	 * window, where this test can fail on Linux, reporting that 2
> +	 * seconds has passed.
> +	 */
> +	do {
> +		usleep(10000);
> +		gettimeofday(&t1, NULL);
> +	} while (t1.tv_usec > 700*1000 || t1.tv_usec < 300*1000);
> +
>  	time0 = time(NULL);
>  	sleep(WAIT_DURATION);
>  	time1 = time(NULL);

Looking at the test I wonder why we even have to call sleep() and then
time() to get the second timestamp. POSIX specifies that time_t is
integer of floating point type so assigning a number to it and
arithmetic should work just fine. So we can just do time1 = time0 + 1
instead. Or go even further and pass statically defined values to
difftime() and compare it with precomputed value.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
