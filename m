Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RioO2-000807-3y
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 14:33:46 +0000
Date: Thu, 5 Jan 2012 15:44:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105144439.GA20860@saboteur.suse.cz>
References: <1A42CE6F5F474C41B63392A5F80372B212E02C95A3@shsmsx501.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B212E02C95A3@shsmsx501.ccr.corp.intel.com>
Subject: Re: [LTP] [Ltp-commits] [patches 2/3]perfcounter api updates
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
To: "Xu, Anhua" <anhua.xu@intel.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "Song,  Youquan" <youquan.song@intel.com>

Hi!
> >From 85050140d0c6de1cedb538ef42bd8a106e4075ef Mon Sep 17 00:00:00 2001
> From: Xu,Anhua <anhua.xu@intel.com>
> Date: Mon, 28 Nov 2011 15:48:31 +0800
> Subject: [PATCH] perfcounter01: Update calling for perf_event_open
> 
> Since perf_event_open API changed a lot, the original calling no long
> worked

Plese write a better description than "things have changes". From the
patch bellow it looks like syscall parameter format have changed from
integer to structure.

>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
> @@ -49,13 +51,15 @@ extern char *TESTDIR;                /* temporary dir created by tst_tmpdir() */
>  char *TCID     = "performance_counter01"; /* test program identifier.          */
>  int  TST_TOTAL = 1;
>  
> -enum hw_event_types {
> -	PERF_COUNT_CYCLES,
> -	PERF_COUNT_INSTRUCTIONS,
> -	PERF_COUNT_CACHE_REFERENCES,
> -	PERF_COUNT_CACHE_MISSES,
> -	PERF_COUNT_BRANCH_INSTRUCTIONS,
> -	PERF_COUNT_BRANCH_MISSES,
> +static struct perf_event_attr default_attrs[] = {
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_CPU_CYCLES		},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_STALLED_CYCLES_BACKEND	},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_INSTRUCTIONS		},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_CACHE_MISSES 		},
> +  { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_CACHE_REFERENCES	},
>  };

Please tremove the extra spaces before the closing bracket.

>  void cleanup(void) { /* Stub function. */ }
> @@ -67,13 +71,13 @@ main(void) {
>  	int fd1, fd2, ret;
>  
>  	fd1 = syscall(__NR_perf_event_open,
> -			PERF_COUNT_INSTRUCTIONS, 0, 0, 0, -1);
> +			&default_attrs[3], 0, -1, -1, 0);
>  	if (fd1 < 0) {
>  		tst_brkm(TBROK | TERRNO, cleanup,
>  			"Failed to create PERF_COUNT_INSTRUCTIONS fd");
>  	}
>  	fd2 = syscall(__NR_perf_event_open,
> -			PERF_COUNT_CACHE_MISSES, 0, 0, 0, -1);
> +			&default_attrs[6], 0, -1, -1, 0);
>  	if (fd2 < 0) {
>  		tst_brkm(TBROK | TERRNO, cleanup,
>  			"Failed to create PERF_COUNT_CACHE_MISSES fd");
> @@ -104,3 +108,5 @@ main(void) {
>  	tst_exit();
>  
>  }

The rest of the patch seems straightforward, please run it trought
checkpatch (which is part of linux kernel sources) before resending.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
