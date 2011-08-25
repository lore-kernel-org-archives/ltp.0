Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwYG5-0001Sy-TH
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 11:38:05 +0000
Date: Thu, 25 Aug 2011 13:43:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825114316.GA12466@saboteur.suse.cz>
References: <109d27248df0d3518fbc4a6cc410345d6bdfed7f.1314156213.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <109d27248df0d3518fbc4a6cc410345d6bdfed7f.1314156213.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] hugeshmat01: do not use fixed addr
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> hugeshmat01 test use fixed addr for its 2nd testcase, however it does
> not work on some architectures, like powerpc. I took some codes from
> syscalls/shmat01, which fetches the baseaddr by running shmat first at
> setup(), and use it for 2nd testcase.

I would be happier to have the code generating the address in one place
rather than copying the code around.

> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
> +void	*base_addr;
>  
>  struct test_case_t {
>  	int *shmid;
>  	void *addr;
>  	int flags;
> -} TC[] = {
> -	/* a straight forward read/write attach */
> -	{&shm_id_1, 0, 0},
> -
> -       /* an attach using non aligned memory */
> -	{&shm_id_1, (void *)UNALIGNED, SHM_RND},
> -
> -	/* a read only attach */
> -	{&shm_id_1, 0, SHM_RDONLY}
>  };

There is no need to remove the static declaration for the structure,
just set the UNALIGNED to NULL and intialize only what is needed on
runtime.

Also the addr should be initalized with NULL rather than 0.

> +struct test_case_t TC[3];
> +
>  int main(int ac, char **av)
>  {
>  	int lc;				/* loop counter */
> @@ -259,6 +247,35 @@ setup(void)
>  		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
>  			 "resource 1 in setup()");
>  	}
> +
> +	/* Probe an available linear address for attachment */
> +	base_addr = shmat(shm_id_1, NULL, 0);
> +	if (base_addr == (void *)-1)
> +		tst_brkm(TBROK|TERRNO, cleanup,
> +				"Couldn't attach shared memory");
> +	if (shmdt((const void *)base_addr) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup,
> +				"Couldn't detach shared memory");

Cast from void* to const void* is not needed here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
