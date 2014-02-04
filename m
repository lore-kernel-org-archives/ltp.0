Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WAfwN-0001qf-NU
	for ltp-list@lists.sourceforge.net; Tue, 04 Feb 2014 13:21:27 +0000
Date: Tue, 4 Feb 2014 14:20:55 +0100
From: chrubis@suse.cz
Message-ID: <20140204132055.GA5837@rei>
References: <1386844012.1603.17.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386844012.1603.17.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 1/2] getrlimit/getrlimit01.c: cleanup
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +/*
> + *   Test for checking functionality of getrlimit(2)
> + */

I've changed this comment to be more verbose about the test purpose.

> @@ -74,94 +31,72 @@
>  
>  			if (TEST_RETURN == -1) {
> -				tst_resm(TFAIL, "getrlimit() failed to get %s "
> -					 "values. errno is %d",
> +				tst_resm(TFAIL,
> +					 "getrlimit() test %s failed errno: %d",
>  					 testcases[i].res_str, TEST_ERRNO);

Changed the TFAIL to TFAIL | TTERRNO instead of the %d.

And pushed both patches, thanks.

PS: Sorry for the late response, I've had quite a lot of work after I've
    returned from Christmas vacation.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
