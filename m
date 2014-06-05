Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WsVRE-0002vQ-8y
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 11:02:28 +0000
Date: Thu, 5 Jun 2014 13:02:06 +0200
From: chrubis@suse.cz
Message-ID: <20140605110206.GA13350@rei>
References: <1400077009-6831-1-git-send-email-shuang.qiu@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400077009-6831-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH] kernel/mem/mtest06/mmap1.c: Update the
 synchronization logic
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
To: shuang.qiu@oracle.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Currently in mmap1.c,the reader and writer cannot synchronize with each other.
> Added one more lock and update the logic a little to make it work.
> 
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> ---
>  testcases/kernel/mem/mtest06/mmap1.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
> index cd1127f..6bdbf75 100644
> --- a/testcases/kernel/mem/mtest06/mmap1.c
> +++ b/testcases/kernel/mem/mtest06/mmap1.c
> @@ -65,6 +65,7 @@ static int verbose_print = 0;
>  static char *volatile map_address;
>  static jmp_buf jmpbuf;
>  static volatile char read_lock = 0;
> +static volatile char write_lock = 0;
>  
>  char *TCID = "mmap1";
>  int TST_TOTAL = 1;
> @@ -157,6 +158,7 @@ void *map_write_unmap(void *ptr)
>  
>  		while (read_lock)
>  			sched_yield();
> +		read_lock = 1;

This is obviously wrong because combined with the removal of the
read_lock = 1 from the read_mem() thread you just disabled the writer
thread entirely.

>  		sigfillset(&sa.sa_mask);
>  		sigdelset(&sa.sa_mask, SIGSEGV);
> @@ -197,6 +199,7 @@ void *map_write_unmap(void *ptr)
>  			perror("map_write_unmap(): mmap()");
>  			pthread_exit((void *)1);
>  		}
> +		write_lock = 0;
>  	}
>  
>  	pthread_exit((void *)0);
> @@ -218,6 +221,9 @@ void *read_mem(void *ptr)
>  
>  	for (i = 0; i < args[2]; i++) {
>  
> +		while (write_lock)
> +			sched_yield();
> +		write_lock = 1;

The same here, this disables the thread.


Can you describe precisely what race condition are you trying to fix?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
