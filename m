Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <avagin@gmail.com>) id 1Nw978-0002S7-5d
	for ltp-list@lists.sourceforge.net; Mon, 29 Mar 2010 07:10:22 +0000
Received: from mail-bw0-f218.google.com ([209.85.218.218])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nw975-0004Dy-Tx
	for ltp-list@lists.sourceforge.net; Mon, 29 Mar 2010 07:10:22 +0000
Received: by bwz10 with SMTP id 10so13340001bwz.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Mar 2010 00:10:13 -0700 (PDT)
Message-ID: <4BB0524E.7020409@gmail.com>
Date: Mon, 29 Mar 2010 11:10:06 +0400
From: "avagin@gmail.com" <avagin@gmail.com>
MIME-Version: 1.0
References: <1269370994-7087-1-git-send-email-dguryanov@parallels.com>
In-Reply-To: <1269370994-7087-1-git-send-email-dguryanov@parallels.com>
Subject: Re: [LTP] [PATCH] mmap1: fix race between map_write_unmap and
	read_mem
Reply-To: avagin@gmail.com
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi, all.

We have seen on this test case in more detail and find some race conditions.

1. the first race between setting & reading & checking & printing value 
of map_address

This race is reproduced if a reader thread is started before a 
map_write_unmap thread. I added logging and got follow output:

caught unexpected signal - 11 info->si_addr=(nil) 
map_address=0x2aaaaaaac000--- exiting

[thread]	:	[operation]
read_mem	:	if (strncmp((char *)map_address, "a", 1) != 0)
map_write_unmap	:	map_address = mmap(...)
read_mem	:	info->si_addr == map_address

2. the second race between memcpy and a check of memory content.
[thread]	:	[operation]
map_write_unmap	:	map_address = mmap(...)
read_mem	:	if (strncmp((char *)map_address, "a", 1) != 0)
map_write_unmap	:	memset(map_address, 'a', mwuargs[1]);


On 03/23/2010 10:03 PM, Dmitry Guryanov wrote:
> On one of test runs it failed with follwing log:
>
> mmap1       0  INFO  :  created thread[1093683520]
> mmap1       0  INFO  :  pid[6430]: map, change contents, unmap files 1000 times
> mmap1       0  INFO  :  created thread[1109268800]
> mmap1       0  INFO  :  pid[6430] - read contents of memory (nil) 1000 times
> mmap1       0  INFO  :  page fault occurred at (nil)
> mmap1       0  INFO  :  page fault occurred at (nil)
> ....................
> mmap1       0  INFO  :  page fault occurred at (nil)
> caught unexpected signal - 11 --- exiting
>
> This can happen, if thread map_write_unmap haven't mapped file yet, but
> thread read_mem already began to read from it (it reads from map_address, which
> will be NULL in this case).

This testcase tries to handle SIGSEGV:
in reader thread, it does setjmp(), and in signal handler it does longjmp().

>
> Let's wait, while thread map_write_unmap actually maps file, in read_mem thread
> and zero map_address each time map_write_unmap unmaps this memory.
> ---
>   testcases/kernel/mem/mtest06/mmap1.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
> index 47ab49a..28d9e5d 100644
> --- a/testcases/kernel/mem/mtest06/mmap1.c
> +++ b/testcases/kernel/mem/mtest06/mmap1.c
> @@ -331,6 +331,7 @@ map_write_unmap(void *args)	/* file descriptor of the file to be mapped.  */
>               exit_val = MWU_FAIL;
>               pthread_exit((void *)exit_val);
>           }
> +        map_address = NULL;
>       }
>       exit_val = M_SUCCESS;
>       pthread_exit((void *)exit_val);
> @@ -358,6 +359,10 @@ read_mem(void *args)		/* number of reads performed		      */
>       long 	*rmargs = args;	/* local pointer to the arguments	      */
>       long exit_val = 0;  /* pthread exit value			      */
>
> +    /* wait for first thread to map file */
> +    while(!map_address)
> +        sched_yield();
> +
>       tst_resm(TINFO, "pid[%d] - read contents of memory %p %ld times",
>              getpid(), map_address, rmargs[2]);
>       if (verbose_print)


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
