Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZAeZ9-0000Du-9G
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2015 13:30:11 +0000
Date: Thu, 2 Jul 2015 15:28:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150702132849.GB17833@rei.suse.de>
References: <1435827019-7831-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1435827019-7831-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] network/stress/ssh: tcp_fastopen test must be run
 with kernel 3.7 or newer
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
> index 7960627..3ff2367 100644
> --- a/testcases/network/stress/ssh/ssh-stress
> +++ b/testcases/network/stress/ssh/ssh-stress
> @@ -126,6 +126,9 @@ test02()
>  
>  test03()
>  {
> +	tst_kvercmp 3 7 0 && \
> +		tst_brkm TCONF "Test must be run with kernel 3.7 or newer"

Hmm, do we need to exit whole test if test03() cannot be executed?

Shouldn't this rather be tst_resm TCONF followed with return?

Alexej, can you look at this please?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
