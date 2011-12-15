Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rb1e5-0006S5-6e
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 03:06:09 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Rb1e4-00088s-AR
	for ltp-list@lists.sourceforge.net; Thu, 15 Dec 2011 03:06:09 +0000
Received: by yenm12 with SMTP id m12so1289883yen.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Dec 2011 19:06:02 -0800 (PST)
Message-ID: <4EE963F0.9090201@casparzhang.com>
Date: Thu, 15 Dec 2011 11:05:20 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4EE95F75.6030909@cn.fujitsu.com>
In-Reply-To: <4EE95F75.6030909@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] memcg_function:fix the wrong use of mlock
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
To: ltp-list@lists.sourceforge.net

On 12/15/2011 10:46 AM, Peng Haitao wrote:
> 
> mlock and munmap will return -1 when ERROR.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Nice catch.

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>  .../cpuset/cpuset_memory_test/cpuset_memory_test.c |    4 ++--
>  .../controllers/memcg/functional/memcg_process.c   |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
> index 8d37b24..512df3a 100644
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c
> @@ -196,7 +196,7 @@ void mmap_file(int flag_allocated)
>  		}
>  		touch_memory_and_echo_node(p, memsize);
>  	} else {
> -		if (!munmap(p, memsize) == -1)
> +		if (munmap(p, memsize) == -1)
>  			err(1, "munmap(file) failed");
>  
>  		if (opt_hugepage) {
> @@ -236,7 +236,7 @@ void mmap_lock2(int flag_allocated)
>  			err(1, "mlock failed");
>  		touch_memory_and_echo_node(p, memsize);
>  	} else {
> -		if (!munmap(p, memsize) == -1)
> +		if (munmap(p, memsize) == -1)
>  			err(1, "munmap failed");
>  	}
>  }
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
> index 4f8c257..37ded19 100644
> --- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
> @@ -167,7 +167,7 @@ void mmap_file()
>  		}
>  		touch_memory(p, memsize);
>  	} else {
> -		if (!munmap(p, memsize) == -1)
> +		if (munmap(p, memsize) == -1)
>  			err(1, "munmap(file) failed");
>  
>  		if (opt_hugepage) {
> @@ -202,10 +202,10 @@ void mmap_lock2()
>  		if (p == MAP_FAILED)
>  			err(1, "mmap failed");
>  
> -		if (!mlock(p, memsize))
> +		if (mlock(p, memsize) == -1)
>  			err(1, "mlock failed");
>  	} else {
> -		if (!munmap(p, memsize) == -1)
> +		if (munmap(p, memsize) == -1)
>  			err(1, "munmap failed");
>  	}
>  }


------------------------------------------------------------------------------
10 Tips for Better Server Consolidation
Server virtualization is being driven by many needs.  
But none more important than the need to reduce IT complexity 
while improving strategic productivity.  Learn More! 
http://www.accelacomm.com/jaw/sdnl/114/51507609/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
