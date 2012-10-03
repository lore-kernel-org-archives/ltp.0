Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJOef-000360-As
	for ltp-list@lists.sourceforge.net; Wed, 03 Oct 2012 13:06:25 +0000
Date: Wed, 3 Oct 2012 15:06:40 +0200
From: chrubis@suse.cz
Message-ID: <20121003130640.GD22986@saboteur.suse.cz>
References: <502496C6.3090906@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <502496C6.3090906@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4] pthread_cond_brodcast/1-2.c hung when mem left
 is not enough
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
>  /* Do not create more than this amount of children: */
> -#define MAX_PROCESS_CHILDREN  (200)
> -#define MAX_THREAD_CHILDREN   (1000)
> +static int max_process_children  = 200;
> +static int max_thread_children = 1000;
>  
>  #define TIMEOUT  (180)
>  
> @@ -243,6 +244,42 @@ void *timer(void *arg)
>  	return NULL; /* For compiler */
>  }
>  
> +#ifdef __linux__
> +static void children_number(void)
> +{
> +	struct sysinfo sysinformation;
> +	int ret;
> +	int avail_number;
> +	unsigned long per_process;
> +	unsigned long min_stack;
> +
> +	min_stack = sysconf(_SC_THREAD_STACK_MIN);
> +
> +	ret = sysinfo(&sysinformation);
> +	if (ret != 0)
> +		UNRESOLVED(ret, "Failed to get system information.");
> +
> +	per_process = min_stack * max_thread_children;
> +	if (per_process > sysinformation.freeram)
> +		UNTESTED("Not enough memory.");
> +
> +	avail_number = sysinformation.freeram / per_process;
> +
> +	if (avail_number < 10)
> +		UNTESTED("Not enough memory.");
> +
> +	max_process_children = (avail_number < max_process_children ?
> +					avail_number : max_process_children);
> +
> +	return;
> +}

I generally don't like to see linux-only solutions in the open posix
testsuite and advice to use them only when there is no POSIX interface
for them.

And this looks like the only thing that is not in the scope of POSIX is
size of the available memory. What about creating header in
open_posix_testsuite/include/ that would define interface to get free
ram in different systems and using this code in general case?

And actually I think that free ram itself is enough to figoure out
available memory as the kernel tends to eat as many memory for buffers
as available and reclaims it back only when needed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
