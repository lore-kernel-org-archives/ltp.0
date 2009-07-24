Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MUPS9-0003C8-Lx
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 18:25:09 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUPS5-0000LA-Fx
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 18:25:09 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6OIGgCb023568
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 12:16:42 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6OIOxoE198430
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 12:24:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6OIOwon011075
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Jul 2009 12:24:59 -0600
Date: Fri, 24 Jul 2009 11:24:57 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090724182457.GJ5878@count0.beaverton.ibm.com>
References: <1248272525-13205-1-git-send-email-nobuhiro@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1248272525-13205-1-git-send-email-nobuhiro@andestech.com>
Subject: Re: [LTP] [PATCH] Fixed static build which needs to link
	the	pthread library in pidns and pipeio.
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
To: nobuhiro <nobuhiro@andestech.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 22, 2009 at 10:22:05PM +0800, nobuhiro wrote:
> 
> Signed-off-by: nobuhiro <nobuhiro@andestech.com>
> ---
>  testcases/kernel/containers/pidns/Makefile |    2 +-
>  testcases/kernel/ipc/pipeio/Makefile       |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/containers/pidns/Makefile b/testcases/kernel/containers/pidns/Makefile
> index 4886d58..14f49da 100644
> --- a/testcases/kernel/containers/pidns/Makefile
> +++ b/testcases/kernel/containers/pidns/Makefile
> @@ -20,7 +20,7 @@
> 
>  CFLAGS += -Wall
>  CPPFLAGS += -I../../../../include -I../libclone
> -LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt
> +LDLIBS += -L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt -lpthread

I'm not sure this is correct. I just did a CVS update and grepped for
"pthread". I don't see a single use of pthreads in there. What output
suggested all of these tests need to link to pthreads? Could you at
least stick that in the changelog?

> 
>  SRCS    := $(wildcard *.c)
>  TARGETS := $(SRCS:%.c=%)
> diff --git a/testcases/kernel/ipc/pipeio/Makefile b/testcases/kernel/ipc/pipeio/Makefile
> index afd3e8d..d2a1d5f 100644
> --- a/testcases/kernel/ipc/pipeio/Makefile
> +++ b/testcases/kernel/ipc/pipeio/Makefile
> @@ -22,7 +22,7 @@
>  ###########################################################################
>  CFLAGS   += -Wall
>  CPPFLAGS += -I../../../../include
> -LDLIBS   += -L../../../../lib -lltp -lrt
> +LDLIBS   += -L../../../../lib -lltp -lrt -lpthread

Same here.

Cheers,
	-Matt Helsley

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
