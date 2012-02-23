Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S0VCw-0004dG-T2
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 09:43:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S0VCq-0002tq-8q
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 09:43:26 +0000
Message-ID: <4F4609F6.5060008@cn.fujitsu.com>
Date: Thu, 23 Feb 2012 17:42:14 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <y> <1329985431-27567-1-git-send-email-y>
In-Reply-To: <1329985431-27567-1-git-send-email-y>
Subject: Re: [LTP] [PATCH] getrusage04: add opportunity to increase the max
 [us]time increment
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
Cc: ltp-list@lists.sourceforge.net

On 02/23/2012 04:23 PM, Filippo ARCIDIACONO wrote:

> From: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> 
> On slow systems it could be needed to increase the max value [us]time
> increment beetween two getrusage calls.
> 
> Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> ---
>  testcases/kernel/syscalls/getrusage/getrusage04.c |   42 +++++++++++++++++---
>  1 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
> index 3bdd3b0..92f8361 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage04.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
> @@ -54,11 +54,22 @@ int TST_TOTAL = 1;
>  
>  #define BIAS_MAX      1000
>  #define RECORD_MAX    20
> +#define FACTOR_MAX    10
>  
>  #ifndef RUSAGE_THREAD
>  #define RUSAGE_THREAD 1
>  #endif
>  
> +static int opt_factor;
> +static char *factor_str;
> +static long factor_nr = 1;
> +
> +option_t child_options[] = {
> +	{ "m:", &opt_factor, &factor_str },
> +	{ NULL, NULL,         NULL }
> +};
> +
> +static void fusage(void);
>  static void busyloop(long wait);
>  static void setup(void);
>  static void cleanup(void);
> @@ -69,8 +80,9 @@ int main(int argc, char *argv[])
>  	unsigned long ulast, udelta, slast, sdelta;
>  	int i, lc;
>  	char *msg;
> +	char msg_string[BUFSIZ];
>  
> -	msg = parse_opts(argc, argv, NULL, NULL);
> +	msg = parse_opts(argc, argv, child_options, fusage);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> @@ -80,6 +92,11 @@ int main(int argc, char *argv[])
>  
>  	setup();
>  
> +	if (opt_factor)
> +		factor_nr = SAFE_STRTOL(cleanup, factor_str, 0, FACTOR_MAX);
> +
> +	tst_resm(TINFO, "Using %ld as multiply factor for max [us]time increment (1000+%ldus)!", factor_nr, BIAS_MAX * factor_nr);


Could you please fix the over 80 characters warning?

> +
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  		Tst_count = 0; i = 0;
>  		ulast = 0, slast = 0;
> @@ -95,14 +112,20 @@ int main(int argc, char *argv[])
>  				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
>  					    usage.ru_utime.tv_usec,
>  					    usage.ru_stime.tv_usec);
> -				if (udelta > 1000+BIAS_MAX)
> -					tst_brkm(TFAIL, cleanup,
> -						    "utime increased > 1000us:"
> +				if (udelta > 1000+(BIAS_MAX * factor_nr)) {
> +					sprintf(msg_string,
> +						"utime increased > %ldus:",
> +						1000 + BIAS_MAX * factor_nr);
> +					tst_brkm(TFAIL, cleanup, msg_string,
>  						    " delta = %luus", udelta);
> -				if (sdelta > 1000+BIAS_MAX)
> -					tst_brkm(TFAIL, cleanup,
> -						    "stime increased > 1000us:"
> +				}
> +				if (sdelta > 1000+(BIAS_MAX * factor_nr)) {
> +					sprintf(msg_string,
> +						"stime increased > %ldus:",
> +						1000 + BIAS_MAX * factor_nr);
> +					tst_brkm(TFAIL, cleanup, msg_string,
>  						    " delta = %luus", sdelta);
> +				}
>  			}
>  			ulast = usage.ru_utime.tv_usec;
>  			slast = usage.ru_stime.tv_usec;
> @@ -113,6 +136,11 @@ int main(int argc, char *argv[])
>  	tst_exit();
>  }
>  
> +static void fusage(void)
> +{
> +	printf("  -m n    use n as multiply factor for max [us]time increment (1000+(1000*n)us), default value is 1\n");


ditto


Thanks
-Wanlong Gao

> +}
> +
>  static void busyloop(long wait)
>  {
>  	while (wait--)



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
