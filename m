Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1VvP8m-0005rE-V9
	for ltp-list@lists.sourceforge.net; Tue, 24 Dec 2013 10:23:09 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VvP8m-0007LA-5Q
	for ltp-list@lists.sourceforge.net; Tue, 24 Dec 2013 10:23:08 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rBOAMxrO023983
	for <ltp-list@lists.sourceforge.net>; Tue, 24 Dec 2013 18:22:59 +0800
Message-ID: <52B95F74.2070805@cn.fujitsu.com>
Date: Tue, 24 Dec 2013 18:18:28 +0800
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <52B95C5A.8090406@cn.fujitsu.com>
In-Reply-To: <52B95C5A.8090406@cn.fujitsu.com>
Subject: Re: [LTP] semop/semop04.c: fix a bug when running with -i option
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
To: ltp-list@lists.sourceforge.net

Sorry, there is something wrong with the subject and please ignore this mail:(

Regards,
Xiaoguang Wang

On 12/24/2013 06:05 PM, Xiaoguang Wang wrote:
> semop/semop04.c: fix a bug when running with -i option
>
> If we run semop04 like this: ./semop04 -i 2,
> its output will be:
>
> semop04     1  TPASS  :  expected failure - errno = 11 : Resource temporarily unavailable
> semop04     2  TPASS  :  expected failure - errno = 11 : Resource temporarily unavailable
> semop04     1  TBROK  :  semctl() failed
> semop04     2  TBROK  :  Remaining cases broken.
>
> Actually in the second iteration, semctl will return ERANGE. This is
> because the val variable will be less than zero in the sceond iteration.
>
> Variable should be reset to 1 before this actual errno test.
>
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/ipc/semop/semop04.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
> index 2725378..f7efd86 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop04.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
> @@ -80,7 +80,7 @@ int main(int ac, char **av)
>  {
>  	int lc;
>  	char *msg;
> -	int val = 1;		/* value for SETVAL */
> +	int val;		/* value for SETVAL */
>  
>  	int i;
>  
> @@ -96,6 +96,7 @@ int main(int ac, char **av)
>  		/* reset tst_count in case we are looping */
>  		tst_count = 0;
>  
> +		val = 1;
>  		for (i = 0; i < TST_TOTAL; i++) {
>  
>  			/* initialize the s_buf buffer */


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
