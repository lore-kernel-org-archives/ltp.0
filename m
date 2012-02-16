Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rxv10-0006wU-Ho
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 06:40:26 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rxv0z-0007tU-Q3
	for ltp-list@lists.sourceforge.net; Thu, 16 Feb 2012 06:40:26 +0000
Received: by daln34 with SMTP id n34so1820855dal.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Feb 2012 22:40:20 -0800 (PST)
Message-ID: <4F3CA4B0.9000401@casparzhang.com>
Date: Thu, 16 Feb 2012 14:39:44 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1329311088-2093-1-git-send-email-filippo.arcidiacono@st.com>
In-Reply-To: <1329311088-2093-1-git-send-email-filippo.arcidiacono@st.com>
Subject: Re: [LTP] [PATCH v2] getrusage03: add opportunity to reduce memory
 allocation's size
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

Hi,

On 02/15/2012 09:04 PM, Filippo ARCIDIACONO wrote:
>  static struct rusage ru;
>  static long maxrss_init;
> -static int retval, status;
> +static int retval, status, opt_factor;
>  static pid_t pid;
> +static char *factor_str;
> +int factor_nr = 10;

missing `static`?

>  
> +option_t child_options[] = {
> +	{ "m:", &opt_factor, &factor_str },
> +	{ NULL, NULL,         NULL }
> +};
> +
> +static void usage(void);
>  static void inherit_fork(void);
> -static void inherit_fork2(void);
> +static void inherit_fork2(const int size);
>  static void fork_malloc(void);
>  static void grandchild_maxrss(void);
>  static void zombie(void);
> @@ -68,23 +76,33 @@ static void cleanup(void);
>  
>  int main(int argc, char *argv[])
>  {
> -	int lc;
> +	int lc, size;
>  	char *msg;
>  
> -	msg = parse_opts(argc, argv, NULL, NULL);
> +	msg = parse_opts(argc, argv, child_options, usage);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
>  	setup();
>  
> +	if (opt_factor)
> +		factor_nr = atoi(factor_str);
> +
> +	if (factor_nr == 0)
> +		tst_brkm(TBROK, cleanup, "Input factor must be != 0");

Hi, I guess factor_nr should not be < 0 too? If so, you might want to use

    factor_nr = SAFE_STRTOL(NULL, factor_str, 1, LONG_MAX);

where SAFE_STRTOL is defined in safe_macros.h, of course you should make
factor_nr to be long int.

Rest looks good to me.

Thanks,
Caspar


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
