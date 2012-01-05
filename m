Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RiooH-0001lv-Fl
	for ltp-list@lists.sourceforge.net; Thu, 05 Jan 2012 15:00:53 +0000
Date: Thu, 5 Jan 2012 16:11:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120105151145.GC20860@saboteur.suse.cz>
References: <1A42CE6F5F474C41B63392A5F80372B212E02C95B5@shsmsx501.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B212E02C95B5@shsmsx501.ccr.corp.intel.com>
Subject: Re: [LTP] [Ltp-commits] [patch] perfcounter01: fix infinite loops
 when no issues encountered
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
> In the original test, if no error upon perfcounter, this test will
> never end. Add a "loop" variable to force stopping when no issues detected
> 
> Signed-off-by: Xu,Anhua <anhua.xu@intel.com>
> ---
>  .../performance_counters/performance_counter01.c   |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/performance_counters/performance_counter01.c b/testcases/kernel/performance_counters/performance_counter01.c
> index 23cc31b..7ffd15a 100644
> --- a/testcases/kernel/performance_counters/performance_counter01.c
> +++ b/testcases/kernel/performance_counters/performance_counter01.c
> @@ -67,7 +67,7 @@ void cleanup(void) { /* Stub function. */ }
>  int
>  main(void) {
>  
> -	unsigned long long count1, count2;
> +	unsigned long long count1, count2, loop = 100;
>  	int fd1, fd2, ret;
>  
>  	fd1 = syscall(__NR_perf_event_open,
> @@ -103,7 +103,7 @@ main(void) {
>  
>  		}
>  
> -	} while (ret == sizeof(unsigned long long));
> +	} while (ret == sizeof(unsigned long long) && loop--);
>  
>  	tst_exit();

Hmm, and also the return value from read should be checked and
the test should fail if read() has returned error.

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
