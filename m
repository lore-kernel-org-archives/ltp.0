Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VWjS7-00056U-PV
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 09:01:07 +0000
Date: Thu, 17 Oct 2013 11:00:53 +0200
From: chrubis@suse.cz
Message-ID: <20131017090053.GA23578@rei.Home>
References: <CAGcQJusNyFXzWp-4FXA9HSfgcHePQdGxGZHyY38jvym+iQ1cnA@mail.gmail.com>
	<CAGcQJuvyNDpE7vS19UChrPwK9fzMR74jigDYJ_7d6Ste0ONtAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGcQJuvyNDpE7vS19UChrPwK9fzMR74jigDYJ_7d6Ste0ONtAw@mail.gmail.com>
Subject: Re: [LTP] Fwd: LTP patch contribution.
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
To: prakash b <bjsprakash@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hi ltp-list,
> 
> I would like to submit a minor patch to ltp/sourceforge.
> 
> To resolve abi related issues.
> 
> index c6226f8..6bc5863 100644
> --- a/testcases/kernel/mem/lib/Makefile
> +++ b/testcases/kernel/mem/lib/Makefile
> @@ -20,7 +20,7 @@ top_srcdir            ?= ../../../..
> 
>  include $(top_srcdir)/include/mk/env_pre.mk
> 
> -CFLAGS                 := -I../include
> +CFLAGS                 += -I../include
>  INTERNAL_LIB           := libmem.a
> 
>  include $(top_srcdir)/testcases/kernel/include/lib.mk

Thanks for your effort.

Can you describe, in detail, why is this change needed?
(ideally in commit message)

Also can you send a signed patch?
(i.e. patch with a Signed-off-by line, git can help you create these)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
