Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1USsrf-00024R-H1
	for ltp-list@lists.sourceforge.net; Thu, 18 Apr 2013 17:43:19 +0000
Date: Thu, 18 Apr 2013 19:44:06 +0200
From: chrubis@suse.cz
Message-ID: <20130418174406.GA1425@rei.suse.cz>
References: <516F7F88.30707@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516F7F88.30707@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]syscalls/adjtimex: Test for mode
 ADJ_OFFSET_SINGLESHOT
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

Hi!
>  #if defined UCLINUX && !__THROW
>  /* workaround for libc bug causing failure in sys/timex.h */
> @@ -74,20 +35,19 @@
>  #include "test.h"
>  #include "usctest.h"
> 
> -#define SET_MODE ( ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
> -	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK )
> +#define SET_MODE (ADJ_OFFSET | ADJ_FREQUENCY | ADJ_MAXERROR | ADJ_ESTERROR | \
> +	ADJ_STATUS | ADJ_TIMECONST | ADJ_TICK)
> 
> -static void setup();
> -static void cleanup();
> +static void setup(void);
> +static void cleanup(void);
> 
>  char *TCID = "adjtimex01";
> -int TST_TOTAL = 1;
> +int TST_TOTAL = 2;
> 
>  static struct timex tim_save;
> 
>  int main(int ac, char **av)
>  {
> -
>  	int lc;
>  	char *msg;
> 
> @@ -106,7 +66,26 @@ int main(int ac, char **av)
>  		TEST(adjtimex(&tim_save));
> 
>  		if ((TEST_RETURN >= 0) && (TEST_RETURN <= 5)) {
> -			tst_resm(TPASS, "adjtimex() returned %ld", TEST_RETURN);
> +			tst_resm(TPASS, "adjtimex() with mode %u returned %ld",
> +				 SET_MODE, TEST_RETURN);
> +		} else {
> +			tst_resm(TFAIL | TTERRNO, "Test Failed, adjtimex()"
> +				 "returned %ld", TEST_RETURN);
> +		}
> +	}
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		/* Call adjtimex(2) */
> +		tim_save.modes = ADJ_OFFSET_SINGLESHOT;
> +
> +		TEST(adjtimex(&tim_save));
> +
> +		if ((TEST_RETURN >= 0) && (TEST_RETURN <= 5)) {
> +			tst_resm(TPASS, "adjtimex() with mode %u returned %ld",
> +				 ADJ_OFFSET_SINGLESHOT, TEST_RETURN);
>  		} else {
>  			tst_resm(TFAIL | TTERRNO, "Test Failed, adjtimex()"
>  				 "returned %ld", TEST_RETURN);

I think that doing the test loop twice would fail at least for '-i' and
'-I'. My guess is that the second loop would not be exectuted at all.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
