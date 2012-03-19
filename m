Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S9aLZ-0006fO-UU
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 11:01:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S9aLY-0006I1-1L
	for ltp-list@lists.sourceforge.net; Mon, 19 Mar 2012 11:01:53 +0000
Message-ID: <4F6711E0.7020807@cn.fujitsu.com>
Date: Mon, 19 Mar 2012 19:00:48 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <2fb866f36188a32158e9cb402adb5d59d9df27d2.1332151930.git.zliu@redhat.com>
In-Reply-To: <2fb866f36188a32158e9cb402adb5d59d9df27d2.1332151930.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v3] mem/oom: avoid unexpected error when no memcg
 swap accounting
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Zhouping Liu <zliu@redhat.com>
Cc: Cai Qian <caiqian@redhat.com>, LTP List <ltp-list@lists.sourceforge.net>

On 03/19/2012 06:28 PM, Zhouping Liu wrote:

> Since commit http://git.kernel.org/linus/a42c390cfa0c,
> which added an option to control memcg swap, when kernel
> neither set CGROUP_MEM_RES_CTLR_SWAP_ENABLED nor add
> 'swapaccount=1' kernel parameter, that indicates memcg swap
> accounting is disabled, it will have no such file:
> memory.memsw.*, then oom03 & oom04 cases will fail.
> 
> The patch fixed it: removed memsw cases when memcg swap
> accounting is disabled, and added a TCONF:
> tst_resm(TCONF,"memcg swap accounting is disabled");
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> Reviewed-by: Caspar Zhang <czhang@redhat.com>
> 
> v2 -> v3: added MEMCG_SW_LIMIT to instead of
>           'MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes"'
>           and updated TINFO to TCONF, which made more sense.
> ---
>  testcases/kernel/mem/include/mem.h |    1 +
>  testcases/kernel/mem/oom/oom03.c   |   12 ++++++++++--
>  testcases/kernel/mem/oom/oom04.c   |   25 ++++++++++++++++++++-----
>  3 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index 00bb139..4c568cd 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -50,6 +50,7 @@ void ksm_usage(void);
>  #define CPATH_NEW		CPATH "/1"
>  #define MEMCG_PATH		"/dev/cgroup"
>  #define MEMCG_PATH_NEW		MEMCG_PATH "/1"
> +#define MEMCG_SW_LIMIT		MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes"
>  #if HAVE_SYS_EVENTFD_H
>  #define PATH_OOMCTRL		MEMCG_PATH_NEW "/memory.oom_control"
>  #define PATH_EVTCTRL		MEMCG_PATH_NEW "/cgroup.event_control"
> diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
> index b90d4d7..6de68b0 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -66,8 +66,16 @@ int main(int argc, char *argv[])
>  		write_file(MEMCG_PATH_NEW "/memory.limit_in_bytes", mem);
>  		testoom(0, 0, 0);
>  
> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
> -		testoom(0, 1, 0);
> +		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
> +			if (errno == ENOENT)
> +				tst_resm(TCONF,
> +				    "memcg swap accounting is disabled");
> +			else
> +				tst_brkm(TBROK|TERRNO, cleanup, "access");
> +		} else {
> +			write_file(MEMCG_SW_LIMIT, mem);
> +			testoom(0, 1, 0);
> +		}
>  	}
>  	cleanup();
>  	tst_exit();
> diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
> index fb35f96..00030b9 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -48,6 +48,7 @@ int main(int argc, char *argv[])
>  {
>  	char *msg;
>  	int lc;
> +	int swap_acc_on = 1;
>  	long nodes[MAXNODES];
>  	char buf[BUFSIZ], mem[BUFSIZ];
>  
> @@ -73,19 +74,33 @@ int main(int argc, char *argv[])
>  		snprintf(mem, BUFSIZ, "%ld", TESTMEM);
>  		write_file(MEMCG_PATH_NEW "/memory.limit_in_bytes", mem);
>  
> +		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
> +			if (errno == ENOENT) {
> +				tst_resm(TCONF,
> +				    "memcg swap accounting is disabled");
> +				swap_acc_on = 0;
> +			} else
> +				tst_brkm(TBROK|TERRNO, cleanup, "access");


Here also need a parentheses for "else" , but it's just as well.

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>



Thanks,
Wanlong Gao


> +		}
> +
>  		tst_resm(TINFO, "process mempolicy.");
>  		testoom(1, 0, 1);
>  
> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
> -		testoom(1, 1, 1);
> +		if (swap_acc_on) {
> +			write_file(MEMCG_SW_LIMIT, mem);
> +			testoom(1, 1, 1);
> +		}
>  
>  		tst_resm(TINFO, "process cpuset.");
>  
> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", "-1");
> +		if (swap_acc_on)
> +			write_file(MEMCG_SW_LIMIT, "-1");
>  		testoom(0, 0, 1);
>  
> -		write_file(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes", mem);
> -		testoom(0, 1, 1);
> +		if (swap_acc_on) {			
> +			write_file(MEMCG_SW_LIMIT, mem);
> +			testoom(0, 1, 1);
> +		}
>  	}
>  	cleanup();
>  	tst_exit();



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
