Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VuuE0-0004iA-N9
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 01:22:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VuuDz-00071s-Mg
	for ltp-list@lists.sourceforge.net; Mon, 23 Dec 2013 01:22:28 +0000
Message-ID: <52B79043.9070602@cn.fujitsu.com>
Date: Mon, 23 Dec 2013 09:22:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <69b0ae6d4039f97ac8bc68975640f8a79ac69aa2.1386926927.git.jstancek@redhat.com>
In-Reply-To: <69b0ae6d4039f97ac8bc68975640f8a79ac69aa2.1386926927.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] get_robust_list01: use pid_max instead of
	UINT16_MAX
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/13/2013 05:29 PM, Jan Stancek wrote:
> UINT16_MAX can be a valid pid number on some systems.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  .../syscalls/get_robust_list/get_robust_list01.c   |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> index dd5e726..17da538 100644
> --- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> +++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
> @@ -68,6 +68,7 @@ struct robust_list_head {
>  };
>  
>  int exp_enos[] = { ESRCH, EPERM, EFAULT, 0 };
> +static unsigned int pid_max;
>  
>  void setup(void);
>  void cleanup(void);
> @@ -134,7 +135,7 @@ int main(int argc, char **argv)
>  		 * find the task specified by the pid argument.
>  		 */
>  
> -		TEST(ltp_syscall(__NR_get_robust_list, UINT16_MAX,
> +		TEST(ltp_syscall(__NR_get_robust_list, pid_max,
>  				      (struct robust_list_head *)&head,
>  				      &len_ptr));
>  
> @@ -190,6 +191,7 @@ void setup(void)
>  	tst_require_root(NULL);
>  
>  	TEST_EXP_ENOS(exp_enos);
> +	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/pid_max", "%u", &pid_max);
>  
>  	TEST_PAUSE;
>  }
> 


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
