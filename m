Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filippo.arcidiacono@st.com>) id 1S3Te4-0001dP-3S
	for ltp-list@lists.sourceforge.net; Fri, 02 Mar 2012 14:39:44 +0000
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S3Te0-000154-6A
	for ltp-list@lists.sourceforge.net; Fri, 02 Mar 2012 14:39:44 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB97E1CB
	for <ltp-list@lists.sourceforge.net>;
	Fri,  2 Mar 2012 14:39:24 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E79523EB
	for <ltp-list@lists.sourceforge.net>;
	Fri,  2 Mar 2012 14:39:24 +0000 (GMT)
From: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
References: <1329994678-10121-1-git-send-email-filippo.arcidiacono@st.com>
In-Reply-To: <1329994678-10121-1-git-send-email-filippo.arcidiacono@st.com>
Date: Fri, 2 Mar 2012 15:39:01 +0100
Message-ID: <032901ccf882$36775950$a3660bf0$@arcidiacono@st.com>
MIME-Version: 1.0
Content-Language: en-us
Subject: Re: [LTP] [PATCH v2] getrusage04: add opportunity to increase the
	max [us]time increment
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
To: 'Filippo ARCIDIACONO' <filippo.arcidiacono@st.com>, ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Filippo ARCIDIACONO [mailto:filippo.arcidiacono@st.com]
> Sent: Thursday, February 23, 2012 11:58 AM
> To: ltp-list@lists.sourceforge.net
> Cc: Filippo Arcidiacono; Salvatore Cro
> Subject: [PATCH v2] getrusage04: add opportunity to increase the max
> [us]time increment
> 
> On slow systems it could be needed to increase the max value [us]time
> increment beetween two getrusage calls.
> 
> Signed-off-by: Filippo Arcidiacono <filippo.arcidiacono@st.com>
> Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
> ---
>  testcases/kernel/syscalls/getrusage/getrusage04.c |   44
> +++++++++++++++++---
>  1 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c
> b/testcases/kernel/syscalls/getrusage/getrusage04.c
> index 3bdd3b0..e142d22 100644
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
> @@ -80,6 +92,12 @@ int main(int argc, char *argv[])
> 
>  	setup();
> 
> +	if (opt_factor)
> +		factor_nr = SAFE_STRTOL(cleanup, factor_str, 0,
> FACTOR_MAX);
> +
> +	tst_resm(TINFO, "Using %ld as multiply factor for max [us]time "
> +		 "increment (1000+%ldus)!", factor_nr, BIAS_MAX *
> factor_nr);
> +
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>  		Tst_count = 0; i = 0;
>  		ulast = 0, slast = 0;
> @@ -95,14 +113,20 @@ int main(int argc, char *argv[])
>  				tst_resm(TINFO, "utime:%12luus;
stime:%12luus",
>  					    usage.ru_utime.tv_usec,
>  					    usage.ru_stime.tv_usec);
> -				if (udelta > 1000+BIAS_MAX)
> -					tst_brkm(TFAIL, cleanup,
> -						    "utime increased >
1000us:"
> +				if (udelta > 1000+(BIAS_MAX * factor_nr)) {
> +					sprintf(msg_string,
> +						"utime increased > %ldus:",
> +						1000 + BIAS_MAX *
factor_nr);
> +					tst_brkm(TFAIL, cleanup, msg_string,
>  						    " delta = %luus",
udelta);
> -				if (sdelta > 1000+BIAS_MAX)
> -					tst_brkm(TFAIL, cleanup,
> -						    "stime increased >
1000us:"
> +				}
> +				if (sdelta > 1000+(BIAS_MAX * factor_nr)) {
> +					sprintf(msg_string,
> +						"stime increased > %ldus:",
> +						1000 + BIAS_MAX *
factor_nr);
> +					tst_brkm(TFAIL, cleanup, msg_string,
>  						    " delta = %luus",
sdelta);
> +				}
>  			}
>  			ulast = usage.ru_utime.tv_usec;
>  			slast = usage.ru_stime.tv_usec;
> @@ -113,6 +137,12 @@ int main(int argc, char *argv[])
>  	tst_exit();
>  }
> 
> +static void fusage(void)
> +{
> +	printf("  -m n    use n as multiply factor for max [us]time "
> +	       "increment (1000+(1000*n)us),\n          default value is
> 1\n");
> +}
> +
>  static void busyloop(long wait)
>  {
>  	while (wait--)
> --
> 1.5.5.6

Is this version ok for you, or there are any other comments?

Thanks,
Filippo.




------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
