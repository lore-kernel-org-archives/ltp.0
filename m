Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1O25d3-00030w-Uv
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 16:39:53 +0000
Received: from xenotime.net ([72.52.64.118])
	by sfi-mx-1.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1O25d2-0007UM-T5
	for ltp-list@lists.sourceforge.net; Wed, 14 Apr 2010 16:39:53 +0000
Received: from chimera.site ([71.245.98.113]) by xenotime.net for
	<ltp-list@lists.sourceforge.net>; Wed, 14 Apr 2010 08:19:53 -0700
Date: Wed, 14 Apr 2010 08:19:53 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Message-Id: <20100414081953.7356b407.rdunlap@xenotime.net>
In-Reply-To: <000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
References: <000001cadad6$c061c590$412550b0$@co.jp>
	<4BC487C9.9080300@xenotime.net>
	<000901cadb78$a2d05080$e870f180$@co.jp>
	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>
	<000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, 14 Apr 2010 17:58:17 +0900 Mitani wrote:

> Hi, 
> 
> I suggest new patch.
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

This one is OK with me also, but...

Is it possible to determine the difference between a kernel that does
not support hugepages at all and a kernel that does support hugepages
but just does not have enough of them allocated?

or maybe we don't care about this difference.  Do we?


> ============
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c	2010-04-14
> 16:40:25.000000000 +0900
> @@ -127,8 +127,7 @@
>  
>  	/* Check number of hugepages */
>  	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
> -		tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> \
> -				sufficient availability of Hugepages on the
> system");
> +		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>  
>  	/* Perform global setup for test */
>  	setup();
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c	2010-04-14
> 16:48:54.000000000 +0900
> @@ -105,7 +105,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c	2010-04-14
> 16:49:15.000000000 +0900
> @@ -102,7 +102,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c	2010-04-14
> 16:49:31.000000000 +0900
> @@ -86,7 +86,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c	2010-04-14
> 16:50:16.000000000 +0900
> @@ -130,7 +130,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c	2010-04-14
> 16:50:28.000000000 +0900
> @@ -102,7 +102,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c	2010-04-14
> 16:50:40.000000000 +0900
> @@ -105,7 +105,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c	2010-04-14
> 16:51:11.000000000 +0900
> @@ -87,7 +87,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c	2010-04-14
> 16:51:34.000000000 +0900
> @@ -82,7 +82,7 @@
>  
>  	/* The following loop checks looping state if -i option given */
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>          else             
>                huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>          
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c	2010-04-14
> 16:51:45.000000000 +0900
> @@ -84,7 +84,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>    
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c	2010-04-14
> 16:51:55.000000000 +0900
> @@ -85,7 +85,7 @@
>  
>  	/* The following loop checks looping state if -i option given */
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>  
> --- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	2010-04-01
> 15:23:09.000000000 +0900
> +++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c	2010-04-14
> 16:52:10.000000000 +0900
> @@ -86,7 +86,7 @@
>  	}
>  
>          if ( get_no_of_hugepages() <= 0 || hugepages_size() <= 0 )
> -             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to
> sufficient availability of Hugepages on the system");
> +             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
>          else             
>               huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() *
> hugepages_size() * 1024) / 2 ;
>         
> ============


---
~Randy

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
