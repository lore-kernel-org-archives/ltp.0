Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VEgoe-0002tk-5Z
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 14:33:48 +0000
Date: Wed, 28 Aug 2013 16:33:56 +0200
From: chrubis@suse.cz
Message-ID: <20130828143355.GA383@rei>
References: <521DF60B.9010401@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521DF60B.9010401@oracle.com>
Subject: Re: [LTP] [PATCH] ltp: Fix races in mmap1
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
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  static int verbose_print = 0;
> -static char *map_address;
> +static char *volatile map_address;

Ok.

>  static jmp_buf jmpbuf;
>  static volatile char read_lock = 0;
>  
> @@ -228,11 +228,13 @@ void *read_mem(void *ptr)
>  				tst_resm(TINFO, "page fault occurred due to "
>  					 "a read after an unmap");
>  		} else {
> -			if (verbose_print)
> +			if (verbose_print) {
> +				read_lock = 1;
>  				tst_resm(TINFO,
>  					 "read_mem(): content of memory: %s",
>  					 (char *)map_address);
> -
> +				read_lock = 0;
> +			}
>  			for (j = 0; j < args[1]; j++) {
>  				read_lock = 1;
>  				if (map_address[j] != 'a')

Good catch, I've overlooked the tst_resm() when I was fixing the
testcase.

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
