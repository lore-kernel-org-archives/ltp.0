Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VvQNw-0003gT-VJ
	for ltp-list@lists.sourceforge.net; Tue, 24 Dec 2013 11:42:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VvQNv-0008JA-Bf
	for ltp-list@lists.sourceforge.net; Tue, 24 Dec 2013 11:42:52 +0000
Message-ID: <1387885358.1622.104.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Tue, 24 Dec 2013 19:42:38 +0800
In-Reply-To: <1387884941.1622.98.camel@G08JYZSD130126>
References: <1387884941.1622.98.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v3 1/4] fallocate/fallocate.h: move inline function
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
Cc: Mike Frysinger <vapier@gentoo.org>

On Tue, 2013-12-24 at 19:35 +0800, zenglg.jy wrote:
> >From edb98f0b69c16f612f79fe24d10597af47424f13 Mon Sep 17 00:00:00 2001
> From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> Date: Tue, 24 Dec 2013 19:21:32 +0800
> Subject: [PATCH] fallocate/fallocate.h: move inline function
> 
> Moved common inline function to fallocate.h
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/fallocate/fallocate.h   | 47 +++++++++++++++++++++++
>  testcases/kernel/syscalls/fallocate/fallocate01.c | 23 +----------
>  testcases/kernel/syscalls/fallocate/fallocate02.c | 19 +--------
>  testcases/kernel/syscalls/fallocate/fallocate03.c | 19 +--------
>  4 files changed, 50 insertions(+), 58 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fallocate/fallocate.h
> 
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate.h b/testcases/kernel/syscalls/fallocate/fallocate.h
> new file mode 100644
> index 0000000..e47338b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fallocate/fallocate.h
> @@ -0,0 +1,47 @@
> +/*
> + * Copyright (c) International Business Machines  Corp., 2007
> + * Copyright (c) 2013 Fujitsu Ltd.
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU Library General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + */
> +
> +#ifndef FALLOCATE_H
> +#define FALLOCATE_H
> +
> +#include <sys/types.h>
> +#include <endian.h>
> +#include "linux_syscall_numbers.h"
> +
> +static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
> +{
> +/*
> + * Use __WORDSIZE will fail on ABI's that have 64bit registers but 32bit
> + * longs like MIPS n32 and x86_64 x32
> + */

I do not know about the ABI's problem. Could someone give me a help.
Best regards,
Zeng

> +#if __WORDSIZE == 64 || defined __powerpc64__ || defined __mips64 ||\
> +defined __x86_64__ || defined __sparc64__
> +	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
> +
> +#else
> +	return (long)ltp_syscall(__NR_fallocate, fd, mode,
> +				 __LONG_LONG_PAIR((off_t) (offset >> 32),
> +						  (off_t) offset),
> +				 __LONG_LONG_PAIR((off_t) (len >> 32),
> +						  (off_t) len));
> +#endif
> +}
> +
> +#endif /* FALLOCATE.H */
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
> index 0240687..eec39fa 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate01.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
> @@ -100,12 +100,10 @@
>  
>  #include "test.h"
>  #include "usctest.h"
> -#include "linux_syscall_numbers.h"
> +#include "fallocate.h"
>  
>  #define BLOCKS_WRITTEN 12
>  
> -/* Local Function */
> -static inline long fallocate();
>  void get_blocksize(int);
>  void populate_files(int fd);
>  void runtest(int, int, loff_t);
> @@ -183,16 +181,10 @@ void get_blocksize(int fd)
>  void populate_files(int fd)
>  {
>  	char buf[buf_size + 1];
> -	char *fname;
>  	int index;
>  	int blocks;
>  	int data;
>  
> -	if (fd == fd_mode1)
> -		fname = fname_mode1;
> -	else
> -		fname = fname_mode2;
> -
>  	for (blocks = 0; blocks < BLOCKS_WRITTEN; blocks++) {
>  		for (index = 0; index < buf_size; index++)
>  			buf[index] = 'A' + (index % 26);
> @@ -239,19 +231,6 @@ int main(int ac, char **av)
>  	tst_exit();
>  }
>  
> -static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
> -{
> -#if __WORDSIZE == 32
> -	return (long)ltp_syscall(__NR_fallocate, fd, mode,
> -			     __LONG_LONG_PAIR((off_t) (offset >> 32),
> -					      (off_t) offset),
> -			     __LONG_LONG_PAIR((off_t) (len >> 32),
> -					      (off_t) len));
> -#else
> -	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
> -#endif
> -}
> -
>  /*****************************************************************************
>   * Calls the system call, with appropriate parameters and writes data
>   ******************************************************************************/
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate02.c b/testcases/kernel/syscalls/fallocate/fallocate02.c
> index 37f0635..e5e482c 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate02.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate02.c
> @@ -96,7 +96,7 @@
>  
>  #include "test.h"
>  #include "usctest.h"
> -#include "linux_syscall_numbers.h"
> +#include "fallocate.h"
>  
>  #define BLOCKS_WRITTEN 12
>  
> @@ -108,7 +108,6 @@
>  
>  #define OFFSET 12
>  
> -static inline long fallocate();
>  void populate_file();
>  void create_fifo();
>  void create_pipe();
> @@ -225,22 +224,6 @@ void populate_file()
>  }
>  
>  /*****************************************************************************
> - * Wraper function to call fallocate system call
> - ******************************************************************************/
> -static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
> -{
> -#if __WORDSIZE == 32
> -	return (long)ltp_syscall(__NR_fallocate, fd, mode,
> -			     __LONG_LONG_PAIR((off_t) (offset >> 32),
> -					      (off_t) offset),
> -			     __LONG_LONG_PAIR((off_t) (len >> 32),
> -					      (off_t) len));
> -#else
> -	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
> -#endif
> -}
> -
> -/*****************************************************************************
>   * Main function that calls the system call with the  appropriate parameters
>   ******************************************************************************/
>  /* ac: number of command line parameters */
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
> index 973b2d7..a42dcad 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate03.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
> @@ -95,7 +95,7 @@
>  
>  #include "test.h"
>  #include "usctest.h"
> -#include "linux_syscall_numbers.h"
> +#include "fallocate.h"
>  
>  #define BLOCKS_WRITTEN 12
>  #define HOLE_SIZE_IN_BLOCKS 12
> @@ -103,7 +103,6 @@
>  #define FALLOC_FL_KEEP_SIZE 1	//Need to be removed once the glibce support is provided
>  #define TRUE 0
>  
> -static inline long fallocate();
>  void get_blocksize(int);
>  void populate_file();
>  void file_seek(off_t);
> @@ -219,22 +218,6 @@ void populate_file()
>  }
>  
>  /*****************************************************************************
> - * Wraper function to call fallocate system call
> - ******************************************************************************/
> -static inline long fallocate(int fd, int mode, loff_t offset, loff_t len)
> -{
> -#if __WORDSIZE == 32
> -	return (long)ltp_syscall(__NR_fallocate, fd, mode,
> -			     __LONG_LONG_PAIR((off_t) (offset >> 32),
> -					      (off_t) offset),
> -			     __LONG_LONG_PAIR((off_t) (len >> 32),
> -					      (off_t) len));
> -#else
> -	return ltp_syscall(__NR_fallocate, fd, mode, offset, len);
> -#endif
> -}
> -
> -/*****************************************************************************
>   * Main function that calls the system call with the  appropriate parameters
>   ******************************************************************************/
>  /* ac: number of command line parameters */



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
