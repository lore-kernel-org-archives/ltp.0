Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfsnQ-00088x-3R
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:32 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfsnN-00035T-07
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:31 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7P9uvHm009272
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:56:57 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9wNRK230570
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:58:23 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9wNDT003449
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:58:23 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A930FD1.9060903@us.ibm.com>
References: <4A930FD1.9060903@us.ibm.com>
Date: Tue, 25 Aug 2009 15:28:17 +0530
Message-Id: <1251194297.5534.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH][realtime] add support for long options
Reply-To: subrata@linux.vnet.ibm.com
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
To: Darren Hart <dvhltc@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Vernon Mauery <vernux@us.ibm.com>

On Mon, 2009-08-24 at 15:10 -0700, Darren Hart wrote: 
> add support for long options
> 
> Incorporating existing tests (like pthread_cond_many) may require support
> for long options if the existing arguments are to remain supported.  This
> patch adds support for long options, while keeping the default of only
> short options in place.  long opts MUST have an equivalent short opt so
> as to not require changing (and complicating) the parse_arg signature.
> This patch tests for this in the rt_init routine.
> 
> Signed-off-by: Darren Hart <dvhltc@us.ibm.com>

Thanks Darren.

Regards--
Subrata

> Acked-by: Vernon Mauery <vernux@us.ibm.com>
> 
> ---
>  include/librttest.h |   12 ++++++++++--
>  lib/librttest.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 6 deletions(-)
> 
> Index: realtime/include/librttest.h
> ===================================================================
> --- realtime.orig/include/librttest.h
> +++ realtime/include/librttest.h
> @@ -235,10 +235,12 @@ static volatile int _debug_count = 0;
>  /* rt_help: print help for standard args */
>  void rt_help();
> 
> -/* rt_init: initialize librttest
> +/* rt_init_long: initialize librttest
>   * options: pass in an getopt style string of options -- e.g. "ab:cd::e:"
>   *          if this or parse_arg is null, no option parsing will be done
>   *          on behalf of the calling program (only internal args will be parsed)
> + * longopts: a pointer to the first element of an array of struct option, the
> + *           last entry must be set to all zeros.
>   * parse_arg: a function that will get called when one of the above
>   *            options is encountered on the command line.  It will be passed
>   *            the option -- e.g. 'b' -- and the value.  Something like:
> @@ -267,7 +269,13 @@ void rt_help();
>   * argc: passed from main
>   * argv: passed from main
>   */
> -int rt_init(const char *options, int (*parse_arg)(int option, char *value), int argc, char *argv[]);
> +int rt_init_long(const char *options, const struct option *longopts,
> +		 int (*parse_arg)(int option, char *value),
> +		 int argc, char *argv[]);
> +
> +/* rt_init: same as rt_init_long with no long options */
> +int rt_init(const char *options, int (*parse_arg)(int option, char *value),
> +	    int argc, char *argv[]);
> 
>  int create_thread(void*(*func)(void*), void *arg, int prio, int policy);
> 
> Index: realtime/lib/librttest.c
> ===================================================================
> --- realtime.orig/lib/librttest.c
> +++ realtime/lib/librttest.c
> @@ -99,9 +99,13 @@ void calibrate_busyloop(void)
>  	iters_per_us = (CALIBRATE_LOOPS * NS_PER_US) / (end-start);
>  }
> 
> -int rt_init(const char *options, int (*parse_arg)(int option, char *value), int argc, char *argv[])
> +int rt_init_long(const char *options, const struct option *longopts,
> +		 int (*parse_arg)(int option, char *value), int argc,
> +		 char *argv[])
>  {
> +	const struct option *cur_opt;
>  	int use_buffer = 1;
> +	char *longopt_vals;
>  	size_t i;
>  	int c;
>  	opterr = 0;
> @@ -126,8 +130,33 @@ int rt_init(const char *options, int (*p
>  			exit(1);
>  		}
>  	}
> +
> +	/* Ensure each long options has a known unique short option in val. */
> +	longopt_vals = "";
> +	cur_opt = longopts;
> +	while (cur_opt && cur_opt->name) {
> +		if (cur_opt->flag) {
> +			fprintf(stderr, "Programmer error -- argument --%s flag"
> +				" is non-null\n", cur_opt->name);
> +			exit(1);
> +		}
> +		if (!strchr(all_options, cur_opt->val)) {
> +			fprintf(stderr, "Progreammer error -- argument --%s "
> +				"shortopt -%c wasn't listed in options (%s)\n",
> +				cur_opt->name, cur_opt->val, all_options);
> +			exit(1);
> +		}
> +		if (strchr(longopt_vals, cur_opt->val)) {
> +			fprintf(stderr, "Programmer error -- argument --%s "
> +				"shortopt -%c is used more than once\n",
> +				cur_opt->name, cur_opt->val);
> +			exit(1);
> +		}
> +		asprintf(&longopt_vals, "%s%c", longopt_vals, cur_opt->val);
> +		cur_opt++;
> +	}
>  	
> -	while ((c = getopt(argc, argv, all_options)) != -1) {
> +	while ((c = getopt_long(argc, argv, all_options, longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'c':
>  			pass_criteria = atof(optarg);
> @@ -148,11 +177,17 @@ int rt_init(const char *options, int (*p
>  			save_stats = 1;
>  			break;
>  		case ':':
> -			fprintf(stderr, "option -%c: missing arg\n", optopt);
> +			if (optopt == '-')
> +				fprintf(stderr, "long option missing arg\n");
> +			else
> +				fprintf(stderr, "option -%c: missing arg\n", optopt);
>  			parse_arg('h', optarg); /* Just to display usage */
>  			exit (1); /* Just in case. (should normally be done by usage()) */
>  		case '?':
> -			fprintf(stderr, "option -%c not recognized\n", optopt);
> +			if (optopt == '-')
> +				fprintf(stderr, "unrecognized long option\n");
> +			else
> +				fprintf(stderr, "option -%c not recognized\n", optopt);
>  			parse_arg('h', optarg); /* Just to display usage */
>  			exit (1); /* Just in case. (should normally be done by usage()) */
>  		default:
> @@ -185,6 +220,12 @@ int rt_init(const char *options, int (*p
>  	return 0;
>  }
> 
> +int rt_init(const char *options, int (*parse_arg)(int option, char *value),
> +	    int argc, char *argv[])
> +{
> +	return rt_init_long(options, NULL, parse_arg, argc, argv);
> +}
> +
>  void buffer_init(void)
>  {
>  	_print_buffer = (char *)malloc(PRINT_BUFFER_SIZE);


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
