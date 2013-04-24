Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UUwES-0008O1-T0
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 09:43:20 +0000
Date: Wed, 24 Apr 2013 11:44:14 +0200
From: chrubis@suse.cz
Message-ID: <20130424094414.GC5674@rei>
References: <517794DF.5020307@cn.fujitsu.com> <51779629.1090701@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51779629.1090701@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/getitimer01.c: Test for getting
 ITIMER_VIRTUAL and ITIMER_PROF
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

> diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
> index 968e34f..9c3ad90 100644
> --- a/testcases/kernel/syscalls/getitimer/getitimer01.c
> +++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
> @@ -19,6 +19,7 @@
>  /*
>    HISTORY
>      03/2001 - Written by Wayne Boyer
> +    04/2013 - ITIMER_VIRTUAL and ITIMER_PROF test added by DAN LI

I would rather see just Copyright line abowe, if you wan't your name in
the source. What have been changed should be clear from the 'git log'.

>    TEST ITEMS:
>      Check that a correct call to getitimer() succeeds.
> @@ -34,11 +35,17 @@ static void cleanup(void);
>  static void setup(void);
> 
>  char *TCID = "getitimer01";
> -int TST_TOTAL = 1;
> +int TST_TOTAL = 3;
> +
> +static int itimer_name[] = {
> +			ITIMER_REAL,
> +			ITIMER_VIRTUAL,
> +			ITIMER_PROF, };

Please move the closing curly brace to the next line, such as:

static int itimer_name[] = {
	...
};

>  int main(int ac, char **av)
>  {
>  	int lc;
> +	int idx;

Name the loop variable just i.

>  	char *msg;
>  	struct itimerval *value;
> 
> @@ -51,32 +58,37 @@ int main(int ac, char **av)
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  		tst_count = 0;
> 
> -		/* allocate space for the itimerval structure */
> -		value = (struct itimerval *)malloc(sizeof(struct itimerval));
> -		if (value == NULL)
> -			tst_brkm(TBROK, cleanup, "value malloc failed");
> -
> -		TEST(getitimer(ITIMER_REAL, value));
> -
> -		if (TEST_RETURN != 0)
> -			tst_resm(TFAIL, "call failed - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -
> -		if (STD_FUNCTIONAL_TEST) {
> +		for (idx = 0; idx < 3; idx++) {
> +			/* allocate space for the itimerval structure */
> +			value = (struct itimerval *)malloc(
> +						sizeof(struct itimerval));
> +			if (value == NULL) {
> +				tst_resm(TBROK, "value malloc failed");
> +				continue;
> +			}

Same here, no need for the malloc() where:

struct itimerval value;

...

getitimer(..., &value);

is sufficient.

> -			/*
> -			 * Since ITIMER_REAL is effectively disabled (we did
> -			 * not set it before the getitimer call), the elements
> -			 * in it_value should be zero.
> -			 */
> -			if ((value->it_value.tv_sec == 0) &&
> -			    (value->it_value.tv_usec == 0)) {
> -				tst_resm(TPASS, "functional test passed");
> +			TEST(getitimer(itimer_name[idx], value));
> +
> +			if (TEST_RETURN != 0)
> +				tst_resm(TFAIL, "call failed - errno = %d - %s",
> +					 TEST_ERRNO, strerror(TEST_ERRNO));
> +
> +			if (STD_FUNCTIONAL_TEST) {
> +
> +				/*
> +				* Since ITIMER is effectively disabled (we did
> +				* not set it before the getitimer call), the
> +				* elements in it_value should be zero.
> +				*/
> +				if ((value->it_value.tv_sec == 0) &&
> +					(value->it_value.tv_usec == 0)) {
> +					tst_resm(TPASS, "functionality is ok");
> +				} else {
> +					tst_resm(TFAIL, "timer are non zero");
> +				}
>  			} else {
> -				tst_resm(TFAIL, "timer values are non zero");
> +				tst_resm(TPASS, "call succeeded");
>  			}
> -		} else {
> -			tst_resm(TPASS, "call succeeded");
>  		}
>  	}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
