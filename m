Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YnnQn-0003R2-V7
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 12:19:05 +0000
Date: Thu, 30 Apr 2015 14:18:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430121835.GC24720@rei.suse.de>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1427787975-10668-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1427787975-10668-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/6] lib6/asapi_04.c: cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void setup(void);

Hmm, setup() is declared static here.

> +static void test_in6_are_addr_equal(void);
> +static void test_protocols_entry(void);
> +static int csum_test(char *rhost);
> +static void test_ipv6_checksum(void);
>  
> -#define READ_TIMEOUT	5	/* secs */
>  
> -void do_tests(void);
> -void setup(void), cleanup(void);
> -int csum_test(char *rhost);
> +static void (*testfunc[])(void) = { test_in6_are_addr_equal,
> +	test_protocols_entry, test_ipv6_checksum };
> +
> +char *TCID = "asapi_04";
> +int TST_TOTAL = ARRAY_SIZE(testfunc);
>  
>  int main(int argc, char *argv[])
>  {
>  	int lc;
> +	int i;
>  
>  	tst_parse_opts(argc, argv, 0, 0);
>  
> @@ -86,22 +65,27 @@ int main(int argc, char *argv[])
>  
>  	setup();
>  
> -	for (lc = 0; TEST_LOOPING(lc); ++lc)
> -		do_tests();
> +	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> +		tst_count = 0;
>  
> -	cleanup();
> +		for (i = 0; i < TST_TOTAL; i++)
> +			(*testfunc[i])();
> +	}
>  
>  	tst_exit();
>  }
>  
> -void do_tests(void)
> +void setup(void)
>  {
> -	int i;
> +	TEST_PAUSE;
> +}

But it's missing static here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
